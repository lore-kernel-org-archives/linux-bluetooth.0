Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Feb 2008 15:21:22 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <356106.66582.qm@web8402.mail.in.yahoo.com>
Subject: Re: [Bluez-devel] system hangs playing audio on headset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0409510851=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0409510851==
Content-Type: multipart/alternative; boundary="0-1902117600-1202291482=:66582"

--0-1902117600-1202291482=:66582
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for that hint=0AWhen I try =0A[root@localhost Pramod]# /usr/local/li=
b/bluetooth/bluetoothd-service-audio=0Athis is not working....=0Aaudio[1311=
7]: Bluetooth Audio daemon=0Aaudio[13117]: Unix socket created: 5=0Aaudio[1=
3117]: audio.conf: /etc/bluetooth/audio.conf: key Enable not found=0Aaudio[=
13117]: audio.conf: /etc/bluetooth/audio.conf: key Disable not found=0Aaudi=
o[13117]: Adding service record failed: Method "AddServiceRecord" with sign=
ature "ay" on interface "org.bluez.Database" doesn't exist=0Aaudio[13117]: =
Unable to register HS AG service record=0Aaudio[13117]: Unregistered manage=
r path=0Aaudio[13117]: Audio init failed!=0A=0AI saw those AddServiceRecord=
 scripts on bluez_Audio_HowTO..=0AHow to work them out?=0A =0A=0AThanks and=
 Best regards =0APramod=0A=0A----- Original Message ----=0AFrom: Marcel Hol=
tmann <marcel@holtmann.org>=0ATo: BlueZ development <bluez-devel@lists.sour=
ceforge.net>=0ACc: bluez-users@brisammon.fastmail.fm=0ASent: Wednesday, 6 F=
ebruary, 2008 2:53:02 PM=0ASubject: Re: [Bluez-devel] system hangs playing =
audio on headset=0A=0AHi =0APramod,=0A=0A> =0A4) =0AI =0Aam =0Ausing =0Alin=
ux-2.6.22 =0Akernel, =0ABluez-3.25 =0A(libs, =0Autils), =0Aalso=0A> =0Ainst=
alled =0APLUGS =0A& =0ASBC =0Afrom =0Asvn=0A>  =0A  =0A =0ABut =0Ai =0Acoul=
d =0Anot =0Aaplly =0ASCO =0Aflow =0Acontrol =0Apatch =0Ato =0Amy =0Akernel.=
...it=0A> =0Afailed..=0A> =0A> =0ANeed =0AI =0Agive =0Amore =0Ainfo =0Ato =
=0Aknow =0Awhats =0Agoing =0Awrong..=0A> =0AWhats =0Ais =0Athe =0Apatch =0A=
for  =0ASCO =0Aflow =0Acontrol =0Afor =0A2..6.22 =0A??=0A=0Atry =0Ausing =
=0Athe =0ABluetooth =0Aaudio =0Aservice =0A(which =0Acomes =0Awith =0A3.25)=
 =0Ainstead =0Aof=0Aexternal =0Aheadsetd. =0ASee =0Awiki.bluez.org =0Afor =
=0Ainstructions.=0A=0ARegards=0A=0AMarcel=0A=0A=0A=0A----------------------=
---------------------------------------------------=0AThis =0ASF.net =0Aema=
il =0Ais =0Asponsored =0Aby: =0AMicrosoft=0ADefy =0Aall =0Achallenges. =0AM=
icrosoft(R) =0AVisual =0AStudio =0A2008.=0Ahttp://clk.atdmt.com/MRT/go/vse0=
120000070mrt/direct/01/=0A_______________________________________________=
=0ABluez-devel =0Amailing =0Alist=0ABluez-devel@lists.sourceforge.net=0Ahtt=
ps://lists.sourceforge.net/lists/listinfo/bluez-devel=0A=0A=0A=0A=0A=0A=0A=
=0A      Why delete messages? Unlimited storage is just a click away. Go to=
 http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html
--0-1902117600-1202291482=:66582
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Thanks for that hint<br>When I try <br>[root@localhost Pram=
od]# /usr/local/lib/bluetooth/bluetoothd-service-audio<br>this is not worki=
ng....<br>audio[13117]: Bluetooth Audio daemon<br>audio[13117]: Unix socket=
 created: 5<br>audio[13117]: audio.conf: /etc/bluetooth/audio.conf: key Ena=
ble not found<br>audio[13117]: audio.conf: /etc/bluetooth/audio.conf: key D=
isable not found<br>audio[13117]: Adding service record failed: Method "Add=
ServiceRecord" with signature "ay" on interface "org.bluez.Database" doesn'=
t exist<br>audio[13117]: Unable to register HS AG service record<br>audio[1=
3117]: Unregistered manager path<br>audio[13117]: Audio init failed!<br><br=
><div>I saw those AddServiceRecord scripts on bluez_Audio_HowTO..<br>How to=
 work them out?<br>&nbsp;<br></div>Thanks and Best
 regards<div>&nbsp;</div><div>Pramod<div style=3D"font-family: times new ro=
man,new york,times,serif; font-size: 12pt;"><br><br><div style=3D"font-fami=
ly: times new roman,new york,times,serif; font-size: 12pt;">----- Original =
Message ----<br>From: Marcel Holtmann &lt;marcel@holtmann.org&gt;<br>To: Bl=
ueZ development &lt;bluez-devel@lists.sourceforge.net&gt;<br>Cc: bluez-user=
s@brisammon.fastmail.fm<br>Sent: Wednesday, 6 February, 2008 2:53:02 PM<br>=
Subject: Re: [Bluez-devel] system hangs playing audio on headset<br><br>Hi =
=0APramod,<br><br>&gt; =0A4) =0AI =0Aam =0Ausing =0Alinux-2.6.22 =0Akernel,=
 =0ABluez-3.25 =0A(libs, =0Autils), =0Aalso<br>&gt; =0Ainstalled =0APLUGS =
=0A&amp; =0ASBC =0Afrom =0Asvn<br>&gt;&nbsp; =0A&nbsp; =0A =0ABut =0Ai =0Ac=
ould =0Anot =0Aaplly =0ASCO =0Aflow =0Acontrol =0Apatch =0Ato =0Amy =0Akern=
el...it<br>&gt; =0Afailed..<br>&gt; <br>&gt; =0ANeed =0AI =0Agive =0Amore =
=0Ainfo =0Ato =0Aknow =0Awhats =0Agoing =0Awrong..<br>&gt; =0AWhats =0Ais =
=0Athe =0Apatch =0Afor&nbsp; =0ASCO =0Aflow =0Acontrol =0Afor =0A2..6.22 =
=0A??<br><br>try =0Ausing =0Athe =0ABluetooth =0Aaudio =0Aservice =0A(which=
 =0Acomes =0Awith =0A3.25) =0Ainstead =0Aof<br>external =0Aheadsetd. =0ASee=
 =0Awiki.bluez.org =0Afor =0Ainstructions.<br><br>Regards<br><br>Marcel<br>=
<br><br><br>---------------------------------------------------------------=
----------<br>This =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosof=
t<br>Defy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008=
..<br><a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" ta=
rget=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a>=
<br>_______________________________________________<br>Bluez-devel =0Amaili=
ng =0Alist<br><a ymailto=3D"mailto:Bluez-devel@lists.sourceforge.net" href=
=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge=
..net</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-d=
evel" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-=
devel</a><br></div><br></div></div></div><br>=0A=0A=0A      <!--4--><hr siz=
e=3D1></hr> 5, 50, 500, 5000 - Store N number of mails in your inbox. <a hr=
ef=3D"http://in.rd.yahoo.com/tagline_mail_4/*http://help.yahoo.com/l/in/yah=
oo/mail/yahoomail/tools/tools-08.html/">Click here.</a></body></html>
--0-1902117600-1202291482=:66582--



--===============0409510851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0409510851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0409510851==--
