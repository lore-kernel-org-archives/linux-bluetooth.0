Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Feb 2008 10:58:07 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <841732.94094.qm@web8405.mail.in.yahoo.com>
Subject: [Bluez-devel] Fw: [Bluez-users] Headset not playing audio HELP
	PLEASE
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1048387801=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1048387801==
Content-Type: multipart/alternative; boundary="0-1212549559-1202880487=:94094"

--0-1212549559-1202880487=:94094
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A=0Ahi=0AThanks for the reply=0AI run following=0A[Pramod@localhost ~]$ s=
trings /sbin/modprobe | grep conf=0A/etc/modules.conf=0Ashowconfig=0A/etc/m=
odprobe.conf=0AUsage: %s [-v] [-V] [-C config-file] [-n] [-i] [-q] [-b] [-o=
 <modname>] <modname> [parameters...]=0AFailed to open config file %s: %s=
=0AFailed to open included config file %s: %s=0A=0AThis is my /usr/src/linu=
x-2.6.15.i686/.config(Only BT configs are given here)=0ACONFIG_BT=3Dy=0ACON=
FIG_BT_L2CAP=3Dy=0ACONFIG_BT_SCO=3Dy=0ACONFIG_BT_RFCOMM=3Dy=0ACONFIG_BT_RFC=
OMM_TTY=3Dy=0ACONFIG_BT_BNEP=3Dy=0ACONFIG_BT_BNEP_MC_FILTER=3Dy=0ACONFIG_BT=
_BNEP_PROTO_FILTER=3Dy=0ACONFIG_BT_CMTP=3Dm=0ACONFIG_BT_HIDP=3Dy=0A=0A#=0A#=
 Bluetooth device=0A drivers=0A#=0ACONFIG_BT_HCIUSB=3Dy=0ACONFIG_BT_HCIUSB_=
SCO=3Dy=0ACONFIG_BT_HCIUART=3Dy=0ACONFIG_BT_HCIUART_H4=3Dy=0ACONFIG_BT_HCIU=
ART_BCSP=3Dy=0ACONFIG_BT_HCIBCM203X=3Dy=0ACONFIG_BT_HCIBPA10X=3Dy=0ACONFIG_=
BT_HCIBFUSB=3Dy=0ACONFIG_BT_HCIDTL1=3Dy=0ACONFIG_BT_HCIBT3C=3Dy=0ACONFIG_BT=
_HCIBLUECARD=3Dy=0ACONFIG_BT_HCIBTUART=3Dy=0ACONFIG_BT_HCIVHCI=3Dy=0ACONFIG=
_IEEE80211=3Dm=0A=0ASO I have hci_usb compiled in my kernel... =0AThese are=
 things I did now...=0A[root@localhost Pramod]# mv /etc/modules.conf /etc/m=
odules.conf_old=0Acopied these lines to /etc/modprobe.conf=0Aalias net-pf-3=
1 bluez  ------> changed to ----->  alias net-pf-31 bluetooth=0Aalias bt-pr=
oto-0 l2cap=0Aalias bt-proto-2 sco=0Aalias bt-proto-3 rfcomm=0AAdded "optio=
ns =0Ahci_usb =0Aforce_scofix=3D1" to  /etc/modprobe.conf file...=0ANow I r=
ebooted ..=0AWhen I restarted my hcid(with sdpd, audi-service autostart) I =
found some things that I never seen =0Abefore in /var/log/messages these ar=
e=0A/***This log appeared for first time*****/=0AFeb 13 09:48:40 localhost =
audio[2473]: Loading device 00:0F:DE:B1:02:42 (headset )=0AFeb 13 09:48:40 =
localhost audio[2473]: Setting 00:0F:DE:B1:02:42 as default device=0A=0AThe=
n I did =0A[Pramod@localhost ~]$ arecord -D bluetooth -f S16_LE test.raw=0A=
=0Aboth ACL and SCO were established =0AI was able to record sound from hea=
dset...=0ABut when I tried=0A[Pramod@localhost ~]$ aplay -D bluetooth -f S1=
6_LE test.raw=0APlaying raw data 'test.raw' : Signed 16 bit Little Endian, =
Rate 8000 Hz, Mono=0A=0ANo sound was listened on headset=0A=0A[root@localho=
st Pramod]# hcitool con=0AConnections:=0A        < SCO 00:0F:DE:B1:02:42 ha=
ndle 1 state 1 lm=0A SLAVE=0A        < ACL 00:0F:DE:B1:02:42 handle 11 stat=
e 1 lm MASTER=0A=0A[root@localhost Pramod]# hcidump -x=0A> SCO data: handle=
 1 flags 0x00 dlen 48=0A    4F 00 CE FF B2 FF B5 FF 41 00 B5 00 B9 00 85 00=
 8B 00 A3 00=0A    54 00 42 00 38 00 1B 00 FB FF D1 FF AB FF 44 00 78 00 87=
 00=0A    73 00 56 00 E8 FF F4 FF=0Actnr+c=0A=0Athe logs were=0AFeb 13 09:4=
9:35 localhost hcid[2469]: link_key_request (sba=3D00:02:72:CE:5B:80, dba=
=3D00:0F:DE:B1:02:42)=0AFeb 13 09:49:36 localhost hcid[2469]: link_key_noti=
fy (sba=3D00:02:72:CE:5B:80, dba=3D00:0F:DE:B1:02:42)Feb 13 09:49:36 localh=
ost audio[2473]: Badly formated or unrecognized command: AT*ECBP=3D?=0AFeb =
13 09:49:36 localhost audio[2473]: Badly formated or unrecognized command: =
AT+CSCS=3D"UTF-8"=0AFeb 13 09:49:36 localhost audio[2473]: Badly formated o=
r unrecognized command: AT+CLAN?=0AFeb 13 09:51:06 localhost audio[2473]:=
=0A Audio API: received BT_GETCAPABILITIES_REQ=0AFeb 13 09:51:06 localhost =
audio[2473]: Audio API: sending BT_GETCAPABILITIES_RSP=0AFeb 13 09:51:06 lo=
calhost audio[2473]: Audio API: received BT_SETCONFIGURATION_REQ=0AFeb 13 0=
9:51:06 localhost audio[2473]: config sbc - frequency =3D 0 channel_mode =
=3D 0 allocation =3D 0 subbands =3D 0 blocks =3D 0 bitpool =3D 0=0AFeb 13 0=
9:51:08 localhost hcid[2469]: pin_code_request (sba=3D00:02:72:CE:5B:80, db=
a=3D00:0F:DE:B1:02:42)=0AFeb 13 09:51:08 localhost hcid[2469]: link_key_not=
ify (sba=3D00:02:72:CE:5B:80, dba=3D00:0F:DE:B1:02:42)Feb 13 09:51:09 local=
host audio[2473]: Badly formated or unrecognized command: AT*ECBP=3D?=0AFeb=
 13 09:51:09 localhost audio[2473]: SCO fd=3D11=0AFeb 13 09:51:09 localhost=
 audio[2473]: Audio API: sending BT_SETCONFIGURATION_RSP=0AFeb 13 09:51:09 =
localhost audio[2473]: Audio API: received BT_STREAMSTART_REQ=0AFeb 13 09:5=
1:09 localhost audio[2473]: Audio API: sending BT_STREAMSTART_RSP=0AFeb 13 =
09:51:09=0A localhost audio[2473]: Audio API: sending BT_STREAMFD_IND=0AFeb=
 13 09:51:09 localhost audio[2473]: Badly formated or unrecognized command:=
 AT+CSCS=3D"UTF-8"=0AFeb 13 09:51:09 localhost audio[2473]: Badly formated =
or unrecognized command: AT+CLAN?=0AFeb 13 09:52:30 localhost audio[2473]: =
Audio API: received BT_STREAMSTART_REQ=0AFeb 13 09:52:30 localhost audio[24=
73]: Audio API: sending BT_STREAMSTART_RSP=0AFeb 13 09:52:30 localhost audi=
o[2473]: Audio API: sending BT_STREAMFD_IND=0AFeb 13 09:52:43 localhost ker=
nel: hci_scodata_packet: hci0 SCO packet for unknown connection handle 1=0A=
=0AFeb 13 09:52:43 localhost kernel: hci_scodata_packet: hci0 SCO packet fo=
r unknown connection handle 1=0AFeb 13 09:53:12 localhost audio[2473]: Audi=
o API: received BT_GETCAPABILITIES_REQ=0AFeb 13 09:53:12 localhost audio[24=
73]: Audio API: sending BT_GETCAPABILITIES_RSP=0AFeb 13 09:53:12 localhost =
audio[2473]: Audio API: received BT_SETCONFIGURATION_REQ=0AFeb 13=0A 09:53:=
12 localhost audio[2473]: config sbc - frequency =3D 0 channel_mode =3D 0 a=
llocation =3D 0 subbands =3D 0 blocks =3D 0 bitpool =3D 0=0A=0AI had made a=
ll the changes suggested by you. Are they done properly?=0AThis is my hcico=
nfig -a output=0A[root@localhost Pramod]# /usr/local/sbin/hciconfig -a =0Ah=
ci0:   Type: USB=0A        BD Address: 00:02:72:CE:5B:80 ACL MTU: 1017:8 SC=
O MTU: 64:0=0A        UP RUNNING PSCAN ISCAN=0A        RX bytes:5974443 acl=
:279 sco:116978 events:188 errors:0=0A        TX bytes:4222 acl:168 sco:0 c=
ommands:90 errors:0=0A        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 =
0x80=0A        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=0A        L=
ink policy: RSWITCH HOLD SNIFF=0A PARK=0A        Link mode: SLAVE ACCEPT=0A=
        Name: 'BlueZ (0)'=0A        Class: 0x080100=0A        Service Class=
es: Capturing=0A        Device Class: Computer, Uncategorized=0A        HCI=
 Ver: 2.0 (0x3) HCI Rev: 0x204d LMP Ver: 2.0 (0x3) LMP Subver: 0x4127=0A   =
     Manufacturer: Broadcom Corporation (15)=0A=0Aplease Suggest me somethi=
ng=0ASorry for the long mail...=0A=0AThanks and Best regards =0APramod=0A=
=0A----- Original Message ----=0AFrom: jayjwa <jayjwa@atr2.ath.cx>=0ATo: Bl=
ueZ users=0A <bluez-users@lists.sourceforge.net>=0ASent: Tuesday, 12 Februa=
ry, 2008 6:17:12 PM=0ASubject: Re: [Bluez-users] Headset not playing audio =
HELP PLEASE=0A=0A=0AOn =0AMon, =0A11 =0AFeb =0A2008, =0Apramod =0Agurav =0A=
wrote:=0A=0A-> =0Ai =0Atried =0Aadding =0Aoptions =0Ahci_usb =0Aforce_scofi=
x=3D1 =0Ato =0Afile =0Aetc/modprobe.d/bluez=0A-> =0Abut =0Athis =0Afile =0A=
was =0Anot =0Athere =0AI =0Acreated =0Ait =0Aand =0Aadded =0Athe =0Aoption.=
=0A-> =0ABut =0Ano =0Achange=0A=0AI'm =0Anot =0Asure =0Amodprobe =0Alooks =
=0Ain =0Athat =0Afile. =0ABy =0Adefault, =0Ait =0Alooks =0Ain =0A/etc/modpr=
obe.conf. =0ARun =0A'strings =0A/sbin/modprobe =0A| =0Agrep =0Aconf' =0Aand=
 =0Ayou =0Acan =0Asee =0Awhere =0Ait's =0Alooking.=0A=0A-> =0AOne =0Amore =
=0Athing =0Ais =0Ai =0Ahave =0Ano =0Amodule =0Acalled =0Ahci_usb =0Afound =
=0Awhen =0AI =0Ado=0A-> =0A[Pramod@localhost =0A~]$ =0Alsmod =0A| =0Agrep =
=0Ahci=0A-> =0Auhci_hcd  =0A  =0A  =0A  =0A  =0A  =0A  =0A =0A29072  =0A0=
=0A=0AHm. =0AI =0Awonder =0Awhat =0Ais =0Arunning =0Ayour =0Aadapter =0Athe=
n? =0AMaybe =0Ait's =0Acompiled =0Ain? =0AIf =0Athere =0Ais =0ACONFIG_BT_HC=
IUSB=3Dy =0Ain =0Ayour =0Akernel =0Aconfig, =0Athen =0Ait =0Ais.=0A=0A=0A->=
 =0AThis =0Ais =0Asome =0Ainfo =0Ai =0Awould =0Alike =0Ato =0Ashare =0A-> =
=0A[Pramod@localhost =0A~]$ =0Acat =0A/etc/modules.conf=0A->  =0A#Bluez=0A-=
> =0A#alias =0Anet-pf-31  =0A  =0A  =0Abluez=0A-> =0A#alias =0Abt-proto-0  =
=0A  =0A =0Al2cap=0A-> =0Aalias =0Anet-pf-31 =0Abluez=0A-> =0Aalias =0Abt-p=
roto-0 =0Al2cap=0A-> =0Aalias =0Abt-proto-2 =0Asco=0A-> =0Aalias =0Abt-prot=
o-3 =0Arfcomm=0A=0AThat's =0Aan =0Aold =0Afile, =0Aand =0Ayou =0Acan =0Apro=
bably =0Akill =0Ait. =0AAll =0Athat =0Ainfo =0Ashould =0Abe =0Ain =0Athe =
=0Amodprobe.conf =0Anow. =0AYour =0Aalias =0Afor =0Anet-pf-31 =0Ashould =0A=
point =0Ato =0A'bluetooth', =0Aas =0Athat =0Ais =0Athe =0Amodule =0Afor =0A=
bluetooth =0Aprotocol =0Aon =0Amodern =0Akernels. =0AThere =0Ais =0Ano =0Am=
ore =0A'bluez' =0Amodule =0Aas =0Afar =0Aas =0AI =0Acan =0Atell.=0A=0A=0A->=
 =0A[Pramod@localhost =0A~]$ =0A/usr/local/sbin/hciconfig =0A-a=0A-> =0Ahci=
0:  =0A =0AType: =0AUSB=0A->  =0A  =0A  =0A  =0A =0ABD =0AAddress: =0A00:0B=
:0D:33:9E:FB =0AACL =0AMTU: =0A120:20 =0ASCO =0AMTU: =0A64:0=0A->  =0A  =0A=
  =0A  =0A =0AUP =0ARUNNING =0APSCAN =0AISCAN=0A->  =0A  =0A  =0A  =0A =0AR=
X =0Abytes:6912199 =0Aacl:71 =0Asco:135480 =0Aevents:72 =0Aerrors:0=0A->  =
=0A  =0A  =0A  =0A =0ATX =0Abytes:1053 =0Aacl:35 =0Asco:0 =0Acommands:30 =
=0Aerrors:0=0A->  =0A  =0A  =0A  =0A =0AFeatures: =0A0xff =0A0xff =0A0x05 =
=0A0x00 =0A0x00 =0A0x00 =0A0x00 =0A0x00=0A->  =0A  =0A  =0A  =0A =0APacket =
=0Atype: =0ADM1 =0ADM3 =0ADM5 =0ADH1 =0ADH3 =0ADH5 =0AHV1 =0AHV2 =0AHV3=0A-=
>  =0A  =0A  =0A  =0A =0ALink =0Apolicy: =0AHOLD =0APARK=0A=0AI =0Ahave =0A=
'lp =0Arswitch,hold,sniff,part' =0Ain =0Amy =0Ahcid.conf, =0Aso =0Athere =
=0Ais =0Athose =0Anames =0Aabove =0Ain =0A"Link =0Apolicy". =0AI'm =0Anot =
=0Asure =0Aif =0Ait =0Amatters =0Ahere =0Aor =0Anot =0Abut =0AI =0Athought =
=0AI'd =0Amention =0Ait.=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A      Sav=
e all your chat conversations. Find them online at http://in.messenger.yaho=
o.com/webmessengerpromo.php
--0-1212549559-1202880487=:94094
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><br><div>&nbsp;</div><div><div style=3D"font-family: times =
new roman,new york,times,serif; font-size: 12pt;"><div style=3D"font-family=
: times new roman,new york,times,serif; font-size: 12pt;"><br><div style=3D=
"font-family: times new roman,new york,times,serif; font-size: 12pt;"><div =
style=3D"font-family: times new roman,new york,times,serif; font-size: 12pt=
;">hi<br>Thanks for the reply<br>I run following<br>[Pramod@localhost ~]$ s=
trings /sbin/modprobe | grep conf<br>/etc/modules.conf<br>showconfig<br>/et=
c/modprobe.conf<br>Usage: %s [-v] [-V] [-C config-file] [-n] [-i] [-q] [-b]=
 [-o &lt;modname&gt;] &lt;modname&gt; [parameters...]<br>Failed to open con=
fig file %s: %s<br>Failed to open included config file %s: %s<br><br>This i=
s my /usr/src/linux-2.6.15.i686/.config(Only BT configs are given
 here)<br>CONFIG_BT=3Dy<br>CONFIG_BT_L2CAP=3Dy<br>CONFIG_BT_SCO=3Dy<br>CONF=
IG_BT_RFCOMM=3Dy<br>CONFIG_BT_RFCOMM_TTY=3Dy<br>CONFIG_BT_BNEP=3Dy<br>CONFI=
G_BT_BNEP_MC_FILTER=3Dy<br>CONFIG_BT_BNEP_PROTO_FILTER=3Dy<br>CONFIG_BT_CMT=
P=3Dm<br>CONFIG_BT_HIDP=3Dy<br><br>#<br># Bluetooth device=0A drivers<br>#<=
br>CONFIG_BT_HCIUSB=3Dy<br>CONFIG_BT_HCIUSB_SCO=3Dy<br>CONFIG_BT_HCIUART=3D=
y<br>CONFIG_BT_HCIUART_H4=3Dy<br>CONFIG_BT_HCIUART_BCSP=3Dy<br>CONFIG_BT_HC=
IBCM203X=3Dy<br>CONFIG_BT_HCIBPA10X=3Dy<br>CONFIG_BT_HCIBFUSB=3Dy<br>CONFIG=
_BT_HCIDTL1=3Dy<br>CONFIG_BT_HCIBT3C=3Dy<br>CONFIG_BT_HCIBLUECARD=3Dy<br>CO=
NFIG_BT_HCIBTUART=3Dy<br>CONFIG_BT_HCIVHCI=3Dy<br>CONFIG_IEEE80211=3Dm<br><=
br><div>SO I have hci_usb compiled in my kernel... <br>These are things I d=
id now...<br>[root@localhost Pramod]# mv /etc/modules.conf /etc/modules.con=
f_old<br>copied these lines to /etc/modprobe.conf<br>alias net-pf-31 bluez&=
nbsp; ------&gt; changed to -----&gt;&nbsp; alias net-pf-31 bluetooth<br>al=
ias bt-proto-0 l2cap<br>alias bt-proto-2 sco<br>alias bt-proto-3 rfcomm<br>=
Added "options =0Ahci_usb =0Aforce_scofix=3D1" to&nbsp; /etc/modprobe.conf =
file...<br>Now I rebooted ..<br>When I restarted my hcid(with sdpd, audi-se=
rvice autostart) I found some things that I never seen <br>before in /var/l=
og/messages these are<br>/***This log appeared for first time*****/<br>Feb =
13 09:48:40 localhost audio[2473]: Loading device 00:0F:DE:B1:02:42 (headse=
t )<br>Feb 13 09:48:40 localhost audio[2473]: Setting 00:0F:DE:B1:02:42 as =
default device<br><br>Then I did <br>[Pramod@localhost ~]$ arecord -D bluet=
ooth -f S16_LE test.raw<br><br>both ACL and SCO were established <br>I was =
able to record sound from headset...<br>But when I tried<br>[Pramod@localho=
st ~]$ aplay -D bluetooth -f S16_LE test.raw<br>Playing raw data 'test.raw'=
 : Signed 16 bit Little Endian, Rate 8000 Hz, Mono<br><br>No sound was list=
ened on headset<br><br>[root@localhost Pramod]# hcitool con<br>Connections:=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; SCO 00:0F:DE:B1:02:42 h=
andle 1 state 1 lm=0A SLAVE<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
lt; ACL 00:0F:DE:B1:02:42 handle 11 state 1 lm MASTER<br><br>[root@localhos=
t Pramod]# hcidump -x<br>&gt; SCO data: handle 1 flags 0x00 dlen 48<br>&nbs=
p;&nbsp;&nbsp; 4F 00 CE FF B2 FF B5 FF 41 00 B5 00 B9 00 85 00 8B 00 A3 00<=
br>&nbsp;&nbsp;&nbsp; 54 00 42 00 38 00 1B 00 FB FF D1 FF AB FF 44 00 78 00=
 87 00<br>&nbsp;&nbsp;&nbsp; 73 00 56 00 E8 FF F4 FF<br>ctnr+c<br><br>the l=
ogs were<br>Feb 13 09:49:35 localhost hcid[2469]: link_key_request (sba=3D0=
0:02:72:CE:5B:80, dba=3D00:0F:DE:B1:02:42)<br>Feb 13 09:49:36 localhost hci=
d[2469]: link_key_notify (sba=3D00:02:72:CE:5B:80, dba=3D00:0F:DE:B1:02:42)=
Feb 13 09:49:36 localhost audio[2473]: Badly formated or unrecognized comma=
nd: AT*ECBP=3D?<br>Feb 13 09:49:36 localhost audio[2473]: Badly formated or=
 unrecognized command: AT+CSCS=3D"UTF-8"<br>Feb 13 09:49:36 localhost audio=
[2473]: Badly formated or unrecognized command: AT+CLAN?<br>Feb 13 09:51:06=
 localhost audio[2473]:=0A Audio API: received BT_GETCAPABILITIES_REQ<br>Fe=
b 13 09:51:06 localhost audio[2473]: Audio API: sending BT_GETCAPABILITIES_=
RSP<br>Feb 13 09:51:06 localhost audio[2473]: Audio API: received BT_SETCON=
FIGURATION_REQ<br>Feb 13 09:51:06 localhost audio[2473]: config sbc - frequ=
ency =3D 0 channel_mode =3D 0 allocation =3D 0 subbands =3D 0 blocks =3D 0 =
bitpool =3D 0<br>Feb 13 09:51:08 localhost hcid[2469]: pin_code_request (sb=
a=3D00:02:72:CE:5B:80, dba=3D00:0F:DE:B1:02:42)<br>Feb 13 09:51:08 localhos=
t hcid[2469]: link_key_notify (sba=3D00:02:72:CE:5B:80, dba=3D00:0F:DE:B1:0=
2:42)Feb 13 09:51:09 localhost audio[2473]: Badly formated or unrecognized =
command: AT*ECBP=3D?<br>Feb 13 09:51:09 localhost audio[2473]: SCO fd=3D11<=
br>Feb 13 09:51:09 localhost audio[2473]: Audio API: sending BT_SETCONFIGUR=
ATION_RSP<br>Feb 13 09:51:09 localhost audio[2473]: Audio API: received BT_=
STREAMSTART_REQ<br>Feb 13 09:51:09 localhost audio[2473]: Audio API: sendin=
g BT_STREAMSTART_RSP<br>Feb 13 09:51:09=0A localhost audio[2473]: Audio API=
: sending BT_STREAMFD_IND<br>Feb 13 09:51:09 localhost audio[2473]: Badly f=
ormated or unrecognized command: AT+CSCS=3D"UTF-8"<br>Feb 13 09:51:09 local=
host audio[2473]: Badly formated or unrecognized command: AT+CLAN?<br>Feb 1=
3 09:52:30 localhost audio[2473]: Audio API: received BT_STREAMSTART_REQ<br=
>Feb 13 09:52:30 localhost audio[2473]: Audio API: sending BT_STREAMSTART_R=
SP<br>Feb 13 09:52:30 localhost audio[2473]: Audio API: sending BT_STREAMFD=
_IND<br>Feb 13 09:52:43 localhost kernel: hci_scodata_packet: hci0 SCO pack=
et for unknown connection handle 1<br><br>Feb 13 09:52:43 localhost kernel:=
 hci_scodata_packet: hci0 SCO packet for unknown connection handle 1<br>Feb=
 13 09:53:12 localhost audio[2473]: Audio API: received BT_GETCAPABILITIES_=
REQ<br>Feb 13 09:53:12 localhost audio[2473]: Audio API: sending BT_GETCAPA=
BILITIES_RSP<br>Feb 13 09:53:12 localhost audio[2473]: Audio API: received =
BT_SETCONFIGURATION_REQ<br>Feb 13=0A 09:53:12 localhost audio[2473]: config=
 sbc - frequency =3D 0 channel_mode =3D 0 allocation =3D 0 subbands =3D 0 b=
locks =3D 0 bitpool =3D 0<br><br>I had made all the changes suggested by yo=
u. Are they done properly?<br>This is my hciconfig -a output<br>[root@local=
host Pramod]# /usr/local/sbin/hciconfig -a <br>hci0:&nbsp;&nbsp; Type: USB<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:02:72:CE:5B:80=
 ACL MTU: 1017:8 SCO MTU: 64:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX b=
ytes:5974443 acl:279 sco:116978 events:188 errors:0<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; TX bytes:4222 acl:168 sco:0 commands:90 errors:0<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x8d 0xfe 0x=
9b 0xf9 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type=
: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Link policy: RSWITCH HOLD SNIFF=0A PARK<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; Name: 'BlueZ (0)'<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; Class: 0x080100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service C=
lasses: Capturing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Clas=
s: Computer, Uncategorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HC=
I Ver: 2.0 (0x3) HCI Rev: 0x204d LMP Ver: 2.0 (0x3) LMP Subver: 0x4127<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Broadcom Corporatio=
n (15)<br><br>please Suggest me something<br>Sorry for the long mail...<br>=
</div>Thanks and Best regards<div>&nbsp;</div><div>Pramod<div style=3D"font=
-family: times new roman,new york,times,serif; font-size: 12pt;"><br><br><d=
iv style=3D"font-family: times new roman,new york,times,serif; font-size: 1=
2pt;">----- Original Message ----<br>From: jayjwa &lt;jayjwa@atr2.ath.cx&gt=
;<br>To: BlueZ users=0A &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: =
Tuesday, 12 February, 2008 6:17:12 PM<br>Subject: Re: [Bluez-users] Headset=
 not playing audio HELP PLEASE<br><br><br>On =0AMon, =0A11 =0AFeb =0A2008, =
=0Apramod =0Agurav =0Awrote:<br><br>-&gt; =0Ai =0Atried =0Aadding =0Aoption=
s =0Ahci_usb =0Aforce_scofix=3D1 =0Ato =0Afile =0Aetc/modprobe.d/bluez<br>-=
&gt; =0Abut =0Athis =0Afile =0Awas =0Anot =0Athere =0AI =0Acreated =0Ait =
=0Aand =0Aadded =0Athe =0Aoption.<br>-&gt; =0ABut =0Ano =0Achange<br><br>I'=
m =0Anot =0Asure =0Amodprobe =0Alooks =0Ain =0Athat =0Afile. =0ABy =0Adefau=
lt, =0Ait =0Alooks =0Ain <br>/etc/modprobe.conf. =0ARun =0A'strings =0A/sbi=
n/modprobe =0A| =0Agrep =0Aconf' =0Aand =0Ayou =0Acan =0Asee <br>where =0Ai=
t's =0Alooking.<br><br>-&gt; =0AOne =0Amore =0Athing =0Ais =0Ai =0Ahave =0A=
no =0Amodule =0Acalled =0Ahci_usb =0Afound =0Awhen =0AI =0Ado<br>-&gt; =0A[=
Pramod@localhost =0A~]$ =0Alsmod =0A| =0Agrep =0Ahci<br>-&gt; =0Auhci_hcd&n=
bsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A290=
72&nbsp; =0A0<br><br>Hm. =0AI =0Awonder =0Awhat =0Ais =0Arunning =0Ayour =
=0Aadapter =0Athen? =0AMaybe =0Ait's =0Acompiled =0Ain? <br>If =0Athere =0A=
is =0ACONFIG_BT_HCIUSB=3Dy =0Ain =0Ayour =0Akernel =0Aconfig, =0Athen =0Ait=
 =0Ais.<br><br><br>-&gt; =0AThis =0Ais =0Asome =0Ainfo =0Ai =0Awould =0Alik=
e =0Ato =0Ashare <br>-&gt; =0A[Pramod@localhost =0A~]$ =0Acat =0A/etc/modul=
es.conf<br>-&gt;&nbsp; =0A#Bluez<br>-&gt; =0A#alias =0Anet-pf-31&nbsp; =0A&=
nbsp; =0A&nbsp; =0Abluez<br>-&gt; =0A#alias =0Abt-proto-0&nbsp; =0A&nbsp; =
=0A =0Al2cap<br>-&gt; =0Aalias =0Anet-pf-31 =0Abluez<br>-&gt; =0Aalias =0Ab=
t-proto-0 =0Al2cap<br>-&gt; =0Aalias =0Abt-proto-2 =0Asco<br>-&gt; =0Aalias=
 =0Abt-proto-3 =0Arfcomm<br><br>That's =0Aan =0Aold =0Afile, =0Aand =0Ayou =
=0Acan =0Aprobably =0Akill =0Ait. =0AAll =0Athat =0Ainfo =0Ashould =0Abe =
=0Ain <br>the =0Amodprobe.conf =0Anow. =0AYour =0Aalias =0Afor =0Anet-pf-31=
 =0Ashould =0Apoint =0Ato =0A'bluetooth', <br>as =0Athat =0Ais =0Athe =0Amo=
dule =0Afor =0Abluetooth =0Aprotocol =0Aon =0Amodern =0Akernels. =0AThere =
=0Ais =0Ano <br>more =0A'bluez' =0Amodule =0Aas =0Afar =0Aas =0AI =0Acan =
=0Atell.<br><br><br>-&gt; =0A[Pramod@localhost =0A~]$ =0A/usr/local/sbin/hc=
iconfig =0A-a<br>-&gt; =0Ahci0:&nbsp; =0A =0AType: =0AUSB<br>-&gt;&nbsp; =
=0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ABD =0AAddress: =0A00:0B:0D:33:9E:FB =
=0AACL =0AMTU: =0A120:20 =0ASCO =0AMTU: =0A64:0<br>-&gt;&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A =0AUP =0ARUNNING =0APSCAN =0AISCAN<br>-&gt;&nbsp; =
=0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ARX =0Abytes:6912199 =0Aacl:71 =0Asco:1=
35480 =0Aevents:72 =0Aerrors:0<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp;=
 =0A =0ATX =0Abytes:1053 =0Aacl:35 =0Asco:0 =0Acommands:30 =0Aerrors:0<br>-=
&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0AFeatures: =0A0xff =0A0xff =
=0A0x05 =0A0x00 =0A0x00 =0A0x00 =0A0x00 =0A0x00<br>-&gt;&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A =0APacket =0Atype: =0ADM1 =0ADM3 =0ADM5 =0ADH1 =0AD=
H3 =0ADH5 =0AHV1 =0AHV2 =0AHV3<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp;=
 =0A =0ALink =0Apolicy: =0AHOLD =0APARK<br><br>I =0Ahave =0A'lp =0Arswitch,=
hold,sniff,part' =0Ain =0Amy =0Ahcid.conf, =0Aso =0Athere =0Ais =0Athose =
=0Anames <br>above =0Ain =0A"Link =0Apolicy". =0AI'm =0Anot =0Asure =0Aif =
=0Ait =0Amatters =0Ahere =0Aor =0Anot =0Abut =0AI =0Athought <br>I'd =0Amen=
tion =0Ait.<br><br></div></div></div></div></div></div><br></div></div></di=
v><br>=0A=0A=0A      <!--4--><hr size=3D1></hr> 5, 50, 500, 5000 - Store N =
number of mails in your inbox. <a href=3D"http://in.rd.yahoo.com/tagline_ma=
il_4/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/"=
>Click here.</a></body></html>
--0-1212549559-1202880487=:94094--


--===============1048387801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1048387801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1048387801==--
