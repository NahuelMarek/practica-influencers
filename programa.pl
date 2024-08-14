% Aquí va el código.
usuario(ana, [(youtube, 3000000), (instagram, 2700000), (tiktok, 1000000), (twitch,2)]).
usuario(beto, [(youtube, 6000000), (instagram, 1100000), (twitch,120000)]).
usuario(cami, [(tiktok, 2000 )]).
usuario(dani, [(youtube, 1000000)]).
usuario(evelyn, [(instagram, 1)]).

influencer(Usuario):-
    usuario(Usuario,_),
    sumarSubs(Usuario, SubsTotales),
    SubsTotales>10000.



sumarSubs(Usuario, SubsTotales):-
    usuario(Usuario,Lista),
    findall(Subs, member((_,Subs), Lista), ListaSoloSubs),
    sumlist(ListaSoloSubs, SubsTotales).

omnipresente(Usuario):-
    usuario(Usuario,_),
    not(noEsOmnipresente(Usuario)).

noEsOmnipresente(Usuario):-
    usuario(Usuario, Redes1),
    usuario(OtroUsuario, Redes2),
    Usuario\=OtroUsuario,
    member((Red,_), Redes2),
    not(member((Red,_), Redes1)).

exclusivo(Usuario):-
    usuario(Usuario, Lista),
    length(Lista, Tamano),
    Tamano=1.

red(tiktok).
red(instagram).
red(youtube).
red(twitch).

video(cami, youtube, 5, [cami]).
video(ana, tiktok, 1, [beto, evelyn]).
video(ana, tiktok, 1, [ana]).
foto(ana, instagram, [ana]).
foto(beto, instagram, []).
foto(evelyn, instagram, [evelyn,cami]).
stream(cami, twitch,leagueOfLegends, []).



tematicaDeJuegos(leagueOfLegends).
tematicaDeJuegos(minecraft).
tematicaDeJuegos(aoe).

adictiva(Red):-
    red(Red),
    not(tieneContenidoNoAdictivo(Red)).

tieneContenidoNoAdictivo(Red):-
    video(_,Red,Duracion,_),
    Duracion>=3.
tieneContenidoNoAdictivo(Red):-
    stream(_, Red, Tematica,_),
    not(tematicaDeJuegos(Tematica)).
tieneContenidoNoAdictivo(Red):-
    foto(_,Red, Integrantes),
    length(Integrantes,CantDeIntegrantes),
    CantDeIntegrantes<4.

colaboran(Usuario1,Usuario2):-
    apareceEnLaRedDe(Usuario1,Usuario2).
colaboran(Usuario1,Usuario2):-
    apareceEnLaRedDe(Usuario2,Usuario1).

apareceEnLaRedDe(Usuario2,Usuario1):-
    video(Usuario1, _, _, Aparecen),
    member(Usuario2,Aparecen).

apareceEnLaRedDe(Usuario2,Usuario1):-
    foto(Usuario1, _, Aparecen),
    member(Usuario2,Aparecen).

apareceEnLaRedDe(Usuario,Usuario):-
    stream(Usuario,_,_,_).
apareceEnLaRedDe(Usuario2,Usuario1):-
    stream(Usuario1,_,_,Aparecen),
    member(Usuario2,Aparecen).

caminoALaFama(Usuario):-
    usuario(Usuario,_),
    not(influencer(Usuario)),
    apareceEnLaRedDe(Usuario,Usuario2),
    influencer(Usuario2).

caminoALaFama(Usuario):-
    usuario(Usuario,_),
    not(influencer(Usuario)),
    apareceEnLaRedDeInfluencer(Usuario).

apareceEnLaRedDeInfluencer(Usuario):-
    usuario(Usuario,_),
    not(influencer(Usuario)),
    influencer(Influencer),
    apareceEnLaRedDe(Usuario,Influencer).
    

apareceEnLaRedDeInfluencer(Usuario):-
    usuario(Usuario,_),
    not(influencer(Usuario)),
    usuario(UsuarioIntermedio,_),
    Usuario\=UsuarioIntermedio,
    apareceEnLaRedDe(Usuario,UsuarioIntermedio),
    apareceEnLaRedDeInfluencer(UsuarioIntermedio).

