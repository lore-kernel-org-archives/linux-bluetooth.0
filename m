Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2008 10:19:12 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <926260.91408.qm@web8408.mail.in.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============0345213831=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0345213831==
Content-Type: multipart/alternative; boundary="0-1768090546-1203050952=:91408"

--0-1768090546-1203050952=:91408
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for your valuable time and guidance.=0Ait was initially=0A[root@loca=
lhost Pramod]# hcitool conn=0A=0AConnections:=0AWhen I press button on HS ,=
 I receive this on console(but no popup)=0A[root@localhost Pramod]# Authori=
zation request for device 00:0F:DE:B1:02:42=0ANow when I do=0A[root@localho=
st Pramod]# hcitool conn=0AConnections:=0A        > ACL 00:0F:DE:B1:02:42 h=
andle 11 state 1 lm SLAVE AUTH ENCRYPT SECURE=0A=0AIts fine till here I thi=
nk=0AI am able record sound using=0A[Pramod@localhost ~]$ arecord -D blueto=
oth -f S16_LE today.raw=0ARecording WAVE 'today.raw' : Signed 16 bit Little=
 Endian, Rate 8000 Hz, Mono=0AI am able to do it.=0ABut when I Do =0A[Pramo=
d@localhost ~]$ aplay -D bluetooth -t raw -f S16_LE today.raw=0APlaying WAV=
E 'today.raw' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono=0AI am not =
able hear anything=0A=0AThis is my hciconfig=0A[root@localhost Pramod]# /us=
r/local/sbin/hciconfig -a=0Ahci0:   Type: USB=0A        BD Address: 00:02:7=
2:CE:5B:80 ACL MTU: 1017:8 SCO MTU: 64:0=0A        UP RUNNING PSCAN ISCAN=
=0A        RX bytes:5057856 acl:233 sco:99008 events:218 errors:0=0A       =
 TX bytes:4708 acl:165 sco:0 commands:102 errors:0=0A        Features: 0xff=
 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80=0A        Packet type: DM1 DM3 DM5 DH1 =
DH3 DH5 HV1 HV2 HV3=0A        Link policy: RSWITCH HOLD SNIFF PARK=0A      =
  Link mode: SLAVE ACCEPT=0A        Name: 'BlueZ (0)'=0A        Class: 0x08=
0000=0A        Service Classes: Capturing=0A        Device Class: Miscellan=
eous,=0A        HCI Ver: 2.0 (0x3) HCI Rev: 0x204d LMP Ver: 2.0 (0x3) LMP S=
ubver: 0x4127=0A        Manufacturer: Broadcom Corporation (15)=0A=0AI see =
one difference in mine & yours at line number 2 end=0ASCO MTU: 64:0 -------=
---mine =0ASCO =0AMTU: =0A64:8 ----------yours=0AAlso my         Service Cl=
asses: Capturing=0AIs it OK??=0AThis is my hcidump when I was playing audio=
=0A[root@localhost Pramod]# /usr/local/sbin/hcidump -i hci0 --asci=0AHCI sn=
iffer - Bluetooth packet analyzer ver 1.40=0Adevice: hci0 snap_len: 1028 fi=
lter: 0xffffffff=0A> SCO data: handle 1 flags 0x00 dlen 48=0A    . . . . . =
. k . . . . . . . x . . . . .=0A    . . . . _ . . . . . . . . . . . \ . . .=
=0A    . . . . E . . .=0A> SCO data: handle 1 flags 0x00 dlen 48=0A    k . =
. . n . l . . . ' . : . . . B . a .=0A    . . 2 . p . . . . . . . u . " . \=
 . . .=0A    . . . . z . . .=0A=0AI tried variations in audio.conf, but no =
changes .=0AI need to try something else.=0AOne more thing If you dont mind=
. what is static struct usb_device_id blacklist_ids[]=0Aand static struct u=
sb_device_id bluetooth_ids[] =0Ain /usr/src/linux-2.6.22.16/drivers/bluetoo=
th/hci_usb.c=0A=0AThanks and have a great weekend..Hope to get some way thr=
ough it.=0A=0AThanks and Best regards =0APramod=0A=0A----- Original Message=
 ----=0AFrom: jayjwa <jayjwa@atr2.ath.cx>=0ATo: BlueZ users <bluez-users@li=
sts.sourceforge.net>=0ASent: Thursday, 14 February, 2008 7:52:45 PM=0ASubje=
ct: Re: [Bluez-users] Headset not playing audio HELP PLEASE=0A=0A=0AOn =0AW=
ed, =0A13 =0AFeb =0A2008, =0Apramod =0Agurav =0Awrote:=0A=0A-> =0A[Pramod@l=
ocalhost =0A~]$ =0Astrings =0A/sbin/modprobe =0A| =0Agrep =0Aconf=0A-> =0A/=
etc/modules.conf=0A-> =0Ashowconfig=0A-> =0A/etc/modprobe.conf=0A-> =0AUsag=
e: =0A%s =0A[-v] =0A[-V] =0A[-C =0Aconfig-file] =0A[-n] =0A[-i] =0A[-q] =0A=
[-b] =0A[-o =0A<modname>] =0A<modname> =0A[parameters...]=0A-> =0AFailed =
=0Ato =0Aopen =0Aconfig =0Afile =0A%s: =0A%s=0A-> =0AFailed =0Ato =0Aopen =
=0Aincluded =0Aconfig =0Afile =0A%s: =0A%s=0A=0ALooks =0Alike =0Ait's =0Aus=
ing =0Aboth =0A/etc/modules.conf =0Aand =0A/etc/modprobe.conf, =0AI'd =0Ast=
ick =0Awith =0A/etc/modprobe.conf =0Aas =0AI =0Athink =0Athat's =0Athe =0Ac=
urrently =0Aused =0Aone =0Ain =0Athe =0ALinux =0Acommunity.=0A=0A=0A-> =0AT=
his =0Ais =0Amy =0A/usr/src/linux-2.6.15..i686/.config(Only =0ABT =0Aconfig=
s =0Aare =0Agiven =0Ahere)=0A-> =0ACONFIG_BT=3Dy=0A-> =0ACONFIG_BT_L2CAP=3D=
y=0A-> =0ACONFIG_BT_SCO=3Dy=0A-> =0ACONFIG_BT_RFCOMM=3Dy=0A-> =0ACONFIG_BT_=
RFCOMM_TTY=3Dy=0A-> =0ACONFIG_BT_BNEP=3Dy=0A-> =0ACONFIG_BT_BNEP_MC_FILTER=
=3Dy=0A-> =0ACONFIG_BT_BNEP_PROTO_FILTER=3Dy=0A-> =0ACONFIG_BT_CMTP=3Dm=0A-=
> =0ACONFIG_BT_HIDP=3Dy=0A-> =0A#=0A-> =0A# =0ABluetooth =0Adevice=0A->  =
=0Adrivers=0A-> =0A#=0A-> =0ACONFIG_BT_HCIUSB=3Dy=0A-> =0ACONFIG_BT_HCIUSB_=
SCO=3Dy=0A-> =0ACONFIG_BT_HCIUART=3Dy=0A-> =0ACONFIG_BT_HCIUART_H4=3Dy=0A->=
 =0ACONFIG_BT_HCIUART_BCSP=3Dy=0A-> =0ACONFIG_BT_HCIBCM203X=3Dy=0A-> =0ACON=
FIG_BT_HCIBPA10X=3Dy=0A-> =0ACONFIG_BT_HCIBFUSB=3Dy=0A-> =0ACONFIG_BT_HCIDT=
L1=3Dy=0A-> =0ACONFIG_BT_HCIBT3C=3Dy=0A-> =0ACONFIG_BT_HCIBLUECARD=3Dy=0A->=
 =0ACONFIG_BT_HCIBTUART=3Dy=0A-> =0ACONFIG_BT_HCIVHCI=3Dy=0A-> =0ACONFIG_IE=
EE80211=3Dm=0A=0ALooks =0Alike =0Ait's =0Aall =0Acompiled =0Ain, =0Awhich =
=0Ais =0AOK. =0AYou =0Acould =0Ado =0Amodules =0A(=3Dm) =0Ato =0Asave =0Ake=
rnel =0Asize, =0Aif =0Ayou =0Alike, =0Abut =0Ait's =0Afine =0Ahow =0Ait =0A=
is =0Anow.=0A=0A-> =0ASO =0AI =0Ahave =0Ahci_usb =0Acompiled =0Ain =0Amy =
=0Akernel... =0A-> =0AThese =0Aare =0Athings =0AI =0Adid =0Anow...=0A-> =0A=
[root@localhost =0APramod]# =0Amv =0A/etc/modules.conf =0A/etc/modules.conf=
_old=0A-> =0Acopied =0Athese =0Alines =0Ato =0A/etc/modprobe.conf=0A-> =0Aa=
lias =0Anet-pf-31 =0Abluez  =0A------> =0Achanged =0Ato =0A----->  =0Aalias=
 =0Anet-pf-31 =0Abluetooth=0A-> =0Aalias =0Abt-proto-0 =0Al2cap=0A-> =0Aali=
as =0Abt-proto-2 =0Asco=0A-> =0Aalias =0Abt-proto-3 =0Arfcomm=0A-> =0AAdded=
 =0A"options =0A-> =0Ahci_usb =0A-> =0Aforce_scofix=3D1" =0Ato  =0A/etc/mod=
probe.conf =0Afile...=0A=0AHopefully =0Aon =0Aone =0Aline?=0A=0Aoptions    =
=0Ahci_usb =0Aforce_scofix=3D1=0A=0AYou =0Acan =0Atry =0Ato =0Asee =0Aif =
=0Asome =0Aof =0Athe =0Aother =0Aoptions =0Awork =0Afor =0Ayou. =0ASee =0At=
hem =0Awith =0A'modinfo =0Ahci_usb'.=0A=0A=0A-> =0ANow =0AI =0Arebooted =0A=
..=0A=0A=0AIf =0Athey =0Awere =0Amodules, =0Ayou =0Awon't =0Ahave =0Ato =0A=
reboot =0Aevery =0Atime =0Ayou =0Achange =0Aan =0Aoptions. =0AJust=0A=0Amod=
probe =0A-r =0Ahci_usb=0Amodprobe =0Ahci_usb =0Aforce_scofix=3D1=0A=0Aor =
=0Aany =0Aother =0Aoption. =0AIf =0Ait =0Asays =0A'module =0Awhatever =0Ais=
 =0Ain =0Ause' =0Akill =0Athe =0Athings =0Ausing =0Ait =0Afirst, =0Athen =
=0Arestart =0Athem. =0AUsually =0Aanything =0Awith =0A'blue' =0Aor =0A'hci'=
 =0Ain =0Athe =0Aname. =0A'pkill' =0Aworks =0Agood =0Afor =0Athat, =0Aif =
=0Ayou =0Ahave =0A'pkill'.=0A=0A=0A-> =0AWhen =0AI =0Arestarted =0Amy =0Ahc=
id(with =0Asdpd, =0Aaudi-service =0Aautostart) =0AI =0Afound =0Asome =0Athi=
ngs =0Athat =0AI =0Anever =0Aseen =0A-> =0Abefore =0Ain =0A/var/log/message=
s =0Athese =0Aare=0A-> =0A/***This =0Alog =0Aappeared =0Afor =0Afirst =0Ati=
me*****/=0A-> =0AFeb =0A13 =0A09:48:40 =0Alocalhost =0Aaudio[2473]: =0ALoad=
ing =0Adevice =0A00:0F:DE:B1:02:42 =0A(headset =0A)=0A-> =0AFeb =0A13 =0A09=
:48:40 =0Alocalhost =0Aaudio[2473]: =0ASetting =0A00:0F:DE:B1:02:42 =0Aas =
=0Adefault =0Adevice=0A-> =0A-> =0AThen =0AI =0Adid =0A-> =0A[Pramod@localh=
ost =0A~]$ =0Aarecord =0A-D =0Abluetooth =0A-f =0AS16_LE =0Atest.raw=0A-> =
=0A-> =0Aboth =0AACL =0Aand =0ASCO =0Awere =0Aestablished =0A-> =0AI =0Awas=
 =0Aable =0Ato =0Arecord =0Asound =0Afrom =0Aheadset...=0A-> =0ABut =0Awhen=
 =0AI =0Atried=0A-> =0A[Pramod@localhost =0A~]$ =0Aaplay =0A-D =0Abluetooth=
 =0A-f =0AS16_LE =0Atest.raw=0A-> =0APlaying =0Araw =0Adata =0A'test.raw' =
=0A: =0ASigned =0A16 =0Abit =0ALittle =0AEndian, =0ARate =0A8000 =0AHz, =0A=
Mono=0A-> =0A-> =0ANo =0Asound =0Awas =0Alistened =0Aon =0Aheadset=0A-> =0A=
-> =0A[root@localhost =0APramod]# =0Ahcitool =0Acon=0A-> =0AConnections:=0A=
->  =0A  =0A  =0A  =0A =0A< =0ASCO =0A00:0F:DE:B1:02:42 =0Ahandle =0A1 =0As=
tate =0A1 =0Alm =0ASLAVE=0A->  =0A  =0A  =0A  =0A =0A< =0AACL =0A00:0F:DE:B=
1:02:42 =0Ahandle =0A11 =0Astate =0A1 =0Alm =0AMASTER=0A=0AMaybe =0Athe =0A=
device =0Aisn't =0Ain =0Athe =0Aright =0Astate. =0AAfter =0Ayours =0Ait =0A=
says =0Aeither =0A'SLAVE' =0Aor =0A"MASTER", =0Awhen =0Amine =0Ais =0Aready=
 =0Ato =0Aplay =0Ait =0Alists:=0A=0Ahcitool =0Acon=0AConnections:=0A  =0A  =
=0A  =0A  =0A =0A> =0AACL =0A00:1A:45:01:F9:42 =0Ahandle =0A11 =0Astate =0A=
1 =0Alm =0AMASTER =0AAUTH =0AENCRYPT =0ASECURE=0A=0AIf =0AI =0Atry =0Ato =
=0Aplay =0Awithout =0Athat =0Areading =0Aas =0Aabove, =0AI =0Aget =0Anothin=
g, =0Aor =0Asometimes =0Agarbage. =0ADoes =0Ayour =0Aheadset =0Ahave =0Aa =
=0Abutton =0Aor =0Aswitch =0Ato =0Amake =0Ait =0Apair?=0A=0A=0AI =0Aset =0A=
up =0Aall =0Athe =0Abluetooth =0Astuff =0Afirst, =0Astart=0Apasskey-agent =
=0A--default =0A(PIN =0Anumber) =0A(addr =0Aof =0Aheadset) =0A&=0Aauth-agen=
t =0A&=0A=0Athen =0Aturn =0Aon =0Athe =0Aheadset, =0Await =0Aa =0Afew =0Ase=
conds. =0ALook =0Aat =0A'hcitool =0Acon' =0Aand =0Aif =0Aif =0Athe =0Aparam=
eters =0Aare =0Athere. =0AIf =0Aso, =0Aplay =0Asound, =0Aif =0Anot, =0Apres=
s =0Athe =0Abutton =0Aon =0Athe =0Aheadset, =0Aand =0Alook =0Aagain =0Aat =
=0A'hcitool =0Acon' =0Afor =0Aparameters =0Ato =0Abe =0Acorrect. =0AIt's =
=0Ahard =0Ato =0Asay =0Awhat =0Ato =0Ado =0Aexactly =0Afor =0Ayour =0Aheads=
et, =0Abecause =0AI've =0Anever =0Aseen =0Ait, =0Aand =0Acan =0Aonly =0Ague=
ss =0Aat =0Ahow =0Ait =0Aworks. =0AIf =0Athis =0Astuff =0Ahere =0Adoesn't =
=0Awork, =0AI'd =0Asay =0Ayou'll =0Ajust =0Ahave =0Ato =0Aplay =0Aaround =
=0Awith =0Ait, =0Aor =0Asee =0Aif =0Ayou =0Acan =0Aget =0Ayour =0Ahands =0A=
on =0Asome =0Aother =0Aheadsets =0Ato =0Asee =0Aif =0Athey =0Awork/work =0A=
differently.=0A=0Asox =0A-t =0Amp3 =0Afile.mp3 =0A-t =0Aalsa =0Apcm.bluetoo=
th=0A=0A>From =0Athis =0Alist, =0Ait =0Aseems =0Ayou're =0Asupposed =0Ato =
=0Ause =0Aa =0Agnome =0Aor =0AKDE =0Autility =0Afor =0Athe =0Ajobs =0Aof =
=0Apasskey-agent =0Aand =0Aauth-agent. =0AYou =0Amight =0Atry =0Athose. =0A=
There's =0Aprobably =0Aa =0Apackage =0Aor =0Asource =0Afor =0Athem =0Asomep=
lace.=0A=0A=0A-> =0A[root@localhost =0APramod]# =0Ahcidump =0A-x=0A-> =0A> =
=0ASCO =0Adata: =0Ahandle =0A1 =0Aflags =0A0x00 =0Adlen =0A48=0A->  =0A  =
=0A =0A4F =0A00 =0ACE =0AFF =0AB2 =0AFF =0AB5 =0AFF =0A41 =0A00 =0AB5 =0A00=
 =0AB9 =0A00 =0A85 =0A00 =0A8B =0A00 =0AA3 =0A00=0A->  =0A  =0A =0A54 =0A00=
 =0A42 =0A00 =0A38 =0A00 =0A1B =0A00 =0AFB =0AFF =0AD1 =0AFF =0AAB =0AFF =
=0A44 =0A00 =0A78 =0A00 =0A87 =0A00=0A->  =0A  =0A =0A73 =0A00 =0A56 =0A00 =
=0AE8 =0AFF =0AF4 =0AFF=0A-> =0Actnr+c=0A=0Ahcidump =0A-i =0Ahci0 =0A--asci=
i=0A=0Ais =0Aa =0Alittle =0Aeasier =0Ato =0Aread, =0Athan =0A-x, =0Awhich =
=0Ais =0Ahex. =0AYou =0Acan =0Aat =0Aleast =0Aread =0Awhat's =0Agoing =0Aon=
.=0A=0A=0A-> =0Athe =0Alogs =0Awere=0A-> =0AFeb =0A13 =0A09:49:35 =0Alocalh=
ost =0Ahcid[2469]: =0Alink_key_request =0A(sba=3D00:02:72:CE:5B:80, =0Adba=
=3D00:0F:DE:B1:02:42)=0A-> =0AFeb =0A13 =0A09:49:36 =0Alocalhost =0Ahcid[24=
69]: =0Alink_key_notify =0A(sba=3D00:02:72:CE:5B:80, =0Adba=3D00:0F:DE:B1:0=
2:42)Feb =0A13 =0A09:49:36 =0Alocalhost =0Aaudio[2473]: =0ABadly =0Aformate=
d =0Aor =0Aunrecognized =0Acommand: =0AAT*ECBP=3D?=0A-> =0AFeb =0A13 =0A09:=
49:36 =0Alocalhost =0Aaudio[2473]: =0ABadly =0Aformated =0Aor =0Aunrecogniz=
ed =0Acommand: =0AAT+CSCS=3D"UTF-8"=0A-> =0AFeb =0A13 =0A09:49:36 =0Alocalh=
ost =0Aaudio[2473]: =0ABadly =0Aformated =0Aor =0Aunrecognized =0Acommand: =
=0AAT+CLAN?=0A=0AI =0Asee =0Athese =0Atoo =0Asometimes, =0AI =0Adon't =0Ath=
ink =0Athey =0Astop =0Ait =0Afrom =0Aworking. =0AMaybe =0Atry =0Aboth =0Awa=
ys =0Ain =0A/etc/bluetooth/audio.conf:=0A=0A# =0ASet =0Ato =0Atrue =0Ato =
=0Aonly =0Asupport =0AHSP=0A# =0ADefaults =0Ato =0Afalse=0ADisableHFP=3Dfal=
se=0A=0Aand=0A=0A# =0ASet =0Ato =0Atrue =0Ato =0Aonly =0Asupport =0AHSP=0A#=
 =0ADefaults =0Ato =0Afalse=0ADisableHFP=3Dtrue=0A=0Aand =0Arestart. =0ASee=
 =0Aif =0Athat =0Achanges =0Aanything. =0AIf =0Anot =0Aleave =0Ait =0Aas =
=0ADisableHFP=3Dfalse=0A=0A=0A=0A-> =0AFeb =0A13 =0A09:51:06 =0Alocalhost =
=0Aaudio[2473]: =0AAudio =0AAPI: =0Areceived =0ABT_GETCAPABILITIES_REQ=0A->=
 =0AFeb =0A13 =0A09:51:06 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0A=
sending =0ABT_GETCAPABILITIES_RSP=0A-> =0AFeb =0A13 =0A09:51:06 =0Alocalhos=
t =0Aaudio[2473]: =0AAudio =0AAPI: =0Areceived =0ABT_SETCONFIGURATION_REQ=
=0A=0A=0A-> =0AFeb =0A13 =0A09:51:06 =0Alocalhost =0Aaudio[2473]: =0Aconfig=
 =0Asbc =0A- =0Afrequency =0A=3D =0A0 =0Achannel_mode =0A=3D =0A0 =0Aalloca=
tion =0A=3D =0A0 =0Asubbands =0A=3D =0A0 =0Ablocks =0A=3D =0A0 =0Abitpool =
=0A=3D =0A0=0A-> =0AFeb =0A13 =0A09:51:08 =0Alocalhost =0Ahcid[2469]: =0Api=
n_code_request =0A(sba=3D00:02:72:CE:5B:80, =0Adba=3D00:0F:DE:B1:02:42)=0A-=
> =0AFeb =0A13 =0A09:51:08 =0Alocalhost =0Ahcid[2469]: =0Alink_key_notify =
=0A(sba=3D00:02:72:CE:5B:80, =0Adba=3D00:0F:DE:B1:02:42)Feb =0A13 =0A09:51:=
09 =0Alocalhost =0Aaudio[2473]: =0ABadly =0Aformated =0Aor =0Aunrecognized =
=0Acommand: =0AAT*ECBP=3D?=0A-> =0AFeb =0A13 =0A09:51:09 =0Alocalhost =0Aau=
dio[2473]: =0ASCO =0Afd=3D11=0A-> =0AFeb =0A13 =0A09:51:09 =0Alocalhost =0A=
audio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_SETCONFIGURATION_RSP=0A-> =
=0AFeb =0A13 =0A09:51:09 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Ar=
eceived =0ABT_STREAMSTART_REQ=0A-> =0AFeb =0A13 =0A09:51:09 =0Alocalhost =
=0Aaudio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART_RSP=0A-> =0AF=
eb =0A13 =0A09:51:09 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Asendi=
ng =0ABT_STREAMFD_IND=0A-> =0AFeb =0A13 =0A09:51:09 =0Alocalhost =0Aaudio[2=
473]: =0ABadly =0Aformated =0Aor =0Aunrecognized =0Acommand: =0AAT+CSCS=3D"=
UTF-8"=0A-> =0AFeb =0A13 =0A09:51:09 =0Alocalhost =0Aaudio[2473]: =0ABadly =
=0Aformated =0Aor =0Aunrecognized =0Acommand: =0AAT+CLAN?=0A-> =0AFeb =0A13=
 =0A09:52:30 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Areceived =0AB=
T_STREAMSTART_REQ=0A-> =0AFeb =0A13 =0A09:52:30 =0Alocalhost =0Aaudio[2473]=
: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART_RSP=0A-> =0AFeb =0A13 =0A09=
:52:30 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_STREA=
MFD_IND=0A-> =0AFeb =0A13 =0A09:52:43 =0Alocalhost =0Akernel: =0Ahci_scodat=
a_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown =0Aconnection =0Ahandl=
e =0A1=0A-> =0A-> =0AFeb =0A13 =0A09:52:43 =0Alocalhost =0Akernel: =0Ahci_s=
codata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown =0Aconnection =0A=
handle =0A1=0A=0AThese =0Atwo =0Alines =0Aabove =0Amight =0Ashow =0Aa =0Apr=
oblem. =0AIt =0Ashouldn't =0Abe =0Aunknown, =0Acorrect?=0A=0A=0A-> =0AFeb =
=0A13 =0A09:53:12 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Areceived=
 =0ABT_GETCAPABILITIES_REQ=0A-> =0AFeb =0A13 =0A09:53:12 =0Alocalhost =0Aau=
dio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_GETCAPABILITIES_RSP=0A-> =0AFe=
b =0A13 =0A09:53:12 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Areceiv=
ed =0ABT_SETCONFIGURATION_REQ=0A-> =0AFeb =0A13 =0A09:53:12 =0Alocalhost =
=0Aaudio[2473]: =0Aconfig =0Asbc =0A- =0Afrequency =0A=3D =0A0 =0Achannel_m=
ode =0A=3D =0A0 =0Aallocation =0A=3D =0A0 =0Asubbands =0A=3D =0A0 =0Ablocks=
 =0A=3D =0A0 =0Abitpool =0A=3D =0A0=0A-> =0A-> =0AI =0Ahad =0Amade =0Aall =
=0Athe =0Achanges =0Asuggested =0Aby =0Ayou. =0AAre =0Athey =0Adone =0Aprop=
erly?=0A=0ALooks =0AOK =0Aso =0Afar.=0A=0A-> =0AThis =0Ais =0Amy =0Ahciconf=
ig =0A-a =0Aoutput=0A-> =0A[root@localhost =0APramod]# =0A/usr/local/sbin/h=
ciconfig =0A-a =0A-> =0Ahci0:  =0A =0AType: =0AUSB=0A->  =0A  =0A  =0A  =0A=
 =0ABD =0AAddress: =0A00:02:72:CE:5B:80 =0AACL =0AMTU: =0A1017:8 =0ASCO =0A=
MTU: =0A64:0=0A->  =0A  =0A  =0A  =0A =0AUP =0ARUNNING =0APSCAN =0AISCAN=0A=
->  =0A  =0A  =0A  =0A =0ARX =0Abytes:5974443 =0Aacl:279 =0Asco:116978 =0Ae=
vents:188 =0Aerrors:0=0A->  =0A  =0A  =0A  =0A =0ATX =0Abytes:4222 =0Aacl:1=
68 =0Asco:0 =0Acommands:90 =0Aerrors:0=0A=0ARx =0Ais =0Areceived, =0Alook =
=0Aat =0Asco, =0A116978. =0ABut =0Alook =0Aat =0ATX, =0Atransmitted, =0Asco=
:0 =0Amakes =0Ame =0Athink =0Anothing =0Ais =0Agetting =0Asent. =0AWatch =
=0Ahcidump =0Awhen =0Athe =0Asound =0Ais =0Asupposed =0Ato =0Aplay, =0Adoes=
 =0Ait =0Alook =0Aat =0Ait's =0Abeing =0Asent, =0Ajust =0Anot =0Areceived, =
=0Aor =0Anot =0Asent =0Aat =0Aall =0Abecause =0Aof =0Asome =0Areason?=0A=0A=
Look =0Aat =0Athe =0ATX, =0ATX =0Asco =0Aon =0Amy =0Aoutput =0Aafter =0Aone=
 =0Afile,=0A=0Ahci0:  =0A =0AType: =0AUSB=0A  =0A  =0A  =0A  =0A =0ABD =0AA=
ddress: =0A00:0A:3A:7C:5C:74 =0AACL =0AMTU: =0A1017:8 =0ASCO =0AMTU: =0A64:=
8=0A  =0A  =0A  =0A  =0A =0AUP =0ARUNNING =0APSCAN =0AISCAN=0A  =0A  =0A  =
=0A  =0A =0ARX =0Abytes:5348812 =0Aacl:52 =0Asco:104818 =0Aevents:93 =0Aerr=
ors:0=0A  =0A  =0A  =0A  =0A =0ATX =0Abytes:5403125 =0Aacl:48 =0Asco:105913=
 =0Acommands:44 =0Aerrors:0=0A  =0A  =0A  =0A  =0A =0AFeatures: =0A0xff =0A=
0xff =0A0x8d =0A0xfe =0A0x9b =0A0xf9 =0A0x00 =0A0x80=0A  =0A  =0A  =0A  =0A=
 =0APacket =0Atype: =0ADM1 =0ADM3 =0ADM5 =0ADH1 =0ADH3 =0ADH5 =0AHV1 =0AHV2=
 =0AHV3=0A  =0A  =0A  =0A  =0A =0ALink =0Apolicy: =0ARSWITCH =0AHOLD =0ASNI=
FF =0APARK=0A  =0A  =0A  =0A  =0A =0ALink =0Amode: =0ASLAVE =0AACCEPT=0A  =
=0A  =0A  =0A  =0A =0AName: =0A'[vdrl] =0A/ =0ABT =0ADevice =0A0'=0A  =0A  =
=0A  =0A  =0A =0AClass: =0A0x020108=0A  =0A  =0A  =0A  =0A =0AService =0ACl=
asses: =0ANetworking=0A  =0A  =0A  =0A  =0A =0ADevice =0AClass: =0AComputer=
, =0AServer=0A  =0A  =0A  =0A  =0A =0AHCI =0AVer: =0A2.0 =0A(0x3) =0AHCI =
=0ARev: =0A0x4107 =0ALMP =0AVer: =0A2.0 =0A(0x3) =0ALMP =0ASubver: =0A0x430=
e=0A  =0A  =0A  =0A  =0A =0AManufacturer: =0ABroadcom =0ACorporation =0A(15=
)=0A=0A=0A=0ARX =0Abytes:5348812 =0Aacl:52 =0Asco:104818=0ATX =0Abytes:5403=
125 =0Aacl:48 =0Asco:105913=0A=0A=0A=0A=0A-----Inline Attachment Follows---=
--=0A=0A-------------------------------------------------------------------=
------=0AThis =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft=0AD=
efy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.=0Aht=
tp://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=0A=0A=0A-----Inline A=
ttachment Follows-----=0A=0A_______________________________________________=
=0ABluez-users =0Amailing =0Alist=0ABluez-users@lists.sourceforge.net=0Ahtt=
ps://lists.sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=0A=0A=
=0A=0A      Bollywood, fun, friendship, sports and more. You name it, we ha=
ve it on http://in.promos.yahoo.com/groups  
--0-1768090546-1203050952=:91408
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Thanks for your valuable time and guidance.<br>it was initi=
ally<br>[root@localhost Pramod]# hcitool conn<br>=0AConnections:<br>When I =
press button on HS , I receive this on console(but no popup)<br>[root@local=
host Pramod]# Authorization request for device 00:0F:DE:B1:02:42<br>Now whe=
n I do<br>[root@localhost Pramod]# hcitool conn<br>Connections:<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; ACL 00:0F:DE:B1:02:42 handle 11 sta=
te 1 lm SLAVE AUTH ENCRYPT SECURE<br><br>Its fine till here I think<br>I am=
 able record sound using<br>[Pramod@localhost ~]$ arecord -D bluetooth -f S=
16_LE today.raw<br>Recording WAVE 'today.raw' : Signed 16 bit Little Endian=
, Rate 8000 Hz, Mono<br><span style=3D"font-style: italic;"></span>I am abl=
e to do it.<br>But when I Do <br>[Pramod@localhost ~]$ aplay -D bluetooth -=
t raw -f S16_LE today.raw<br>Playing WAVE 'today.raw' : Signed 16 bit Littl=
e Endian, Rate 8000 Hz, Mono<br>I am not able hear anything<br><br>This is =
my hciconfig<br>[root@localhost Pramod]# /usr/local/sbin/hciconfig -a<br>hc=
i0:&nbsp;&nbsp; Type:
 USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:02:72:CE:=
5B:80 ACL MTU: 1017:8 <span style=3D"font-style: italic; font-weight: bold;=
 text-decoration: underline;">SCO MTU: 64:0</span><br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; RX bytes:5057856 acl:233 sco:99008 events:218 errors:0<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:4708 acl:165 sco:0 comma=
nds:102 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0x=
ff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (0)'<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; Class:
 0x080000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"text=
-decoration: underline;">Service Classes: Capturing</span><br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Miscellaneous,<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 2.0 (0x3) HCI Rev: 0x204d LMP Ver: 2=
.0 (0x3) LMP Subver: 0x4127<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; M=
anufacturer: Broadcom Corporation (15)<br><br>I see one difference in mine =
&amp; yours at line number 2 end<br>SCO MTU: 64:0 ----------mine <br>SCO =
=0AMTU: =0A64:8 ----------yours<br>Also my &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; <span style=3D"text-decoration: underline;">Service Classes: Cap=
turing</span><br>Is it OK??<br>This is my hcidump when I was playing audio<=
br>[root@localhost Pramod]# /usr/local/sbin/hcidump -i hci0 --asci<br>HCI s=
niffer - Bluetooth packet analyzer ver 1.40<br>device: hci0 snap_len: 1028 =
filter: 0xffffffff<br>&gt; SCO data: handle 1 flags 0x00 dlen 48<br>&nbsp;&=
nbsp;&nbsp; . . . . . . k . . . . . . . x . . . . .<br>&nbsp;&nbsp;&nbsp; .=
 . . . _ . . . . . . . . . . . \ . . .<br>&nbsp;&nbsp;&nbsp; . . . . E . . =
.<br>&gt; SCO data: handle 1 flags 0x00 dlen 48<br>&nbsp;&nbsp;&nbsp; k . .=
 . n . l . . . ' . : . . . B . a .<br>&nbsp;&nbsp;&nbsp; . . 2 . p . . . . =
. . . u . " . \ . . .<br>&nbsp;&nbsp;&nbsp; . . . . z . . .<br><br><div>I t=
ried variations in audio.conf, but no changes .<br>I need to try something =
else.<br>One more thing If you dont mind. what is static struct usb_device_=
id
 blacklist_ids[]<br>and static struct usb_device_id bluetooth_ids[] <br>in =
/usr/src/linux-2.6.22.16/drivers/bluetooth/hci_usb.c<br><br>Thanks and have=
 a great weekend..Hope to get some way through it.<br></div>Thanks and Best=
 regards<div>&nbsp;</div><div>Pramod<div style=3D"font-family: times new ro=
man,new york,times,serif; font-size: 12pt;"><br><br><div style=3D"font-fami=
ly: times new roman,new york,times,serif; font-size: 12pt;">----- Original =
Message ----<br>From: jayjwa &lt;jayjwa@atr2.ath.cx&gt;<br>To: BlueZ users =
&lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: Thursday, 14 February, 2=
008 7:52:45 PM<br>Subject: Re: [Bluez-users] Headset not playing audio HELP=
 PLEASE<br><br><br>On =0AWed, =0A13 =0AFeb =0A2008, =0Apramod =0Agurav =0Aw=
rote:<br><br>-&gt; =0A[Pramod@localhost =0A~]$ =0Astrings =0A/sbin/modprobe=
 =0A| =0Agrep =0Aconf<br>-&gt; =0A/etc/modules.conf<br>-&gt; =0Ashowconfig<=
br>-&gt; =0A/etc/modprobe.conf<br>-&gt; =0AUsage: =0A%s =0A[-v] =0A[-V] =0A=
[-C =0Aconfig-file] =0A[-n] =0A[-i] =0A[-q] =0A[-b] =0A[-o =0A&lt;modname&g=
t;] =0A&lt;modname&gt; =0A[parameters...]<br>-&gt; =0AFailed =0Ato =0Aopen =
=0Aconfig =0Afile =0A%s: =0A%s<br>-&gt; =0AFailed =0Ato =0Aopen =0Aincluded=
 =0Aconfig =0Afile =0A%s: =0A%s<br><br>Looks =0Alike =0Ait's =0Ausing =0Abo=
th =0A/etc/modules.conf =0Aand =0A/etc/modprobe.conf, =0AI'd =0Astick <br>w=
ith =0A/etc/modprobe.conf =0Aas =0AI =0Athink =0Athat's =0Athe =0Acurrently=
 =0Aused =0Aone =0Ain =0Athe =0ALinux <br>community.<br><br><br>-&gt; =0ATh=
is =0Ais =0Amy =0A/usr/src/linux-2.6.15..i686/.config(Only =0ABT =0Aconfigs=
 =0Aare =0Agiven =0Ahere)<br>-&gt; =0ACONFIG_BT=3Dy<br>-&gt; =0ACONFIG_BT_L=
2CAP=3Dy<br>-&gt; =0ACONFIG_BT_SCO=3Dy<br>-&gt; =0ACONFIG_BT_RFCOMM=3Dy<br>=
-&gt; =0ACONFIG_BT_RFCOMM_TTY=3Dy<br>-&gt; =0ACONFIG_BT_BNEP=3Dy<br>-&gt; =
=0ACONFIG_BT_BNEP_MC_FILTER=3Dy<br>-&gt; =0ACONFIG_BT_BNEP_PROTO_FILTER=3Dy=
<br>-&gt; =0ACONFIG_BT_CMTP=3Dm<br>-&gt; =0ACONFIG_BT_HIDP=3Dy<br>-&gt; =0A=
#<br>-&gt; =0A# =0ABluetooth =0Adevice<br>-&gt;&nbsp; =0Adrivers<br>-&gt; =
=0A#<br>-&gt; =0ACONFIG_BT_HCIUSB=3Dy<br>-&gt; =0ACONFIG_BT_HCIUSB_SCO=3Dy<=
br>-&gt; =0ACONFIG_BT_HCIUART=3Dy<br>-&gt; =0ACONFIG_BT_HCIUART_H4=3Dy<br>-=
&gt; =0ACONFIG_BT_HCIUART_BCSP=3Dy<br>-&gt; =0ACONFIG_BT_HCIBCM203X=3Dy<br>=
-&gt; =0ACONFIG_BT_HCIBPA10X=3Dy<br>-&gt; =0ACONFIG_BT_HCIBFUSB=3Dy<br>-&gt=
; =0ACONFIG_BT_HCIDTL1=3Dy<br>-&gt; =0ACONFIG_BT_HCIBT3C=3Dy<br>-&gt; =0ACO=
NFIG_BT_HCIBLUECARD=3Dy<br>-&gt; =0ACONFIG_BT_HCIBTUART=3Dy<br>-&gt; =0ACON=
FIG_BT_HCIVHCI=3Dy<br>-&gt; =0ACONFIG_IEEE80211=3Dm<br><br>Looks =0Alike =
=0Ait's =0Aall =0Acompiled =0Ain, =0Awhich =0Ais =0AOK. =0AYou =0Acould =0A=
do =0Amodules =0A(=3Dm) =0Ato <br>save =0Akernel =0Asize, =0Aif =0Ayou =0Al=
ike, =0Abut =0Ait's =0Afine =0Ahow =0Ait =0Ais =0Anow.<br><br>-&gt; =0ASO =
=0AI =0Ahave =0Ahci_usb =0Acompiled =0Ain =0Amy =0Akernel... <br>-&gt; =0AT=
hese =0Aare =0Athings =0AI =0Adid =0Anow...<br>-&gt; =0A[root@localhost =0A=
Pramod]# =0Amv =0A/etc/modules.conf =0A/etc/modules.conf_old<br>-&gt; =0Aco=
pied =0Athese =0Alines =0Ato =0A/etc/modprobe.conf<br>-&gt; =0Aalias =0Anet=
-pf-31 =0Abluez&nbsp; =0A------&gt; =0Achanged =0Ato =0A-----&gt;&nbsp; =0A=
alias =0Anet-pf-31 =0Abluetooth<br>-&gt; =0Aalias =0Abt-proto-0 =0Al2cap<br=
>-&gt; =0Aalias =0Abt-proto-2 =0Asco<br>-&gt; =0Aalias =0Abt-proto-3 =0Arfc=
omm<br>-&gt; =0AAdded =0A"options <br>-&gt; =0Ahci_usb <br>-&gt; =0Aforce_s=
cofix=3D1" =0Ato&nbsp; =0A/etc/modprobe.conf =0Afile...<br><br>Hopefully =
=0Aon =0Aone =0Aline?<br><br>options&nbsp;&nbsp;&nbsp; =0Ahci_usb =0Aforce_=
scofix=3D1<br><br>You =0Acan =0Atry =0Ato =0Asee =0Aif =0Asome =0Aof =0Athe=
 =0Aother =0Aoptions =0Awork =0Afor =0Ayou. =0ASee =0Athem =0Awith <br>'mod=
info =0Ahci_usb'.<br><br><br>-&gt; =0ANow =0AI =0Arebooted =0A..<br><br><br=
>If =0Athey =0Awere =0Amodules, =0Ayou =0Awon't =0Ahave =0Ato =0Areboot =0A=
every =0Atime =0Ayou =0Achange =0Aan <br>options. =0AJust<br><br>modprobe =
=0A-r =0Ahci_usb<br>modprobe =0Ahci_usb =0Aforce_scofix=3D1<br><br>or =0Aan=
y =0Aother =0Aoption. =0AIf =0Ait =0Asays =0A'module =0Awhatever =0Ais =0Ai=
n =0Ause' =0Akill =0Athe =0Athings <br>using =0Ait =0Afirst, =0Athen =0Ares=
tart =0Athem. =0AUsually =0Aanything =0Awith =0A'blue' =0Aor =0A'hci' =0Ain=
 <br>the =0Aname. =0A'pkill' =0Aworks =0Agood =0Afor =0Athat, =0Aif =0Ayou =
=0Ahave =0A'pkill'.<br><br><br>-&gt; =0AWhen =0AI =0Arestarted =0Amy =0Ahci=
d(with =0Asdpd, =0Aaudi-service =0Aautostart) =0AI =0Afound =0Asome =0Athin=
gs =0Athat =0AI =0Anever =0Aseen <br>-&gt; =0Abefore =0Ain =0A/var/log/mess=
ages =0Athese =0Aare<br>-&gt; =0A/***This =0Alog =0Aappeared =0Afor =0Afirs=
t =0Atime*****/<br>-&gt; =0AFeb =0A13 =0A09:48:40 =0Alocalhost =0Aaudio[247=
3]: =0ALoading =0Adevice =0A00:0F:DE:B1:02:42 =0A(headset =0A)<br>-&gt; =0A=
Feb =0A13 =0A09:48:40 =0Alocalhost =0Aaudio[2473]: =0ASetting =0A00:0F:DE:B=
1:02:42 =0Aas =0Adefault =0Adevice<br>-&gt; <br>-&gt; =0AThen =0AI =0Adid <=
br>-&gt; =0A[Pramod@localhost =0A~]$ =0Aarecord =0A-D =0Abluetooth =0A-f =
=0AS16_LE =0Atest.raw<br>-&gt; <br>-&gt; =0Aboth =0AACL =0Aand =0ASCO =0Awe=
re =0Aestablished <br>-&gt; =0AI =0Awas =0Aable =0Ato =0Arecord =0Asound =
=0Afrom =0Aheadset...<br>-&gt; =0ABut =0Awhen =0AI =0Atried<br>-&gt; =0A[Pr=
amod@localhost =0A~]$ =0Aaplay =0A-D =0Abluetooth =0A-f =0AS16_LE =0Atest.r=
aw<br>-&gt; =0APlaying =0Araw =0Adata =0A'test.raw' =0A: =0ASigned =0A16 =
=0Abit =0ALittle =0AEndian, =0ARate =0A8000 =0AHz, =0AMono<br>-&gt; <br>-&g=
t; =0ANo =0Asound =0Awas =0Alistened =0Aon =0Aheadset<br>-&gt; <br>-&gt; =
=0A[root@localhost =0APramod]# =0Ahcitool =0Acon<br>-&gt; =0AConnections:<b=
r>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A&lt; =0ASCO =0A00:0F:DE:=
B1:02:42 =0Ahandle =0A1 =0Astate =0A1 =0Alm =0ASLAVE<br>-&gt;&nbsp; =0A&nbs=
p; =0A&nbsp; =0A&nbsp; =0A =0A&lt; =0AACL =0A00:0F:DE:B1:02:42 =0Ahandle =
=0A11 =0Astate =0A1 =0Alm =0AMASTER<br><br>Maybe =0Athe =0Adevice =0Aisn't =
=0Ain =0Athe =0Aright =0Astate. =0AAfter =0Ayours =0Ait =0Asays =0Aeither =
=0A'SLAVE' <br>or =0A"MASTER", =0Awhen =0Amine =0Ais =0Aready =0Ato =0Aplay=
 =0Ait =0Alists:<br><br>hcitool =0Acon<br>Connections:<br>&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A =0A&gt; =0AACL =0A00:1A:45:01:F9:42 =0Ahandle =0A11=
 =0Astate =0A1 =0Alm =0AMASTER =0AAUTH =0AENCRYPT =0ASECURE<br><br>If =0AI =
=0Atry =0Ato =0Aplay =0Awithout =0Athat =0Areading =0Aas =0Aabove, =0AI =0A=
get =0Anothing, =0Aor =0Asometimes <br>garbage. =0ADoes =0Ayour =0Aheadset =
=0Ahave =0Aa =0Abutton =0Aor =0Aswitch =0Ato =0Amake =0Ait =0Apair?<br><br>=
<br>I =0Aset =0Aup =0Aall =0Athe =0Abluetooth =0Astuff =0Afirst, =0Astart<b=
r>passkey-agent =0A--default =0A(PIN =0Anumber) =0A(addr =0Aof =0Aheadset) =
=0A&amp;<br>auth-agent =0A&amp;<br><br>then =0Aturn =0Aon =0Athe =0Aheadset=
, =0Await =0Aa =0Afew =0Aseconds. =0ALook =0Aat =0A'hcitool =0Acon' =0Aand =
=0Aif =0Aif <br>the =0Aparameters =0Aare =0Athere. =0AIf =0Aso, =0Aplay =0A=
sound, =0Aif =0Anot, =0Apress =0Athe =0Abutton =0Aon =0Athe <br>headset, =
=0Aand =0Alook =0Aagain =0Aat =0A'hcitool =0Acon' =0Afor =0Aparameters =0At=
o =0Abe =0Acorrect. =0AIt's <br>hard =0Ato =0Asay =0Awhat =0Ato =0Ado =0Aex=
actly =0Afor =0Ayour =0Aheadset, =0Abecause =0AI've =0Anever =0Aseen =0Ait,=
 <br>and =0Acan =0Aonly =0Aguess =0Aat =0Ahow =0Ait =0Aworks. =0AIf =0Athis=
 =0Astuff =0Ahere =0Adoesn't =0Awork, =0AI'd =0Asay <br>you'll =0Ajust =0Ah=
ave =0Ato =0Aplay =0Aaround =0Awith =0Ait, =0Aor =0Asee =0Aif =0Ayou =0Acan=
 =0Aget =0Ayour =0Ahands =0Aon <br>some =0Aother =0Aheadsets =0Ato =0Asee =
=0Aif =0Athey =0Awork/work =0Adifferently.<br><br>sox =0A-t =0Amp3 =0Afile.=
mp3 =0A-t =0Aalsa =0Apcm.bluetooth<br><br>&gt;From =0Athis =0Alist, =0Ait =
=0Aseems =0Ayou're =0Asupposed =0Ato =0Ause =0Aa =0Agnome =0Aor =0AKDE =0Au=
tility =0Afor =0Athe <br>jobs =0Aof =0Apasskey-agent =0Aand =0Aauth-agent. =
=0AYou =0Amight =0Atry =0Athose. =0AThere's =0Aprobably =0Aa <br>package =
=0Aor =0Asource =0Afor =0Athem =0Asomeplace.<br><br><br>-&gt; =0A[root@loca=
lhost =0APramod]# =0Ahcidump =0A-x<br>-&gt; =0A&gt; =0ASCO =0Adata: =0Ahand=
le =0A1 =0Aflags =0A0x00 =0Adlen =0A48<br>-&gt;&nbsp; =0A&nbsp; =0A =0A4F =
=0A00 =0ACE =0AFF =0AB2 =0AFF =0AB5 =0AFF =0A41 =0A00 =0AB5 =0A00 =0AB9 =0A=
00 =0A85 =0A00 =0A8B =0A00 =0AA3 =0A00<br>-&gt;&nbsp; =0A&nbsp; =0A =0A54 =
=0A00 =0A42 =0A00 =0A38 =0A00 =0A1B =0A00 =0AFB =0AFF =0AD1 =0AFF =0AAB =0A=
FF =0A44 =0A00 =0A78 =0A00 =0A87 =0A00<br>-&gt;&nbsp; =0A&nbsp; =0A =0A73 =
=0A00 =0A56 =0A00 =0AE8 =0AFF =0AF4 =0AFF<br>-&gt; =0Actnr+c<br><br>hcidump=
 =0A-i =0Ahci0 =0A--ascii<br><br>is =0Aa =0Alittle =0Aeasier =0Ato =0Aread,=
 =0Athan =0A-x, =0Awhich =0Ais =0Ahex. =0AYou =0Acan =0Aat =0Aleast =0Aread=
 <br>what's =0Agoing =0Aon.<br><br><br>-&gt; =0Athe =0Alogs =0Awere<br>-&gt=
; =0AFeb =0A13 =0A09:49:35 =0Alocalhost =0Ahcid[2469]: =0Alink_key_request =
=0A(sba=3D00:02:72:CE:5B:80, =0Adba=3D00:0F:DE:B1:02:42)<br>-&gt; =0AFeb =
=0A13 =0A09:49:36 =0Alocalhost =0Ahcid[2469]: =0Alink_key_notify =0A(sba=3D=
00:02:72:CE:5B:80, =0Adba=3D00:0F:DE:B1:02:42)Feb =0A13 =0A09:49:36 =0Aloca=
lhost =0Aaudio[2473]: =0ABadly =0Aformated =0Aor =0Aunrecognized =0Acommand=
: =0AAT*ECBP=3D?<br>-&gt; =0AFeb =0A13 =0A09:49:36 =0Alocalhost =0Aaudio[24=
73]: =0ABadly =0Aformated =0Aor =0Aunrecognized =0Acommand: =0AAT+CSCS=3D"U=
TF-8"<br>-&gt; =0AFeb =0A13 =0A09:49:36 =0Alocalhost =0Aaudio[2473]: =0ABad=
ly =0Aformated =0Aor =0Aunrecognized =0Acommand: =0AAT+CLAN?<br><br>I =0Ase=
e =0Athese =0Atoo =0Asometimes, =0AI =0Adon't =0Athink =0Athey =0Astop =0Ai=
t =0Afrom =0Aworking. =0AMaybe =0Atry <br>both =0Aways =0Ain =0A/etc/blueto=
oth/audio.conf:<br><br># =0ASet =0Ato =0Atrue =0Ato =0Aonly =0Asupport =0AH=
SP<br># =0ADefaults =0Ato =0Afalse<br>DisableHFP=3Dfalse<br><br>and<br><br>=
# =0ASet =0Ato =0Atrue =0Ato =0Aonly =0Asupport =0AHSP<br># =0ADefaults =0A=
to =0Afalse<br>DisableHFP=3Dtrue<br><br>and =0Arestart. =0ASee =0Aif =0Atha=
t =0Achanges =0Aanything. =0AIf =0Anot =0Aleave =0Ait =0Aas <br>DisableHFP=
=3Dfalse<br><br><br><br>-&gt; =0AFeb =0A13 =0A09:51:06 =0Alocalhost =0Aaudi=
o[2473]: =0AAudio =0AAPI: =0Areceived =0ABT_GETCAPABILITIES_REQ<br>-&gt; =
=0AFeb =0A13 =0A09:51:06 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0As=
ending =0ABT_GETCAPABILITIES_RSP<br>-&gt; =0AFeb =0A13 =0A09:51:06 =0Alocal=
host =0Aaudio[2473]: =0AAudio =0AAPI: =0Areceived =0ABT_SETCONFIGURATION_RE=
Q<br><br><br>-&gt; =0AFeb =0A13 =0A09:51:06 =0Alocalhost =0Aaudio[2473]: =
=0Aconfig =0Asbc =0A- =0Afrequency =0A=3D =0A0 =0Achannel_mode =0A=3D =0A0 =
=0Aallocation =0A=3D =0A0 =0Asubbands =0A=3D =0A0 =0Ablocks =0A=3D =0A0 =0A=
bitpool =0A=3D =0A0<br>-&gt; =0AFeb =0A13 =0A09:51:08 =0Alocalhost =0Ahcid[=
2469]: =0Apin_code_request =0A(sba=3D00:02:72:CE:5B:80, =0Adba=3D00:0F:DE:B=
1:02:42)<br>-&gt; =0AFeb =0A13 =0A09:51:08 =0Alocalhost =0Ahcid[2469]: =0Al=
ink_key_notify =0A(sba=3D00:02:72:CE:5B:80, =0Adba=3D00:0F:DE:B1:02:42)Feb =
=0A13 =0A09:51:09 =0Alocalhost =0Aaudio[2473]: =0ABadly =0Aformated =0Aor =
=0Aunrecognized =0Acommand: =0AAT*ECBP=3D?<br>-&gt; =0AFeb =0A13 =0A09:51:0=
9 =0Alocalhost =0Aaudio[2473]: =0ASCO =0Afd=3D11<br>-&gt; =0AFeb =0A13 =0A0=
9:51:09 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_SETC=
ONFIGURATION_RSP<br>-&gt; =0AFeb =0A13 =0A09:51:09 =0Alocalhost =0Aaudio[24=
73]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_REQ<br>-&gt; =0AFeb =0A=
13 =0A09:51:09 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Asending =0A=
BT_STREAMSTART_RSP<br>-&gt; =0AFeb =0A13 =0A09:51:09 =0Alocalhost =0Aaudio[=
2473]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IND<br>-&gt; =0AFeb =0A13=
 =0A09:51:09 =0Alocalhost =0Aaudio[2473]: =0ABadly =0Aformated =0Aor =0Aunr=
ecognized =0Acommand: =0AAT+CSCS=3D"UTF-8"<br>-&gt; =0AFeb =0A13 =0A09:51:0=
9 =0Alocalhost =0Aaudio[2473]: =0ABadly =0Aformated =0Aor =0Aunrecognized =
=0Acommand: =0AAT+CLAN?<br>-&gt; =0AFeb =0A13 =0A09:52:30 =0Alocalhost =0Aa=
udio[2473]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_REQ<br>-&gt; =0A=
Feb =0A13 =0A09:52:30 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Asend=
ing =0ABT_STREAMSTART_RSP<br>-&gt; =0AFeb =0A13 =0A09:52:30 =0Alocalhost =
=0Aaudio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IND<br>-&gt; =0A=
Feb =0A13 =0A09:52:43 =0Alocalhost =0Akernel: =0Ahci_scodata_packet: =0Ahci=
0 =0ASCO =0Apacket =0Afor =0Aunknown =0Aconnection =0Ahandle =0A1<br>-&gt; =
<br>-&gt; =0AFeb =0A13 =0A09:52:43 =0Alocalhost =0Akernel: =0Ahci_scodata_p=
acket: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown =0Aconnection =0Ahandle =
=0A1<br><br>These =0Atwo =0Alines =0Aabove =0Amight =0Ashow =0Aa =0Aproblem=
. =0AIt =0Ashouldn't =0Abe =0Aunknown, =0Acorrect?<br><br><br>-&gt; =0AFeb =
=0A13 =0A09:53:12 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Areceived=
 =0ABT_GETCAPABILITIES_REQ<br>-&gt; =0AFeb =0A13 =0A09:53:12 =0Alocalhost =
=0Aaudio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_GETCAPABILITIES_RSP<br>-&=
gt; =0AFeb =0A13 =0A09:53:12 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =
=0Areceived =0ABT_SETCONFIGURATION_REQ<br>-&gt; =0AFeb =0A13 =0A09:53:12 =
=0Alocalhost =0Aaudio[2473]: =0Aconfig =0Asbc =0A- =0Afrequency =0A=3D =0A0=
 =0Achannel_mode =0A=3D =0A0 =0Aallocation =0A=3D =0A0 =0Asubbands =0A=3D =
=0A0 =0Ablocks =0A=3D =0A0 =0Abitpool =0A=3D =0A0<br>-&gt; <br>-&gt; =0AI =
=0Ahad =0Amade =0Aall =0Athe =0Achanges =0Asuggested =0Aby =0Ayou. =0AAre =
=0Athey =0Adone =0Aproperly?<br><br>Looks =0AOK =0Aso =0Afar.<br><br>-&gt; =
=0AThis =0Ais =0Amy =0Ahciconfig =0A-a =0Aoutput<br>-&gt; =0A[root@localhos=
t =0APramod]# =0A/usr/local/sbin/hciconfig =0A-a <br>-&gt; =0Ahci0:&nbsp; =
=0A =0AType: =0AUSB<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ABD =
=0AAddress: =0A00:02:72:CE:5B:80 =0AACL =0AMTU: =0A1017:8 =0ASCO =0AMTU: =
=0A64:0<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0AUP =0ARUNNING =
=0APSCAN =0AISCAN<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ARX =
=0Abytes:5974443 =0Aacl:279 =0Asco:116978 =0Aevents:188 =0Aerrors:0<br>-&gt=
;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ATX =0Abytes:4222 =0Aacl:168 =
=0Asco:0 =0Acommands:90 =0Aerrors:0<br><br>Rx =0Ais =0Areceived, =0Alook =
=0Aat =0Asco, =0A116978. =0ABut =0Alook =0Aat =0ATX, =0Atransmitted, =0Asco=
:0 =0Amakes <br>me =0Athink =0Anothing =0Ais =0Agetting =0Asent. =0AWatch =
=0Ahcidump =0Awhen =0Athe =0Asound =0Ais =0Asupposed =0Ato <br>play, =0Adoe=
s =0Ait =0Alook =0Aat =0Ait's =0Abeing =0Asent, =0Ajust =0Anot =0Areceived,=
 =0Aor =0Anot =0Asent =0Aat =0Aall <br>because =0Aof =0Asome =0Areason?<br>=
<br>Look =0Aat =0Athe =0ATX, =0ATX =0Asco =0Aon =0Amy =0Aoutput =0Aafter =
=0Aone =0Afile,<br><br>hci0:&nbsp; =0A =0AType: =0AUSB<br>&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A =0ABD =0AAddress: =0A00:0A:3A:7C:5C:74 =0AACL =0AMT=
U: =0A1017:8 =0ASCO =0AMTU: =0A64:8<br>&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp;=
 =0A =0AUP =0ARUNNING =0APSCAN =0AISCAN<br>&nbsp; =0A&nbsp; =0A&nbsp; =0A&n=
bsp; =0A =0ARX =0Abytes:5348812 =0Aacl:52 =0Asco:104818 =0Aevents:93 =0Aerr=
ors:0<br>&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ATX =0Abytes:5403125 =
=0Aacl:48 =0Asco:105913 =0Acommands:44 =0Aerrors:0<br>&nbsp; =0A&nbsp; =0A&=
nbsp; =0A&nbsp; =0A =0AFeatures: =0A0xff =0A0xff =0A0x8d =0A0xfe =0A0x9b =
=0A0xf9 =0A0x00 =0A0x80<br>&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0APack=
et =0Atype: =0ADM1 =0ADM3 =0ADM5 =0ADH1 =0ADH3 =0ADH5 =0AHV1 =0AHV2 =0AHV3<=
br>&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ALink =0Apolicy: =0ARSWITCH =
=0AHOLD =0ASNIFF =0APARK<br>&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ALin=
k =0Amode: =0ASLAVE =0AACCEPT<br>&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =
=0AName: =0A'[vdrl] =0A/ =0ABT =0ADevice =0A0'<br>&nbsp; =0A&nbsp; =0A&nbsp=
; =0A&nbsp; =0A =0AClass: =0A0x020108<br>&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbs=
p; =0A =0AService =0AClasses: =0ANetworking<br>&nbsp; =0A&nbsp; =0A&nbsp; =
=0A&nbsp; =0A =0ADevice =0AClass: =0AComputer, =0AServer<br>&nbsp; =0A&nbsp=
; =0A&nbsp; =0A&nbsp; =0A =0AHCI =0AVer: =0A2.0 =0A(0x3) =0AHCI =0ARev: =0A=
0x4107 =0ALMP =0AVer: =0A2.0 =0A(0x3) =0ALMP =0ASubver: <br>0x430e<br>&nbsp=
; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0AManufacturer: =0ABroadcom =0ACorpora=
tion =0A(15)<br><br><br><br>RX =0Abytes:5348812 =0Aacl:52 =0Asco:104818<br>=
TX =0Abytes:5403125 =0Aacl:48 =0Asco:105913<br><br><br><!-- kill --><div><b=
r><br>-----Inline Attachment Follows-----<br><br>--------------------------=
-----------------------------------------------<br>This =0ASF.net =0Aemail =
=0Ais =0Asponsored =0Aby: =0AMicrosoft<br>Defy =0Aall =0Achallenges. =0AMic=
rosoft(R) =0AVisual =0AStudio =0A2008.<br><a href=3D"http://clk.atdmt.com/M=
RT/go/vse0120000070mrt/direct/01/" target=3D"_blank">http://clk.atdmt.com/M=
RT/go/vse0120000070mrt/direct/01/</a></div><!-- kill --><div><br><br>-----I=
nline Attachment Follows-----<br><br>______________________________________=
_________<br>Bluez-users =0Amailing =0Alist<br><a ymailto=3D"mailto:Bluez-u=
sers@lists.sourceforge.net" href=3D"mailto:Bluez-users@lists.sourceforge.ne=
t">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists.source=
forge.net/lists/listinfo/bluez-users" target=3D"_blank">https://lists.sourc=
eforge.net/lists/listinfo/bluez-users</a><br></div></div><br></div></div></=
div><br>=0A=0A=0A      <!--10--><hr size=3D1></hr> Chat on a cool, new inte=
rface. No download required. <a href=3D"http://in.rd.yahoo.com/tagline_webm=
essenger_10/*http://in.messenger.yahoo.com/webmessengerpromo.php">Click her=
e.</a></body></html>
--0-1768090546-1203050952=:91408--


--===============0345213831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0345213831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0345213831==--
