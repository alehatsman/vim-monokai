" monokai.vim (extended, opinionated, Tree-sitter aware)

if !has('gui_running') && &t_Co < 256
  finish
endif

if !exists('g:monokai_italics')
  let g:monokai_italics = 1
endif

if !exists('g:monokai_gui_italic')
  let g:monokai_gui_italic = g:monokai_italics
endif

if !exists('g:monokai_term_italic')
  let g:monokai_term_italic = g:monokai_italics
endif

if !exists('g:monokai_transparent')
  let g:monokai_transparent = 0
endif

if !exists('g:monokai_dim_inactive')
  let g:monokai_dim_inactive = 0
endif

set background=dark
hi clear

if exists('syntax_on')
  syntax reset
endif

let colors_name = 'monokai'

" Utils {{{

function! s:parse_format(raw, allow_italic) abort
  if a:raw ==# '' || a:raw ==# 'NONE'
    return 'NONE'
  endif
  let l:parts = split(a:raw, ',')
  let l:out = []
  for l:p in l:parts
    if l:p ==# 'italic' && !a:allow_italic
      continue
    endif
    if l:p !=# ''
      call add(l:out, l:p)
    endif
  endfor
  return empty(l:out) ? 'NONE' : join(l:out, ',')
endfunction

function! s:h(group, style) abort
  let l:rawfmt = get(a:style, 'format', 'NONE')
  let l:ctermformat = s:parse_format(l:rawfmt, g:monokai_term_italic)
  let l:guiformat  = s:parse_format(l:rawfmt, g:monokai_gui_italic)

  let l:ctermfg = has_key(a:style, 'fg') ? a:style.fg.cterm : 'NONE'
  let l:ctermbg = has_key(a:style, 'bg') ? a:style.bg.cterm : 'NONE'

  execute 'highlight' a:group
        \ 'guifg='   . (has_key(a:style, 'fg') ? a:style.fg.gui : 'NONE')
        \ 'guibg='   . (has_key(a:style, 'bg') ? a:style.bg.gui : 'NONE')
        \ 'guisp='   . (has_key(a:style, 'sp') ? a:style.sp.gui : 'NONE')
        \ 'gui='     . (l:guiformat ==# '' ? 'NONE' : l:guiformat)
        \ 'ctermfg=' . l:ctermfg
        \ 'ctermbg=' . l:ctermbg
        \ 'cterm='   . (l:ctermformat ==# '' ? 'NONE' : l:ctermformat)
endfunction

" }}}
" Palette {{{

let s:white       = { 'gui': '#E8E8E3', 'cterm': '252' }
let s:white2      = { 'gui': '#d8d8d3', 'cterm': '250' }
let s:black       = { 'gui': '#272822', 'cterm': '234' }
let s:lightblack  = { 'gui': '#2D2E27', 'cterm': '235' }
let s:lightblack2 = { 'gui': '#383a3e', 'cterm': '236' }
let s:lightblack3 = { 'gui': '#3f4145', 'cterm': '237' }
let s:darkblack   = { 'gui': '#211F1C', 'cterm': '233' }
let s:br_grey     = { 'gui': '#a1a29c', 'cterm': '243' }
let s:grey        = { 'gui': '#8F908A', 'cterm': '243' }
let s:lightgrey   = { 'gui': '#575b61', 'cterm': '237' }
let s:darkgrey    = { 'gui': '#64645e', 'cterm': '239' }
let s:warmgrey    = { 'gui': '#75715E', 'cterm': '59' }

let s:pink        = { 'gui': '#F92772', 'cterm': '197' }
let s:green       = { 'gui': '#A6E22D', 'cterm': '148' }
let s:aqua        = { 'gui': '#66d9ef', 'cterm': '81' }
let s:yellow      = { 'gui': '#E6DB74', 'cterm': '186' }
let s:orange      = { 'gui': '#FD9720', 'cterm': '208' }
let s:purple      = { 'gui': '#ae81ff', 'cterm': '141' }
let s:red         = { 'gui': '#e73c50', 'cterm': '196' }
let s:purered     = { 'gui': '#ff0000', 'cterm': '196' }
let s:darkred     = { 'gui': '#5f0000', 'cterm': '52' }

let s:cyan        = { 'gui': '#A1EFE4', 'cterm': '159' }
let s:br_green    = { 'gui': '#9EC400', 'cterm': '148' }
let s:br_yellow   = { 'gui': '#E7C547', 'cterm': '221' }
let s:br_blue     = { 'gui': '#7AA6DA', 'cterm': '110' }
let s:br_purple   = { 'gui': '#B77EE0', 'cterm': '140' }
let s:br_cyan     = { 'gui': '#54CED6', 'cterm': '80' }
let s:br_white    = { 'gui': '#FFFFFF', 'cterm': '231' }

" Diff palette

let s:diff_add_bg     = { 'gui': '#2a331d', 'cterm': '22' }
let s:diff_add_fg     = s:green
let s:diff_delete_bg  = { 'gui': '#3a2226', 'cterm': '52' }
let s:diff_delete_fg  = s:pink
let s:diff_change_bg  = { 'gui': '#222933', 'cterm': '17' }
let s:diff_change_fg  = s:aqua

" }}}
" Core editor {{{

if has('termguicolors')
  set termguicolors
endif

if g:monokai_transparent
  call s:h('Normal',       { 'fg': s:white })
else
  call s:h('Normal',       { 'fg': s:white,      'bg': s:black })
endif

call s:h('ColorColumn',    {                     'bg': s:lightblack })
call s:h('Conceal',        { 'fg': s:grey })
call s:h('Cursor',         { 'fg': s:black,      'bg': s:white })
call s:h('CursorColumn',   {                     'bg': s:lightblack2 })
call s:h('CursorLine',     {                     'bg': s:lightblack2 })
call s:h('NonText',        { 'fg': s:lightgrey })
call s:h('Visual',         {                     'bg': s:lightgrey })
call s:h('Search',         { 'fg': s:black,      'bg': s:yellow })
call s:h('MatchParen',     { 'fg': s:purple,                     'format': 'bold' })
call s:h('Question',       { 'fg': s:yellow })
call s:h('ModeMsg',        { 'fg': s:yellow })
call s:h('MoreMsg',        { 'fg': s:yellow })
call s:h('ErrorMsg',       { 'fg': s:black,      'bg': s:red,    'format': 'standout' })
call s:h('WarningMsg',     { 'fg': s:red })
call s:h('VertSplit',      { 'fg': s:darkgrey,   'bg': s:darkblack })
call s:h('WinSeparator',   { 'fg': s:darkgrey,   'bg': s:darkblack })
call s:h('LineNr',         { 'fg': s:grey,       'bg': s:lightblack })
call s:h('CursorLineNr',   { 'fg': s:orange,     'bg': s:lightblack2, 'format': 'bold' })
call s:h('Whitespace',     { 'fg': s:lightgrey })
call s:h('EndOfBuffer',    { 'fg': s:lightblack })

if g:monokai_transparent
  call s:h('SignColumn',   { })
else
  call s:h('SignColumn',   {                     'bg': s:lightblack })
endif

if g:monokai_dim_inactive
  if g:monokai_transparent
    call s:h('NormalNC', { 'fg': s:grey })
  else
    call s:h('NormalNC', { 'fg': s:grey, 'bg': s:lightblack })
  endif
endif

" Extra UI
call s:h('QuickFixLine',   { 'fg': s:white,     'bg': s:lightblack2, 'format': 'bold' })
call s:h('Substitute',     { 'fg': s:black,     'bg': s:orange, 'format': 'bold' })
call s:h('IncSearch',      { 'fg': s:black,     'bg': s:orange, 'format': 'bold' })
call s:h('CurSearch',      { 'fg': s:black,     'bg': s:br_yellow })

if g:monokai_transparent
  call s:h('WinBar',       { 'fg': s:grey })
  call s:h('StatusColumn', { 'fg': s:grey })
else
  call s:h('WinBar',       { 'fg': s:grey,      'bg': s:lightblack })
  call s:h('StatusColumn', { 'fg': s:grey,      'bg': s:lightblack })
endif

" }}}
" Statusline / Tabline {{{

call s:h('StatusLine',     { 'fg': s:black,      'bg': s:lightgrey })
call s:h('StatusLineNC',   { 'fg': s:lightgrey,  'bg': s:darkblack })
call s:h('TabLine',        { 'fg': s:lightgrey,  'bg': s:lightblack })
call s:h('TabLineSel',     { 'fg': s:darkblack,  'bg': s:warmgrey, 'format': 'bold' })
call s:h('TabLineFill',    {                     'bg': s:lightblack })
call s:h('User1',          { 'fg': s:yellow,     'bg': s:lightgrey, 'format': 'bold' })
call s:h('User2',          { 'fg': s:orange,     'bg': s:lightgrey, 'format': 'bold' })
call s:h('User3',          { 'fg': s:purple,     'bg': s:lightgrey, 'format': 'bold' })
call s:h('User4',          { 'fg': s:aqua,       'bg': s:lightgrey, 'format': 'bold' })

" }}}
" Spell / Misc / UI {{{

call s:h('SpellBad',       { 'fg': s:red,        'format': 'undercurl' })
call s:h('SpellCap',       { 'fg': s:purple,     'format': 'underline' })
call s:h('SpellRare',      { 'fg': s:aqua,       'format': 'underline' })
call s:h('SpellLocal',     { 'fg': s:pink,       'format': 'underline' })

call s:h('SpecialKey',     { 'fg': s:pink })
call s:h('Title',          { 'fg': s:yellow })
call s:h('Directory',      { 'fg': s:aqua })

call s:h('Folded',         { 'fg': s:warmgrey,   'bg': s:darkblack })
call s:h('FoldColumn',     { 'fg': s:grey,       'bg': s:lightblack })

call s:h('Pmenu',          { 'fg': s:white2,     'bg': s:darkblack })
call s:h('PmenuSel',       { 'fg': s:aqua,       'bg': s:darkblack, 'format': 'reverse,bold' })
call s:h('PmenuThumb',     {                     'bg': s:grey })
call s:h('PmenuSbar',      {                     'bg': s:lightblack })

call s:h('NormalFloat',    { 'fg': s:white2,     'bg': s:darkblack })

" }}}
" Generic syntax {{{

call s:h('Constant',       { 'fg': s:purple })
call s:h('Number',         { 'fg': s:purple })
call s:h('Float',          { 'fg': s:purple })
call s:h('Boolean',        { 'fg': s:purple })
call s:h('Character',      { 'fg': s:yellow })
call s:h('String',         { 'fg': s:yellow })

call s:h('Type',           { 'fg': s:white })
call s:h('Structure',      { 'fg': s:aqua })
call s:h('StorageClass',   { 'fg': s:aqua })
call s:h('Typedef',        { 'fg': s:aqua })

call s:h('Identifier',     { 'fg': s:white })
call s:h('Function',       { 'fg': s:green })

call s:h('Statement',      { 'fg': s:pink })
call s:h('Operator',       { 'fg': s:pink })
call s:h('Label',          { 'fg': s:pink })
call s:h('Keyword',        { 'fg': s:pink })

call s:h('PreProc',        { 'fg': s:green })
call s:h('Include',        { 'fg': s:pink })
call s:h('Define',         { 'fg': s:pink })
call s:h('Macro',          { 'fg': s:green })
call s:h('PreCondit',      { 'fg': s:green })

call s:h('Special',        { 'fg': s:purple })
call s:h('SpecialChar',    { 'fg': s:pink })
call s:h('Delimiter',      { 'fg': s:pink })
call s:h('SpecialComment', { 'fg': s:aqua })
call s:h('Tag',            { 'fg': s:pink })

call s:h('Todo',           { 'fg': s:orange,    'format': 'bold,italic' })
call s:h('Comment',        { 'fg': s:warmgrey,  'format': 'italic' })

call s:h('Underlined',     { 'fg': s:green })
call s:h('Ignore',         {} )
call s:h('Error',          { 'fg': s:purered,   'bg': s:lightblack3 })

" }}}
" Diff / Git {{{

call s:h('DiffAdd',        { 'fg': s:diff_add_fg,    'bg': s:diff_add_bg })
call s:h('DiffDelete',     { 'fg': s:diff_delete_fg, 'bg': s:diff_delete_bg })
call s:h('DiffChange',     { 'fg': s:diff_change_fg, 'bg': s:diff_change_bg })
call s:h('DiffText',       { 'fg': s:white,          'bg': s:diff_change_bg, 'format': 'bold' })

call s:h('GitSignsAdd',    { 'fg': { 'gui': '#8FCF4A', 'cterm': '113' } })
call s:h('GitSignsChange', { 'fg': { 'gui': '#7AA6DA', 'cterm': '110' } })
call s:h('GitSignsDelete', { 'fg': { 'gui': '#FF6FA3', 'cterm': '205' } })

hi def link diffAdded   DiffAdd
hi def link diffChanged DiffChange
hi def link diffRemoved DiffDelete

hi def link gitcommitSummary       Normal
hi def link gitcommitOverflow      Error
hi def link gitcommitUntracked     Comment
hi def link gitcommitDiscarded     Comment
hi def link gitcommitSelected      Comment

" }}}
" Diagnostics {{{

call s:h('DiagnosticError',         { 'fg': s:red })
call s:h('DiagnosticWarn',          { 'fg': s:orange })
call s:h('DiagnosticInfo',          { 'fg': s:yellow })
call s:h('DiagnosticHint',          { 'fg': s:grey })
call s:h('DiagnosticOk',            { 'fg': s:green })
call s:h('DiagnosticUnnecessary',   { 'fg': s:grey })

hi def link DiagnosticSignError DiagnosticError
hi def link DiagnosticSignWarn  DiagnosticWarn
hi def link DiagnosticSignInfo  DiagnosticInfo
hi def link DiagnosticSignHint  DiagnosticHint
hi def link DiagnosticSignOk    DiagnosticOk

call s:h('DiagnosticUnderlineError',{ 'sp': s:red,    'format': 'undercurl' })
call s:h('DiagnosticUnderlineWarn', { 'sp': s:orange, 'format': 'undercurl' })
call s:h('DiagnosticUnderlineInfo', { 'sp': s:aqua,   'format': 'undercurl' })
call s:h('DiagnosticUnderlineHint', { 'sp': s:grey,   'format': 'undercurl' })

call s:h('DiagnosticVirtualTextError', { 'fg': s:red,    'bg': s:lightblack3 })
call s:h('DiagnosticVirtualTextWarn',  { 'fg': s:orange, 'bg': s:lightblack3 })
call s:h('DiagnosticVirtualTextInfo',  { 'fg': s:yellow, 'bg': s:lightblack3 })
call s:h('DiagnosticVirtualTextHint',  { 'fg': s:grey,   'bg': s:lightblack3 })
call s:h('DiagnosticVirtualTextOk',    { 'fg': s:green,  'bg': s:lightblack3 })

" }}}
" Language-specific accents {{{

" Markdown
call s:h('markdownCode',            { 'fg': s:purple, 'format': 'italic' })
call s:h('markdownListMarker',      { 'fg': s:purple })

" Vim
call s:h('vimCommand',              { 'fg': s:pink })

" HTML / XML / JSX
call s:h('htmlTag',                 { 'fg': s:pink })
call s:h('htmlEndTag',              { 'fg': s:white })
call s:h('htmlTagName',             { 'fg': s:pink })
call s:h('htmlArg',                 { 'fg': s:green })
call s:h('htmlSpecialChar',         { 'fg': s:purple })

call s:h('xmlTag',                  { 'fg': s:pink })
call s:h('xmlEndTag',               { 'fg': s:pink })
call s:h('xmlTagName',              { 'fg': s:orange })
call s:h('xmlAttrib',               { 'fg': s:green })

call s:h('jsxTag',                  { 'fg': s:white })
call s:h('jsxCloseTag',             { 'fg': s:white })
call s:h('jsxTagName',              { 'fg': s:pink })
call s:h('jsxComponentName',        { 'fg': s:pink })
call s:h('jsxAttrib',               { 'fg': s:green })

" CSS
call s:h('cssProp',                 { 'fg': s:yellow })
call s:h('cssUIAttr',               { 'fg': s:yellow })
call s:h('cssFunctionName',         { 'fg': s:aqua })
call s:h('cssColor',                { 'fg': s:purple })
call s:h('cssPseudoClassId',        { 'fg': s:purple })
call s:h('cssClassName',            { 'fg': s:green })
call s:h('cssValueLength',          { 'fg': s:purple })
call s:h('cssCommonAttr',           { 'fg': s:pink })
call s:h('cssBraces',               { 'fg': s:white })
call s:h('cssClassNameDot',         { 'fg': s:pink })
call s:h('cssURL',                  { 'fg': s:orange, 'format': 'underline,italic' })

" Parameters / constructors
call s:h('Parameter',               { 'fg': s:orange })
call s:h('Constructor',             { 'fg': s:aqua, 'format': 'italic' })

" }}}
" Plugin groups / links {{{

hi def link NERDTreeDir              Directory
hi def link NERDTreeDirSlash         Directory
hi def link NERDTreeCWD              Directory
hi def link NERDTreeOpenable         Directory
hi def link NERDTreeClosable         Directory
hi def link NERDTreeUp               Directory
hi def link NERDTreeHelp             Comment
hi def link NERDTreeBookmarksHeader  Title
hi def link NERDTreeBookmarksLeader  NonText
hi def link NERDTreeBookmarkName     Directory

hi def link NvimTreeRootFolder       Directory
hi def link NvimTreeFolderIcon       Directory
hi! NvimTreeFolderIcon guifg=#75715E ctermfg=59

hi def link SyntasticErrorSign       DiagnosticError
hi def link SyntasticWarningSign     DiagnosticWarn

hi def link DapUIVariable            Normal
hi def link DapUIValue               Normal
hi def link DapUIFrameName           Normal
hi def link DapUILineNumber          LineNr
hi def link DapUIBreakpointsLine     LineNr
hi def link DapUIBreakpointsCurrentLine CursorLineNr
hi def link DapUIBreakpointsPath     Directory
hi def link DapUIBreakpointsInfo     DiagnosticInfo
hi def link DapUIWatchesEmpty        DiagnosticHint
hi def link DapUIWatchesValue        DiagnosticInfo
hi def link DapUIWatchesError        DiagnosticError

hi def link CocErrorSign             DiagnosticError
hi def link CocWarningSign           DiagnosticWarn
hi def link CocInfoSign              DiagnosticInfo
hi def link CocHintSign              DiagnosticHint

" NvimTree extended
if has('nvim')
  if g:monokai_transparent
    call s:h('NvimTreeNormal',       { 'fg': s:white })
    call s:h('NvimTreeEndOfBuffer',  { 'fg': s:lightblack })
  else
    call s:h('NvimTreeNormal',       { 'fg': s:white, 'bg': s:black })
    call s:h('NvimTreeEndOfBuffer',  { 'fg': s:lightblack, 'bg': s:black })
  endif
  call s:h('NvimTreeWinSeparator',   { 'fg': s:darkgrey, 'bg': s:darkblack })
  hi def link NvimTreeFolderIcon     Directory
  call s:h('NvimTreeGitDirty',       { 'fg': s:orange })
  call s:h('NvimTreeGitNew',         { 'fg': s:green })
  call s:h('NvimTreeGitDeleted',     { 'fg': s:pink })
  call s:h('NvimTreeGitIgnored',     { 'fg': s:warmgrey })
endif

" Telescope maps to Float* to keep borders consistent
hi def link TelescopeNormal          NormalFloat
hi def link TelescopeBorder          FloatBorder
hi def link TelescopeTitle           FloatTitle
hi def link TelescopePromptNormal    NormalFloat
hi def link TelescopePromptBorder    FloatBorder
hi def link TelescopeResultsNormal   NormalFloat
hi def link TelescopeResultsBorder   FloatBorder
hi def link TelescopePreviewNormal   NormalFloat
hi def link TelescopePreviewBorder   FloatBorder
call s:h('TelescopeSelection', { 'fg': s:white, 'bg': s:lightblack2, 'format': 'bold' })

" Float border/title with transparency awareness
if g:monokai_transparent
  call s:h('FloatBorder',    { 'fg': s:darkgrey })
  call s:h('FloatTitle',     { 'fg': s:yellow, 'format': 'bold' })
else
  call s:h('FloatBorder',    { 'fg': s:darkgrey, 'bg': s:darkblack })
  call s:h('FloatTitle',     { 'fg': s:yellow,   'bg': s:darkblack, 'format': 'bold' })
endif

" }}}
" Tree-sitter (opinionated Monokai mapping) {{{

if has('nvim')
  " Comments / text
  hi def link @comment                  Comment
  hi def link @comment.documentation    Comment

  " Literals
  hi def link @string                   String
  hi def link @string.regex             String
  hi def link @string.escape            SpecialChar
  hi def link @character                Character
  hi def link @number                   Number
  hi def link @float                    Float
  hi def link @boolean                  Boolean

  " Constants
  call s:h('@constant',                 { 'fg': s:purple })
  call s:h('@constant.builtin',         { 'fg': s:aqua })
  call s:h('@constant.macro',           { 'fg': s:green })

  " Types
  call s:h('@type',                     { 'fg': s:aqua, 'format': 'italic' })
  call s:h('@type.builtin',             { 'fg': s:aqua })
  call s:h('@type.qualifier',           { 'fg': s:pink })
  call s:h('@attribute',                { 'fg': s:purple })
  call s:h('@attribute.builtin',        { 'fg': s:purple })

  " Identifiers
  call s:h('@variable',                 { 'fg': s:white })
  call s:h('@variable.builtin',         { 'fg': s:purple })
  call s:h('@variable.parameter',       { 'fg': s:orange })
  call s:h('@variable.parameter.builtin',{ 'fg': s:orange })
  call s:h('@variable.member',          { 'fg': s:white2 })
  call s:h('@field',                    { 'fg': s:white2 })
  call s:h('@property',                 { 'fg': s:white2 })

  " Functions
  call s:h('@function',                 { 'fg': s:green })
  call s:h('@function.builtin',         { 'fg': s:aqua })
  call s:h('@function.call',            { 'fg': s:green })
  call s:h('@function.method',          { 'fg': s:green })
  call s:h('@function.method.call',     { 'fg': s:green })
  call s:h('@constructor',              { 'fg': s:aqua, 'format': 'italic' })

  " Keywords / operators
  call s:h('@keyword',                  { 'fg': s:pink })
  call s:h('@keyword.function',         { 'fg': s:pink })
  call s:h('@keyword.operator',         { 'fg': s:pink })
  call s:h('@keyword.return',           { 'fg': s:pink })
  call s:h('@operator',                 { 'fg': s:pink })

  " Punctuation
  call s:h('@punctuation.delimiter',    { 'fg': s:pink })
  call s:h('@punctuation.bracket',      { 'fg': s:white })
  call s:h('@punctuation.special',      { 'fg': s:purple })

  " Tags (HTML/JSX)
  call s:h('@tag',                      { 'fg': s:pink })
  call s:h('@tag.builtin',              { 'fg': s:pink })
  call s:h('@tag.attribute',            { 'fg': s:green })
  call s:h('@tag.delimiter',            { 'fg': s:white })

  " Namespaces / modules
  call s:h('@namespace',                { 'fg': s:aqua })

  " Link-based dedup
  hi def link @function.call           @function
  hi def link @function.method         @function
  hi def link @function.method.call    @function
  hi def link @variable.member         @field
  hi def link @property                @field
  hi def link @punctuation             @punctuation.delimiter

  " Newer captures
  call s:h('@module',                  { 'fg': s:aqua })
  call s:h('@decorator',               { 'fg': s:purple })
  call s:h('@string.special.url',      { 'fg': s:orange, 'format': 'underline' })
  call s:h('@string.special.path',     { 'fg': s:yellow })
  call s:h('@string.special.symbol',   { 'fg': s:purple })
  call s:h('@comment.todo',            { 'fg': s:orange, 'format': 'bold,italic' })
  call s:h('@markup.link',             { 'fg': s:aqua })
  call s:h('@markup.link.label',       { 'fg': s:green })
  call s:h('@markup.link.url',         { 'fg': s:orange, 'format': 'underline' })

  " LSP semantic tokens
  hi def link @lsp.type.class          @type
  hi def link @lsp.type.enum           @type
  hi def link @lsp.type.enumMember     @constant
  hi def link @lsp.type.function       @function
  hi def link @lsp.type.method         @function
  hi def link @lsp.type.interface      @type
  hi def link @lsp.type.namespace      @namespace
  hi def link @lsp.type.parameter      @variable.parameter
  hi def link @lsp.type.property       @field
  hi def link @lsp.type.type           @type
  hi def link @lsp.type.typeParameter  @type
  hi def link @lsp.type.variable       @variable
endif

" }}}
" Terminal {{{

if has('nvim')
  let g:terminal_color_0  = s:black.gui
  let g:terminal_color_1  = s:red.gui
  let g:terminal_color_2  = s:green.gui
  let g:terminal_color_3  = s:yellow.gui
  let g:terminal_color_4  = s:aqua.gui
  let g:terminal_color_5  = s:purple.gui
  let g:terminal_color_6  = s:cyan.gui
  let g:terminal_color_7  = s:white.gui
  let g:terminal_color_8  = s:darkgrey.gui
  let g:terminal_color_9  = s:pink.gui
  let g:terminal_color_10 = s:br_green.gui
  let g:terminal_color_11 = s:br_yellow.gui
  let g:terminal_color_12 = s:br_blue.gui
  let g:terminal_color_13 = s:br_purple.gui
  let g:terminal_color_14 = s:br_cyan.gui
  let g:terminal_color_15 = s:br_white.gui
else
  let g:terminal_ansi_colors = [
        \ s:black.gui,
        \ s:red.gui,
        \ s:green.gui,
        \ s:yellow.gui,
        \ s:aqua.gui,
        \ s:purple.gui,
        \ s:cyan.gui,
        \ s:white.gui,
        \ s:darkgrey.gui,
        \ s:pink.gui,
        \ s:br_green.gui,
        \ s:br_yellow.gui,
        \ s:br_blue.gui,
        \ s:br_purple.gui,
        \ s:br_cyan.gui,
        \ s:br_white.gui ]
endif

" }}}
