/* ******************************************************
 *
 * SIO 2023-2024 - Labo 3 : Répartition équitable
 *
 * Groupe : K
 *
 * Nom et prénom : Herman Loïc
 *
****************************************************** */

/* ******************************************************
 *
 * Définition des paramètres
 *
 ****************************************************** */

/* -- Paramètres d'entrées -- */

param AmtGroups, integer, >= 1;
/* Nombre de groupes/personnes/boîtes */

param AmtObjects, integer, >= 1;
/* Nombre d'objets à répartir  */

param Values{i in 1..AmtObjects}, integer, >= 1;
/* Valeurs des objets à répartir */

/* -- Ensembles pour simplifier la définition des contraintes -- */

set Groups := 1..AmtGroups;
/* Ensemble des groupes/personnes/boîtes */

set Objects := 1..AmtObjects;
/* Ensemble des objets à répartir */

/* ******************************************************
 *
 * Définition du programme
 *
 ****************************************************** */

var x{i in Objects, j in Groups}, binary;
/* x[i,j] = 1 indique que l'objet i est assigné au groupe j */

var t;
/* t est une variable auxiliaire qui représente la valeur minimale 
   de la somme des valeurs des objets par groupe */

s.t. OneGroupPerObject{i in Objects}: sum{j in Groups} x[i,j] = 1;
/* Chaque objet ne peut être placé que dans un groupe à la fois */

s.t. MinimizingConstraint{j in Groups}: sum{i in Objects} x[i,j] * Values[i] >= t;
/* La somme des valeurs des objets par groupe doit être supérieure ou égale à t.
   Afin de permettre un objectif de "max-min" */

maximize MinimizingObjective: t;
/* L'objectif est de maximiser la valeur minimale de la somme 
   des valeurs des objets par groupe */

solve;

/* ******************************************************
 *
 * Affichage des résultats
 *
 ****************************************************** */

printf "\n"; printf{1..60} "="; printf "\n\n";
printf "Valeur minimale de la somme des valeurs des objets d'un groupe : %d\n", t;

printf "-----------------\n";
printf "Répartition des objets par groupe :\n";
printf{i in Objects, j in Groups: x[i,j] == 1} "Objet %2d de valeur %2d dans le groupe %d\n", i, Values[i], j;

printf "-----------------\n";
printf "Valeur des objets par groupe :\n";
printf{j in Groups} "Groupe %d : %d\n", j, sum{i in Objects} x[i,j] * Values[i];

printf "\n"; printf{1..60} "="; printf "\n\n";

/* ******************************************************
 *
 * Section Data
 *
 ****************************************************** */

data;

# Jeu de données n° 1

/* Nombre de groupes/personnes/boîtes */
param AmtGroups := 4;

/* Nombre d'objets à répartir  */
param AmtObjects := 13;

/* Valeur des objets à répartir  */
param Values :=
	 1	2
	 2	5
	 3	8
	 4	8
	 5	9
	 6	11
	 7	16
	 8	22
	 9	28
	10	31
	11	32
	12	34
	13	35
;

#################################

# Jeu de données n° 2

# /* Nombre de groupes/personnes/boîtes */
# param AmtGroups := 4;

# /* Nombre d'objets à répartir  */
# param AmtObjects := 14;

# /* Valeur des objets à répartir  */
# param Values :=
# 	 1	1
# 	 2	2
# 	 3	3
# 	 4	4
# 	 5	5
# 	 6	6
# 	 7	7
# 	 8	8
# 	 9	9
# 	10	10
# 	11	11
# 	12	12
# 	13	13
# 	14	14
# ;


end;
