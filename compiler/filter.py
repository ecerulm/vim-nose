#!/usr/bin/env python
# encoding: utf-8

import re
import sys

def parse_traceback(cdata):
    lines = [line for line in cdata.split('\n') if "File" in line]
    for line in lines:
        # print line
        matches =  re.match("\s+File\s\"+(\S+)\",\s+line\s+(\d+),\s+in\s+(\S+)",line)
        # print matches.groups()
        yield matches.groups()

def print_testcase_line(testcase):
    testname = testcase.attrib['name']
    try:
        child = next(iter(testcase))
    except StopIteration:
        return # nothing to print, the testcase passed
    result = child.tag
    message = child.attrib['message']
    # print vars(child)
    for (filename,line,function) in parse_traceback(child.text):
        print("%s:%s:%s:%s:%s:%s" % (filename,line,function,testname,result,message,))

import xml.etree.ElementTree as ET
tree = ET.parse(sys.argv[1])
testsuite = tree.getroot()
testsuitename = testsuite.attrib['name']
num_tests = int(testsuite.attrib['tests'])
num_failures = int(testsuite.attrib['failures'])
num_errors = int(testsuite.attrib['errors'])
num_skipped = int(testsuite.attrib['skip'])

for testcase in testsuite:
    print_testcase_line(testcase)
#Final line
print("%s T:%d F:%d E:%d S:%d" % (testsuitename,num_tests,num_failures,num_errors,num_skipped))
