Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Feb 2008 16:29:55 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <605264.10985.qm@web8411.mail.in.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============1940879720=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1940879720==
Content-Type: multipart/alternative; boundary="0-266349495-1202295595=:10985"

--0-266349495-1202295595=:10985
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks again=0AI now use these command to stop and start hcid...its working=
 fine...=0A=0A[root@localhost Pramod]# /etc/init.d/bluetooth start=0AStarti=
ng Bluetooth subsystem: hcid hid2hci.=0A[root@localhost Pramod]# /etc/init.=
d/bluetooth stop=0AStopping Bluetooth subsystem: hcid.=0A=0ABut after runni=
ng audio service same error come again and i am not able to connect to head=
set=0Avia rfcomm which was happening when I was using default set of BT uti=
ls in /usr/sbin & /usr/bin=0A=0Awhy is it so????=0A=0A =0AThanks and Best r=
egards =0APramod=0A=0A----- Original Message ----=0AFrom: Marcel Holtmann <=
marcel@holtmann.org>=0ATo: BlueZ development <bluez-devel@lists.sourceforge=
..net>=0ASent: Wednesday, 6 February, 2008 4:13:34 PM=0ASubject: Re: [Bluez-=
devel] system hangs playing audio on headset=0A=0AHi =0AParmod,=0A=0A> =0Ah=
ere =0Aare =0Athings =0AI =0Adif =0Athis =0Atime. =0Ai =0Aused =0Ahcid =0Af=
rom =0A3.25 =0Athis =0Aearlier =0Ait=0A> =0Awas =0Adefault =0Aone..=0A> =0A=
i =0AKilled =0Ahcid, =0Asdpd=0A> =0A1....[root@localhost =0APramod]# =0A/us=
r/local/sbin/hcid=0A> =0A-f =0A/etc/bluetooth/hcid.conf=0A> =0A2....[root@l=
ocalhost =0APramod]# =0A/usr/local/sbin/sdpd=0A=0Adon't =0Astart =0Asdpd. =
=0AUse =0Ahcid =0A-s =0Awhich =0Aincludes =0Athe =0ASDP =0Aserver.=0A=0AReg=
ards=0A=0AMarcel=0A=0A=0A=0A-----------------------------------------------=
--------------------------=0AThis =0ASF.net =0Aemail =0Ais =0Asponsored =0A=
by: =0AMicrosoft=0ADefy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0A=
Studio =0A2008.=0Ahttp://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=
=0A_______________________________________________=0ABluez-devel =0Amailing=
 =0Alist=0ABluez-devel@lists.sourceforge.net=0Ahttps://lists.sourceforge.ne=
t/lists/listinfo/bluez-devel=0A=0A=0A=0A=0A=0A=0A=0A      Forgot the famous=
 last words? Access your message archive online at http://in.messenger.yaho=
o.com/webmessengerpromo.php
--0-266349495-1202295595=:10985
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Thanks again<br>I now use these command to stop and start h=
cid...its working fine...<br><br>[root@localhost Pramod]# /etc/init.d/bluet=
ooth start<br>Starting Bluetooth subsystem: hcid hid2hci.<br>[root@localhos=
t Pramod]# /etc/init.d/bluetooth stop<br>Stopping Bluetooth subsystem: hcid=
..<br><br>But after running audio service same error come again and i am not=
 able to connect to headset<br>via rfcomm which was happening when I was us=
ing default set of BT utils in /usr/sbin &amp; /usr/bin<br><br>why is it so=
????<br><br><div>&nbsp;</div>Thanks and Best regards<div>&nbsp;</div><div>P=
ramod<div style=3D"font-family: times new roman,new york,times,serif; font-=
size: 12pt;"><br><br><div style=3D"font-family: times new roman,new york,ti=
mes,serif; font-size: 12pt;">----- Original Message ----<br>From: Marcel
 Holtmann &lt;marcel@holtmann.org&gt;<br>To: BlueZ development &lt;bluez-de=
vel@lists.sourceforge.net&gt;<br>Sent: Wednesday, 6 February, 2008 4:13:34 =
PM<br>Subject: Re: [Bluez-devel] system hangs playing audio on headset<br><=
br>Hi =0AParmod,<br><br>&gt; =0Ahere =0Aare =0Athings =0AI =0Adif =0Athis =
=0Atime. =0Ai =0Aused =0Ahcid =0Afrom =0A3.25 =0Athis =0Aearlier =0Ait<br>&=
gt; =0Awas =0Adefault =0Aone..<br>&gt; =0Ai =0AKilled =0Ahcid, =0Asdpd<br>&=
gt; =0A1....[root@localhost =0APramod]# =0A/usr/local/sbin/hcid<br>&gt; =0A=
-f =0A/etc/bluetooth/hcid.conf<br>&gt; =0A2....[root@localhost =0APramod]# =
=0A/usr/local/sbin/sdpd<br><br>don't =0Astart =0Asdpd. =0AUse =0Ahcid =0A-s=
 =0Awhich =0Aincludes =0Athe =0ASDP =0Aserver.<br><br>Regards<br><br>Marcel=
<br><br><br><br>-----------------------------------------------------------=
--------------<br>This =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicr=
osoft<br>Defy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A=
2008.<br><a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=
" target=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=
</a><br>_______________________________________________<br>Bluez-devel =0Am=
ailing =0Alist<br><a ymailto=3D"mailto:Bluez-devel@lists.sourceforge.net" h=
ref=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourcefo=
rge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/blue=
z-devel" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/blu=
ez-devel</a><br></div><br></div></div></div><br>=0A=0A=0A      <!--5--><hr =
size=3D1></hr> Get the freedom to save as many mails as you wish. <a href=
=3D"http://in.rd.yahoo.com/tagline_mail_5/*http://help.yahoo.com/l/in/yahoo=
/mail/yahoomail/tools/tools-08.html/">Click here to know how.</a></body></h=
tml>
--0-266349495-1202295595=:10985--



--===============1940879720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1940879720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1940879720==--
