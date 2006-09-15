Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <OFE46EC5CE.E48BB4E7-ONC12571EA.00581EAB-C12571EA.00593B4C@sagem.com>
Date: Fri, 15 Sep 2006 18:14:38 +0200
From: "Jean-Jacques BRUCKER" <jean-jacques.brucker@sagem.com>
Content-Type: multipart/mixed; boundary="=_mixed 00593B4AC12571EA_="
MIME-Version: 1.0
Subject: [Bluez-devel] bluez : new bluetooth keyboard supported by hidd.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--=_mixed 00593B4AC12571EA_=
Content-Type: multipart/alternative;
	boundary="=_alternative 00593B4AC12571EA_="


--=_alternative 00593B4AC12571EA_=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The message I send before was too big (cause of the joined tar.gz) and=20
Marcel is "abwesend". As i suggest he is the list moderator, my precedent e=
mail could be=20
unread for a month. That is why I re-send this lighter email.

PS: Sorry to use Lotus Notes (running with wine). But I don't have direct=20
access to internet in my office room and I can't send "better" emails.

  -  -  -  -  -  -  -
Cordialement,
Jean-Jacques.
Poste : 92 26
----- R=E9achemin=E9 par Jean-Jacques BRUCKER/EXT/SAGEM le 15/09/2006 18:02=
=20
-----


Jean-Jacques BRUCKER

15/09/2006 17:47

=20
        Pour :  marcel@holtmann.org
        cc :    bluez-devel@lists.sourceforge.net
        Objet : bluez : new bluetooth keyboard supported by hidd.


 Hello,
I have recently bought a bluetooth "Smart Keyboard" for my Nokia 770.
But this keyboard, doesn't have a sdp server and was not supported by=20
bluez-tools.

(Here are the caracteristics of my keyboard:=20
        bd addr : 00:0A:3A:2E:7B:AC
        name : KEYBOARD
        CoD (Class of Device/Service) : 0x001f00
)

So i have make some change in your source code to support him.
Here is my patch and the patched tar.gz (with my makefiles, and i have=20
verify that files wasn't modified recently on CVS).

As you will see i have created a new file devices.h and i have suggested=20
an architecture to manage different peripherals.

As I work for Sagem Communication, this keyboard now will work on our=20
Sagem Linux phone (in developpement).
(I Gonna make it work now on my Nokia 770, but I don't know how to do it=20
yet, as it use dbus... and i am asking me if that was really necessary,=20
and if hidd is used on the Nokia 770...).

I notice the hidd deamon may need some minor improvement now, like forking =

and doing a "search device" on a signal event. Or reading a configuration=20
file that contains knows devices and connect them on other signal... (or=20
using dbus... ?). (just thinking... trying to share ideas...).

PS: I don't have a "secure" mail server to suscribe myself to bluez-devel=20
mail list. So could you please add one of my email to the bluez-devel mail =

list ?
(personnal email: jjbrucker@free.fr, professionnal email:=20
jean-jacques.brucker@sagem.com, should be the one in sender field of this=20
email).

PS2: Any comments about my patche are welcome...
=20


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
--=_alternative 00593B4AC12571EA_=
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">The message I send before was too bi=
g (cause of the joined tar.gz) and Marcel is &quot;</font><font size=3D2 fa=
ce=3D"Courier New">abwesend</font><font size=3D2 face=3D"sans-serif">&quot;=
. As i suggest he is the list moderator, my precedent email could be unread=
 for a month. That is why I re-send this lighter email.</font><br><br><font=
 size=3D2 face=3D"sans-serif">PS: Sorry to use Lotus Notes (running with wi=
ne). But I don't have direct access to internet in my office room and I can=
't send &quot;better&quot; emails.</font><br><br><font size=3D2 face=3D"san=
s-serif">&nbsp; - &nbsp;- &nbsp;- &nbsp;- &nbsp;- &nbsp;- &nbsp;-<br>Cordia=
lement,<br>Jean-Jacques.<br>Poste : 92 26</font><br><font size=3D1 color=3D=
#800080 face=3D"sans-serif">----- R=E9achemin=E9 par Jean-Jacques BRUCKER/E=
XT/SAGEM le 15/09/2006 18:02 -----</font><br><table width=3D100%><tr valign=
=3Dtop><td><td><font size=3D1 face=3D"sans-serif"><b>Jean-Jacques BRUCKER</=
b></font><br><p><font size=3D1 face=3D"sans-serif">15/09/2006 17:47</font><=
br><td><font size=3D1 face=3D"Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font><br=
><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Pour : &nbs=
p; &nbsp; &nbsp; &nbsp;marcel@holtmann.org</font><br><font size=3D1 face=3D=
"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc : &nbsp; &nbsp; &nbsp; &nbsp;bl=
uez-devel@lists.sourceforge.net</font><br><font size=3D1 face=3D"sans-serif=
">&nbsp; &nbsp; &nbsp; &nbsp; Objet : &nbsp; &nbsp; &nbsp; &nbsp;bluez : ne=
w bluetooth keyboard supported by hidd.</font><br></table><br><br><font siz=
e=3D2 face=3D"sans-serif">&nbsp;Hello,</font><br><font size=3D2 face=3D"san=
s-serif">I have recently bought a bluetooth &quot;Smart Keyboard&quot; for =
my Nokia 770.</font><br><font size=3D2 face=3D"sans-serif">But this keyboar=
d, doesn't have a sdp server and was not supported by bluez-tools.</font><b=
r><br><font size=3D2 face=3D"sans-serif">(Here are the caracteristics of my=
 keyboard: &nbsp;</font><br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp=
; &nbsp; &nbsp; bd addr : 00:0A:3A:2E:7B:AC</font><br><font size=3D2 face=
=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; name : KEYBOARD</font><br><font=
 size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; CoD (Class of Dev=
ice/Service) : 0x001f00</font><br><font size=3D2 face=3D"sans-serif">)</fon=
t><br><br><font size=3D2 face=3D"sans-serif">So i have make some change in =
your source code to support him.</font><br><font size=3D2 face=3D"sans-seri=
f">Here is my patch and the patched tar.gz (with my makefiles, and i have v=
erify that files wasn't modified recently on CVS).</font><br><br><font size=
=3D2 face=3D"sans-serif">As you will see i have created a new file devices.=
h and i have suggested an architecture to manage different peripherals.</fo=
nt><br><br><font size=3D2 face=3D"sans-serif">As I work for Sagem Communica=
tion, this keyboard now will work on our Sagem Linux phone (in developpemen=
t).</font><br><font size=3D2 face=3D"sans-serif">(I Gonna make it work now =
on my Nokia 770, but I don't know how to do it yet, as it use dbus... and i=
 am asking me if that was really necessary, and if hidd is used on the Noki=
a 770...).</font><br><br><font size=3D2 face=3D"sans-serif">I notice the hi=
dd deamon may need some minor improvement now, like forking and doing a &qu=
ot;search device&quot; on a signal event. Or reading a configuration file t=
hat contains knows devices and connect them on other signal... (or using db=
us... ?). (just thinking... trying to share ideas...).</font><br><br><font =
size=3D2 face=3D"sans-serif">PS: I don't have a &quot;secure&quot; mail ser=
ver to suscribe myself to bluez-devel mail list. So could you please add on=
e of my email to the bluez-devel mail list ?</font><br><font size=3D2 face=
=3D"sans-serif">(personnal email: jjbrucker@free.fr, professionnal email: j=
ean-jacques.brucker@sagem.com, should be the one in sender field of this em=
ail).</font><br><br><font size=3D2 face=3D"sans-serif">PS2: Any comments ab=
out my patche are welcome...</font><br><font size=3D2 face=3D"sans-serif">&=
nbsp;</font><br><br><br><font size=3D2 face=3D"sans-serif">&nbsp; - &nbsp;-=
 &nbsp;- &nbsp;- &nbsp;- &nbsp;- &nbsp;-<br>Cordialement,<br>Jean-Jacques.<=
/font><br><BR>
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
--=_alternative 00593B4AC12571EA_=--

--=_mixed 00593B4AC12571EA_=
Content-Type: application/octet-stream; name="hidd_enhance.patch.bz2"
Content-Disposition: attachment; filename="hidd_enhance.patch.bz2"
Content-Transfer-Encoding: base64

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
AIMN6tl7o4zLxn/i7kinChIPlQf4AA==

--=_mixed 00593B4AC12571EA_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=_mixed 00593B4AC12571EA_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=_mixed 00593B4AC12571EA_=--
