Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Feb 2008 10:10:49 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: bluez-devel <bluez-devel@lists.sourceforge.net>,
	Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <611951.12552.qm@web8407.mail.in.yahoo.com>
Subject: [Bluez-users] Headset not playing audio HELP PLEASE
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0712145052=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net
List-ID: <bluez-devel.lists.sourceforge.net>

--===============0712145052==
Content-Type: multipart/alternative; boundary="0-952357200-1202445649=:12552"

--0-952357200-1202445649=:12552
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi All=0ATrying to play audio on my headset HBH-600.=0AWhen I play audio us=
ing mplayer it looks all fine from logs but sound is not played on headset=
=0A[Pramod@localhost ~]$ mplayer_install/bin/mplayer -ao alsa:device=3Dblue=
tooth 1.mp3 MPlayer 1.0rc2-4.1.1 (C) 2000-2007 MPlayer Team=0ACPU: Intel Ce=
leron 2/Pentium III Coppermine,Geyserville (Family: 6, Model: 8, Stepping: =
6)=0ACPUflags:  MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 SSE: 1 SSE2: 0=0ACompiled=
 for x86 CPU with extensions: MMX MMX2 SSE=0A=0APlaying 1.mp3.=0AAudio file=
 file format detected.=0AClip info:=0A Title: Dream Girl=0A Artist: EM Inc.=
=0A Album: Kishore Kumar - LEGEND Vol 5=0A Year:=0A Comment: Visit: http://=
welcome.to/eminc=0A Genre: Other=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AOpening audio decoder: [mp3lib] MPEG la=
yer-2, layer-3=0AAUDIO: 44100 Hz, 2 ch, s16le, 128.0 kbit/9.07% (ratio: 160=
00->176400)=0ASelected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2,=
 layer-3)=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0AAO: [alsa] 8000Hz 1ch s16le (2 bytes per sample)=0AVideo: no vi=
deo=0AStarting playback...=0A[AO_ALSA] Write error: Resource temporarily un=
available=0A[AO_ALSA] Trying to reset soundcard.=0A[AO_ALSA] Write error: R=
esource temporarily unavailable=0A[AO_ALSA] Trying to reset soundcard.=0AA:=
   1.1 (01.1) of 356.0 (05:56.0) 13.9%=0A=0A************=0AOn the console w=
here i run the audio service I get these log=0Aaudio[3032]: Accepted new cl=
ient connection on unix socket (fd=3D9) audio[3032]: Audio API: received BT=
_GETCAPABILITIES_REQ=0Aaudio[3032]: Got path /org/bluez/hci0 for adapter wi=
th address 00:0B:0D:33:9E:FB=0Aaudio[3032]: /org/bluez/hci0 GetRemoteName()=
: Not available=0APasskey request for device 00:0F:DE:B1:02:42=0Aaudio[3032=
]: Audio service discovery completed with success=0Aaudio[3032]: Found Head=
set record=0Aaudio[3032]: Discovered Headset service on RFCOMM channel 1=0A=
audio[3032]: Selecting default device=0Aaudio[3032]: Audio API: sending BT_=
GETCAPABILITIES_RSP=0Aaudio[3032]: Audio API: received BT_SETCONFIGURATION_=
REQ=0Aaudio[3032]: config sbc - frequency =3D 0 channel_mode =3D 0 allocati=
on =3D 0 subbands =3D 0 blocks =3D 0 bitpool =3D 0=0Aaudio[3032]: State cha=
nged /org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_=
CONNECT_IN_PROGRESS=0Aaudio[3032]: /org/bluez/audio/device0: Connecting to =
00:0F:DE:B1:02:42 channel 1=0Aaudio[3032]: State changed /org/bluez/audio/d=
evice0: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED=0Aaudi=
o[3032]: /org/bluez/audio/device0: Connected to 00:0F:DE:B1:02:42=0Aaudio[3=
032]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECTED -> HE=
ADSET_STATE_PLAY_IN_PROGRESS=0Aaudio[3032]: Received AT*ECBP=3D?=0Aaudio[30=
32]: Badly formated or unrecognized command: AT*ECBP=3D?=0Aaudio[3032]: Rec=
eived AT+CLIP=3D1=0Aaudio[3032]: Received AT+CSCS=3D"UTF-8"=0Aaudio[3032]: =
Badly formated or unrecognized command: AT+CSCS=3D"UTF-8"=0Aaudio[3032]: Re=
ceived AT+CLAN?=0Aaudio[3032]: Badly formated or unrecognized command: AT+C=
LAN?=0Aaudio[3032]: SCO socket opened for headset /org/bluez/audio/device0=
=0Aaudio[3032]: SCO fd=3D11=0Aaudio[3032]: Audio API: sending BT_SETCONFIGU=
RATION_RSP=0Aaudio[3032]: State changed /org/bluez/audio/device0: HEADSET_S=
TATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING=0Aaudio[3032]: Audio API: re=
ceived BT_STREAMSTART_REQ=0Aaudio[3032]: Audio API: sending BT_STREAMSTART_=
RSP=0Aaudio[3032]: Audio API: sending BT_STREAMFD_IND=0Aaudio[3032]: Receiv=
ed AT+VGS=3D15=0Aaudio[3032]: Received AT+VGS=3D14=0Aaudio[3032]: Received =
AT+VGS=3D12=0Aaudio[3032]: Audio API: received BT_STREAMSTART_REQ=0Aaudio[3=
032]: Audio API: sending BT_STREAMSTART_RSP=0Aaudio[3032]: Audio API: sendi=
ng BT_STREAMFD_IND=0Aaudio[3032]: Audio API: received BT_STREAMSTART_REQ=0A=
audio[3032]: Audio API: sending BT_STREAMSTART_RSP=0Aaudio[3032]: Audio API=
: sending BT_STREAMFD_IND=0Aaudio[3032]: Unix client disconnected (fd=3D9)=
=0Aaudio[3032]: State changed /org/bluez/audio/device0: HEADSET_STATE_PLAYI=
NG -> HEADSET_STATE_DISCONNECTED=0A=0A=0AThese are contents of some files..=
...=0A# HCI daemon configuration file.=0A# HCId options=0Aoptions {=0A     =
    autoinit yes;=0A          security user;=0A        pairing multi;=0A#  =
     passkey "0000";=0A} =0A=0Adevice {=0A        name "MyBD";=0A        cl=
ass 0x000100;=0A        #pkt_type=0A DH1,DM1,HV1;=0A        iscan enable; p=
scan enable;=0A        lp rswitch,hold,sniff,park;=0A}=0A/etc/bluetooth/aud=
io.service=0A=0A[Bluetooth Service]=0AIdentifier=3Daudio=0AName=3DAudio ser=
vice=0ADescription=3DBluetooth Audio service=0AAutostart=3Dfalse=0A=0Acat ~=
/.asoundrc=0Apcm.bluetooth {=0A        type bluetooth=0A        device 00:0=
F:DE:B1:02:42   #headset address=0A}=0A=0Acat /etc/asound.conf=0A#Generated=
 by system-config-soundcard, do not edit by hand=0A#SWCONF=0A#DEV 0=0Adefau=
lts.pcm.card 0=0Adefaults.pcm.device 0=0Adefaults.ctl.card 0=0A=0AI run fol=
lowing commands=0A[root@localhost ~]# /etc/init.d/bluetooth start   -------=
--- without -s option=0A[root@localhost ~]# ps -ea | grep sdpd=0A[root@loca=
lhost ~]# /usr/local/lib/bluetooth/bluetoothd-service-audio &=0A[1]=0A 4472=
=0A[root@localhost ~]# audio[4472]: Bluetooth Audio daemon=0Aaudio[4472]: U=
nix socket created: 5=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf:=
 key Enable not found=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf:=
 key Disable not found=0Aaudio[4472]: add_service_record: got record id 0x1=
0000=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf: key Disable not =
found=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf: group A2DP not =
found=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf: group A2DP not =
found=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf: group A2DP not =
found=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf: group A2DP not =
found=0Aaudio[4472]: SEP 0x9795040 registered: type:0 codec:0 seid:1=0Aaudi=
o[4472]: add_service_record: got record id 0x10001=0Aaudio[4472]: add_servi=
ce_record: got record id 0x10002=0Aaudio[4472]: add_service_record: got rec=
ord id 0x10003=0Aaudio[4472]: Registered manager=0A path:/org/bluez/audio=
=0A/usr/local/lib/bluetooth/bluetoothd-service-audio &=0A[2] 4604=0A=0A/var=
/log/messages are -----------=0A                                           =
     HCID=0AFeb  7 11:07:51 localhost hcid[32128]: Bluetooth HCI daemon=0AF=
eb  7 11:07:51 localhost hcid[32128]: HCI dev 0 registered=0AFeb  7 11:07:5=
1 localhost hcid[32128]: HCI dev 0 already up=0AFeb  7 11:07:51 localhost h=
cid[32128]: Device hci0 has been added=0AFeb  7 11:07:51 localhost hcid[321=
28]: Starting security manager 0=0AFeb  7 11:07:51 localhost hcid[32128]: D=
evice hci0 has been activated=0AFeb =0A7 11:07:51 localhost hcid[32128]: Cr=
eated local server at=0Aunix:abstract=3D/var/run/dbus-KmH44CDyJ1,guid=3D2f9=
9aa4799c1691555c6259fb275d700=0AFeb  7 11:07:51 localhost input[32132]: Blu=
etooth Input=0A daemon=0AFeb  7 11:07:51 localhost input[32132]: Registered=
 input manager path:/org/bluez/input=0A                                    =
        SDPD=0AFeb  7 11:08:23 localhost sdpd[32136]: Bluetooth SDP daemon=
=0AFeb  7 11:08:23 localhost sdpd[32136]: Starting SDP server=0A           =
                                 BT AUDIO DAEMON=0AFeb  7 11:09:04 localhos=
t audio[32141]: Bluetooth Audio daemon=0AFeb  7 11:09:04 localhost audio[32=
141]: Unix socket created: 5=0AFeb  7 11:09:04 localhost audio[32141]: Regi=
stered manager path:/org/bluez/audio=0A=0AI also run passkey agent with def=
ault pass key 0000.=0A(The thing work after this only. )=0AI hear a sound o=
n headset but thats not what i am playing.=0A=0ACan anyone give me suggesti=
on on what i am missing???????/=0A =0AThanks and Best regards =0APramod=0A=
=0A=0A=0A=0A=0A      Now you can chat without downloading messenger. Go to =
http://in.messenger.yahoo.com/webmessengerpromo.php
--0-952357200-1202445649=:12552
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi All<br>Trying to play audio on my headset HBH-600.<br>Wh=
en I play audio using mplayer it looks all fine from logs but sound is not =
played on headset<br>[Pramod@localhost ~]$ mplayer_install/bin/mplayer -ao =
alsa:device=3Dbluetooth 1.mp3 MPlayer 1.0rc2-4.1.1 (C) 2000-2007 MPlayer Te=
am<br>CPU: Intel Celeron 2/Pentium III Coppermine,Geyserville (Family: 6, M=
odel: 8, Stepping: 6)<br>CPUflags:&nbsp; MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 =
SSE: 1 SSE2: 0<br>Compiled for x86 CPU with extensions: MMX MMX2 SSE<br><br=
>Playing 1.mp3.<br>Audio file file format detected.<br>Clip info:<br>&nbsp;=
Title: Dream Girl<br>&nbsp;Artist: EM Inc.<br>&nbsp;Album: Kishore Kumar - =
LEGEND Vol 5<br>&nbsp;Year:<br><span>&nbsp;Comment: Visit: <a target=3D"_bl=
ank"
 href=3D"http://welcome.to/eminc">http://welcome.to/eminc</a></span><br>&nb=
sp;Genre: Other<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>Opening audio decoder: [mp3lib] MPEG layer-2, layer-3=
<br>AUDIO: 44100 Hz, 2 ch, s16le, 128.0 kbit/9.07% (ratio: 16000-&gt;176400=
)<br>Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2, layer-3)=
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>AO: [alsa] 8000Hz 1ch s16le (2 bytes per sample)<br>Video: no video<=
br>Starting playback...<br>[AO_ALSA] Write error: Resource temporarily unav=
ailable<br>[AO_ALSA] Trying to reset soundcard.<br>[AO_ALSA] Write error: R=
esource temporarily unavailable<br>[AO_ALSA] Trying to reset soundcard.<br>=
A:&nbsp;&nbsp; 1.1 (01.1) of 356.0 (05:56.0) 13.9%<br><br>************<br>O=
n the console where i run the audio service I get these log<br>audio[3032]:=
 Accepted new client connection on unix socket (fd=3D9) audio[3032]:
 Audio API: received BT_GETCAPABILITIES_REQ<br>audio[3032]: Got path /org/b=
luez/hci0 for adapter with address 00:0B:0D:33:9E:FB<br>audio[3032]: /org/b=
luez/hci0 GetRemoteName(): Not available<br>Passkey request for device 00:0=
F:DE:B1:02:42<br>audio[3032]: Audio service discovery completed with succes=
s<br>audio[3032]: Found Headset record<br>audio[3032]: Discovered Headset s=
ervice on RFCOMM channel 1<br>audio[3032]: Selecting default device<br>audi=
o[3032]: Audio API: sending BT_GETCAPABILITIES_RSP<br>audio[3032]: Audio AP=
I: received BT_SETCONFIGURATION_REQ<br>audio[3032]: config sbc - frequency =
=3D 0 channel_mode =3D 0 allocation =3D 0 subbands =3D 0 blocks =3D 0 bitpo=
ol =3D 0<br>audio[3032]: State changed /org/bluez/audio/device0: HEADSET_ST=
ATE_DISCONNECTED -&gt; HEADSET_STATE_CONNECT_IN_PROGRESS<br>audio[3032]: /o=
rg/bluez/audio/device0: Connecting to 00:0F:DE:B1:02:42 channel 1<br>audio[=
3032]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PRO=
GRESS
 -&gt; HEADSET_STATE_CONNECTED<br>audio[3032]: /org/bluez/audio/device0: Co=
nnected to 00:0F:DE:B1:02:42<br>audio[3032]: State changed /org/bluez/audio=
/device0: HEADSET_STATE_CONNECTED -&gt; HEADSET_STATE_PLAY_IN_PROGRESS<br>a=
udio[3032]: Received AT*ECBP=3D?<br>audio[3032]: Badly formated or unrecogn=
ized command: AT*ECBP=3D?<br>audio[3032]: Received AT+CLIP=3D1<br>audio[303=
2]: Received AT+CSCS=3D"UTF-8"<br>audio[3032]: Badly formated or unrecogniz=
ed command: AT+CSCS=3D"UTF-8"<br>audio[3032]: Received AT+CLAN?<br>audio[30=
32]: Badly formated or unrecognized command: AT+CLAN?<br>audio[3032]: SCO s=
ocket opened for headset /org/bluez/audio/device0<br>audio[3032]: SCO fd=3D=
11<br>audio[3032]: Audio API: sending BT_SETCONFIGURATION_RSP<br>audio[3032=
]: State changed /org/bluez/audio/device0: HEADSET_STATE_PLAY_IN_PROGRESS -=
&gt; HEADSET_STATE_PLAYING<br>audio[3032]: Audio API: received BT_STREAMSTA=
RT_REQ<br>audio[3032]: Audio API: sending BT_STREAMSTART_RSP<br>audio[3032]=
:
 Audio API: sending BT_STREAMFD_IND<br>audio[3032]: Received AT+VGS=3D15<br=
>audio[3032]: Received AT+VGS=3D14<br>audio[3032]: Received AT+VGS=3D12<br>=
audio[3032]: Audio API: received BT_STREAMSTART_REQ<br>audio[3032]: Audio A=
PI: sending BT_STREAMSTART_RSP<br>audio[3032]: Audio API: sending BT_STREAM=
FD_IND<br>audio[3032]: Audio API: received BT_STREAMSTART_REQ<br>audio[3032=
]: Audio API: sending BT_STREAMSTART_RSP<br>audio[3032]: Audio API: sending=
 BT_STREAMFD_IND<br>audio[3032]: Unix client disconnected (fd=3D9)<br>audio=
[3032]: State changed /org/bluez/audio/device0: HEADSET_STATE_PLAYING -&gt;=
 HEADSET_STATE_DISCONNECTED<br><br><br>These are contents of some files....=
.<br># HCI daemon configuration file.<br># HCId options<br>options {<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autoinit yes;<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; security user;<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; pairing
 multi;<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; passkey "0000";<br>} <br><=
br>device {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name "MyBD";<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; class 0x000100;<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; #pkt_type=0A DH1,DM1,HV1;<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; iscan enable; pscan enable;<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; lp rswitch,hold,sniff,park;<br>}<br>/etc/bluetooth=
/audio.service<br><br>[Bluetooth Service]<br>Identifier=3Daudio<br>Name=3DA=
udio service<br>Description=3DBluetooth Audio service<br>Autostart=3Dfalse<=
br><br>cat ~/.asoundrc<br>pcm.bluetooth {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; type bluetooth<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
evice 00:0F:DE:B1:02:42&nbsp;&nbsp; #headset address<br>}<br><br>cat /etc/a=
sound.conf<br>#Generated by system-config-soundcard, do not edit by hand<br=
>#SWCONF<br>#DEV 0<br>defaults.pcm.card 0<br>defaults.pcm.device 0<br>defau=
lts.ctl.card 0<br><br>I run following commands<br>[root@localhost ~]# /etc/=
init.d/bluetooth start&nbsp;&nbsp; ---------- without -s option<br>[root@lo=
calhost ~]# ps -ea | grep sdpd<br>[root@localhost ~]# /usr/local/lib/blueto=
oth/bluetoothd-service-audio &amp;<br>[1]=0A 4472<br>[root@localhost ~]# au=
dio[4472]: Bluetooth Audio daemon<br>audio[4472]: Unix socket created: 5<br=
>audio[4472]: audio.conf: /etc/bluetooth/audio.conf: key Enable not found<b=
r>audio[4472]: audio.conf: /etc/bluetooth/audio.conf: key Disable not found=
<br>audio[4472]: add_service_record: got record id 0x10000<br>audio[4472]: =
audio.conf: /etc/bluetooth/audio.conf: key Disable not found<br>audio[4472]=
: audio.conf: /etc/bluetooth/audio.conf: group A2DP not found<br>audio[4472=
]: audio.conf: /etc/bluetooth/audio.conf: group A2DP not found<br>audio[447=
2]: audio.conf: /etc/bluetooth/audio.conf: group A2DP not found<br>audio[44=
72]: audio.conf: /etc/bluetooth/audio.conf: group A2DP not found<br>audio[4=
472]: SEP 0x9795040 registered: type:0 codec:0 seid:1<br>audio[4472]: add_s=
ervice_record: got record id 0x10001<br>audio[4472]: add_service_record: go=
t record id 0x10002<br>audio[4472]: add_service_record: got record id 0x100=
03<br>audio[4472]: Registered manager=0A path:/org/bluez/audio<br>/usr/loca=
l/lib/bluetooth/bluetoothd-service-audio &amp;<br>[2] 4604<br><br>/var/log/=
messages are -----------<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;  =
&nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp=
;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  HCID<br>Feb&nbsp; 7 11:0=
7:51 localhost hcid[32128]: Bluetooth HCI daemon<br>Feb&nbsp; 7 11:07:51 lo=
calhost hcid[32128]: HCI dev 0 registered<br>Feb&nbsp; 7 11:07:51 localhost=
 hcid[32128]: HCI dev 0 already up<br>Feb&nbsp; 7 11:07:51 localhost hcid[3=
2128]: Device hci0 has been added<br>Feb&nbsp; 7 11:07:51 localhost hcid[32=
128]: Starting security manager 0<br>Feb&nbsp; 7 11:07:51 localhost hcid[32=
128]: Device hci0 has been activated<br>Feb&nbsp;=0A7 11:07:51 localhost hc=
id[32128]: Created local server at=0Aunix:abstract=3D/var/run/dbus-KmH44CDy=
J1,guid=3D2f99aa4799c1691555c6259fb275d700<br>Feb&nbsp; 7 11:07:51 localhos=
t input[32132]: Bluetooth Input=0A daemon<br>Feb&nbsp; 7 11:07:51 localhost=
 input[32132]: Registered input manager path:/org/bluez/input<br>&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbs=
p;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  S=
DPD<br>Feb&nbsp; 7 11:08:23 localhost sdpd[32136]: Bluetooth SDP daemon<br>=
Feb&nbsp; 7 11:08:23 localhost sdpd[32136]: Starting SDP server<br>&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&n=
bsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp; =
 BT AUDIO DAEMON<br>Feb&nbsp; 7 11:09:04 localhost audio[32141]: Bluetooth =
Audio daemon<br>Feb&nbsp; 7 11:09:04 localhost audio[32141]: Unix socket cr=
eated: 5<br>Feb&nbsp; 7 11:09:04 localhost audio[32141]: Registered manager=
 path:/org/bluez/audio<br><br>I also run passkey agent with default pass ke=
y 0000.<br>(The thing work after this only. )<br>I hear a sound on headset =
but thats not what i am
 playing.<br><br>Can anyone give me suggestion on what i am missing???????/=
<br><div>&nbsp;</div>Thanks and Best regards<div>&nbsp;</div><div>Pramod<di=
v><br></div></div></div><br>=0A=0A=0A      <!--5--><hr size=3D1></hr> Get t=
he freedom to save as many mails as you wish. <a href=3D"http://in.rd.yahoo=
.com/tagline_mail_5/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/=
tools-08.html/">Click here to know how.</a></body></html>
--0-952357200-1202445649=:12552--


--===============0712145052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0712145052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0712145052==--
