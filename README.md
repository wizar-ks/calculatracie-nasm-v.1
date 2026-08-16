🛠️ Calculatrice x86-64 NASM (Linux)
Petite calculatrice en ligne de commande écrite en assembleur x86-64 sous Linux. Codée sans librairie externe (sans C / libc), en utilisant directement les appels système (syscall) et la convention System V AMD64.

🚀 Ce que fait la v1.0
Affichage et Lecture : Communication directe avec le noyau Linux via sys_read (RAX = 0) et sys_write (RAX = 1).

Conversion ASCII ↔ INT : Algorithmes faits main pour convertir le texte saisi dans le terminal en entiers manipulables par le CPU, et inversement pour l'affichage.

Gestion des nombres négatifs : Prise en charge des résultats négatifs avec le complément à deux et affichage dynamique du signe -.

Adressage mémoire : Navigation efficace dans la mémoire avec l'adressage relatif [base + index].

Conventions de registres : Passage des arguments dans les registres standards (RDI pour l'adresse du buffer, RSI pour la taille) et protection des registres avec push / pop.

🧰 Prérequis
Un système Linux (natif ou WSL2 sur Windows).

NASM (Netwide Assembler)

GNU ld (linker / éditeur de liens)

Pour installer les outils nécessaires sous Debian / Ubuntu / WSL :

Bash
sudo apt update
sudo apt install nasm build-essential
📦 Compilation et Exécution
Assembler le code source :

Bash
nasm -f elf64 calc.asm -o calc.o
Créer l'exécutable :

Bash
ld calc.o -o calc
Lancer le programme :

Bash
./calc
Saisis tes nombres dans le terminal et appuie sur Entrée pour voir le résultat.

🧠 Organisation des registres
RDI : Adresse mémoire du buffer (.data ou .bss).

RSI : Taille du buffer ou deuxième paramètre.

RAX : Numéro du syscall (0 pour lire, 1 pour écrire) et valeur de retour du calcul.

📅 La suite (Roadmap)
[x] v1.0 : Calculatrice de base, gestion du signe - et respect des conventions RDI/RSI.

[ ] v2.0 : Gestion complète des nombres à plusieurs chiffres (multi-digits).

[ ] v3.0 : Ajout de la multiplication (imul) et de la division (idiv).

📄 Licence
Projet open-source sous licence MIT.
