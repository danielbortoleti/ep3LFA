#Participantes: 

#Daniel Bortoleti Melo, João Peres, Matteo Hernandez, Thiago Santos.

require 'raabro'
module Reconhecedor include Raabro

def soma(i);
seq(:soma, i,:y,:mais,:x);
end
def subtracao(i);
seq(:subtracao, i,:y,:menos,:x);
end
def multiplicacao(i);
seq(:multiplicacao, i,:n,:multi,:y);
end
def divisao(i);
seq(:divisao, i,:n,:div,:y);
end
def exponenciacao(i);
seq(:exponenciacao, i,:n,:elevado,:y);
end
def elevado(i);
rex(:elevado, i, /\^\s*/);
end
def multi(i);
rex(:multi, i, /\*\s*/);
end
def div(i);
rex(:div, i, /\/\s*/);
end
def menos(i);
rex(:menos, i, /\-\s*/);
end
def mais(i);
rex(:mais, i, /\+\s*/);
end
def num(i);
rex(:num, i, /[0-9]+\s*/);
end
def parentesesComeco(i);
rex(:parentesesComeco, i, /\(\s*/);
end
def parentesesFinal(i);
rex(:parentesesFinal, i, /\)\s*/);
end

def negativo(i);
seq(nil, i,:menos,:x);
end

def exp_parenteses(i);
seq(:exp_parenteses, i,:parentesesComeco,:x,:parentesesFinal);
end


def primaria(i);
alt(nil, i,:exponenciacao);
end
def secundaria(i);
alt(nil, i,:divisao,:multiplicacao);
end
def terciaria(i);
alt(nil, i,:subtracao,:soma);
end



def x(i);
alt(nil, i,:terciaria,:y);
end
def y(i);
alt(nil, i,:secundaria,:z);
end
def z(i);
alt(nil, i,:primaria,:n);
end
def n(i);
alt(nil, i,:exp_parenteses,:negativo,:num);
end

def expressao(i);
alt(:expressao, i,:soma,:subtracao,:multiplicacao,:divisao,:exponenciacao,:exp_parenteses,:negativo,:num);
end

def rewrite_num(t)
t.string
end

def rewrite_mais(t)
"soma"
end

def rewrite_menos(t)
"menos"
end

def rewrite_multi(t)
"multiplicacao"
end

def rewrite_div(t)
"divisao"
end

def rewrite_elevado(t)
"potencia"
end

def rewrite_parentesesComeco(t)
"parenteses"
end

def rewrite_parentesesFinal(t)
"parenteses"
end

def rewrite_divisao(t)
folhas = t.children
folhas.collect {
  | e | rewrite(e)
}.append()
end

def rewrite_exponenciacao(t)
folhas = t.children
folhas.collect {
  | e | rewrite(e)
}.append()
end

def rewrite_exp_parenteses(t)
folhas = t.children
folhas.collect {
  | e | rewrite(e)
}.append()
end

def rewrite_expressao(t)
folhas = t.children
folhas.collect {
  | e | rewrite(e)
}.append()
end
def rewrite_soma(t)
folhas = t.children
folhas.collect {
  | e | rewrite(e)
}.append()
end

def rewrite_subtracao(t)
folhas = t.children
folhas.collect {
  | e | rewrite(e)
}.append()
end

def rewrite_multiplicacao(t)
folhas = t.children
folhas.collect {
  | e | rewrite(e)
}.append()
end

end


#Output

p Reconhecedor.parse("(1+4) * 2^4")
puts
p Reconhecedor.parse("7 / (1-3)")
puts
p Reconhecedor.parse("9^(1*6 / 2+4)")
puts
p Reconhecedor.parse("2+4 ^ -4/4")
puts


p Reconhecedor.parse("^2 + 4", error:true)
puts
p Reconhecedor.parse("9*2 +", error:true)
puts
p Reconhecedor.parse("9++3", error:true)
puts
p Reconhecedor.parse("( )*3", error:true)
puts
p Reconhecedor.parse("(3 + 3", error:true)
puts