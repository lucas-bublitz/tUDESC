#import "../imports.typ": *



= Lista de Abreviaturas e Siglas

Este template oferece um sistema automatizado para gerenciar abreviaturas e siglas, garantindo consistência e gerando automaticamente uma "Lista de Abreviaturas e Siglas" no seu documento.

A funcionalidade é inteligente: na primeira vez que uma sigla é mencionada no texto, ela aparecerá por extenso, seguida da sigla entre parênteses. Nas menções seguintes, apenas a sigla será exibida.

- *Primeira menção:* Associação Brasileira de Normas Técnicas (ABNT)
- *Menções seguintes:* ABNT

Esta funcionalidade é uma implementação do excelente pacote `glossarium`. Para funcionalidades avançadas, consulte a #link("https://typst.app/universe/package/glossarium")[documentação oficial do glossarium].

== Como Utilizar: Passo a Passo

O processo é dividido em três etapas simples:
+ *Criar* um arquivo com a definição dos termos.
+ *Importar* e conectar essa lista ao seu documento principal.
+ *Utilizar* as siglas no seu texto.

#line(length: 100%)

=== Passo 1: Crie seu Arquivo de Termos

Para manter seu projeto organizado, recomendamos criar um arquivo separado para suas siglas, por exemplo, `siglas.typ`. Dentro deste arquivo, você definirá uma lista chamada `term-list`.

Cada item na lista é um dicionário que pode conter as seguintes chaves:

- `key`: O identificador único que você usará para chamar a sigla no texto (ex: `"abnt"`).
- `short`: A sigla ou abreviatura em si (ex: `[ABNT]`).
- `long`: O termo por extenso (ex: `[Associação Brasileira de Normas Técnicas]`).
- `plural`: (Opcional) A forma plural da sigla, se aplicável (ex: `[PCBs]`).
- `longplural`: (Opcional) A forma plural do termo por extenso (ex: `[Placas de Circuito Impresso]`).

#figure(
  caption: "Exemplo de um arquivo de definições `siglas.typ`.",
  [
    ```typst
    // Arquivo: siglas.typ
    // Defina todos os seus termos e abreviaturas aqui.

    #let term-list = (
      (
        key: "abnt",
        short: [ABNT],
        long: [Associação Brasileira de Normas Técnicas],
      ),
      (
        key: "i2c",
        short: [I2C],
        long: [_Inter-Integrated Circuit_],
      ),
      (
        key: "adj",
        short: [adj.],
        long: [adjetivo],
      ),
      (
        // Exemplo com suporte a plural
        key: "pcb",
        short: [PCB],
        plural: [PCBs],
        long: [Placa de Circuito Impresso],
        longplural: [Placas de Circuito Impresso],
      )
    )
    ```
  ],
)

#line(length: 100%)

=== Passo 2: Conecte a Lista ao seu Documento Principal

No seu arquivo principal (`documento.typ`, por exemplo), você precisa fazer duas coisas:
+ Importar a `term-list` do arquivo que você criou.
+ Passar essa lista para a função do template através do argumento `acronyms-terms`.

```typst
// Importa a lista de termos do nosso arquivo.
#import "terms.typ": term-list

// ... outras importações e configurações

// Passa a lista para o template.
#show: bellbird-udesc-paper.with(
  // ... outros argumentos como title, author, etc.

  acronyms-terms: term-list, // É aqui que a mágica acontece!

  // ... outros argumentos
)
```

#line(length: 100%)

=== Passo 3: Utilize as Siglas no Texto

Agora você está pronto para usar as siglas e abreviaturas no seu texto. Para inserir uma, simplesmente use `@` seguido pela `key` que você definiu.

- Para a forma singular, use: `@abnt`, `@pcb`.
- Para a forma plural (se definida), adicione `:pl`: `@pcb:pl`.

#figure(
  caption: "Exemplo de uso das siglas e abreviaturas no texto.",
  [
    ```typst
    // Dentro do corpo do seu documento:
    As normas da @abnt são fundamentais para trabalhos acadêmicos. Elas definem a estrutura e formatação.

    O projeto utiliza o protocolo de comunicação @i2c para conectar os microcontroladores.

    Neste capítulo, projetamos diversas @pcb:pl. Cada @pcb foi desenhada com cuidado.

    A palavra "belo" é um @adj.
    ```
  ],
)

=== Resultado Final

Ao compilar o documento com o texto acima, o Typst irá gerar o seguinte resultado:

#box(
  inset: 10pt,
  stroke: black,
  [
    As normas da @abnt são fundamentais para trabalhos acadêmicos. Elas definem a estrutura e formatação.

    O projeto utiliza o protocolo de comunicação @i2c para conectar os microcontroladores.

    Neste capítulo, projetamos diversas @pcb:pl. Cada @pcb foi desenhada com cuidado.

    A palavra "belo" é um @adj.
  ],
)


Adicionalmente, uma página intitulada "Lista de Abreviaturas e Siglas" será automaticamente criada e populada no seu documento.


