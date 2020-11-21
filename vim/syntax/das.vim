" Vim syntax file for Dascript
" Copy-pasted and adapted from das syntax highlighing by Neil Schemenauer,
" Dmitry Vasiliev and " Zvezdan Petkovic.

" quit when a syntax file was already loaded.
if exists("b:current_syntax")
  finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim


if exists("das_highlight_all")
  if exists("das_no_builtin_highlight")
    unlet das_no_builtin_highlight
  endif
  if exists("das_no_doctest_code_highlight")
    unlet das_no_doctest_code_highlight
  endif
  if exists("das_no_number_highlight")
    unlet das_no_number_highlight
  endif
  let das_space_error_highlight = 1
endif

syn keyword dasStatement recover return break continue pass yield goto
syn keyword dasStatement operator
syn keyword dasStatement let var typedef
syn keyword dasStatement enum struct class def nextgroup=dasFunction skipwhite
syn keyword dasStatement new delete
syn keyword dasStatement typeinfo type label
syn keyword dasStatement array const table smart_ptr
syn keyword dasStatement with where unsafe
syn keyword dasStatement cast deref upcast addr reinterpret
syn keyword dasStatement module
syn keyword dasStatement override abstract public implicit shared
syn keyword dasStatement iterator generator 
syn keyword dasConditional if static_if else elif static_elif
syn keyword dasRepeat	for while
syn keyword dasOperator	in is as
syn keyword dasException try expect finally
syn keyword dasInclude	require
syn keyword dasAnnotate options

syn match   dasFunction	"\h\w*" display contained

syn match   dasComment	"//.*$" contains=dasTodo,@Spell
syn region  dasComment	start="/\*" end="\*/" contains=dasTodo,@Spell
syn keyword dasTodo		FIXME NOTE NOTES TODO XXX contained

" Triple-quoted strings can contain doctests.
syn region  dasString matchgroup=dasQuotes
      \ start=+[uU]\=\z(["]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=dasEscape,@Spell

syn match   dasEscape	+\\[abfnrtv'"\\]+ contained
syn match   dasEscape	"\\\o\{1,3}" contained
syn match   dasEscape	"\\x\x\{2}" contained
syn match   dasEscape	"\%(\\u\x\{4}\|\\U\x\{8}\)" contained
" Python allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
syn match   dasEscape	"\\N{\a\+\%(\s\a\+\)*}" contained
syn match   dasEscape	"\\$"

if !exists("das_no_number_highlight")
  syn match dasNumbers	display transparent "\<\d\|\.\d" contains=dasNumber,dasFloat,dasOctal
  " Same, but without octal error (for comments)
  syn match dasNumbersCom	display contained transparent "\<\d\|\.\d" contains=dasNumber,dasFloat,dasOctal
  syn match dasNumber		display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
  "hex number
  syn match dasNumber		display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
  " Flag the first zero of an octal number as something special
  syn match dasOctal		display contained "0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=dasOctalZero
  syn match dasOctalZero	display contained "\<0"
  syn match dasFloat		display contained "\d\+f"
  "floating point number, with dot, optional exponent
  syn match dasFloat		display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
  "floating point number, starting with a dot, optional exponent
  syn match dasFloat		display contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
  "floating point number, without dot, with exponent
  syn match dasFloat		display contained "\d\+e[-+]\=\d\+[fl]\=\>"
endif

if !exists("das_no_builtin_highlight")
  syn keyword dasBuiltin true false null
  syn keyword dasBuiltin bool void string auto bitfield
  syn keyword dasBuiltin int int2 int3 int4 int64 int8 int16
  syn keyword dasBuiltin uint uint2 uint3 uint4 uint64 uint8 uint16
  syn keyword dasBuiltin float float2 float3 float4 double
  syn keyword dasBuiltin range urange block function lambda tuple variant
endif

if exists("das_space_error_highlight")
  " trailing whitespace
  syn match   dasSpaceError	display excludenl "\s\+$"
  " mixed tabs and spaces
  syn match   dasSpaceError	display " \+\t"
  syn match   dasSpaceError	display "\t\+ "
endif

" Sync at the beginning of class, function, or method definition.
syn sync match dasSync grouphere NONE "^\%(def\|class\|struct\)\s\+\h\w*\s*[(:]"

" The default highlight links.  Can be overridden later.
hi def link dasStatement		  Statement
hi def link dasConditional		Conditional
hi def link dasRepeat		      Repeat
hi def link dasOperator		    Operator
hi def link dasException		  Exception
hi def link dasInclude		    Include
hi def link dasAnnotate		    Define
hi def link dasFunction		    Function
hi def link dasComment		    Comment
hi def link dasTodo			      Todo
hi def link dasString		      String
hi def link dasQuotes		      String
hi def link dasEscape		      Special
if !exists("das_no_number_highlight")
  hi def link dasFloat      Number
  hi def link dasNumber     Number
  hi def link dasNumbers    Number
  hi def link dasNumbersCom Number
  hi def link dasOctal      Number
  hi def link dasOctalZero  Number
endif
if !exists("das_no_builtin_highlight")
  hi def link dasBuiltin		Function
endif
if exists("das_space_error_highlight")
  hi def link dasSpaceError		Error
endif

let b:current_syntax = "das"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet:
