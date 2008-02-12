Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Feb 2008 14:28:06 +0530 (IST)
From: Andrew William <andrewonwork@yahoo.co.in>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <485653.64438.qm@web94006.mail.in2.yahoo.com>
Subject: [Bluez-devel] headset trouble. no sound on headset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1873304038=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1873304038==
Content-Type: multipart/alternative; boundary="0-1489197057-1202806686=:64438"

--0-1489197057-1202806686=:64438
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!-- DIV {margin:0px;}-->hi All=0ATrying to play audio on my headset HBH-60=
0.=0AWhen I play audio using mplayer it looks all fine from logs but sound =
is not played on headset=0Axyz@localhost~]$ mplayer_install/bin/mplayer -ao=
 alsa:device=3Dbluetooth 1.mp3 MPlayer1.0rc2-4.1.1 (C) 2000-2007 MPlayer Te=
am=0ACPU: Intel Celeron 2/Pentium III Coppermine,Geyserville (Family: 6, Mo=
del: 8, Stepping: 6)=0ACPUflags:  MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 SSE: 1 =
SSE2: 0=0ACompiled for x86 CPU with extensions: MMX MMX2 SSE=0A=0APlaying 1=
..mp3.=0AAudio file file format detected.=0AClip info:=0A Title: Dream Girl=
=0A Artist: EM Inc.=0A Album: Kishore Kumar - LEGEND Vol 5=0A Year:=0A Comm=
ent: Visit: http://welcome.to/eminc=0A Genre: Other=0A=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AOpening audio decoder=
: [mp3lib] MPEG layer-2, layer-3=0AAUDIO: 44100 Hz, 2 ch, s16le, 128.0 kbit=
/9.07% (ratio: 16000->176400)=0ASelected audio codec: [mp3] afm: mp3lib (mp=
3lib MPEG layer-2, layer-3)=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AAO: [alsa] 8000Hz 1ch s16le (2 bytes per samp=
le)=0AVideo: no video=0AStarting playback...=0A[AO_ALSA] Write error: Resou=
rce temporarily unavailable=0A[AO_ALSA] Trying to reset soundcard.=0A[AO_AL=
SA] Write error: Resource temporarily unavailable=0A[AO_ALSA] Trying to res=
et soundcard.=0AA:   1.1 (01.1) of 356.0 (05:56.0) 13.9%=0A=0A************=
=0AOn the console where i run the audio service I get these log=0Aaudio[303=
2]: Accepted new client connection on unix socket (fd=3D9) audio[3032]: Aud=
io API: received BT_GETCAPABILITIES_REQ=0Aaudio[3032]: Got path /org/bluez/=
hci0 for adapter with address 00:0B:0D:33:9E:FB=0Aaudio[3032]: /org/bluez/h=
ci0 GetRemoteName(): Not available=0APasskey request for device 00:0F:DE:B1=
:02:42=0Aaudio[3032]: Audio service discovery completed with success=0Aaudi=
o[3032]: Found Headset record=0Aaudio[3032]: Discovered Headset service on =
RFCOMM channel 1=0Aaudio[3032]: Selecting default device=0Aaudio[3032]: Aud=
io API: sending BT_GETCAPABILITIES_RSP=0Aaudio[3032]: Audio API: received B=
T_SETCONFIGURATION_REQ=0Aaudio[3032]: config sbc - frequency =3D 0 channel_=
mode =3D 0 allocation =3D 0 subbands =3D 0 blocks =3D 0 bitpool =3D 0=0Aaud=
io[3032]: State changed /org/bluez/audio/device0: HEADSET_STATE_DISCONNECTE=
D -> HEADSET_STATE_CONNECT_IN_PROGRESS=0Aaudio[3032]: /org/bluez/audio/devi=
ce0: Connecting to 00:0F:DE:B1:02:42 channel 1=0Aaudio[3032]: State changed=
 /org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STA=
TE_CONNECTED=0Aaudio[3032]: /org/bluez/audio/device0: Connected to 00:0F:DE=
:B1:02:42=0Aaudio[3032]: State changed /org/bluez/audio/device0: HEADSET_ST=
ATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS=0Aaudio[3032]: Received AT*=
ECBP=3D?=0Aaudio[3032]: Badly formated or unrecognized command: AT*ECBP=3D?=
=0Aaudio[3032]: Received AT+CLIP=3D1=0Aaudio[3032]: Received AT+CSCS=3D"UTF=
-8"=0Aaudio[3032]: Badly formated or unrecognized command: AT+CSCS=3D"UTF-8=
"=0Aaudio[3032]: Received AT+CLAN?=0Aaudio[3032]: Badly formated or unrecog=
nized command: AT+CLAN?=0Aaudio[3032]: SCO socket opened for headset /org/b=
luez/audio/device0=0Aaudio[3032]: SCO fd=3D11=0Aaudio[3032]: Audio API: sen=
ding BT_SETCONFIGURATION_RSP=0Aaudio[3032]: State changed /org/bluez/audio/=
device0: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING=0Aaudio[30=
32]: Audio API: received BT_STREAMSTART_REQ=0Aaudio[3032]: Audio API: sendi=
ng BT_STREAMSTART_RSP=0Aaudio[3032]: Audio API: sending BT_STREAMFD_IND=0Aa=
udio[3032]: Received AT+VGS=3D15=0Aaudio[3032]: Received AT+VGS=3D14=0Aaudi=
o[3032]: Received AT+VGS=3D12=0Aaudio[3032]: Audio API: received BT_STREAMS=
TART_REQ=0Aaudio[3032]: Audio API: sending BT_STREAMSTART_RSP=0Aaudio[3032]=
: Audio API: sending BT_STREAMFD_IND=0Aaudio[3032]: Audio API: received BT_=
STREAMSTART_REQ=0Aaudio[3032]: Audio API: sending BT_STREAMSTART_RSP=0Aaudi=
o[3032]: Audio API: sending BT_STREAMFD_IND=0Aaudio[3032]: Unix client disc=
onnected (fd=3D9)=0Aaudio[3032]: State changed /org/bluez/audio/device0: HE=
ADSET_STATE_PLAYING -> HEADSET_STATE_DISCONNECTED=0A=0A=0AThese are content=
s of some files.....=0A# HCI daemon configuration file.=0A# HCId options=0A=
options {=0A         autoinit yes;=0A          security user;=0A        pai=
ring multi;=0A#       passkey "0000";=0A} =0A=0Adevice {=0A        name "My=
BD";=0A        class 0x000100;=0A        #pkt_type DH1,DM1,HV1;=0A        i=
scan enable; pscan enable;=0A        lp rswitch,hold,sniff,park;=0A}=0A/etc=
/bluetooth/audio.service=0A=0A[Bluetooth Service]=0AIdentifier=3Daudio=0ANa=
me=3DAudio service=0ADescription=3DBluetooth Audio service=0AAutostart=3Dfa=
lse=0A=0Acat ~/.asoundrc=0Apcm.bluetooth {=0A        type bluetooth=0A     =
   device 00:0F:DE:B1:02:42   #headset address=0A}=0A=0Acat /etc/asound.con=
f=0A#Generated by system-config-soundcard, do not edit by hand=0A#SWCONF=0A=
#DEV 0=0Adefaults.pcm.card 0=0Adefaults.pcm.device 0=0Adefaults.ctl.card 0=
=0A=0AI run following commands=0A[root@localhost ~]# /etc/init.d/bluetooth =
start   ---------- without -s option=0A[root@localhost ~]# ps -ea | grep sd=
pd=0A[root@localhost ~]# /usr/local/lib/bluetooth/bluetoothd-service-audio =
&=0A[1] 4472=0A[root@localhost ~]# audio[4472]: Bluetooth Audio daemon=0Aau=
dio[4472]: Unix socket created: 5=0Aaudio[4472]: audio.conf: /etc/bluetooth=
/audio.conf: key Enable not found=0Aaudio[4472]: audio.conf: /etc/bluetooth=
/audio.conf: key Disable not found=0Aaudio[4472]: add_service_record: got r=
ecord id 0x10000=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf: key =
Disable not found=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf: gro=
up A2DP not found=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf: gro=
up A2DP not found=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf: gro=
up A2DP not found=0Aaudio[4472]: audio.conf: /etc/bluetooth/audio.conf: gro=
up A2DP not found=0Aaudio[4472]: SEP 0x9795040 registered: type:0 codec:0 s=
eid:1=0Aaudio[4472]: add_service_record: got record id 0x10001=0Aaudio[4472=
]: add_service_record: got record id 0x10002=0Aaudio[4472]: add_service_rec=
ord: got record id 0x10003=0Aaudio[4472]: Registered manager path:/org/blue=
z/audio=0A/usr/local/lib/bluetooth/bluetoothd-service-audio &=0A[2] 4604=0A=
=0A/var/log/messages are -----------=0A                                    =
            HCID=0AFeb  7 11:07:51 localhost hcid[32128]: Bluetooth HCI dae=
mon=0AFeb  7 11:07:51 localhost hcid[32128]: HCI dev 0 registered=0AFeb  7 =
11:07:51 localhost hcid[32128]: HCI dev 0 already up=0AFeb  7 11:07:51 loca=
lhost hcid[32128]: Device hci0 has been added=0AFeb  7 11:07:51 localhost h=
cid[32128]: Starting security manager 0=0AFeb  7 11:07:51 localhost hcid[32=
128]: Device hci0 has been activated=0AFeb 7 11:07:51 localhost hcid[32128]=
: Created local server atunix:abstract=3D/var/run/dbus-KmH44CDyJ1,guid=3D2f=
99aa4799c1691555c6259fb275d700=0AFeb  7 11:07:51 localhost input[32132]: Bl=
uetooth Input daemon=0AFeb  7 11:07:51 localhost input[32132]: Registered i=
nput manager path:/org/bluez/input=0A                                      =
      SDPD=0AFeb  7 11:08:23 localhost sdpd[32136]: Bluetooth SDP daemon=0A=
Feb  7 11:08:23 localhost sdpd[32136]: Starting SDP server=0A              =
                              BT AUDIO DAEMON=0AFeb  7 11:09:04 localhost a=
udio[32141]: Bluetooth Audio daemon=0AFeb  7 11:09:04 localhost audio[32141=
]: Unix socket created: 5=0AFeb  7 11:09:04 localhost audio[32141]: Registe=
red manager path:/org/bluez/audio=0A=0AI also run passkey agent with defaul=
t pass key 0000.=0A(The thing work after this only. )=0AI hear a sound on h=
eadset but thats not what i am playing.=0AWhats wrong with the setup??? =0A=
Can anyone give me suggestion on what i am missing??????? Do I need some ot=
her headset?=0A here is my headset info, its a sony ericsson HS=0A[root@loc=
alhost]# hcitool info 00:0F:DE:B1:02:42=0ARequesting information ...=0APass=
key request for device 00:0F:DE:B1:02:42=0A        BD Address:  00:0F:DE:B1=
:02:42=0A        Device Name: HBH-602=0A        LMP Version: 1.1 (0x1) LMP =
Subversion: 0x9240=0A        Manufacturer: Philips Semiconductors (37)=0A  =
      Features: 0xbc 0x28 0x01 0x00 0x00 0x00 0x00 0x00=0A                <=
encryption> <slot offset> <timing accuracy> <role switch>=0A               =
 <sniff mode> <SCO link> <HV3 packets> <CVSD>=0Ahelp me please .....=0A=0AT=
hanks and Best regards =0A=0A=0A=0A=0A=0A=0A      Unlimited freedom, unlimi=
ted storage. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail=
/tools/tools-08.html/
--0-1489197057-1202806686=:64438
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div><style type=3D"text/css"><!-- DIV {margin:0px;}--></st=
yle><div style=3D"font-family: times new roman,new york,times,serif; font-s=
ize: 12pt;">hi All<br>Trying to play audio on my headset HBH-600.<br>When I=
 play audio using mplayer it looks all fine from logs but sound is not play=
ed on headset<br>xyz@localhost=0A~]$ mplayer_install/bin/mplayer -ao alsa:d=
evice=3Dbluetooth 1.mp3 MPlayer=0A1.0rc2-4.1.1 (C) 2000-2007 MPlayer Team<b=
r>CPU: Intel Celeron 2/Pentium III Coppermine,Geyserville (Family: 6, Model=
: 8, Stepping: 6)<br>CPUflags:&nbsp; MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 SSE:=
 1 SSE2: 0<br>Compiled for x86 CPU with extensions: MMX MMX2 SSE<br><br>Pla=
ying 1.mp3.<br>Audio file file format detected.<br>Clip info:<br>&nbsp;Titl=
e: Dream Girl<br>&nbsp;Artist: EM Inc.<br>&nbsp;Album: Kishore Kumar - LEGE=
ND Vol 5<br>&nbsp;Year:<br><span>&nbsp;Comment: Visit: <a rel=3D"nofollow" =
target=3D"_blank" href=3D"http://welcome.to/eminc">http://welcome.to/eminc<=
/a></span><br>&nbsp;Genre: Other<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Opening audio decoder: [mp3lib] MPEG l=
ayer-2, layer-3<br>AUDIO: 44100 Hz, 2 ch, s16le, 128.0 kbit/9.07% (ratio: 1=
6000-&gt;176400)<br>Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG la=
yer-2, layer-3)<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>AO:
 [alsa] 8000Hz 1ch s16le (2 bytes per sample)<br>Video: no video<br>Startin=
g playback...<br>[AO_ALSA] Write error: Resource temporarily unavailable<br=
>[AO_ALSA] Trying to reset soundcard.<br>[AO_ALSA] Write error: Resource te=
mporarily unavailable<br>[AO_ALSA] Trying to reset soundcard.<br>A:&nbsp;&n=
bsp; 1.1 (01.1) of 356.0 (05:56.0) 13.9%<br><br>************<br>On the cons=
ole where i run the audio service I get these log<br>audio[3032]: Accepted =
new client connection on unix socket (fd=3D9) audio[3032]:=0A Audio API: re=
ceived BT_GETCAPABILITIES_REQ<br>audio[3032]: Got path /org/bluez/hci0 for =
adapter with address 00:0B:0D:33:9E:FB<br>audio[3032]: /org/bluez/hci0 GetR=
emoteName(): Not available<br>Passkey request for device 00:0F:DE:B1:02:42<=
br>audio[3032]: Audio service discovery completed with success<br>audio[303=
2]: Found Headset record<br>audio[3032]: Discovered Headset service on RFCO=
MM channel 1<br>audio[3032]: Selecting default device<br>audio[3032]: Audio=
 API: sending BT_GETCAPABILITIES_RSP<br>audio[3032]: Audio API: received BT=
_SETCONFIGURATION_REQ<br>audio[3032]: config sbc - frequency =3D 0 channel_=
mode =3D 0 allocation =3D 0 subbands =3D 0 blocks =3D 0 bitpool =3D 0<br>au=
dio[3032]: State changed /org/bluez/audio/device0: HEADSET_STATE_DISCONNECT=
ED -&gt; HEADSET_STATE_CONNECT_IN_PROGRESS<br>audio[3032]: /org/bluez/audio=
/device0: Connecting to 00:0F:DE:B1:02:42 channel 1<br>audio[3032]: State c=
hanged /org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS=0A -&gt;=
 HEADSET_STATE_CONNECTED<br>audio[3032]: /org/bluez/audio/device0: Connecte=
d to 00:0F:DE:B1:02:42<br>audio[3032]: State changed /org/bluez/audio/devic=
e0: HEADSET_STATE_CONNECTED -&gt; HEADSET_STATE_PLAY_IN_PROGRESS<br>audio[3=
032]: Received AT*ECBP=3D?<br>audio[3032]: Badly formated or unrecognized c=
ommand: AT*ECBP=3D?<br>audio[3032]: Received AT+CLIP=3D1<br>audio[3032]: Re=
ceived AT+CSCS=3D"UTF-8"<br>audio[3032]: Badly formated or unrecognized com=
mand: AT+CSCS=3D"UTF-8"<br>audio[3032]: Received AT+CLAN?<br>audio[3032]: B=
adly formated or unrecognized command: AT+CLAN?<br>audio[3032]: SCO socket =
opened for headset /org/bluez/audio/device0<br>audio[3032]: SCO fd=3D11<br>=
audio[3032]: Audio API: sending BT_SETCONFIGURATION_RSP<br>audio[3032]: Sta=
te changed /org/bluez/audio/device0: HEADSET_STATE_PLAY_IN_PROGRESS -&gt; H=
EADSET_STATE_PLAYING<br>audio[3032]: Audio API: received BT_STREAMSTART_REQ=
<br>audio[3032]: Audio API: sending BT_STREAMSTART_RSP<br>audio[3032]:=0A A=
udio API: sending BT_STREAMFD_IND<br>audio[3032]: Received AT+VGS=3D15<br>a=
udio[3032]: Received AT+VGS=3D14<br>audio[3032]: Received AT+VGS=3D12<br>au=
dio[3032]: Audio API: received BT_STREAMSTART_REQ<br>audio[3032]: Audio API=
: sending BT_STREAMSTART_RSP<br>audio[3032]: Audio API: sending BT_STREAMFD=
_IND<br>audio[3032]: Audio API: received BT_STREAMSTART_REQ<br>audio[3032]:=
 Audio API: sending BT_STREAMSTART_RSP<br>audio[3032]: Audio API: sending B=
T_STREAMFD_IND<br>audio[3032]: Unix client disconnected (fd=3D9)<br>audio[3=
032]: State changed /org/bluez/audio/device0: HEADSET_STATE_PLAYING -&gt; H=
EADSET_STATE_DISCONNECTED<br><br><br>These are contents of some files.....<=
br># HCI daemon configuration file.<br># HCId options<br>options {<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autoinit yes;<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; security user;<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; pairing=0A multi;<br>#&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; passkey "0000";<br>} <br><br>device {<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; name "MyBD";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; class 0x000100;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #pkt_type=
=0A DH1,DM1,HV1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iscan enable=
; pscan enable;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lp rswitch,ho=
ld,sniff,park;<br>}<br>/etc/bluetooth/audio.service<br><br>[Bluetooth Servi=
ce]<br>Identifier=3Daudio<br>Name=3DAudio service<br>Description=3DBluetoot=
h Audio service<br>Autostart=3Dfalse<br><br>cat ~/.asoundrc<br>pcm.bluetoot=
h {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type bluetooth<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device 00:0F:DE:B1:02:42&nbsp;&nbsp; #h=
eadset address<br>}<br><br>cat /etc/asound.conf<br>#Generated by system-con=
fig-soundcard, do not edit by hand<br>#SWCONF<br>#DEV 0<br>defaults.pcm.car=
d 0<br>defaults.pcm.device 0<br>defaults.ctl.card 0<br><br>I run following =
commands<br>[root@localhost ~]# /etc/init.d/bluetooth start&nbsp;&nbsp; ---=
------- without -s option<br>[root@localhost ~]# ps -ea | grep sdpd<br>[roo=
t@localhost ~]# /usr/local/lib/bluetooth/bluetoothd-service-audio &amp;<br>=
[1]=0A 4472<br>[root@localhost ~]# audio[4472]: Bluetooth Audio daemon<br>a=
udio[4472]: Unix socket created: 5<br>audio[4472]: audio.conf: /etc/bluetoo=
th/audio.conf: key Enable not found<br>audio[4472]: audio.conf: /etc/blueto=
oth/audio.conf: key Disable not found<br>audio[4472]: add_service_record: g=
ot record id 0x10000<br>audio[4472]: audio.conf: /etc/bluetooth/audio.conf:=
 key Disable not found<br>audio[4472]: audio.conf: /etc/bluetooth/audio.con=
f: group A2DP not found<br>audio[4472]: audio.conf: /etc/bluetooth/audio.co=
nf: group A2DP not found<br>audio[4472]: audio.conf: /etc/bluetooth/audio.c=
onf: group A2DP not found<br>audio[4472]: audio.conf: /etc/bluetooth/audio.=
conf: group A2DP not found<br>audio[4472]: SEP 0x9795040 registered: type:0=
 codec:0 seid:1<br>audio[4472]: add_service_record: got record id 0x10001<b=
r>audio[4472]: add_service_record: got record id 0x10002<br>audio[4472]: ad=
d_service_record: got record id 0x10003<br>audio[4472]: Registered manager=
=0A path:/org/bluez/audio<br>/usr/local/lib/bluetooth/bluetoothd-service-au=
dio &amp;<br>[2] 4604<br><br>/var/log/messages are -----------<br>&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nb=
sp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  =
&nbsp;&nbsp;  HCID<br>Feb&nbsp; 7 11:07:51 localhost hcid[32128]: Bluetooth=
 HCI daemon<br>Feb&nbsp; 7 11:07:51 localhost hcid[32128]: HCI dev 0 regist=
ered<br>Feb&nbsp; 7 11:07:51 localhost hcid[32128]: HCI dev 0 already up<br=
>Feb&nbsp; 7 11:07:51 localhost hcid[32128]: Device hci0 has been added<br>=
Feb&nbsp; 7 11:07:51 localhost hcid[32128]: Starting security manager 0<br>=
Feb&nbsp; 7 11:07:51 localhost hcid[32128]: Device hci0 has been activated<=
br>Feb&nbsp;=0A7 11:07:51 localhost hcid[32128]: Created local server at=0A=
unix:abstract=3D/var/run/dbus-KmH44CDyJ1,guid=3D2f99aa4799c1691555c6259fb27=
5d700<br>Feb&nbsp; 7 11:07:51 localhost input[32132]: Bluetooth Input=0A da=
emon<br>Feb&nbsp; 7 11:07:51 localhost input[32132]: Registered input manag=
er path:/org/bluez/input<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;  =
&nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp=
;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  SDPD<br>Feb&nbsp; 7 11:08:23 localhost=
 sdpd[32136]: Bluetooth SDP daemon<br>Feb&nbsp; 7 11:08:23 localhost sdpd[3=
2136]: Starting SDP server<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;=
  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nb=
sp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  BT AUDIO DAEMON<br>Feb&nbsp; 7 11:09=
:04 localhost audio[32141]: Bluetooth Audio daemon<br>Feb&nbsp; 7 11:09:04 =
localhost audio[32141]: Unix socket created: 5<br>Feb&nbsp; 7 11:09:04 loca=
lhost audio[32141]: Registered manager path:/org/bluez/audio<br><br>I also =
run passkey agent with default pass key 0000.<br>(The thing work after this=
 only. )<br>I hear a sound on headset but thats not what i am=0A playing.<b=
r>Whats wrong with the setup??? <br>Can anyone give me suggestion on what i=
 am missing??????? Do I need some other headset?<br><div>&nbsp;here is my h=
eadset info, its a sony ericsson HS<br>[root@localhost]# hcitool info 00:0F=
:DE:B1:02:42<br>Requesting information ...<br>Passkey request for device 00=
:0F:DE:B1:02:42<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&n=
bsp; 00:0F:DE:B1:02:42<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device=
 Name: HBH-602<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1=
..1 (0x1) LMP Subversion: 0x9240<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; Manufacturer: Philips Semiconductors (37)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Features: 0xbc 0x28 0x01 0x00 0x00 0x00 0x00 0x00<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &lt;encryption&gt; &lt;slot offset&gt; &lt;timing accuracy&gt; &l=
t;role
 switch&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;sniff mode&gt; &lt;SCO link&gt; &lt;HV3 =
packets&gt; &lt;CVSD&gt;<br>help me please .....<br></div>Thanks and Best r=
egards<div>&nbsp;</div></div><br></div></div><br>=0A=0A=0A      <!--2--><hr=
 size=3D1></hr> Did you know? You can CHAT without downloading messenger. <=
a href=3D"http://in.rd.yahoo.com/tagline_webmessenger_2/*http://in.messenge=
r.yahoo.com/webmessengerpromo.php"> Click here</a></body></html>
--0-1489197057-1202806686=:64438--



--===============1873304038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1873304038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1873304038==--
