Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Feb 2008 10:57:04 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <235964.6502.qm@web8412.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1154974047=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1154974047==
Content-Type: multipart/alternative; boundary="0-1875097911-1202880424=:6502"

--0-1875097911-1202880424=:6502
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi=0AThanks for the reply=0AI run following=0A[Pramod@localhost ~]$ strings=
 /sbin/modprobe | grep conf=0A/etc/modules.conf=0Ashowconfig=0A/etc/modprob=
e.conf=0AUsage: %s [-v] [-V] [-C config-file] [-n] [-i] [-q] [-b] [-o <modn=
ame>] <modname> [parameters...]=0AFailed to open config file %s: %s=0AFaile=
d to open included config file %s: %s=0A=0AThis is my /usr/src/linux-2.6.15=
..i686/.config(Only BT configs are given here)=0ACONFIG_BT=3Dy=0ACONFIG_BT_L=
2CAP=3Dy=0ACONFIG_BT_SCO=3Dy=0ACONFIG_BT_RFCOMM=3Dy=0ACONFIG_BT_RFCOMM_TTY=
=3Dy=0ACONFIG_BT_BNEP=3Dy=0ACONFIG_BT_BNEP_MC_FILTER=3Dy=0ACONFIG_BT_BNEP_P=
ROTO_FILTER=3Dy=0ACONFIG_BT_CMTP=3Dm=0ACONFIG_BT_HIDP=3Dy=0A=0A#=0A# Blueto=
oth device=0A drivers=0A#=0ACONFIG_BT_HCIUSB=3Dy=0ACONFIG_BT_HCIUSB_SCO=3Dy=
=0ACONFIG_BT_HCIUART=3Dy=0ACONFIG_BT_HCIUART_H4=3Dy=0ACONFIG_BT_HCIUART_BCS=
P=3Dy=0ACONFIG_BT_HCIBCM203X=3Dy=0ACONFIG_BT_HCIBPA10X=3Dy=0ACONFIG_BT_HCIB=
FUSB=3Dy=0ACONFIG_BT_HCIDTL1=3Dy=0ACONFIG_BT_HCIBT3C=3Dy=0ACONFIG_BT_HCIBLU=
ECARD=3Dy=0ACONFIG_BT_HCIBTUART=3Dy=0ACONFIG_BT_HCIVHCI=3Dy=0ACONFIG_IEEE80=
211=3Dm=0A=0ASO I have hci_usb compiled in my kernel... =0AThese are things=
 I did now...=0A[root@localhost Pramod]# mv /etc/modules.conf /etc/modules.=
conf_old=0Acopied these lines to /etc/modprobe.conf=0Aalias net-pf-31 bluez=
  ------> changed to ----->  alias net-pf-31 bluetooth=0Aalias bt-proto-0 l=
2cap=0Aalias bt-proto-2 sco=0Aalias bt-proto-3 rfcomm=0AAdded "options =0Ah=
ci_usb =0Aforce_scofix=3D1" to  /etc/modprobe.conf file...=0ANow I rebooted=
 ..=0AWhen I restarted my hcid(with sdpd, audi-service autostart) I found s=
ome things that I never seen =0Abefore in /var/log/messages these are=0A/**=
*This log appeared for first time*****/=0AFeb 13 09:48:40 localhost audio[2=
473]: Loading device 00:0F:DE:B1:02:42 (headset )=0AFeb 13 09:48:40 localho=
st audio[2473]: Setting 00:0F:DE:B1:02:42 as default device=0A=0AThen I did=
 =0A[Pramod@localhost ~]$ arecord -D bluetooth -f S16_LE test.raw=0A=0Aboth=
 ACL and SCO were established =0AI was able to record sound from headset...=
=0ABut when I tried=0A[Pramod@localhost ~]$ aplay -D bluetooth -f S16_LE te=
st.raw=0APlaying raw data 'test.raw' : Signed 16 bit Little Endian, Rate 80=
00 Hz, Mono=0A=0ANo sound was listened on headset=0A=0A[root@localhost Pram=
od]# hcitool con=0AConnections:=0A        < SCO 00:0F:DE:B1:02:42 handle 1 =
state 1 lm SLAVE=0A        < ACL 00:0F:DE:B1:02:42 handle 11 state 1 lm MAS=
TER=0A=0A[root@localhost Pramod]# hcidump -x=0A> SCO data: handle 1 flags 0=
x00 dlen 48=0A    4F 00 CE FF B2 FF B5 FF 41 00 B5 00 B9 00 85 00 8B 00 A3 =
00=0A    54 00 42 00 38 00 1B 00 FB FF D1 FF AB FF 44 00 78 00 87 00=0A    =
73 00 56 00 E8 FF F4 FF=0Actnr+c=0A=0Athe logs were=0AFeb 13 09:49:35 local=
host hcid[2469]: link_key_request (sba=3D00:02:72:CE:5B:80, dba=3D00:0F:DE:=
B1:02:42)=0AFeb 13 09:49:36 localhost hcid[2469]: link_key_notify (sba=3D00=
:02:72:CE:5B:80, dba=3D00:0F:DE:B1:02:42)Feb 13 09:49:36 localhost audio[24=
73]: Badly formated or unrecognized command: AT*ECBP=3D?=0AFeb 13 09:49:36 =
localhost audio[2473]: Badly formated or unrecognized command: AT+CSCS=3D"U=
TF-8"=0AFeb 13 09:49:36 localhost audio[2473]: Badly formated or unrecogniz=
ed command: AT+CLAN?=0AFeb 13 09:51:06 localhost audio[2473]: Audio API: re=
ceived BT_GETCAPABILITIES_REQ=0AFeb 13 09:51:06 localhost audio[2473]: Audi=
o API: sending BT_GETCAPABILITIES_RSP=0AFeb 13 09:51:06 localhost audio[247=
3]: Audio API: received BT_SETCONFIGURATION_REQ=0AFeb 13 09:51:06 localhost=
 audio[2473]: config sbc - frequency =3D 0 channel_mode =3D 0 allocation =
=3D 0 subbands =3D 0 blocks =3D 0 bitpool =3D 0=0AFeb 13 09:51:08 localhost=
 hcid[2469]: pin_code_request (sba=3D00:02:72:CE:5B:80, dba=3D00:0F:DE:B1:0=
2:42)=0AFeb 13 09:51:08 localhost hcid[2469]: link_key_notify (sba=3D00:02:=
72:CE:5B:80, dba=3D00:0F:DE:B1:02:42)Feb 13 09:51:09 localhost audio[2473]:=
 Badly formated or unrecognized command: AT*ECBP=3D?=0AFeb 13 09:51:09 loca=
lhost audio[2473]: SCO fd=3D11=0AFeb 13 09:51:09 localhost audio[2473]: Aud=
io API: sending BT_SETCONFIGURATION_RSP=0AFeb 13 09:51:09 localhost audio[2=
473]: Audio API: received BT_STREAMSTART_REQ=0AFeb 13 09:51:09 localhost au=
dio[2473]: Audio API: sending BT_STREAMSTART_RSP=0AFeb 13 09:51:09 localhos=
t audio[2473]: Audio API: sending BT_STREAMFD_IND=0AFeb 13 09:51:09 localho=
st audio[2473]: Badly formated or unrecognized command: AT+CSCS=3D"UTF-8"=
=0AFeb 13 09:51:09 localhost audio[2473]: Badly formated or unrecognized co=
mmand: AT+CLAN?=0AFeb 13 09:52:30 localhost audio[2473]: Audio API: receive=
d BT_STREAMSTART_REQ=0AFeb 13 09:52:30 localhost audio[2473]: Audio API: se=
nding BT_STREAMSTART_RSP=0AFeb 13 09:52:30 localhost audio[2473]: Audio API=
: sending BT_STREAMFD_IND=0AFeb 13 09:52:43 localhost kernel: hci_scodata_p=
acket: hci0 SCO packet for unknown connection handle 1=0A=0AFeb 13 09:52:43=
 localhost kernel: hci_scodata_packet: hci0 SCO packet for unknown connecti=
on handle 1=0AFeb 13 09:53:12 localhost audio[2473]: Audio API: received BT=
_GETCAPABILITIES_REQ=0AFeb 13 09:53:12 localhost audio[2473]: Audio API: se=
nding BT_GETCAPABILITIES_RSP=0AFeb 13 09:53:12 localhost audio[2473]: Audio=
 API: received BT_SETCONFIGURATION_REQ=0AFeb 13 09:53:12 localhost audio[24=
73]: config sbc - frequency =3D 0 channel_mode =3D 0 allocation =3D 0 subba=
nds =3D 0 blocks =3D 0 bitpool =3D 0=0A=0AI had made all the changes sugges=
ted by you. Are they done properly?=0AThis is my hciconfig -a output=0A[roo=
t@localhost Pramod]# /usr/local/sbin/hciconfig -a =0Ahci0:   Type: USB=0A  =
      BD Address: 00:02:72:CE:5B:80 ACL MTU: 1017:8 SCO MTU: 64:0=0A       =
 UP RUNNING PSCAN ISCAN=0A        RX bytes:5974443 acl:279 sco:116978 event=
s:188 errors:0=0A        TX bytes:4222 acl:168 sco:0 commands:90 errors:0=
=0A        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80=0A        Pack=
et type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=0A        Link policy: RSWITCH=
 HOLD SNIFF PARK=0A        Link mode: SLAVE ACCEPT=0A        Name: 'BlueZ (=
0)'=0A        Class: 0x080100=0A        Service Classes: Capturing=0A      =
  Device Class: Computer, Uncategorized=0A        HCI Ver: 2.0 (0x3) HCI Re=
v: 0x204d LMP Ver: 2.0 (0x3) LMP Subver: 0x4127=0A        Manufacturer: Bro=
adcom Corporation (15)=0A=0Aplease Suggest me something=0ASorry for the lon=
g mail...=0A=0AThanks and Best regards =0APramod=0A=0A----- Original Messag=
e ----=0AFrom: jayjwa <jayjwa@atr2.ath.cx>=0ATo: BlueZ users <bluez-users@l=
ists.sourceforge.net>=0ASent: Tuesday, 12 February, 2008 6:17:12 PM=0ASubje=
ct: Re: [Bluez-users] Headset not playing audio HELP PLEASE=0A=0A=0AOn =0AM=
on, =0A11 =0AFeb =0A2008, =0Apramod =0Agurav =0Awrote:=0A=0A-> =0Ai =0Atrie=
d =0Aadding =0Aoptions =0Ahci_usb =0Aforce_scofix=3D1 =0Ato =0Afile =0Aetc/=
modprobe.d/bluez=0A-> =0Abut =0Athis =0Afile =0Awas =0Anot =0Athere =0AI =
=0Acreated =0Ait =0Aand =0Aadded =0Athe =0Aoption.=0A-> =0ABut =0Ano =0Acha=
nge=0A=0AI'm =0Anot =0Asure =0Amodprobe =0Alooks =0Ain =0Athat =0Afile. =0A=
By =0Adefault, =0Ait =0Alooks =0Ain =0A/etc/modprobe.conf. =0ARun =0A'strin=
gs =0A/sbin/modprobe =0A| =0Agrep =0Aconf' =0Aand =0Ayou =0Acan =0Asee =0Aw=
here =0Ait's =0Alooking.=0A=0A-> =0AOne =0Amore =0Athing =0Ais =0Ai =0Ahave=
 =0Ano =0Amodule =0Acalled =0Ahci_usb =0Afound =0Awhen =0AI =0Ado=0A-> =0A[=
Pramod@localhost =0A~]$ =0Alsmod =0A| =0Agrep =0Ahci=0A-> =0Auhci_hcd  =0A =
 =0A  =0A  =0A  =0A  =0A  =0A =0A29072  =0A0=0A=0AHm. =0AI =0Awonder =0Awha=
t =0Ais =0Arunning =0Ayour =0Aadapter =0Athen? =0AMaybe =0Ait's =0Acompiled=
 =0Ain? =0AIf =0Athere =0Ais =0ACONFIG_BT_HCIUSB=3Dy =0Ain =0Ayour =0Akerne=
l =0Aconfig, =0Athen =0Ait =0Ais.=0A=0A=0A-> =0AThis =0Ais =0Asome =0Ainfo =
=0Ai =0Awould =0Alike =0Ato =0Ashare =0A-> =0A[Pramod@localhost =0A~]$ =0Ac=
at =0A/etc/modules.conf=0A->  =0A#Bluez=0A-> =0A#alias =0Anet-pf-31  =0A  =
=0A  =0Abluez=0A-> =0A#alias =0Abt-proto-0  =0A  =0A =0Al2cap=0A-> =0Aalias=
 =0Anet-pf-31 =0Abluez=0A-> =0Aalias =0Abt-proto-0 =0Al2cap=0A-> =0Aalias =
=0Abt-proto-2 =0Asco=0A-> =0Aalias =0Abt-proto-3 =0Arfcomm=0A=0AThat's =0Aa=
n =0Aold =0Afile, =0Aand =0Ayou =0Acan =0Aprobably =0Akill =0Ait. =0AAll =
=0Athat =0Ainfo =0Ashould =0Abe =0Ain =0Athe =0Amodprobe.conf =0Anow. =0AYo=
ur =0Aalias =0Afor =0Anet-pf-31 =0Ashould =0Apoint =0Ato =0A'bluetooth', =
=0Aas =0Athat =0Ais =0Athe =0Amodule =0Afor =0Abluetooth =0Aprotocol =0Aon =
=0Amodern =0Akernels. =0AThere =0Ais =0Ano =0Amore =0A'bluez' =0Amodule =0A=
as =0Afar =0Aas =0AI =0Acan =0Atell.=0A=0A=0A-> =0A[Pramod@localhost =0A~]$=
 =0A/usr/local/sbin/hciconfig =0A-a=0A-> =0Ahci0:  =0A =0AType: =0AUSB=0A->=
  =0A  =0A  =0A  =0A =0ABD =0AAddress: =0A00:0B:0D:33:9E:FB =0AACL =0AMTU: =
=0A120:20 =0ASCO =0AMTU: =0A64:0=0A->  =0A  =0A  =0A  =0A =0AUP =0ARUNNING =
=0APSCAN =0AISCAN=0A->  =0A  =0A  =0A  =0A =0ARX =0Abytes:6912199 =0Aacl:71=
 =0Asco:135480 =0Aevents:72 =0Aerrors:0=0A->  =0A  =0A  =0A  =0A =0ATX =0Ab=
ytes:1053 =0Aacl:35 =0Asco:0 =0Acommands:30 =0Aerrors:0=0A->  =0A  =0A  =0A=
  =0A =0AFeatures: =0A0xff =0A0xff =0A0x05 =0A0x00 =0A0x00 =0A0x00 =0A0x00 =
=0A0x00=0A->  =0A  =0A  =0A  =0A =0APacket =0Atype: =0ADM1 =0ADM3 =0ADM5 =
=0ADH1 =0ADH3 =0ADH5 =0AHV1 =0AHV2 =0AHV3=0A->  =0A  =0A  =0A  =0A =0ALink =
=0Apolicy: =0AHOLD =0APARK=0A=0AI =0Ahave =0A'lp =0Arswitch,hold,sniff,part=
' =0Ain =0Amy =0Ahcid.conf, =0Aso =0Athere =0Ais =0Athose =0Anames =0Aabove=
 =0Ain =0A"Link =0Apolicy". =0AI'm =0Anot =0Asure =0Aif =0Ait =0Amatters =
=0Ahere =0Aor =0Anot =0Abut =0AI =0Athought =0AI'd =0Amention =0Ait.=0A=0A=
=0A------------------------------------------------------------------------=
-=0AThis =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft=0ADefy =
=0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.=0Ahttp:/=
/clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=0A_______________________=
________________________=0ABluez-users =0Amailing =0Alist=0ABluez-users@lis=
ts.sourceforge.net=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-use=
rs=0A=0A=0A=0A=0A=0A=0A=0A=0A      Get the freedom to save as many mails as=
 you wish. To know how, go to http://help.yahoo.com/l/in/yahoo/mail/yahooma=
il/tools/tools-08.html
--0-1875097911-1202880424=:6502
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">hi<br>Thanks for the reply<br>I run following<br>[P=
ramod@localhost ~]$ strings /sbin/modprobe | grep conf<br>/etc/modules.conf=
<br>showconfig<br>/etc/modprobe.conf<br>Usage: %s [-v] [-V] [-C config-file=
] [-n] [-i] [-q] [-b] [-o &lt;modname&gt;] &lt;modname&gt; [parameters...]<=
br>Failed to open config file %s: %s<br>Failed to open included config file=
 %s: %s<br><br>This is my /usr/src/linux-2.6.15.i686/.config(Only BT config=
s are given here)<br>CONFIG_BT=3Dy<br>CONFIG_BT_L2CAP=3Dy<br>CONFIG_BT_SCO=
=3Dy<br>CONFIG_BT_RFCOMM=3Dy<br>CONFIG_BT_RFCOMM_TTY=3Dy<br>CONFIG_BT_BNEP=
=3Dy<br>CONFIG_BT_BNEP_MC_FILTER=3Dy<br>CONFIG_BT_BNEP_PROTO_FILTER=3Dy<br>=
CONFIG_BT_CMTP=3Dm<br>CONFIG_BT_HIDP=3Dy<br><br>#<br># Bluetooth device=0A =
drivers<br>#<br>CONFIG_BT_HCIUSB=3Dy<br>CONFIG_BT_HCIUSB_SCO=3Dy<br>CONFIG_=
BT_HCIUART=3Dy<br>CONFIG_BT_HCIUART_H4=3Dy<br>CONFIG_BT_HCIUART_BCSP=3Dy<br=
>CONFIG_BT_HCIBCM203X=3Dy<br>CONFIG_BT_HCIBPA10X=3Dy<br>CONFIG_BT_HCIBFUSB=
=3Dy<br>CONFIG_BT_HCIDTL1=3Dy<br>CONFIG_BT_HCIBT3C=3Dy<br>CONFIG_BT_HCIBLUE=
CARD=3Dy<br>CONFIG_BT_HCIBTUART=3Dy<br>CONFIG_BT_HCIVHCI=3Dy<br>CONFIG_IEEE=
80211=3Dm<br><br><div>SO I have hci_usb compiled in my kernel... <br>These =
are things I did now...<br>[root@localhost Pramod]# mv /etc/modules.conf /e=
tc/modules.conf_old<br>copied these lines to /etc/modprobe.conf<br>alias ne=
t-pf-31 bluez&nbsp; ------&gt; changed to -----&gt;&nbsp; alias net-pf-31 b=
luetooth<br>alias bt-proto-0 l2cap<br>alias bt-proto-2 sco<br>alias bt-prot=
o-3 rfcomm<br>Added "options =0Ahci_usb =0Aforce_scofix=3D1" to&nbsp; /etc/=
modprobe.conf file...<br>Now I rebooted ..<br>When I restarted my hcid(with=
 sdpd, audi-service autostart) I found some things that I never seen <br>be=
fore in /var/log/messages these are<br>/***This log appeared for first time=
*****/<br>Feb 13 09:48:40 localhost audio[2473]: Loading device 00:0F:DE:B1=
:02:42 (headset )<br>Feb 13 09:48:40 localhost audio[2473]: Setting 00:0F:D=
E:B1:02:42 as default device<br><br>Then I did <br>[Pramod@localhost ~]$ ar=
ecord -D bluetooth -f S16_LE test.raw<br><br>both ACL and SCO were establis=
hed <br>I was able to record sound from headset...<br>But when I tried<br>[=
Pramod@localhost ~]$ aplay -D bluetooth -f S16_LE test.raw<br>Playing raw d=
ata 'test.raw' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono<br><br>No =
sound was listened on headset<br><br>[root@localhost Pramod]# hcitool con<b=
r>Connections:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; SCO 00:0F=
:DE:B1:02:42 handle 1 state 1 lm
 SLAVE<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; ACL 00:0F:DE:B1:0=
2:42 handle 11 state 1 lm MASTER<br><br>[root@localhost Pramod]# hcidump -x=
<br>&gt; SCO data: handle 1 flags 0x00 dlen 48<br>&nbsp;&nbsp;&nbsp; 4F 00 =
CE FF B2 FF B5 FF 41 00 B5 00 B9 00 85 00 8B 00 A3 00<br>&nbsp;&nbsp;&nbsp;=
 54 00 42 00 38 00 1B 00 FB FF D1 FF AB FF 44 00 78 00 87 00<br>&nbsp;&nbsp=
;&nbsp; 73 00 56 00 E8 FF F4 FF<br>ctnr+c<br><br>the logs were<br>Feb 13 09=
:49:35 localhost hcid[2469]: link_key_request (sba=3D00:02:72:CE:5B:80, dba=
=3D00:0F:DE:B1:02:42)<br>Feb 13 09:49:36 localhost hcid[2469]: link_key_not=
ify (sba=3D00:02:72:CE:5B:80, dba=3D00:0F:DE:B1:02:42)Feb 13 09:49:36 local=
host audio[2473]: Badly formated or unrecognized command: AT*ECBP=3D?<br>Fe=
b 13 09:49:36 localhost audio[2473]: Badly formated or unrecognized command=
: AT+CSCS=3D"UTF-8"<br>Feb 13 09:49:36 localhost audio[2473]: Badly formate=
d or unrecognized command: AT+CLAN?<br>Feb 13 09:51:06 localhost audio[2473=
]:
 Audio API: received BT_GETCAPABILITIES_REQ<br>Feb 13 09:51:06 localhost au=
dio[2473]: Audio API: sending BT_GETCAPABILITIES_RSP<br>Feb 13 09:51:06 loc=
alhost audio[2473]: Audio API: received BT_SETCONFIGURATION_REQ<br>Feb 13 0=
9:51:06 localhost audio[2473]: config sbc - frequency =3D 0 channel_mode =
=3D 0 allocation =3D 0 subbands =3D 0 blocks =3D 0 bitpool =3D 0<br>Feb 13 =
09:51:08 localhost hcid[2469]: pin_code_request (sba=3D00:02:72:CE:5B:80, d=
ba=3D00:0F:DE:B1:02:42)<br>Feb 13 09:51:08 localhost hcid[2469]: link_key_n=
otify (sba=3D00:02:72:CE:5B:80, dba=3D00:0F:DE:B1:02:42)Feb 13 09:51:09 loc=
alhost audio[2473]: Badly formated or unrecognized command: AT*ECBP=3D?<br>=
Feb 13 09:51:09 localhost audio[2473]: SCO fd=3D11<br>Feb 13 09:51:09 local=
host audio[2473]: Audio API: sending BT_SETCONFIGURATION_RSP<br>Feb 13 09:5=
1:09 localhost audio[2473]: Audio API: received BT_STREAMSTART_REQ<br>Feb 1=
3 09:51:09 localhost audio[2473]: Audio API: sending BT_STREAMSTART_RSP<br>=
Feb 13 09:51:09
 localhost audio[2473]: Audio API: sending BT_STREAMFD_IND<br>Feb 13 09:51:=
09 localhost audio[2473]: Badly formated or unrecognized command: AT+CSCS=
=3D"UTF-8"<br>Feb 13 09:51:09 localhost audio[2473]: Badly formated or unre=
cognized command: AT+CLAN?<br>Feb 13 09:52:30 localhost audio[2473]: Audio =
API: received BT_STREAMSTART_REQ<br>Feb 13 09:52:30 localhost audio[2473]: =
Audio API: sending BT_STREAMSTART_RSP<br>Feb 13 09:52:30 localhost audio[24=
73]: Audio API: sending BT_STREAMFD_IND<br>Feb 13 09:52:43 localhost kernel=
: hci_scodata_packet: hci0 SCO packet for unknown connection handle 1<br><b=
r>Feb 13 09:52:43 localhost kernel: hci_scodata_packet: hci0 SCO packet for=
 unknown connection handle 1<br>Feb 13 09:53:12 localhost audio[2473]: Audi=
o API: received BT_GETCAPABILITIES_REQ<br>Feb 13 09:53:12 localhost audio[2=
473]: Audio API: sending BT_GETCAPABILITIES_RSP<br>Feb 13 09:53:12 localhos=
t audio[2473]: Audio API: received BT_SETCONFIGURATION_REQ<br>Feb 13
 09:53:12 localhost audio[2473]: config sbc - frequency =3D 0 channel_mode =
=3D 0 allocation =3D 0 subbands =3D 0 blocks =3D 0 bitpool =3D 0<br><br>I h=
ad made all the changes suggested by you. Are they done properly?<br>This i=
s my hciconfig -a output<br>[root@localhost Pramod]# /usr/local/sbin/hcicon=
fig -a <br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; BD Address: 00:02:72:CE:5B:80 ACL MTU: 1017:8 SCO MTU: 64:0<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:5974443 acl:279 sco:116978 even=
ts:188 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:4222=
 acl:168 sco:0 commands:90 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV=
3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD S=
NIFF
 PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (0)'<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x080100<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; Service Classes: Capturing<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 2.0 (0x3) HCI Rev: 0x204d LMP Ver: 2=
..0 (0x3) LMP Subver: 0x4127<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; M=
anufacturer: Broadcom Corporation (15)<br><br>please Suggest me something<b=
r>Sorry for the long mail...<br></div>Thanks and Best regards<div>&nbsp;</d=
iv><div>Pramod<div style=3D"font-family: times new roman,new york,times,ser=
if; font-size: 12pt;"><br><br><div style=3D"font-family: times new roman,ne=
w york,times,serif; font-size: 12pt;">----- Original Message ----<br>From: =
jayjwa &lt;jayjwa@atr2.ath.cx&gt;<br>To: BlueZ users
 &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: Tuesday, 12 February, 2=
008 6:17:12 PM<br>Subject: Re: [Bluez-users] Headset not playing audio HELP=
 PLEASE<br><br><br>On =0AMon, =0A11 =0AFeb =0A2008, =0Apramod =0Agurav =0Aw=
rote:<br><br>-&gt; =0Ai =0Atried =0Aadding =0Aoptions =0Ahci_usb =0Aforce_s=
cofix=3D1 =0Ato =0Afile =0Aetc/modprobe.d/bluez<br>-&gt; =0Abut =0Athis =0A=
file =0Awas =0Anot =0Athere =0AI =0Acreated =0Ait =0Aand =0Aadded =0Athe =
=0Aoption.<br>-&gt; =0ABut =0Ano =0Achange<br><br>I'm =0Anot =0Asure =0Amod=
probe =0Alooks =0Ain =0Athat =0Afile. =0ABy =0Adefault, =0Ait =0Alooks =0Ai=
n <br>/etc/modprobe.conf. =0ARun =0A'strings =0A/sbin/modprobe =0A| =0Agrep=
 =0Aconf' =0Aand =0Ayou =0Acan =0Asee <br>where =0Ait's =0Alooking.<br><br>=
-&gt; =0AOne =0Amore =0Athing =0Ais =0Ai =0Ahave =0Ano =0Amodule =0Acalled =
=0Ahci_usb =0Afound =0Awhen =0AI =0Ado<br>-&gt; =0A[Pramod@localhost =0A~]$=
 =0Alsmod =0A| =0Agrep =0Ahci<br>-&gt; =0Auhci_hcd&nbsp; =0A&nbsp; =0A&nbsp=
; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A29072&nbsp; =0A0<br><br>Hm=
.. =0AI =0Awonder =0Awhat =0Ais =0Arunning =0Ayour =0Aadapter =0Athen? =0AMa=
ybe =0Ait's =0Acompiled =0Ain? <br>If =0Athere =0Ais =0ACONFIG_BT_HCIUSB=3D=
y =0Ain =0Ayour =0Akernel =0Aconfig, =0Athen =0Ait =0Ais.<br><br><br>-&gt; =
=0AThis =0Ais =0Asome =0Ainfo =0Ai =0Awould =0Alike =0Ato =0Ashare <br>-&gt=
; =0A[Pramod@localhost =0A~]$ =0Acat =0A/etc/modules.conf<br>-&gt;&nbsp; =
=0A#Bluez<br>-&gt; =0A#alias =0Anet-pf-31&nbsp; =0A&nbsp; =0A&nbsp; =0Ablue=
z<br>-&gt; =0A#alias =0Abt-proto-0&nbsp; =0A&nbsp; =0A =0Al2cap<br>-&gt; =
=0Aalias =0Anet-pf-31 =0Abluez<br>-&gt; =0Aalias =0Abt-proto-0 =0Al2cap<br>=
-&gt; =0Aalias =0Abt-proto-2 =0Asco<br>-&gt; =0Aalias =0Abt-proto-3 =0Arfco=
mm<br><br>That's =0Aan =0Aold =0Afile, =0Aand =0Ayou =0Acan =0Aprobably =0A=
kill =0Ait. =0AAll =0Athat =0Ainfo =0Ashould =0Abe =0Ain <br>the =0Amodprob=
e.conf =0Anow. =0AYour =0Aalias =0Afor =0Anet-pf-31 =0Ashould =0Apoint =0At=
o =0A'bluetooth', <br>as =0Athat =0Ais =0Athe =0Amodule =0Afor =0Abluetooth=
 =0Aprotocol =0Aon =0Amodern =0Akernels. =0AThere =0Ais =0Ano <br>more =0A'=
bluez' =0Amodule =0Aas =0Afar =0Aas =0AI =0Acan =0Atell.<br><br><br>-&gt; =
=0A[Pramod@localhost =0A~]$ =0A/usr/local/sbin/hciconfig =0A-a<br>-&gt; =0A=
hci0:&nbsp; =0A =0AType: =0AUSB<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp=
; =0A =0ABD =0AAddress: =0A00:0B:0D:33:9E:FB =0AACL =0AMTU: =0A120:20 =0ASC=
O =0AMTU: =0A64:0<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0AUP =
=0ARUNNING =0APSCAN =0AISCAN<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =
=0A =0ARX =0Abytes:6912199 =0Aacl:71 =0Asco:135480 =0Aevents:72 =0Aerrors:0=
<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ATX =0Abytes:1053 =0Aac=
l:35 =0Asco:0 =0Acommands:30 =0Aerrors:0<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp;=
 =0A&nbsp; =0A =0AFeatures: =0A0xff =0A0xff =0A0x05 =0A0x00 =0A0x00 =0A0x00=
 =0A0x00 =0A0x00<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0APacket=
 =0Atype: =0ADM1 =0ADM3 =0ADM5 =0ADH1 =0ADH3 =0ADH5 =0AHV1 =0AHV2 =0AHV3<br=
>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ALink =0Apolicy: =0AHOLD =
=0APARK<br><br>I =0Ahave =0A'lp =0Arswitch,hold,sniff,part' =0Ain =0Amy =0A=
hcid.conf, =0Aso =0Athere =0Ais =0Athose =0Anames <br>above =0Ain =0A"Link =
=0Apolicy". =0AI'm =0Anot =0Asure =0Aif =0Ait =0Amatters =0Ahere =0Aor =0An=
ot =0Abut =0AI =0Athought <br>I'd =0Amention =0Ait.<br><br><br>------------=
-------------------------------------------------------------<br>This =0ASF=
..net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft<br>Defy =0Aall =0Achal=
lenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.<br><a rel=3D"nofollow"=
 target=3D"_blank" href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/dir=
ect/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>___=
____________________________________________<br>Bluez-users =0Amailing =0Al=
ist<br><a rel=3D"nofollow" ymailto=3D"mailto:Bluez-users@lists.sourceforge.=
net" target=3D"_blank" href=3D"mailto:Bluez-users@lists.sourceforge.net">Bl=
uez-users@lists.sourceforge.net</a><br><a rel=3D"nofollow" target=3D"_blank=
" href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users">https:/=
/lists.sourceforge.net/lists/listinfo/bluez-users</a><br></div><br></div></=
div></div></div><br>=0A=0A=0A      <!--3--><hr size=3D1></hr> Save all your=
 chat conversations. <a href=3D"http://in.rd.yahoo.com/tagline_webmessenger=
_3/*http://in.messenger.yahoo.com/webmessengerpromo.php">Find them online.<=
/a></body></html>
--0-1875097911-1202880424=:6502--



--===============1154974047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1154974047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1154974047==--
