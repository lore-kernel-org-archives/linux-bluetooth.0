Return-Path: <jean-jacques.brucker@sagem.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_R=E9f=2E_=3A_Re=3A_bluez_=3A_new?=
 =?ISO-8859-1?Q?_bluetooth_keyboard	supported_by_hidd=2E?=
Message-ID: <OF94D063E5.A6EB9011-ONC12571ED.0029C0F3-C12571ED.002ABA9E@sagem.com>
Date: Mon, 18 Sep 2006 09:46:42 +0200
From: "Jean-Jacques BRUCKER" <jean-jacques.brucker@sagem.com>
Content-Type: multipart/alternative; boundary="=_alternative 002ABA9BC12571ED_="
MIME-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

--=_alternative 002ABA9BC12571ED_=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 About the left space : it work but I have assigned it to Alt key. At the=20
end we need a special kmap file to be able to use all features of this=20
keybord, ( mine is an azerty keyboard), in this keymap file (or using=20
xmodmap with X) we could reassign left space button to space event and Alt =

gr button to Alt and Alt gr event !

 I have assigned this button to Alt because I missed him (to switch=20
between console for exemple), And to not loose a special keypress on the=20
keyboard. (it already have a few keys... only 63 !).

 At the end my patch suggested an architecture to manage different=20
peripherals. The code in is actual state will become a big mess if the=20
number of differents peripheral to manage increase.

Good morning !

  -  -  -  -  -  -  -
Cordialement,
Jean-Jacques.


" Ce courriel et les documents qui y sont attaches peuvent contenir des inf=
ormations confidentielles. Si vous n'etes  pas le destinataire escompte, me=
rci d'en informer l'expediteur imm=E9diatement et de detruire ce courriel  =
ainsi que tous les documents attaches de votre systeme informatique. Toute =
divulgation, distribution ou copie du pr=E9sent courriel et des documents a=
ttaches sans autorisation prealable de son emetteur est interdite."=20

" This e-mail and any attached documents may contain confidential or propri=
etary information. If you are not the intended recipient, please advise the=
 sender immediately and delete this e-mail and all attached documents from =
your computer system. Any unauthorised disclosure, distribution or copying =
hereof is prohibited."
--=_alternative 002ABA9BC12571ED_=
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">&nbsp;About the left space : it work=
 but I have assigned it to Alt key. At the end we need a special kmap file =
to be able to use all features of this keybord, ( mine is an azerty keyboar=
d), in this keymap file (or using xmodmap with X) we could reassign left sp=
ace button to space event and Alt gr button to Alt and Alt gr event !</font=
><br><br><font size=3D2 face=3D"sans-serif">&nbsp;I have assigned this butt=
on to Alt because I missed him (to switch between console for exemple), And=
 to not loose a special keypress on the keyboard. (it already have a few ke=
ys... only 63 !).</font><br><br><font size=3D2 face=3D"sans-serif">&nbsp;At=
 the end my patch suggested an architecture to manage different peripherals=
. The code in is actual state will become a big mess if the number of diffe=
rents peripheral to manage increase.</font><br><br><font size=3D2 face=3D"s=
ans-serif">Good morning !</font><br><br><font size=3D2 face=3D"sans-serif">=
&nbsp; - &nbsp;- &nbsp;- &nbsp;- &nbsp;- &nbsp;- &nbsp;-<br>Cordialement,<b=
r>Jean-Jacques.</font><BR>
<BR>
&quot; Ce courriel et les documents qui y sont attaches peuvent contenir de=
s informations confidentielles. Si vous n'etes  pas le destinataire escompt=
e, merci d'en informer l'expediteur imm=E9diatement et de detruire ce courr=
iel  ainsi que tous les documents attaches de votre systeme informatique. T=
oute divulgation, distribution ou copie du pr=E9sent courriel et des docume=
nts attaches sans autorisation prealable de son emetteur est interdite.&quo=
t; <BR>
<BR>
&quot; This e-mail and any attached documents may contain confidential or p=
roprietary information. If you are not the intended recipient, please advis=
e the sender immediately and delete this e-mail and all attached documents =
from your computer system. Any unauthorised disclosure, distribution or cop=
ying hereof is prohibited.&quot;<BR>
--=_alternative 002ABA9BC12571ED_=--
