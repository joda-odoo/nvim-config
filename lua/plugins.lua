vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() 
            require('lualine').setup {
                options = { 
                    theme = 'auto',
                    section_separators = '', 
                    component_separators = '', 
                    padding = 1 
                },
                sections = { lualine_a = {'mode', 'branch'} },
            }
        end
    }

    use {
        "preservim/nerdcommenter",
        config = function()
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            map('n', '<C-_>', ':call nerdcommenter#Comment(0, "toggle")<CR>' , opts)
            map('v', '<C-_>', ':call nerdcommenter#Comment(0, "toggle")<CR>' , opts)
        end
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { 
            {'nvim-lua/plenary.nvim'},
        },
        config = function() 
            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
            vim.keymap.set('i', '<C-p>', builtin.git_files, {})
        end
    }

    use (
        "nvim-treesitter/nvim-treesitter",
        { run = ':TSUpdate' }
    )

    use {
        "nvim-treesitter/nvim-treesitter-context",
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            {'neovim/nvim-lspconfig'},           
            {'williamboman/mason.nvim'},         
            {'williamboman/mason-lspconfig.nvim'}, 

            {'hrsh7th/nvim-cmp'},         
            {'hrsh7th/cmp-nvim-lsp'},    
            {'hrsh7th/cmp-buffer'},     
            {'hrsh7th/cmp-path'},       
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},  

        
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'}, 
        },

        config = function()
            local lsp = require('lsp-zero').preset({
                name = 'minimal',
                set_lsp_keymaps = true,
                manage_nvim_cmp = true,
                suggest_lsp_servers = false,
            })

            lsp.setup()

            lsp.on_attach(function(client, buf)
                local opts = {buffer = buf, remap = false}

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "vr", function() vim.lsp.buf.references() end, opts)
            end)
        end
    }

end)
