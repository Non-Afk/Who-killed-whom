person(alice).
person(husband).
person(son).
person(daughter).
person(brother).

child(son).
child(daughter).

/*set gender*/
male(husband).
male(son).
male(brother).
female(alice).
female(daughter).

/*Set twins*/
twin(alice,brother).
twin(brother,alice).
twin(son,daughter).
twin(daughter,son).
istwin(X):-twin(X,_).

/*Set ages*/
younger(son, alice).
younger(daughter,alice).
younger(son,husband).
younger(daughter,husband).
younger(son,brother).
younger(daughter,brother).

/*One of the children was alone at the time of the murder.*/
alone(P):-
    child(P).

/*A man and a woman were together in the bar at the time of the murder.*/
bar(F,M):-
    person(F),female(F),
    person(M),male(M).

/*Alice and her husband were not together at the time of the murder.*/
notTogether(A,H):-A=alice,H=husband.
notTogether(A,H):-A=husband,H=alice.

/*Research function*/
searching(Killer,Victim,Bara,Barb,Alone):-
    person(Killer),
    person(Victim),

/*The victim's twin was innocent.*/
    istwin(Victim),
    \+ twin(Killer,Victim),

/*The killer was younger than the victim.*/
    younger(Victim,Killer),

/*Alice and her husband were not together at the time of the murder.*/
    \+ notTogether(Killer,Victim),
    Killer\=Victim,

/*Killer and Victim were not in the bar*/
    bar(Bara,Barb),
    Bara\=Killer,Barb\=Victim,
    Bara\=Victim,Barb\=Killer,

/*Alice and husband were not together*/
    \+ notTogether(Bara,Barb),

    alone(Alone),
    Alone\=Bara,Alone\=Barb,
    Alone\=Killer,Alone\=Victim.

/*Print output*/
printOut:-
    searching(Killer,Victim,Bara,Barb,Alone),
    write(Killer),
    write(' killed '),
    write(Victim),nl,
    write(Bara),
    write(' and '),
    write(Barb),
    write(' were together in the bar.'),nl,
    write(Alone),
    write(' was alone.').

/*Running code*/
?- printOut.