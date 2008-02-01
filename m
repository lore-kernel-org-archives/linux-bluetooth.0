Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2008 17:48:10 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <600225.40719.qm@web8408.mail.in.yahoo.com>
Subject: Re: [Bluez-devel] sdp not starting
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1237282803=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1237282803==
Content-Type: multipart/alternative; boundary="0-38015778-1201868290=:40719"

--0-38015778-1201868290=:40719
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for that hint=0ABut what does -s and -f do...=0AI did not understand=
 the pin_helper option here..=0Ait gives error..=0Adifferent docs say diffe=
rent about pin_helper=0A/etc/bluetooth/pin, /etc/bluetooth/feed-pin.sh and =
/usr/bin/bluez-pin etc=0A=0Awhich one is correct?=0Ahere i used pin_helper =
/etc/bluetooth/feed-pin.sh;=0Ait gives error..why?=0Awhen i do =0A$/usr/loc=
al/sbin/sdpd=0Ait is not started...why=0A=0Athese are the logs=0Ahelp me...=
thanks in advance..=0AFeb  1 17:41:05 localhost hcid[32024]: Bluetooth HCI =
daemon=0AFeb  1 17:41:05 localhost hcid[32024]: Unknown option 'pin_helper'=
 line 27=0AFeb  1 17:41:05 localhost hcid[32024]: syntax error line 27=0AFe=
b  1 17:41:06 localhost hcid[32024]: HCI dev 0 registered=0AFeb  1 17:41:06=
 localhost hcid[32024]: HCI dev 0 already up=0AFeb  1 17:41:06 localhost hc=
id[32024]: Device hci0 has been added=0AFeb  1 17:41:06 localhost hcid[3202=
4]: Starting security manager 0=0AFeb  1 17:41:06 localhost hcid[32024]: De=
vice hci0 has been activated=0AFeb  1 17:41:06 localhost hcid[32024]: Creat=
ed local server at unix:abstract=3D/var/run/dbus-k0vfSKnbsK,guid=3D5a0ca347=
799eb08a1c33407ab7391500=0AFeb  1 17:41:06 localhost audio[32028]: Bluetoot=
h Audio daemon=0AFeb  1 17:41:06 localhost audio[32028]: Unix socket create=
d: 5=0AFeb  1 17:41:06 localhost hcid[32024]: Can't connect to SDP daemon:(=
Connection refused, 111)=0AFeb  1 17:41:06 localhost hcid[32024]: Failed to=
 register service record=0AFeb  1 17:41:06 localhost audio[32028]: Adding s=
ervice record failed: Connection refused=0AFeb  1 17:41:06 localhost audio[=
32028]: Unable to register HS AG service record=0AFeb  1 17:41:06 localhost=
 audio[32028]: Unregistered manager path=0AFeb  1 17:41:06 localhost audio[=
32028]: Audio init failed!=0AFeb  1 17:46:32 localhost smartd[1702]: Device=
: /dev/hda, 1 Currently unreadable (pending) sectors=0AFeb  1 17:46:32 loca=
lhost smartd[1702]: Device: /dev/hda, 1 Offline uncorrectable sectors=0AFeb=
  1 17:48:10 localhost sdpd[32086]: Bluetooth SDP daemon=0AFeb  1 17:48:10 =
localhost sdpd[32086]: Starting SDP server=0AFeb  1 17:48:10 localhost sdpd=
[32086]: binding UNIX socket: Address already in use=0AFeb  1 17:48:10 loca=
lhost sdpd[32086]: Server initialization failed=0A=0A=0A----- Original Mess=
age ----=0AFrom: Bastien Nocera <hadess@hadess.net>=0ATo: BlueZ development=
 <bluez-devel@lists.sourceforge.net>=0ACc: Bluez-users@lists.sourceforge.ne=
t=0ASent: Friday, 1 February, 2008 5:23:41 PM=0ASubject: Re: [Bluez-devel] =
sdp not starting=0A=0A=0AOn =0AFri, =0A2008-02-01 =0Aat =0A17:16 =0A+0530, =
=0Apramod =0Agurav =0Awrote:=0A> =0Ahi =0Aall=0A> =0Ai =0Aam =0Anot =0Aable=
 =0Ato =0Astart =0Athe =0Asdp =0Adaemon. =0AThese =0Aare =0Athe =0Ameesages=
 =0Ai =0Aget=0A> =0Ain =0A/var/log/messages =0A:  =0A =0A> =0AFeb  =0A1 =0A=
17:12:23 =0Alocalhost =0Ahcid[31049]: =0AHCI =0Adev =0A0 =0Aregistered=0A> =
=0AFeb  =0A1 =0A17:12:23 =0Alocalhost =0Ahcid[31049]: =0AHCI =0Adev =0A0 =
=0Aup=0A> =0AFeb  =0A1 =0A17:12:23 =0Alocalhost =0Ahcid[31049]: =0ADevice =
=0Ahci0 =0Ahas =0Abeen =0Aadded=0A> =0AFeb  =0A1 =0A17:12:23 =0Alocalhost =
=0Ahcid[31049]: =0AStarting =0Asecurity =0Amanager =0A0=0A> =0AFeb  =0A1 =
=0A17:12:23 =0Alocalhost =0Ahcid[31049]: =0ADevice =0Ahci0 =0Ahas =0Abeen =
=0Aactivated=0A> =0AFeb  =0A1 =0A17:12:54 =0Alocalhost =0Asdpd[31717]: =0AB=
luetooth =0ASDP =0Adaemon=0A> =0AFeb  =0A1 =0A17:12:54 =0Alocalhost =0Asdpd=
[31717]: =0AStarting =0ASDP =0Aserver=0A> =0AFeb  =0A1 =0A17:12:54 =0Alocal=
host =0Asdpd[31717]: =0Abinding =0AL2CAP =0Asocket: =0AAddress=0A> =0Aalrea=
dy =0Ain =0Ause=0A> =0AFeb  =0A1 =0A17:12:54 =0Alocalhost =0Asdpd[31717]: =
=0AServer =0Ainitialization =0Afailed=0A> =0A> =0A> =0AWhat =0Ais =0Athe =
=0Areason =0A> =0ACan =0Aanyone =0Ahelp =0Ame =0Ain =0Asorting =0Athis?=0A=
=0AYou're =0Aprobably =0Aalready =0Ausing =0Athe =0ASDP =0Aserver =0Abuilt =
=0Ainto =0Ahcid =0A(by =0Apassing=0Athe =0A"-s" =0Aargument =0Ato =0Ahcid),=
 =0Aso =0Ait's =0Anormal =0Athat =0Ait =0Afails.=0A=0ACheers=0A=0A=0A------=
-------------------------------------------------------------------=0AThis =
=0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft=0ADefy =0Aall =0A=
challenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.=0Ahttp://clk.atdmt=
.com/MRT/go/vse0120000070mrt/direct/01/=0A_________________________________=
______________=0ABluez-devel =0Amailing =0Alist=0ABluez-devel@lists.sourcef=
orge.net=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-devel=0A=0A=
=0A=0A=0A=0A=0A      Get the freedom to save as many mails as you wish. To =
know how, go to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools=
-08.html
--0-38015778-1201868290=:40719
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">Thanks for that hint<br>But what does -s and -f do.=
..<br>I did not understand the pin_helper option here..<br>it gives error..=
<br>different docs say different about pin_helper<br>/etc/bluetooth/pin, /e=
tc/bluetooth/feed-pin.sh and <tt>/usr/bin/bluez-pin </tt>etc<br><br>which o=
ne is correct?<br>here i used pin_helper /etc/bluetooth/feed-pin.sh;<br>it =
gives error..why?<br>when i do <br>$/usr/local/sbin/sdpd<br>it is not start=
ed...why<br><br>these are the logs<br>help me...thanks in advance..<br>Feb&=
nbsp; 1 17:41:05 localhost hcid[32024]: Bluetooth HCI daemon<br>Feb&nbsp; 1=
 17:41:05 localhost hcid[32024]: Unknown option 'pin_helper' line 27<br>Feb=
&nbsp; 1 17:41:05 localhost hcid[32024]: syntax error line 27<br>Feb&nbsp;
 1 17:41:06 localhost hcid[32024]: HCI dev 0 registered<br>Feb&nbsp; 1 17:4=
1:06 localhost hcid[32024]: HCI dev 0 already up<br>Feb&nbsp; 1 17:41:06 lo=
calhost hcid[32024]: Device hci0 has been added<br>Feb&nbsp; 1 17:41:06 loc=
alhost hcid[32024]: Starting security manager 0<br>Feb&nbsp; 1 17:41:06 loc=
alhost hcid[32024]: Device hci0 has been activated<br>Feb&nbsp; 1 17:41:06 =
localhost hcid[32024]: Created local server at unix:abstract=3D/var/run/dbu=
s-k0vfSKnbsK,guid=3D5a0ca347799eb08a1c33407ab7391500<br>Feb&nbsp; 1 17:41:0=
6 localhost audio[32028]: Bluetooth Audio daemon<br>Feb&nbsp; 1 17:41:06 lo=
calhost audio[32028]: Unix socket created: 5<br>Feb&nbsp; 1 17:41:06 localh=
ost hcid[32024]: Can't connect to SDP daemon:(Connection refused, 111)<br>F=
eb&nbsp; 1 17:41:06 localhost hcid[32024]: Failed to register service recor=
d<br>Feb&nbsp; 1 17:41:06 localhost audio[32028]: Adding service record fai=
led: Connection refused<br>Feb&nbsp; 1 17:41:06 localhost audio[32028]:
 Unable to register HS AG service record<br>Feb&nbsp; 1 17:41:06 localhost =
audio[32028]: Unregistered manager path<br>Feb&nbsp; 1 17:41:06 localhost a=
udio[32028]: Audio init failed!<br>Feb&nbsp; 1 17:46:32 localhost smartd[17=
02]: Device: /dev/hda, 1 Currently unreadable (pending) sectors<br>Feb&nbsp=
; 1 17:46:32 localhost smartd[1702]: Device: /dev/hda, 1 Offline uncorrecta=
ble sectors<br>Feb&nbsp; 1 17:48:10 localhost sdpd[32086]: Bluetooth SDP da=
emon<br>Feb&nbsp; 1 17:48:10 localhost sdpd[32086]: Starting SDP server<br>=
Feb&nbsp; 1 17:48:10 localhost sdpd[32086]: binding UNIX socket: Address al=
ready in use<br>Feb&nbsp; 1 17:48:10 localhost sdpd[32086]: Server initiali=
zation failed<br><br><br><div style=3D"font-family: times new roman,new yor=
k,times,serif; font-size: 12pt;">----- Original Message ----<br>From: Basti=
en Nocera &lt;hadess@hadess.net&gt;<br>To: BlueZ development &lt;bluez-deve=
l@lists.sourceforge.net&gt;<br>Cc:
 Bluez-users@lists.sourceforge.net<br>Sent: Friday, 1 February, 2008 5:23:4=
1 PM<br>Subject: Re: [Bluez-devel] sdp not starting<br><br><br>On =0AFri, =
=0A2008-02-01 =0Aat =0A17:16 =0A+0530, =0Apramod =0Agurav =0Awrote:<br>&gt;=
 =0Ahi =0Aall<br>&gt; =0Ai =0Aam =0Anot =0Aable =0Ato =0Astart =0Athe =0Asd=
p =0Adaemon. =0AThese =0Aare =0Athe =0Ameesages =0Ai =0Aget<br>&gt; =0Ain =
=0A/var/log/messages =0A:&nbsp; =0A <br>&gt; =0AFeb&nbsp; =0A1 =0A17:12:23 =
=0Alocalhost =0Ahcid[31049]: =0AHCI =0Adev =0A0 =0Aregistered<br>&gt; =0AFe=
b&nbsp; =0A1 =0A17:12:23 =0Alocalhost =0Ahcid[31049]: =0AHCI =0Adev =0A0 =
=0Aup<br>&gt; =0AFeb&nbsp; =0A1 =0A17:12:23 =0Alocalhost =0Ahcid[31049]: =
=0ADevice =0Ahci0 =0Ahas =0Abeen =0Aadded<br>&gt; =0AFeb&nbsp; =0A1 =0A17:1=
2:23 =0Alocalhost =0Ahcid[31049]: =0AStarting =0Asecurity =0Amanager =0A0<b=
r>&gt; =0AFeb&nbsp; =0A1 =0A17:12:23 =0Alocalhost =0Ahcid[31049]: =0ADevice=
 =0Ahci0 =0Ahas =0Abeen =0Aactivated<br>&gt; =0AFeb&nbsp; =0A1 =0A17:12:54 =
=0Alocalhost =0Asdpd[31717]: =0ABluetooth =0ASDP =0Adaemon<br>&gt; =0AFeb&n=
bsp; =0A1 =0A17:12:54 =0Alocalhost =0Asdpd[31717]: =0AStarting =0ASDP =0Ase=
rver<br>&gt; =0AFeb&nbsp; =0A1 =0A17:12:54 =0Alocalhost =0Asdpd[31717]: =0A=
binding =0AL2CAP =0Asocket: =0AAddress<br>&gt; =0Aalready =0Ain =0Ause<br>&=
gt; =0AFeb&nbsp; =0A1 =0A17:12:54 =0Alocalhost =0Asdpd[31717]: =0AServer =
=0Ainitialization =0Afailed<br>&gt; <br>&gt; <br>&gt; =0AWhat =0Ais =0Athe =
=0Areason <br>&gt; =0ACan =0Aanyone =0Ahelp =0Ame =0Ain =0Asorting =0Athis?=
<br><br>You're =0Aprobably =0Aalready =0Ausing =0Athe =0ASDP =0Aserver =0Ab=
uilt =0Ainto =0Ahcid =0A(by =0Apassing<br>the =0A"-s" =0Aargument =0Ato =0A=
hcid), =0Aso =0Ait's =0Anormal =0Athat =0Ait =0Afails.<br><br>Cheers<br><br=
><br>----------------------------------------------------------------------=
---<br>This =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft<br>De=
fy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.<br><a=
 href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target=3D=
"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>___=
____________________________________________<br>Bluez-devel =0Amailing =0Al=
ist<br><a ymailto=3D"mailto:Bluez-devel@lists.sourceforge.net" href=3D"mail=
to:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a>=
<br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" ta=
rget=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a=
><br></div><br></div></div><br>=0A=0A=0A      <!--1--><hr size=3D1></hr> Do=
wnload prohibited? No problem. <a href=3D"http://in.rd.yahoo.com/tagline_we=
bmessenger_1/*http://in.messenger.yahoo.com/webmessengerpromo.php">CHAT</a>=
 from any browser, without download.</body></html>
--0-38015778-1201868290=:40719--


--===============1237282803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1237282803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1237282803==--
