" Vim Compiler File
" Compiler: nose
" Maintainer: Ruben Laguna <ruben.laguna@gmail.com>


if exists("current_compiler")
    finish
endif
let current_compiler = "nose"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpoptions " Save current cpoption to restore later
set cpo&vim  " reset cpoptions to force vim mode

let s:tmpfile = tempname()

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" let s:makeprg = 'nosetests\\ --with-xunit\\ --xunit-file='.s:tmpfile.';./filter.py\\ '.s:tmpfile
let s:makeprg = 'nosetests\ --with-xunit\ --xunit-file='.s:tmpfile.';'.s:path.'/filter.py\ '.s:tmpfile
execute "CompilerSet makeprg=".s:makeprg
CompilerSet efm=%f:%l:%m

" FF
" ======================================================================
" FAIL: test_a (test_myclass.MyClassTestCase)
" ----------------------------------------------------------------------
" Traceback (most recent call last):
"   File "/Users/ecerulm/tmp/tests/test_myclass.py", line 4, in test_a
"     self.fail("a fails")
" AssertionError: a fails

" ======================================================================
" FAIL: test_b (test_myclass.MyClassTestCase)
" ----------------------------------------------------------------------
" Traceback (most recent call last):
"   File "/Users/ecerulm/tmp/tests/test_myclass.py", line 6, in test_b
"     self.fail("b fails")
" AssertionError: b fails

" ----------------------------------------------------------------------
" Ran 2 tests in 0.005s

" FAILED (failures=2)

let &cpo =s:save_cpo
