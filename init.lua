-- vimplug shit 
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'preservim/tagbar'
Plug 'nanotech/jellybeans.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-lualine/lualine.nvim'
Plug ('neoclide/coc.nvim', {branch = 'release'}) 
Plug 'm4xshen/autoclose.nvim'

vim.call('plug#end')

-- vimcmd for vimscript
vim.cmd [[set tabstop=4]]
vim.cmd [[set shiftwidth=4]]
vim.cmd [[set softtabstop=4]]
vim.cmd [[set expandtab]]

vim.cmd [[nnoremap <C-n> :NERDTree<CR>]]

vim.cmd [[set clipboard=unnamedplus]]

vim.cmd [[set number]]

vim.cmd [[colorscheme jellybeans]]

vim.cmd [[nmap <F8> :TagbarToggle<CR>]]

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

-- autoclose.nvim
require("autoclose").setup()

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "rust", "python", "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
}
