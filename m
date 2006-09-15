Return-Path: <jean-jacques.brucker@sagem.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_bluez_=3A_new_bluetooth_keyboard?=
 =?ISO-8859-1?Q?_supported_by_hidd=2E?=
Message-ID: <OF6F05A6E3.87C65DE9-ONC12571EA.005C0311-C12571EA.005E2464@sagem.com>
Date: Fri, 15 Sep 2006 19:08:16 +0200
From: "Jean-Jacques BRUCKER" <jean-jacques.brucker@sagem.com>
Content-Type: multipart/mixed; boundary="=_mixed 005E2462C12571EA_="
MIME-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

--=_mixed 005E2462C12571EA_=
Content-Type: multipart/alternative; boundary="=_alternative 005E2462C12571EA_="


--=_alternative 005E2462C12571EA_=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 Thx to answer me so fast, sorry that in the precedent patch i forget to=20
clean fakehid.c. This is done in this patch. As, I have see in the cvs you =

should have a J3 Keyboard too... :-)
About my Nokia, I know the applet but i don't have take the time to=20
analyse source codes.

 Gonna retry to suscribe list with webform at home.



  -  -  -  -  -  -  -
Cordialement,
Jean-Jacques.





Marcel Holtmann <marcel@holtmann.org>

15/09/2006 18:34
Remis le : 15/09/2006 18:33

=20
        Pour :  Jean-Jacques BRUCKER <jean-jacques.brucker@sagem.com>
        cc :    bluez-devel@lists.sourceforge.net
        Objet : Re: bluez : new bluetooth keyboard supported by hidd.



Hi Jean-Jacques,

> I have recently bought a bluetooth "Smart Keyboard" for my Nokia 770.
> But this keyboard, doesn't have a sdp server and was not supported by
> bluez-tools.
>=20
> (Here are the caracteristics of my keyboard:=20
>         bd addr : 00:0A:3A:2E:7B:AC
>         name : KEYBOARD
>         CoD (Class of Device/Service) : 0x001f00
> )
>=20
> So i have make some change in your source code to support him.
> Here is my patch and the patched tar.gz (with my makefiles, and i have
> verify that files wasn't modified recently on CVS).
>=20
> As you will see i have created a new file devices.h and i have
> suggested an architecture to manage different peripherals.

I have put a file fakehid.txt in the CVS with the characteristics of
this keyboard and also the presenter device.

> As I work for Sagem Communication, this keyboard now will work on our
> Sagem Linux phone (in developpement).

Make sure to send me one for testing ;)

> (I Gonna make it work now on my Nokia 770, but I don't know how to do
> it yet, as it use dbus... and i am asking me if that was really
> necessary, and if hidd is used on the Nokia 770...).

The Nokia 770 has no supported HID support. However you can install an
applet that gives you keyboard support. This however runs hidd and so it
should not be a big problem to integrate it.

> I notice the hidd deamon may need some minor improvement now, like
> forking and doing a "search device" on a signal event. Or reading a
> configuration file that contains knows devices and connect them on
> other signal... (or using dbus... ?). (just thinking... trying to
> share ideas...).

The hidd needs D-Bus support and a small redesign. However at the moment
we are just finishing the D-Bus support in hcid and its sdpd integration
and so it might take some time before we start looking at hidd. However
feel free to propose something.

> PS: I don't have a "secure" mail server to suscribe myself to
> bluez-devel mail list. So could you please add one of my email to the
> bluez-devel mail list ?
> (personnal email: jjbrucker@free.fr, professionnal email:
> jean-jacques.brucker@sagem.com, should be the one in sender field of
> this email).

No idea what this means. Nobody needs a secure mail server to subscribe
to bluez-devel. Simply use the webform to subscribe.

> PS2: Any comments about my patche are welcome...

It needs a little bit nicer and cleaner integration work, but it seem a
good step forward to make this keyboard work under Linux.

Regards

Marcel







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
--=_alternative 005E2462C12571EA_=
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">&nbsp;Thx to answer me so fast, sorr=
y that in the precedent patch i forget to clean fakehid.c. This is done in =
this patch. As, I have see in the cvs you should have a J3 Keyboard too... =
:-)</font><br><font size=3D2 face=3D"sans-serif">About my Nokia, I know the=
 applet but i don't have take the time to analyse source codes.</font><br><=
br><font size=3D2 face=3D"sans-serif">&nbsp;Gonna retry to suscribe list wi=
th webform at home.</font><br><br><br><br><font size=3D2 face=3D"sans-serif=
">&nbsp; - &nbsp;- &nbsp;- &nbsp;- &nbsp;- &nbsp;- &nbsp;-<br>Cordialement,=
<br>Jean-Jacques.<br></font><br><br><br><table width=3D100%><tr valign=3Dto=
p><td><td><font size=3D1 face=3D"sans-serif"><b>Marcel Holtmann &lt;marcel@=
holtmann.org&gt;</b></font><br><p><font size=3D1 face=3D"sans-serif">15/09/=
2006 18:34</font><br><font size=3D1 face=3D"sans-serif">Remis le : 15/09/20=
06 18:33</font><br><td><font size=3D1 face=3D"Arial">&nbsp; &nbsp; &nbsp; &=
nbsp; </font><br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &n=
bsp; Pour : &nbsp; &nbsp; &nbsp; &nbsp;Jean-Jacques BRUCKER &lt;jean-jacque=
s.brucker@sagem.com&gt;</font><br><font size=3D1 face=3D"sans-serif">&nbsp;=
 &nbsp; &nbsp; &nbsp; cc : &nbsp; &nbsp; &nbsp; &nbsp;bluez-devel@lists.sou=
rceforge.net</font><br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nb=
sp; &nbsp; Objet : &nbsp; &nbsp; &nbsp; &nbsp;Re: bluez : new bluetooth key=
board supported by hidd.</font><br></table><br><br><br><font size=3D2 face=
=3D"Courier New">Hi Jean-Jacques,<br><br>&gt; I have recently bought a blue=
tooth &quot;Smart Keyboard&quot; for my Nokia 770.<br>&gt; But this keyboar=
d, doesn't have a sdp server and was not supported by<br>&gt; bluez-tools.<=
br>&gt; <br>&gt; (Here are the caracteristics of my keyboard: &nbsp;<br>&gt=
; &nbsp; &nbsp; &nbsp; &nbsp; bd addr : 00:0A:3A:2E:7B:AC<br>&gt; &nbsp; &n=
bsp; &nbsp; &nbsp; name : KEYBOARD<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; CoD =
(Class of Device/Service) : 0x001f00<br>&gt; )<br>&gt; <br>&gt; So i have m=
ake some change in your source code to support him.<br>&gt; Here is my patc=
h and the patched tar.gz (with my makefiles, and i have<br>&gt; verify that=
 files wasn't modified recently on CVS).<br>&gt; <br>&gt; As you will see i=
 have created a new file devices.h and i have<br>&gt; suggested an architec=
ture to manage different peripherals.<br><br>I have put a file fakehid.txt =
in the CVS with the characteristics of<br>this keyboard and also the presen=
ter device.<br><br>&gt; As I work for Sagem Communication, this keyboard no=
w will work on our<br>&gt; Sagem Linux phone (in developpement).<br><br>Mak=
e sure to send me one for testing ;)<br><br>&gt; (I Gonna make it work now =
on my Nokia 770, but I don't know how to do<br>&gt; it yet, as it use dbus.=
.. and i am asking me if that was really<br>&gt; necessary, and if hidd is =
used on the Nokia 770...).<br><br>The Nokia 770 has no supported HID suppor=
t. However you can install an<br>applet that gives you keyboard support. Th=
is however runs hidd and so it<br>should not be a big problem to integrate =
it.<br><br>&gt; I notice the hidd deamon may need some minor improvement no=
w, like<br>&gt; forking and doing a &quot;search device&quot; on a signal e=
vent. Or reading a<br>&gt; configuration file that contains knows devices a=
nd connect them on<br>&gt; other signal... (or using dbus... ?). (just thin=
king... trying to<br>&gt; share ideas...).<br><br>The hidd needs D-Bus supp=
ort and a small redesign. However at the moment<br>we are just finishing th=
e D-Bus support in hcid and its sdpd integration<br>and so it might take so=
me time before we start looking at hidd. However<br>feel free to propose so=
mething.<br><br>&gt; PS: I don't have a &quot;secure&quot; mail server to s=
uscribe myself to<br>&gt; bluez-devel mail list. So could you please add on=
e of my email to the<br>&gt; bluez-devel mail list ?<br>&gt; (personnal ema=
il: jjbrucker@free.fr, professionnal email:<br>&gt; jean-jacques.brucker@sa=
gem.com, should be the one in sender field of</font><br><font size=3D2 face=
=3D"Courier New">&gt; this email).<br><br>No idea what this means. Nobody n=
eeds a secure mail server to subscribe<br>to bluez-devel. Simply use the we=
bform to subscribe.<br><br>&gt; PS2: Any comments about my patche are welco=
me...<br><br>It needs a little bit nicer and cleaner integration work, but =
it seem a<br>good step forward to make this keyboard work under Linux.<br><=
br>Regards<br><br>Marcel<br><br><br></font><br><br><BR>
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
--=_alternative 005E2462C12571EA_=--

--=_mixed 005E2462C12571EA_=
Content-Type: application/octet-stream; name="hidd_enhance2.patch.bz2"
Content-Disposition: attachment; filename="hidd_enhance2.patch.bz2"
Content-Transfer-Encoding: base64

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
ILSSaYY=

--=_mixed 005E2462C12571EA_=--
