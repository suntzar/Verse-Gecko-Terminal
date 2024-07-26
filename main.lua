-- Definir uma função que limpe a tela
function cls()
 os.execute("clear")
 -- alias cls='clear' abrevia o clear
end

-- Define a aleatoriedade de acordo com o tempo
math.randomseed(os.time())

-- Identifica a largura do terminal em caracteres
local termWidth = tonumber(io.popen('tput cols'):read('*a'))

red    = '\27[31m'
green  = '\27[32m'
yellow = '\27[33m'
blue   = '\27[34m'
purple = '\27[35m'
fade   = '\27[2m'
none   = '\27[39m\27[0m'

-- Definir uma tabela com os nomes e números dos livros da Bíblia
livros = {
  {"GÊNESIS", 50},
  {"ÊXODO", 40},
  {"LEVÍTICO", 27},
  {"NÚMEROS", 36},
  {"DEUTERONÔMIO", 34},
  {"JOSUÉ", 24},
  {"JUÍZES", 21},
  {"RUTE", 4},
  {"I SAMUEL", 31},
  {"II SAMUEL", 24},
  {"I REIS", 22},
  {"II REIS", 25},
  {"I CRÔNICAS", 29},
  {"II CRÔNICAS", 36},
  {"ESDRAS", 10},
  {"NEEMIAS", 13},
  {"ESTER", 10},
  {"JÓ", 42},
  {"SALMOS", 150},
  {"PROVÉRBIOS", 31},
  {"ECLESIASTES", 12},
  {"CÂNTICO DOS CÂNTICOS", 8},
  {"ISAÍAS", 66},
  {"JEREMIAS", 52},
  {"LAMENTAÇÕES", 5},
  {"EZEQUIEL", 48},
  {"DANIEL", 12},
  {"OSÉIAS", 14},
  {"JOEL", 3},
  {"AMÓS", 9},
  {"OBADIAS", 1},
  {"JONAS", 4},
  {"MIQUÉIAS", 7},
  {"NAUM", 3},
  {"HABACUQUE", 3},
  {"SOFONIAS", 3},
  {"AGEU", 2},
  {"ZACARIAS", 14},
  {"MALAQUIAS", 4},
  {"MATEUS", 28},
  {"MARCOS", 16},
  {"LUCAS", 24},
  {"JOÃO", 21},
  {"ATOS", 28},
  {"ROMANOS", 16},
  {"I CORÍNTIOS", 16},
  {"II CORÍNTIOS", 13},
  {"GÁLATAS", 6},
  {"EFÉSIOS", 6},
  {"FILIPENSES", 4},
  {"COLOSSENSES", 4},
  {"I TESSALONICENSES", 5},
  {"II TESSALONICENSES", 3},
  {"I TIMÓTEO", 6},
  {"II TIMÓTEO", 4},
  {"TITO", 3},
  {"FILEMOM", 1},
  {"HEBREUS", 13},
  {"TIAGO", 5},
  {"I PEDRO", 5},
  {"II PEDRO", 3},
  {"I JOÃO", 5},
  {"II JOÃO", 1},
  {"III JOÃO", 1},
  {"JUDAS", 1},
  {"APOCALIPSE", 22},
  {"FIM", 1}
}

--Definir a função que quebra a linha
function quebrar_linha(str, max)
  -- Criar uma variável para armazenar a nova string
  local nova_str = ""
  -- Criar uma variável para armazenar o comprimento da linha atual
  local comp = 0
  -- Dividir a string em palavras separadas por espaços
  for palavra in str:gmatch("%S+") do
    -- Verificar se a palavra cabe na linha atual
    if comp + #palavra <= (max - 20) then
      -- Adicionar a palavra à nova string
      nova_str = nova_str .. palavra .. " "
      -- Atualizar o comprimento da linha atual
      comp = comp + #palavra + 1
    else
      -- Adicionar uma quebra de linha à nova string
      nova_str = nova_str .. "\n          "
      -- Adicionar a palavra à nova string
      nova_str = nova_str .. palavra .. " "
      -- Atualizar o comprimento da linha atual
      comp = #palavra + 1
    end
  end
  -- Retornar a nova string
  return nova_str
end

-- Função para substituir as letras acentuadas
function FormatarAcentos(s)
  local mapaAcentos = {
    ["Á"] = "A", ["É"] = "E", ["Í"] = "I", ["Ó"] = "O", ["Ú"] = "U",
    ["À"] = "A", ["È"] = "E", ["Ì"] = "I", ["Ò"] = "O", ["Ù"] = "U",
    ["Ã"] = "A", ["Õ"] = "O",
    ["Â"] = "A", ["Ê"] = "E", ["Î"] = "I", ["Ô"] = "O", ["Û"] = "U",
    ["Ä"] = "A", ["Ë"] = "E", ["Ï"] = "I", ["Ö"] = "O", ["Ü"] = "U",
    ["Ç"] = "C",
    ["á"] = "a", ["é"] = "e", ["í"] = "i", ["ó"] = "o", ["ú"] = "u",
    ["à"] = "a", ["è"] = "e", ["ì"] = "i", ["ò"] = "o", ["ù"] = "u",
    ["ã"] = "a", ["õ"] = "o",
    ["â"] = "a", ["ê"] = "e", ["î"] = "i", ["ô"] = "o", ["û"] = "u",
    ["ä"] = "a", ["ë"] = "e", ["ï"] = "i", ["ö"] = "o", ["ü"] = "u",
    ["ç"] = "c"
  }

  return (s:gsub(utf8.charpattern, mapaAcentos))
end

-- Definir a função que formata os versículos
function formatar_versiculos(str, max)
  -- Criar uma variável para armazenar a nova string
  local nova_str = ""
  -- Dividir a string em linhas separadas por quebras de linha
  for linha in str:gmatch("[^\n]+") do
    -- Verificar se a linha começa com um número seguido de um espaço
    if linha:match("^%d+ ") then
      -- Adicionar uma quebra de linha à nova string
      nova_str = nova_str .. "\n\n"
      -- Adicionar a linha à nova string com a quebra de linha
      nova_str = nova_str ..  "          " .. quebrar_linha(linha, max) .. "\n\n"
    else
      -- Adicionar a linha à nova string sem a quebra de linha
      nova_str = nova_str .. "          " ..  quebrar_linha(linha, max)
    end
  end
  -- Retornar a nova string
  return nova_str
end

function substituir_numeros(str)
  -- Criar uma tabela com os números e seus equivalentes em superescrito
  local numeros = {}
  for i=0,9 do
    numeros[tostring(i)] = "\27[2m"..i.."\27[39m\27[0m"
  end

  -- Criar uma variável para armazenar a nova string
  local nova_str = ""
  -- Percorrer cada caractere da string
  for c in str:gmatch(".") do
    -- Verificar se o caractere é um número
    if numeros[c] then
      -- Substituir o número pelo seu equivalente em superescrito
      nova_str = nova_str .. numeros[c]
    else
      -- Manter o caractere original
      nova_str = nova_str .. c
    end
  end
  -- Retornar a nova string
  return nova_str
end

function centerText(text,w)
    local padding = (w - #text) // 2
    print(string.rep(" ", padding)..text..string.rep(" ", padding))
    --io.write(('\27[%dC%s\n'):format(padding, text))
end

function centerTextSTR(text,w)
    local padding = (w - #text) // 2
    return (('\27[%dC%s'):format(padding, text)..string.rep(" ", padding))
end

function centerTextInt(text,w)
    local padding = (termWidth - w) // 2
    print(string.rep(" ", padding)..text)
end

function escolhercap(livros, numero)
 local limite = 0
 for i, v in ipairs(livros) do
   limite = limite + v[2]
   if numero <= limite then
     return i, numero - (limite - v[2])
   end
 end
end


function random_cap(indice,capitulo)

 total = 1189

 -- Inicializar o gerador de números aleatórios
 math.randomseed(os.time())
 
 if indice == nil then
   indice, capitulo = escolhercap(livros, math.random(1,total))
 end

 -- Escolher um livro aleatório da tabela
 --local indice = math.random(1, #livros-1)
 local livro = livros[indice]
 local livro2 = livros[indice+1]
 local livro2 = livro2[1]

 -- Escolher um capítulo aleatório do livro
 --local capitulo = math.random(1, livro[2])
 local livro = livro[1]

 -- Abrir o arquivo biblia.txt
 local arquivo = io.open("biblia.txt", "r")

 -- Verificar se o arquivo existe
 if arquivo == nil then
  print("Arquivo não encontrado")
  return
 end

 -- Criar uma variável para armazenar o texto do capítulo
 local texto = ""

 -- Criar uma variável para indicar se encontrou o capítulo
 local encontrado = false
 
 -- Ler o arquivo linha por linha
 for linha in arquivo:lines() do
  -- Remover os espaços em branco no início e no fim da linha
  linha = linha:match("^%s*(.-)%s*$")
  -- Verificar se a linha contém o nome do livro e o número do capítulo
  if linha == livro .. " " .. capitulo then
    -- Marcar que encontrou o capítulo
    encontrado = true
    -- Não adicionar a linha ao texto
  -- Verificar se a linha contém o nome do livro e um número diferente do capítulo
  elseif linha:match(livro) or linha:match(livro2) then
    -- Verificar se já encontrou o capítulo
    if encontrado then
      -- Parar de ler o arquivo
      break
    end
  -- Verificar se já encontrou o capítulo
  elseif encontrado then
    -- Adicionar a linha ao texto
    texto = texto .. linha .. "\n"
  end
 end
 
 -- Fechar o arquivo
 arquivo:close()

 -- Verificar se encontrou o capítulo
 if encontrado then
  -- Printar o texto na tela com os versículos formatados
  cls()
  print("\n\n")
  os.execute("setterm -foreground green")
 -- os.execute("figlet -f standard BIBLIA")
 -- print("O livro e capítulo escolhidos são: \n")
  os.execute("figlet -c -f small "..FormatarAcentos(livro).." "..capitulo)
  os.execute("setterm -foreground white")
  print("\n"..substituir_numeros(formatar_versiculos(texto, termWidth)).."\n")
  os.execute("setterm -foreground green")
  centerText("Verse Gecko",termWidth)
  os.execute("setterm -foreground white --half-bright on")
  --centerText("https://github.com/suntzar/Verse-Gecko-Terminal")
  print()
  centerText("[Enter] Voltar",termWidth)
  print("\n\n\n\n")
  
 else
  -- Printar uma mensagem de erro
 cls()
  print("\n\n")
  os.execute("setterm -foreground green")
  os.execute("figlet -c -f small BIBLIA")
  os.execute("setterm -foreground white")
  print("\n")
  centerText("O livro e capítulo escolhidos são:\n",termWidth)
  centerText(livro .. " | " .. capitulo.."\n\n",termWidth)
  os.execute("setterm -foreground red")
  centerText("Capítulo não encontrado\n\n\n\n",termWidth)
 end
 
 io.read()
 choice(44,0)
end

function choice(w,pag)
  cls()
  
  print("\n\n"..green)
  os.execute("figlet -c -f small GECKO")
  os.execute("setterm --blink off -foreground white")
  print("\n")
  centerText("+"..string.rep("-", w).."+",termWidth)
  centerTextInt(" "..centerTextSTR("Um gerador de capitulos aleatórios",w+1).." ",w+1)
  --centerText("|"..string.rep(" ", w).."|",termWidth)
  centerText("+"..string.rep("-", w).."+",termWidth)
  --centerText("|"..string.rep(" ", w).."|",termWidth)
  centerTextInt("|"..centerTextSTR("coded by L7    Gecko v0.1 (beta)",w+1).."|",w+1)
  centerText("+"..string.rep("-", w).."+",termWidth)
  os.execute("setterm -foreground white --half-bright on")
  centerTextInt("| O ultimo capitulo visto foi:",w+2)
  centerTextInt("| Genesis 4",w+2)
  os.execute("setterm --blink off -foreground white")
  print("\n"..green)
  for i = ((pag)*10+1), (pag+1)*10 do
    local is = ""
    if i < 10 then is = "0"..i else is = i end
    if livros[i] and livros[i][1] ~= "FIM" then
      centerTextInt("["..green..is.."] "..livros[i][1],w)
    end
  end
  --centerText("|"..string.rep(" ", w).."|",termWidth)
  print("\n")
  centerTextInt("[".."88".."] MAIS...",w)
  centerTextInt("[".."99".."] ALEATORIO",w)
  centerTextInt("[".."00".."]".." SAIR",w)
  print(none)
  centerText("+"..string.rep("-", w).."+",termWidth)
  centerTextInt("|"..centerTextSTR("Escolha um livro",w+1).."|",w+1)
  centerText("+"..string.rep("-", w).."+",termWidth)
  print("\n")
  
  local cmd = io.read()
  
  if tonumber(cmd) == 0 then bye() end
  if tonumber(cmd) == 88 then choice(w,(pag+1)%math.floor(66/10+0.5)) end
  if tonumber(cmd) == 99 then random_cap() end
  
  if tonumber(cmd) and tonumber(cmd) < 67 and tonumber(cmd) >= 0 then choiceN(44,tonumber(cmd)) end

  choice(44,pag)
end

function choiceN(w,cap)
  cls()
  
  print("\n\n"..green)
  os.execute("figlet -c -f small GECKO")
  os.execute("setterm --blink off -foreground white")
  print("\n"..none)
  centerText("+"..string.rep("-", w).."+",termWidth)
  centerTextInt(" "..centerTextSTR("Um gerador de capitulos aleatórios",w+1).." ",w+1)
  --centerText("|"..string.rep(" ", w).."|",termWidth)
  centerText("+"..string.rep("-", w).."+",termWidth)
  --centerText("|"..string.rep(" ", w).."|",termWidth)
  centerTextInt("|"..centerTextSTR("coded by L7    Gecko v0.1 (beta)",w+1).."|",w+1)
  centerText("+"..string.rep("-", w).."+",termWidth)
  centerTextInt(fade.."| O ultimo capitulo visto foi:",w+2)
  centerTextInt("| Genesis 4",w+2)
  os.execute("setterm --blink off -foreground white")
  print("\n"..green)
  for i = 1, 10 do
    local str = ""
    for j = 0, 8 do
      if (i+10*j) < 10 then is = "0"..(i+10*j) else is = (i+10*j) end
      if (i+10*j) <= livros[cap][2] then
        --str = str.."["..(is).."] " --..string.rep(" ", 2)
        if (i+10*j) <= 90 then
          if (i+10*j) == 89 then str = str.."[..] " 
          elseif (i+10*j) == 90 then str = str.."["..(livros[cap][2]).."] "
          else str = str.."["..(is).."] " end
        else
          str = str.."["..(is).."] "
        end
      else 
        str = str.."    "
      end
    end
    centerTextInt(str,w)
  end
  print("\n")
  centerTextInt("[".."88".."] MAIS...",w)
  centerTextInt("[".."99".."] ALEATORIO",w)
  centerTextInt("[".."00".."] VOLTAR",w)
  print(none)
  centerText("+"..string.rep("-", w).."+",termWidth)
  centerTextInt("|"..centerTextSTR("Escolha um capitulo ",w+1).."|",w+1)
  centerText("+"..string.rep("-", w).."+",termWidth)
  print("\n")
  
  local cmd = io.read()
  
  if tonumber(cmd) == 0 then choice(44,0) end
  --if tonumber(cmd) == 88 then choice(w,(pag+1)%math.floor(66/10+0.5)) end
  if tonumber(cmd) == 99 then random_cap() end
  
  if tonumber(cmd) and tonumber(cmd) >= 0 and tonumber(cmd) <= livros[cap][2] then random_cap(cap,tonumber(cmd)) end
  
  choiceN(44,cap)
end

function bye()
  cls()
  print("\n"..green)
  os.execute("figlet -c -f small TCHAU")
  os.exit()
end

choice(44,0)
--random_cap()

-- VERSE LEEF
