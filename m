Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Mar 2008 18:32:17 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: bluez-users@brisammon.fastmail.fm,
	bluez-devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <983561.45785.qm@web8402.mail.in.yahoo.com>
Subject: [Bluez-devel] audio[308]: Access denied: Not authorized
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1411548228=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1411548228==
Content-Type: multipart/alternative; boundary="0-1487129173-1204808537=:45785"

--0-1487129173-1204808537=:45785
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi All=0AI am working on arm platform.=0Ai am trying to play audio from inf=
ineon Bt chip on board on my headset.=0Awhen I press button on headset it a=
sks for the authorisation on board console.=0Aand comes out with an error a=
s =0A=0Aaudio[308]: Requesting authorization for device 00:0F:DE:B1:02:42, =
UUID 00001112-0000-1000-8000-00805F9B34FB=0Aaudio[308]: State changed /org/=
bluez/audio/device0: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN=
_PROGRESS=0Aaudio[308]: Access denied: Not authorized=0Aaudio[308]: State c=
hanged /org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADS=
ET_STATE_DISCONNECTED=0A=0Awhen I play audio using=0A[root@OMAP2EVM /]#apla=
y -D bluetooth -f S16_LE test.raw=0Aaudio[308]: Accepted new client connect=
ion on unix socket (fd=3D9)=0Aaudio[308]: Audio API: received BT_GETCAPABIL=
ITIES_REQ=0Aaudio[308]: Audio API: sending BT_GETCAPABILITIES_RSP=0APlaying=
 WAVE 'test.raw' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono=0Aaudio[=
308]: Audio API: received BT_SETCONFIGURATION_REQ=0Aaudio[308]: State chang=
ed /org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CO=
NNECT_IN_PROGRESS=0APasskey request for device 00:0F:DE:B1:02:42=0Aaudio[30=
8]: /org/bluez/audio/device0: Connecting to 00:0F:DE:B1:02:42 channel 1=0Aa=
udio[308]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN=
_PROGRESS -> HEADSET_STATE_CONNECTED=0Aaudio[308]: /org/bluez/audio/device0=
: Connected to 00:0F:DE:B1:02:42=0Aaudio[308]: State changed /org/bluez/aud=
io/device0: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS=0Aaud=
io[308]: Received AT*ECBP=3D?=0Aaudio[308]: Error handling command AT*ECBP=
=3D?: Invalid argument (22)=0Aaudio[308]: SCO socket opened for headset /or=
g/bluez/audio/device0=0Aaudio[308]: SCO fd=3D11=0Aaudio[308]: Audio API: se=
nding BT_SETCONFIGURATION_RSP=0Aaudio[308]: State changed /org/bluez/audio/=
device0: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING=0Aaudio[30=
8]: Audio API: received BT_STREAMSTART_REQ=0Aaudio[308]: Audio API: sending=
 BT_STREAMSTART_RSP=0Aaudio[308]: Audio API: sending BT_STREAMFD_IND=0Aaudi=
o[308]: Unix client disconnected (fd=3D9)=0Aaudio[308]: State changed /org/=
bluez/audio/device0: HEADSET_STATE_PLAYING -> HEADSET_STATE_DISCONNECTED=0A=
=0Amy hcid sdpd, bluetooth-audio-service are running.=0AWhat can do to make=
 the access authorised?=0ACan any one help me in this?=0A=0AThanks and Best=
 regards=0A=0APramod=0A=0A=0A=0A=0A=0A      5, 50, 500, 5000 - Store N numb=
er of mails in your inbox. Go to http://help.yahoo.com/l/in/yahoo/mail/yaho=
omail/tools/tools-08.html
--0-1487129173-1204808537=:45785
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi All<br>I am working on arm platform.<br>i am trying to p=
lay audio from infineon Bt chip on board on my headset.<br>when I press but=
ton on headset it asks for the authorisation on board console.<br>and comes=
 out with an error as <br><br>audio[308]: Requesting authorization for devi=
ce 00:0F:DE:B1:02:42, UUID 00001112-0000-1000-8000-00805F9B34FB<br>audio[30=
8]: State changed /org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED -&gt=
; HEADSET_STATE_CONNECT_IN_PROGRESS<br>audio[308]: Access denied: Not autho=
rized<br>audio[308]: State changed /org/bluez/audio/device0: HEADSET_STATE_=
CONNECT_IN_PROGRESS -&gt; HEADSET_STATE_DISCONNECTED<br><br><div>when I pla=
y audio using<br>[root@OMAP2EVM /]#aplay -D bluetooth -f S16_LE test.raw<br=
>audio[308]: Accepted new client connection on unix socket
 (fd=3D9)<br>audio[308]: Audio API: received BT_GETCAPABILITIES_REQ<br>audi=
o[308]: Audio API: sending BT_GETCAPABILITIES_RSP<br>Playing WAVE 'test.raw=
' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono<br>audio[308]: Audio AP=
I: received BT_SETCONFIGURATION_REQ<br>audio[308]: State changed /org/bluez=
/audio/device0: HEADSET_STATE_DISCONNECTED -&gt; HEADSET_STATE_CONNECT_IN_P=
ROGRESS<br>Passkey request for device 00:0F:DE:B1:02:42<br>audio[308]: /org=
/bluez/audio/device0: Connecting to 00:0F:DE:B1:02:42 channel 1<br>audio[30=
8]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRE=
SS -&gt; HEADSET_STATE_CONNECTED<br>audio[308]: /org/bluez/audio/device0: C=
onnected to 00:0F:DE:B1:02:42<br>audio[308]: State changed /org/bluez/audio=
/device0: HEADSET_STATE_CONNECTED -&gt; HEADSET_STATE_PLAY_IN_PROGRESS<br>a=
udio[308]: Received AT*ECBP=3D?<br>audio[308]: Error handling command AT*EC=
BP=3D?: Invalid argument (22)<br>audio[308]: SCO socket opened for headset
 /org/bluez/audio/device0<br>audio[308]: SCO fd=3D11<br>audio[308]: Audio A=
PI: sending BT_SETCONFIGURATION_RSP<br>audio[308]: State changed /org/bluez=
/audio/device0: HEADSET_STATE_PLAY_IN_PROGRESS -&gt; HEADSET_STATE_PLAYING<=
br>audio[308]: Audio API: received BT_STREAMSTART_REQ<br>audio[308]: Audio =
API: sending BT_STREAMSTART_RSP<br>audio[308]: Audio API: sending BT_STREAM=
FD_IND<br>audio[308]: Unix client disconnected (fd=3D9)<br>audio[308]: Stat=
e changed /org/bluez/audio/device0: HEADSET_STATE_PLAYING -&gt; HEADSET_STA=
TE_DISCONNECTED<br><br>my hcid sdpd, bluetooth-audio-service are running.<b=
r>What can do to make the access authorised?<br>Can any one help me in this=
?<br></div>Thanks and Best regards<br><br><div>Pramod<div><br></div></div><=
/div><br>=0A=0A=0A      <!--4--><hr size=3D1></hr> Forgot the famous last w=
ords? Access your message archive online. <a href=3D"http://in.rd.yahoo.com=
/tagline_webmessenger_4/*http://in.messenger.yahoo.com/webmessengerpromo.ph=
p">Click here.</a></body></html>
--0-1487129173-1204808537=:45785--



--===============1411548228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1411548228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1411548228==--
