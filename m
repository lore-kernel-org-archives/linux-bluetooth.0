Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Feb 2008 14:32:06 +0530 (IST)
From: Andrew William <andrewonwork@yahoo.co.in>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <286841.74554.qm@web94010.mail.in2.yahoo.com>
Subject: Re: [Bluez-devel] problem in audio service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0956532814=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0956532814==
Content-Type: multipart/alternative; boundary="0-638866636-1202374926=:74554"

--0-638866636-1202374926=:74554
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi johan=0AThanks for reply =0Atried this but no change =0AXYZ@localhost Bl=
ueZ]$ dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bl=
uez /org/bluez org.bluez.Manager.ActivateService string:audio=0Amethod retu=
rn sender=3D:1.86 -> dest=3D:1.110=0A   string ":1.111"=0AXYZ@localhost Blu=
eZ]$ dbus-send --system --type=3Dmethod_call --print-reply --dest=3D":1.111=
" /org/bluez/audio org.bluez.audio.Manager.CreateHeadset string:00:0F:DE:B1=
:02:42=0AError org.freedesktop.DBus.Error.ServiceUnknown: The name :1.111 w=
as not provided by any .service files=0A=0A=0A----- Original Message ----=
=0AFrom: Johan Hedberg <johan.hedberg@gmail.com>=0ATo: BlueZ development <b=
luez-devel@lists.sourceforge.net>=0ASent: Thursday, 7 February, 2008 2:09:1=
5 PM=0ASubject: Re: [Bluez-devel] problem in audio service=0A=0AHi =0AAndre=
w,=0A=0AOn =0AFeb =0A7, =0A2008, =0Aat =0A7:42, =0AAndrew =0AWilliam =0Awro=
te:=0A> =0AXYZ@localhost =0Asbc]$ =0Adbus-send =0A--system =0A--type=3Dmeth=
od_call =0A--print- =0A> =0Areply =0A--dest=3Dorg.bluez =0A/org/bluez =0Aor=
g.bluez.Manager.ActivateService  =0A> =0Astring:audio=0A> =0Amethod =0Aretu=
rn =0Asender=3D:1.56 =0A-> =0Adest=3D:1.59=0A>  =0A  =0Astring =0A":1.60"=
=0A>=0A> =0AXYZ@localhost =0Asbc]$ =0Adbus-send =0A--system =0A--type=3Dmet=
hod_call =0A--print- =0A> =0Areply =0A--dest=3D":1.59" =0A/org/bluez/audio =
 =0A> =0Aorg.bluez.audio.Manager.CreateHeadset =0Astring:00:0F:DE:B1:02:42=
=0A> =0AError =0Aorg.freedesktop.DBus.Error.ServiceUnknown: =0AThe =0Aname =
=0A:1.59 =0Awas  =0A> =0Anot =0Aprovided =0Aby =0Aany =0A.service =0Afiles=
=0A>=0A> =0AWhat =0Ais =0Athis =0Aerror? =0ACan =0Asomeone =0Atell =0Ame =
=0Awhat =0Ais =0Abeing =0Amissed =0Ahere?=0A=0AThe =0Avalue =0Aof =0Athe =
=0Astring =0Aparameter =0Ain =0Athe =0Areply =0Awas =0A":1.60" =0Aif =0Ayou=
 =0Alook  =0Aclosely. =0AThat's =0Awhat =0Ayou =0Ashould =0Ahave =0Aused. =
=0AThe =0A"dest=3D:1.59" =0Ais =0Ajust  =0Adebug =0Aoutput =0Afrom =0Adbus-=
send =0Atelling =0Aproperties =0Aof =0Athe =0Amethod =0Areturn  =0Amessage =
=0Athat =0Ait =0Agot =0A(i.e. =0A"1:59" =0Abeing =0Athe =0Aunique =0Aname =
=0Athat =0Adbus-send  =0Ahad =0Aduring =0Athe =0Ashort =0Atime =0Athat =0Ai=
t =0Awas =0Aconnected =0Ato =0Athe =0Abus, =0Awhich =0Aalso  =0Aexplains =
=0Athe =0Aerror =0Ayou =0Agot =0Ain =0Athe =0Asecond =0Acommand =0Asince =
=0Athe =0Afirst =0Adbus- =0Asend =0Aprocess =0Adidn't =0Aexist =0Aanymore).=
=0A=0AJohan=0A=0A----------------------------------------------------------=
---------------=0AThis =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicr=
osoft=0ADefy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2=
008.=0Ahttp://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=0A__________=
_____________________________________=0ABluez-devel =0Amailing =0Alist=0ABl=
uez-devel@lists.sourceforge.net=0Ahttps://lists.sourceforge.net/lists/listi=
nfo/bluez-devel=0A=0A=0A=0A=0A=0A=0A      Unlimited freedom, unlimited stor=
age. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/t=
ools-08.html/
--0-638866636-1202374926=:74554
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">hi johan<br>Thanks for reply <br>tried this but no =
change <br>XYZ@localhost BlueZ]$ dbus-send --system --type=3Dmethod_call --=
print-reply --dest=3Dorg.bluez /org/bluez org.bluez.Manager.ActivateService=
 string:audio<br>method return sender=3D:1.86 -&gt; dest=3D:1.110<br>&nbsp;=
&nbsp; string ":1.111"<br>XYZ@localhost BlueZ]$ dbus-send --system --type=
=3Dmethod_call --print-reply --dest=3D":1.111" /org/bluez/audio org.bluez.a=
udio.Manager.CreateHeadset string:00:0F:DE:B1:02:42<br>Error org.freedeskto=
p.DBus.Error.ServiceUnknown: The name :1.111 was not provided by any .servi=
ce files<br><br><br><div style=3D"font-family: times new roman,new york,tim=
es,serif; font-size: 12pt;">----- Original Message ----<br>From: Johan Hedb=
erg
 &lt;johan.hedberg@gmail.com&gt;<br>To: BlueZ development &lt;bluez-devel@l=
ists.sourceforge.net&gt;<br>Sent: Thursday, 7 February, 2008 2:09:15 PM<br>=
Subject: Re: [Bluez-devel] problem in audio service<br><br>Hi =0AAndrew,<br=
><br>On =0AFeb =0A7, =0A2008, =0Aat =0A7:42, =0AAndrew =0AWilliam =0Awrote:=
<br>&gt; =0AXYZ@localhost =0Asbc]$ =0Adbus-send =0A--system =0A--type=3Dmet=
hod_call =0A--print- <br>&gt; =0Areply =0A--dest=3Dorg.bluez =0A/org/bluez =
=0Aorg.bluez.Manager.ActivateService&nbsp; <br>&gt; =0Astring:audio<br>&gt;=
 =0Amethod =0Areturn =0Asender=3D:1.56 =0A-&gt; =0Adest=3D:1.59<br>&gt;&nbs=
p; =0A&nbsp; =0Astring =0A":1.60"<br>&gt;<br>&gt; =0AXYZ@localhost =0Asbc]$=
 =0Adbus-send =0A--system =0A--type=3Dmethod_call =0A--print- <br>&gt; =0Ar=
eply =0A--dest=3D":1.59" =0A/org/bluez/audio&nbsp; <br>&gt; =0Aorg.bluez.au=
dio.Manager.CreateHeadset =0Astring:00:0F:DE:B1:02:42<br>&gt; =0AError =0Ao=
rg.freedesktop.DBus.Error.ServiceUnknown: =0AThe =0Aname =0A:1.59 =0Awas&nb=
sp; <br>&gt; =0Anot =0Aprovided =0Aby =0Aany =0A.service =0Afiles<br>&gt;<b=
r>&gt; =0AWhat =0Ais =0Athis =0Aerror? =0ACan =0Asomeone =0Atell =0Ame =0Aw=
hat =0Ais =0Abeing =0Amissed =0Ahere?<br><br>The =0Avalue =0Aof =0Athe =0As=
tring =0Aparameter =0Ain =0Athe =0Areply =0Awas =0A":1.60" =0Aif =0Ayou =0A=
look&nbsp; <br>closely. =0AThat's =0Awhat =0Ayou =0Ashould =0Ahave =0Aused.=
 =0AThe =0A"dest=3D:1.59" =0Ais =0Ajust&nbsp; <br>debug =0Aoutput =0Afrom =
=0Adbus-send =0Atelling =0Aproperties =0Aof =0Athe =0Amethod =0Areturn&nbsp=
; <br>message =0Athat =0Ait =0Agot =0A(i.e. =0A"1:59" =0Abeing =0Athe =0Aun=
ique =0Aname =0Athat =0Adbus-send&nbsp; <br>had =0Aduring =0Athe =0Ashort =
=0Atime =0Athat =0Ait =0Awas =0Aconnected =0Ato =0Athe =0Abus, =0Awhich =0A=
also&nbsp; <br>explains =0Athe =0Aerror =0Ayou =0Agot =0Ain =0Athe =0Asecon=
d =0Acommand =0Asince =0Athe =0Afirst =0Adbus- <br>send =0Aprocess =0Adidn'=
t =0Aexist =0Aanymore).<br><br>Johan<br><br>-------------------------------=
------------------------------------------<br>This =0ASF.net =0Aemail =0Ais=
 =0Asponsored =0Aby: =0AMicrosoft<br>Defy =0Aall =0Achallenges. =0AMicrosof=
t(R) =0AVisual =0AStudio =0A2008.<br><a href=3D"http://clk.atdmt.com/MRT/go=
/vse0120000070mrt/direct/01/" target=3D"_blank">http://clk.atdmt.com/MRT/go=
/vse0120000070mrt/direct/01/</a><br>_______________________________________=
________<br>Bluez-devel =0Amailing =0Alist<br><a ymailto=3D"mailto:Bluez-de=
vel@lists.sourceforge.net" href=3D"mailto:Bluez-devel@lists.sourceforge.net=
">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcef=
orge.net/lists/listinfo/bluez-devel" target=3D"_blank">https://lists.source=
forge.net/lists/listinfo/bluez-devel</a><br></div><br></div></div><br>=0A=
=0A=0A      <!--2--><hr size=3D1></hr> Did you know? You can CHAT without d=
ownloading messenger. <a href=3D"http://in.rd.yahoo.com/tagline_webmessenge=
r_2/*http://in.messenger.yahoo.com/webmessengerpromo.php"> Click here</a></=
body></html>
--0-638866636-1202374926=:74554--


--===============0956532814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0956532814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0956532814==--
