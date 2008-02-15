Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2008 10:51:59 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <279946.95245.qm@web8404.mail.in.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============0508444356=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0508444356==
Content-Type: multipart/alternative; boundary="0-1820395392-1203052919=:95245"

--0-1820395392-1203052919=:95245
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi jayjwa =0Awill you please send me the conf files So that I can rectify m=
ines.=0AAlso I want to tell you that I have installed bt-sco but later on I=
 read somewhere that this is older method to do. Is it write?=0ASo I stoped=
 there. Can I try btsco way?=0ABut i dont have module snd_bt_sco.=0Aplease =
enlighten me on btsco .=0A =0AThanks and Best regards =0APramod=0A=0A----- =
Original Message ----=0AFrom: jayjwa <jayjwa@atr2.ath.cx>=0ATo: BlueZ users=
 <bluez-users@lists.sourceforge.net>=0ASent: Thursday, 14 February, 2008 7:=
52:45 PM=0ASubject: Re: [Bluez-users] Headset not playing audio HELP PLEASE=
=0A=0A=0AOn =0AWed, =0A13 =0AFeb =0A2008, =0Apramod =0Agurav =0Awrote:=0A=
=0A-> =0A[Pramod@localhost =0A~]$ =0Astrings =0A/sbin/modprobe =0A| =0Agrep=
 =0Aconf=0A-> =0A/etc/modules.conf=0A-> =0Ashowconfig=0A-> =0A/etc/modprobe=
..conf=0A-> =0AUsage: =0A%s =0A[-v] =0A[-V] =0A[-C =0Aconfig-file] =0A[-n] =
=0A[-i] =0A[-q] =0A[-b] =0A[-o =0A<modname>] =0A<modname> =0A[parameters...=
]=0A-> =0AFailed =0Ato =0Aopen =0Aconfig =0Afile =0A%s: =0A%s=0A-> =0AFaile=
d =0Ato =0Aopen =0Aincluded =0Aconfig =0Afile =0A%s: =0A%s=0A=0ALooks =0Ali=
ke =0Ait's =0Ausing =0Aboth =0A/etc/modules.conf =0Aand =0A/etc/modprobe.co=
nf, =0AI'd =0Astick =0Awith =0A/etc/modprobe.conf =0Aas =0AI =0Athink =0Ath=
at's =0Athe =0Acurrently =0Aused =0Aone =0Ain =0Athe =0ALinux =0Acommunity.=
=0A=0A=0A-> =0AThis =0Ais =0Amy =0A/usr/src/linux-2.6.15..i686/.config(Only=
 =0ABT =0Aconfigs =0Aare =0Agiven =0Ahere)=0A-> =0ACONFIG_BT=3Dy=0A-> =0ACO=
NFIG_BT_L2CAP=3Dy=0A-> =0ACONFIG_BT_SCO=3Dy=0A-> =0ACONFIG_BT_RFCOMM=3Dy=0A=
-> =0ACONFIG_BT_RFCOMM_TTY=3Dy=0A-> =0ACONFIG_BT_BNEP=3Dy=0A-> =0ACONFIG_BT=
_BNEP_MC_FILTER=3Dy=0A-> =0ACONFIG_BT_BNEP_PROTO_FILTER=3Dy=0A-> =0ACONFIG_=
BT_CMTP=3Dm=0A-> =0ACONFIG_BT_HIDP=3Dy=0A-> =0A#=0A-> =0A# =0ABluetooth =0A=
device=0A->  =0Adrivers=0A-> =0A#=0A-> =0ACONFIG_BT_HCIUSB=3Dy=0A-> =0ACONF=
IG_BT_HCIUSB_SCO=3Dy=0A-> =0ACONFIG_BT_HCIUART=3Dy=0A-> =0ACONFIG_BT_HCIUAR=
T_H4=3Dy=0A-> =0ACONFIG_BT_HCIUART_BCSP=3Dy=0A-> =0ACONFIG_BT_HCIBCM203X=3D=
y=0A-> =0ACONFIG_BT_HCIBPA10X=3Dy=0A-> =0ACONFIG_BT_HCIBFUSB=3Dy=0A-> =0ACO=
NFIG_BT_HCIDTL1=3Dy=0A-> =0ACONFIG_BT_HCIBT3C=3Dy=0A-> =0ACONFIG_BT_HCIBLUE=
CARD=3Dy=0A-> =0ACONFIG_BT_HCIBTUART=3Dy=0A-> =0ACONFIG_BT_HCIVHCI=3Dy=0A->=
 =0ACONFIG_IEEE80211=3Dm=0A=0ALooks =0Alike =0Ait's =0Aall =0Acompiled =0Ai=
n, =0Awhich =0Ais =0AOK. =0AYou =0Acould =0Ado =0Amodules =0A(=3Dm) =0Ato =
=0Asave =0Akernel =0Asize, =0Aif =0Ayou =0Alike, =0Abut =0Ait's =0Afine =0A=
how =0Ait =0Ais =0Anow.=0A=0A-> =0ASO =0AI =0Ahave =0Ahci_usb =0Acompiled =
=0Ain =0Amy =0Akernel... =0A-> =0AThese =0Aare =0Athings =0AI =0Adid =0Anow=
....=0A-> =0A[root@localhost =0APramod]# =0Amv =0A/etc/modules.conf =0A/etc/=
modules.conf_old=0A-> =0Acopied =0Athese =0Alines =0Ato =0A/etc/modprobe.co=
nf=0A-> =0Aalias =0Anet-pf-31 =0Abluez  =0A------> =0Achanged =0Ato =0A----=
->  =0Aalias =0Anet-pf-31 =0Abluetooth=0A-> =0Aalias =0Abt-proto-0 =0Al2cap=
=0A-> =0Aalias =0Abt-proto-2 =0Asco=0A-> =0Aalias =0Abt-proto-3 =0Arfcomm=
=0A-> =0AAdded =0A"options =0A-> =0Ahci_usb =0A-> =0Aforce_scofix=3D1" =0At=
o  =0A/etc/modprobe.conf =0Afile...=0A=0AHopefully =0Aon =0Aone =0Aline?=0A=
=0Aoptions    =0Ahci_usb =0Aforce_scofix=3D1=0A=0AYou =0Acan =0Atry =0Ato =
=0Asee =0Aif =0Asome =0Aof =0Athe =0Aother =0Aoptions =0Awork =0Afor =0Ayou=
.. =0ASee =0Athem =0Awith =0A'modinfo =0Ahci_usb'.=0A=0A=0A-> =0ANow =0AI =
=0Arebooted =0A..=0A=0A=0AIf =0Athey =0Awere =0Amodules, =0Ayou =0Awon't =
=0Ahave =0Ato =0Areboot =0Aevery =0Atime =0Ayou =0Achange =0Aan =0Aoptions.=
 =0AJust=0A=0Amodprobe =0A-r =0Ahci_usb=0Amodprobe =0Ahci_usb =0Aforce_scof=
ix=3D1=0A=0Aor =0Aany =0Aother =0Aoption. =0AIf =0Ait =0Asays =0A'module =
=0Awhatever =0Ais =0Ain =0Ause' =0Akill =0Athe =0Athings =0Ausing =0Ait =0A=
first, =0Athen =0Arestart =0Athem. =0AUsually =0Aanything =0Awith =0A'blue'=
 =0Aor =0A'hci' =0Ain =0Athe =0Aname. =0A'pkill' =0Aworks =0Agood =0Afor =
=0Athat, =0Aif =0Ayou =0Ahave =0A'pkill'.=0A=0A=0A-> =0AWhen =0AI =0Arestar=
ted =0Amy =0Ahcid(with =0Asdpd, =0Aaudi-service =0Aautostart) =0AI =0Afound=
 =0Asome =0Athings =0Athat =0AI =0Anever =0Aseen =0A-> =0Abefore =0Ain =0A/=
var/log/messages =0Athese =0Aare=0A-> =0A/***This =0Alog =0Aappeared =0Afor=
 =0Afirst =0Atime*****/=0A-> =0AFeb =0A13 =0A09:48:40 =0Alocalhost =0Aaudio=
[2473]: =0ALoading =0Adevice =0A00:0F:DE:B1:02:42 =0A(headset =0A)=0A-> =0A=
Feb =0A13 =0A09:48:40 =0Alocalhost =0Aaudio[2473]: =0ASetting =0A00:0F:DE:B=
1:02:42 =0Aas =0Adefault =0Adevice=0A-> =0A-> =0AThen =0AI =0Adid =0A-> =0A=
[Pramod@localhost =0A~]$ =0Aarecord =0A-D =0Abluetooth =0A-f =0AS16_LE =0At=
est.raw=0A-> =0A-> =0Aboth =0AACL =0Aand =0ASCO =0Awere =0Aestablished =0A-=
> =0AI =0Awas =0Aable =0Ato =0Arecord =0Asound =0Afrom =0Aheadset...=0A-> =
=0ABut =0Awhen =0AI =0Atried=0A-> =0A[Pramod@localhost =0A~]$ =0Aaplay =0A-=
D =0Abluetooth =0A-f =0AS16_LE =0Atest.raw=0A-> =0APlaying =0Araw =0Adata =
=0A'test.raw' =0A: =0ASigned =0A16 =0Abit =0ALittle =0AEndian, =0ARate =0A8=
000 =0AHz, =0AMono=0A-> =0A-> =0ANo =0Asound =0Awas =0Alistened =0Aon =0Ahe=
adset=0A-> =0A-> =0A[root@localhost =0APramod]# =0Ahcitool =0Acon=0A-> =0AC=
onnections:=0A->  =0A  =0A  =0A  =0A =0A< =0ASCO =0A00:0F:DE:B1:02:42 =0Aha=
ndle =0A1 =0Astate =0A1 =0Alm =0ASLAVE=0A->  =0A  =0A  =0A  =0A =0A< =0AACL=
 =0A00:0F:DE:B1:02:42 =0Ahandle =0A11 =0Astate =0A1 =0Alm =0AMASTER=0A=0AMa=
ybe =0Athe =0Adevice =0Aisn't =0Ain =0Athe =0Aright =0Astate. =0AAfter =0Ay=
ours =0Ait =0Asays =0Aeither =0A'SLAVE' =0Aor =0A"MASTER", =0Awhen =0Amine =
=0Ais =0Aready =0Ato =0Aplay =0Ait =0Alists:=0A=0Ahcitool =0Acon=0AConnecti=
ons:=0A  =0A  =0A  =0A  =0A =0A> =0AACL =0A00:1A:45:01:F9:42 =0Ahandle =0A1=
1 =0Astate =0A1 =0Alm =0AMASTER =0AAUTH =0AENCRYPT =0ASECURE=0A=0AIf =0AI =
=0Atry =0Ato =0Aplay =0Awithout =0Athat =0Areading =0Aas =0Aabove, =0AI =0A=
get =0Anothing, =0Aor =0Asometimes =0Agarbage. =0ADoes =0Ayour =0Aheadset =
=0Ahave =0Aa =0Abutton =0Aor =0Aswitch =0Ato =0Amake =0Ait =0Apair?=0A=0A=
=0AI =0Aset =0Aup =0Aall =0Athe =0Abluetooth =0Astuff =0Afirst, =0Astart=0A=
passkey-agent =0A--default =0A(PIN =0Anumber) =0A(addr =0Aof =0Aheadset) =
=0A&=0Aauth-agent =0A&=0A=0Athen =0Aturn =0Aon =0Athe =0Aheadset, =0Await =
=0Aa =0Afew =0Aseconds. =0ALook =0Aat =0A'hcitool =0Acon' =0Aand =0Aif =0Ai=
f =0Athe =0Aparameters =0Aare =0Athere. =0AIf =0Aso, =0Aplay =0Asound, =0Ai=
f =0Anot, =0Apress =0Athe =0Abutton =0Aon =0Athe =0Aheadset, =0Aand =0Alook=
 =0Aagain =0Aat =0A'hcitool =0Acon' =0Afor =0Aparameters =0Ato =0Abe =0Acor=
rect. =0AIt's =0Ahard =0Ato =0Asay =0Awhat =0Ato =0Ado =0Aexactly =0Afor =
=0Ayour =0Aheadset, =0Abecause =0AI've =0Anever =0Aseen =0Ait, =0Aand =0Aca=
n =0Aonly =0Aguess =0Aat =0Ahow =0Ait =0Aworks. =0AIf =0Athis =0Astuff =0Ah=
ere =0Adoesn't =0Awork, =0AI'd =0Asay =0Ayou'll =0Ajust =0Ahave =0Ato =0Apl=
ay =0Aaround =0Awith =0Ait, =0Aor =0Asee =0Aif =0Ayou =0Acan =0Aget =0Ayour=
 =0Ahands =0Aon =0Asome =0Aother =0Aheadsets =0Ato =0Asee =0Aif =0Athey =0A=
work/work =0Adifferently.=0A=0Asox =0A-t =0Amp3 =0Afile.mp3 =0A-t =0Aalsa =
=0Apcm.bluetooth=0A=0A>From =0Athis =0Alist, =0Ait =0Aseems =0Ayou're =0Asu=
pposed =0Ato =0Ause =0Aa =0Agnome =0Aor =0AKDE =0Autility =0Afor =0Athe =0A=
jobs =0Aof =0Apasskey-agent =0Aand =0Aauth-agent. =0AYou =0Amight =0Atry =
=0Athose. =0AThere's =0Aprobably =0Aa =0Apackage =0Aor =0Asource =0Afor =0A=
them =0Asomeplace.=0A=0A=0A-> =0A[root@localhost =0APramod]# =0Ahcidump =0A=
-x=0A-> =0A> =0ASCO =0Adata: =0Ahandle =0A1 =0Aflags =0A0x00 =0Adlen =0A48=
=0A->  =0A  =0A =0A4F =0A00 =0ACE =0AFF =0AB2 =0AFF =0AB5 =0AFF =0A41 =0A00=
 =0AB5 =0A00 =0AB9 =0A00 =0A85 =0A00 =0A8B =0A00 =0AA3 =0A00=0A->  =0A  =0A=
 =0A54 =0A00 =0A42 =0A00 =0A38 =0A00 =0A1B =0A00 =0AFB =0AFF =0AD1 =0AFF =
=0AAB =0AFF =0A44 =0A00 =0A78 =0A00 =0A87 =0A00=0A->  =0A  =0A =0A73 =0A00 =
=0A56 =0A00 =0AE8 =0AFF =0AF4 =0AFF=0A-> =0Actnr+c=0A=0Ahcidump =0A-i =0Ahc=
i0 =0A--ascii=0A=0Ais =0Aa =0Alittle =0Aeasier =0Ato =0Aread, =0Athan =0A-x=
, =0Awhich =0Ais =0Ahex. =0AYou =0Acan =0Aat =0Aleast =0Aread =0Awhat's =0A=
going =0Aon.=0A=0A=0A-> =0Athe =0Alogs =0Awere=0A-> =0AFeb =0A13 =0A09:49:3=
5 =0Alocalhost =0Ahcid[2469]: =0Alink_key_request =0A(sba=3D00:02:72:CE:5B:=
80, =0Adba=3D00:0F:DE:B1:02:42)=0A-> =0AFeb =0A13 =0A09:49:36 =0Alocalhost =
=0Ahcid[2469]: =0Alink_key_notify =0A(sba=3D00:02:72:CE:5B:80, =0Adba=3D00:=
0F:DE:B1:02:42)Feb =0A13 =0A09:49:36 =0Alocalhost =0Aaudio[2473]: =0ABadly =
=0Aformated =0Aor =0Aunrecognized =0Acommand: =0AAT*ECBP=3D?=0A-> =0AFeb =
=0A13 =0A09:49:36 =0Alocalhost =0Aaudio[2473]: =0ABadly =0Aformated =0Aor =
=0Aunrecognized =0Acommand: =0AAT+CSCS=3D"UTF-8"=0A-> =0AFeb =0A13 =0A09:49=
:36 =0Alocalhost =0Aaudio[2473]: =0ABadly =0Aformated =0Aor =0Aunrecognized=
 =0Acommand: =0AAT+CLAN?=0A=0AI =0Asee =0Athese =0Atoo =0Asometimes, =0AI =
=0Adon't =0Athink =0Athey =0Astop =0Ait =0Afrom =0Aworking. =0AMaybe =0Atry=
 =0Aboth =0Aways =0Ain =0A/etc/bluetooth/audio.conf:=0A=0A# =0ASet =0Ato =
=0Atrue =0Ato =0Aonly =0Asupport =0AHSP=0A# =0ADefaults =0Ato =0Afalse=0ADi=
sableHFP=3Dfalse=0A=0Aand=0A=0A# =0ASet =0Ato =0Atrue =0Ato =0Aonly =0Asupp=
ort =0AHSP=0A# =0ADefaults =0Ato =0Afalse=0ADisableHFP=3Dtrue=0A=0Aand =0Ar=
estart. =0ASee =0Aif =0Athat =0Achanges =0Aanything. =0AIf =0Anot =0Aleave =
=0Ait =0Aas =0ADisableHFP=3Dfalse=0A=0A=0A=0A-> =0AFeb =0A13 =0A09:51:06 =
=0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Areceived =0ABT_GETCAPABILI=
TIES_REQ=0A-> =0AFeb =0A13 =0A09:51:06 =0Alocalhost =0Aaudio[2473]: =0AAudi=
o =0AAPI: =0Asending =0ABT_GETCAPABILITIES_RSP=0A-> =0AFeb =0A13 =0A09:51:0=
6 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Areceived =0ABT_SETCONFIG=
URATION_REQ=0A=0A=0A-> =0AFeb =0A13 =0A09:51:06 =0Alocalhost =0Aaudio[2473]=
: =0Aconfig =0Asbc =0A- =0Afrequency =0A=3D =0A0 =0Achannel_mode =0A=3D =0A=
0 =0Aallocation =0A=3D =0A0 =0Asubbands =0A=3D =0A0 =0Ablocks =0A=3D =0A0 =
=0Abitpool =0A=3D =0A0=0A-> =0AFeb =0A13 =0A09:51:08 =0Alocalhost =0Ahcid[2=
469]: =0Apin_code_request =0A(sba=3D00:02:72:CE:5B:80, =0Adba=3D00:0F:DE:B1=
:02:42)=0A-> =0AFeb =0A13 =0A09:51:08 =0Alocalhost =0Ahcid[2469]: =0Alink_k=
ey_notify =0A(sba=3D00:02:72:CE:5B:80, =0Adba=3D00:0F:DE:B1:02:42)Feb =0A13=
 =0A09:51:09 =0Alocalhost =0Aaudio[2473]: =0ABadly =0Aformated =0Aor =0Aunr=
ecognized =0Acommand: =0AAT*ECBP=3D?=0A-> =0AFeb =0A13 =0A09:51:09 =0Alocal=
host =0Aaudio[2473]: =0ASCO =0Afd=3D11=0A-> =0AFeb =0A13 =0A09:51:09 =0Aloc=
alhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_SETCONFIGURATION_R=
SP=0A-> =0AFeb =0A13 =0A09:51:09 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AA=
PI: =0Areceived =0ABT_STREAMSTART_REQ=0A-> =0AFeb =0A13 =0A09:51:09 =0Aloca=
lhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART_RSP=0A-=
> =0AFeb =0A13 =0A09:51:09 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =
=0Asending =0ABT_STREAMFD_IND=0A-> =0AFeb =0A13 =0A09:51:09 =0Alocalhost =
=0Aaudio[2473]: =0ABadly =0Aformated =0Aor =0Aunrecognized =0Acommand: =0AA=
T+CSCS=3D"UTF-8"=0A-> =0AFeb =0A13 =0A09:51:09 =0Alocalhost =0Aaudio[2473]:=
 =0ABadly =0Aformated =0Aor =0Aunrecognized =0Acommand: =0AAT+CLAN?=0A-> =
=0AFeb =0A13 =0A09:52:30 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Ar=
eceived =0ABT_STREAMSTART_REQ=0A-> =0AFeb =0A13 =0A09:52:30 =0Alocalhost =
=0Aaudio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART_RSP=0A-> =0AF=
eb =0A13 =0A09:52:30 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Asendi=
ng =0ABT_STREAMFD_IND=0A-> =0AFeb =0A13 =0A09:52:43 =0Alocalhost =0Akernel:=
 =0Ahci_scodata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown =0Aconne=
ction =0Ahandle =0A1=0A-> =0A-> =0AFeb =0A13 =0A09:52:43 =0Alocalhost =0Ake=
rnel: =0Ahci_scodata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown =0A=
connection =0Ahandle =0A1=0A=0AThese =0Atwo =0Alines =0Aabove =0Amight =0As=
how =0Aa =0Aproblem. =0AIt =0Ashouldn't =0Abe =0Aunknown, =0Acorrect?=0A=0A=
=0A-> =0AFeb =0A13 =0A09:53:12 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AAPI=
: =0Areceived =0ABT_GETCAPABILITIES_REQ=0A-> =0AFeb =0A13 =0A09:53:12 =0Alo=
calhost =0Aaudio[2473]: =0AAudio =0AAPI: =0Asending =0ABT_GETCAPABILITIES_R=
SP=0A-> =0AFeb =0A13 =0A09:53:12 =0Alocalhost =0Aaudio[2473]: =0AAudio =0AA=
PI: =0Areceived =0ABT_SETCONFIGURATION_REQ=0A-> =0AFeb =0A13 =0A09:53:12 =
=0Alocalhost =0Aaudio[2473]: =0Aconfig =0Asbc =0A- =0Afrequency =0A=3D =0A0=
 =0Achannel_mode =0A=3D =0A0 =0Aallocation =0A=3D =0A0 =0Asubbands =0A=3D =
=0A0 =0Ablocks =0A=3D =0A0 =0Abitpool =0A=3D =0A0=0A-> =0A-> =0AI =0Ahad =
=0Amade =0Aall =0Athe =0Achanges =0Asuggested =0Aby =0Ayou. =0AAre =0Athey =
=0Adone =0Aproperly?=0A=0ALooks =0AOK =0Aso =0Afar.=0A=0A-> =0AThis =0Ais =
=0Amy =0Ahciconfig =0A-a =0Aoutput=0A-> =0A[root@localhost =0APramod]# =0A/=
usr/local/sbin/hciconfig =0A-a =0A-> =0Ahci0:  =0A =0AType: =0AUSB=0A->  =
=0A  =0A  =0A  =0A =0ABD =0AAddress: =0A00:02:72:CE:5B:80 =0AACL =0AMTU: =
=0A1017:8 =0ASCO =0AMTU: =0A64:0=0A->  =0A  =0A  =0A  =0A =0AUP =0ARUNNING =
=0APSCAN =0AISCAN=0A->  =0A  =0A  =0A  =0A =0ARX =0Abytes:5974443 =0Aacl:27=
9 =0Asco:116978 =0Aevents:188 =0Aerrors:0=0A->  =0A  =0A  =0A  =0A =0ATX =
=0Abytes:4222 =0Aacl:168 =0Asco:0 =0Acommands:90 =0Aerrors:0=0A=0ARx =0Ais =
=0Areceived, =0Alook =0Aat =0Asco, =0A116978. =0ABut =0Alook =0Aat =0ATX, =
=0Atransmitted, =0Asco:0 =0Amakes =0Ame =0Athink =0Anothing =0Ais =0Agettin=
g =0Asent. =0AWatch =0Ahcidump =0Awhen =0Athe =0Asound =0Ais =0Asupposed =
=0Ato =0Aplay, =0Adoes =0Ait =0Alook =0Aat =0Ait's =0Abeing =0Asent, =0Ajus=
t =0Anot =0Areceived, =0Aor =0Anot =0Asent =0Aat =0Aall =0Abecause =0Aof =
=0Asome =0Areason?=0A=0ALook =0Aat =0Athe =0ATX, =0ATX =0Asco =0Aon =0Amy =
=0Aoutput =0Aafter =0Aone =0Afile,=0A=0Ahci0:  =0A =0AType: =0AUSB=0A  =0A =
 =0A  =0A  =0A =0ABD =0AAddress: =0A00:0A:3A:7C:5C:74 =0AACL =0AMTU: =0A101=
7:8 =0ASCO =0AMTU: =0A64:8=0A  =0A  =0A  =0A  =0A =0AUP =0ARUNNING =0APSCAN=
 =0AISCAN=0A  =0A  =0A  =0A  =0A =0ARX =0Abytes:5348812 =0Aacl:52 =0Asco:10=
4818 =0Aevents:93 =0Aerrors:0=0A  =0A  =0A  =0A  =0A =0ATX =0Abytes:5403125=
 =0Aacl:48 =0Asco:105913 =0Acommands:44 =0Aerrors:0=0A  =0A  =0A  =0A  =0A =
=0AFeatures: =0A0xff =0A0xff =0A0x8d =0A0xfe =0A0x9b =0A0xf9 =0A0x00 =0A0x8=
0=0A  =0A  =0A  =0A  =0A =0APacket =0Atype: =0ADM1 =0ADM3 =0ADM5 =0ADH1 =0A=
DH3 =0ADH5 =0AHV1 =0AHV2 =0AHV3=0A  =0A  =0A  =0A  =0A =0ALink =0Apolicy: =
=0ARSWITCH =0AHOLD =0ASNIFF =0APARK=0A  =0A  =0A  =0A  =0A =0ALink =0Amode:=
 =0ASLAVE =0AACCEPT=0A  =0A  =0A  =0A  =0A =0AName: =0A'[vdrl] =0A/ =0ABT =
=0ADevice =0A0'=0A  =0A  =0A  =0A  =0A =0AClass: =0A0x020108=0A  =0A  =0A  =
=0A  =0A =0AService =0AClasses: =0ANetworking=0A  =0A  =0A  =0A  =0A =0ADev=
ice =0AClass: =0AComputer, =0AServer=0A  =0A  =0A  =0A  =0A =0AHCI =0AVer: =
=0A2.0 =0A(0x3) =0AHCI =0ARev: =0A0x4107 =0ALMP =0AVer: =0A2.0 =0A(0x3) =0A=
LMP =0ASubver: =0A0x430e=0A  =0A  =0A  =0A  =0A =0AManufacturer: =0ABroadco=
m =0ACorporation =0A(15)=0A=0A=0A=0ARX =0Abytes:5348812 =0Aacl:52 =0Asco:10=
4818=0ATX =0Abytes:5403125 =0Aacl:48 =0Asco:105913=0A=0A=0A=0A=0A-----Inlin=
e Attachment Follows-----=0A=0A--------------------------------------------=
-----------------------------=0AThis =0ASF.net =0Aemail =0Ais =0Asponsored =
=0Aby: =0AMicrosoft=0ADefy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =
=0AStudio =0A2008.=0Ahttp://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01=
/=0A=0A=0A-----Inline Attachment Follows-----=0A=0A________________________=
_______________________=0ABluez-users =0Amailing =0Alist=0ABluez-users@list=
s.sourceforge.net=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-user=
s=0A=0A=0A=0A=0A=0A=0A=0A=0A      Why delete messages? Unlimited storage is=
 just a click away. Go to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/t=
ools/tools-08.html
--0-1820395392-1203052919=:95245
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Hi jayjwa <br>will you please send me the conf files So tha=
t I can rectify mines.<br>Also I want to tell you that I have installed bt-=
sco but later on I read somewhere that this is older method to do. Is it wr=
ite?<br>So I stoped there. Can I try btsco way?<br>But i dont have module s=
nd_bt_sco.<br>please enlighten me on btsco .<span style=3D"font-style: ital=
ic;"><span style=3D"font-style: italic;"><span style=3D"font-style: italic;=
"></span></span></span><br><div>&nbsp;</div>Thanks and Best regards<div>&nb=
sp;</div><div>Pramod<div style=3D"font-family: times new roman,new york,tim=
es,serif; font-size: 12pt;"><br><br><div style=3D"font-family: times new ro=
man,new york,times,serif; font-size: 12pt;">----- Original Message ----<br>=
From: jayjwa &lt;jayjwa@atr2.ath.cx&gt;<br>To: BlueZ users
 &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: Thursday, 14 February, =
2008 7:52:45 PM<br>Subject: Re: [Bluez-users] Headset not playing audio HEL=
P PLEASE<br><br><br>On =0AWed, =0A13 =0AFeb =0A2008, =0Apramod =0Agurav =0A=
wrote:<br><br>-&gt; =0A[Pramod@localhost =0A~]$ =0Astrings =0A/sbin/modprob=
e =0A| =0Agrep =0Aconf<br>-&gt; =0A/etc/modules.conf<br>-&gt; =0Ashowconfig=
<br>-&gt; =0A/etc/modprobe.conf<br>-&gt; =0AUsage: =0A%s =0A[-v] =0A[-V] =
=0A[-C =0Aconfig-file] =0A[-n] =0A[-i] =0A[-q] =0A[-b] =0A[-o =0A&lt;modnam=
e&gt;] =0A&lt;modname&gt; =0A[parameters...]<br>-&gt; =0AFailed =0Ato =0Aop=
en =0Aconfig =0Afile =0A%s: =0A%s<br>-&gt; =0AFailed =0Ato =0Aopen =0Ainclu=
ded =0Aconfig =0Afile =0A%s: =0A%s<br><br>Looks =0Alike =0Ait's =0Ausing =
=0Aboth =0A/etc/modules.conf =0Aand =0A/etc/modprobe.conf, =0AI'd =0Astick =
<br>with =0A/etc/modprobe.conf =0Aas =0AI =0Athink =0Athat's =0Athe =0Acurr=
ently =0Aused =0Aone =0Ain =0Athe =0ALinux <br>community.<br><br><br>-&gt; =
=0AThis =0Ais =0Amy =0A/usr/src/linux-2.6.15..i686/.config(Only =0ABT =0Aco=
nfigs =0Aare =0Agiven =0Ahere)<br>-&gt; =0ACONFIG_BT=3Dy<br>-&gt; =0ACONFIG=
_BT_L2CAP=3Dy<br>-&gt; =0ACONFIG_BT_SCO=3Dy<br>-&gt; =0ACONFIG_BT_RFCOMM=3D=
y<br>-&gt; =0ACONFIG_BT_RFCOMM_TTY=3Dy<br>-&gt; =0ACONFIG_BT_BNEP=3Dy<br>-&=
gt; =0ACONFIG_BT_BNEP_MC_FILTER=3Dy<br>-&gt; =0ACONFIG_BT_BNEP_PROTO_FILTER=
=3Dy<br>-&gt; =0ACONFIG_BT_CMTP=3Dm<br>-&gt; =0ACONFIG_BT_HIDP=3Dy<br>-&gt;=
 =0A#<br>-&gt; =0A# =0ABluetooth =0Adevice<br>-&gt;&nbsp; =0Adrivers<br>-&g=
t; =0A#<br>-&gt; =0ACONFIG_BT_HCIUSB=3Dy<br>-&gt; =0ACONFIG_BT_HCIUSB_SCO=
=3Dy<br>-&gt; =0ACONFIG_BT_HCIUART=3Dy<br>-&gt; =0ACONFIG_BT_HCIUART_H4=3Dy=
<br>-&gt; =0ACONFIG_BT_HCIUART_BCSP=3Dy<br>-&gt; =0ACONFIG_BT_HCIBCM203X=3D=
y<br>-&gt; =0ACONFIG_BT_HCIBPA10X=3Dy<br>-&gt; =0ACONFIG_BT_HCIBFUSB=3Dy<br=
>-&gt; =0ACONFIG_BT_HCIDTL1=3Dy<br>-&gt; =0ACONFIG_BT_HCIBT3C=3Dy<br>-&gt; =
=0ACONFIG_BT_HCIBLUECARD=3Dy<br>-&gt; =0ACONFIG_BT_HCIBTUART=3Dy<br>-&gt; =
=0ACONFIG_BT_HCIVHCI=3Dy<br>-&gt; =0ACONFIG_IEEE80211=3Dm<br><br>Looks =0Al=
ike =0Ait's =0Aall =0Acompiled =0Ain, =0Awhich =0Ais =0AOK. =0AYou =0Acould=
 =0Ado =0Amodules =0A(=3Dm) =0Ato <br>save =0Akernel =0Asize, =0Aif =0Ayou =
=0Alike, =0Abut =0Ait's =0Afine =0Ahow =0Ait =0Ais =0Anow.<br><br>-&gt; =0A=
SO =0AI =0Ahave =0Ahci_usb =0Acompiled =0Ain =0Amy =0Akernel... <br>-&gt; =
=0AThese =0Aare =0Athings =0AI =0Adid =0Anow...<br>-&gt; =0A[root@localhost=
 =0APramod]# =0Amv =0A/etc/modules.conf =0A/etc/modules.conf_old<br>-&gt; =
=0Acopied =0Athese =0Alines =0Ato =0A/etc/modprobe.conf<br>-&gt; =0Aalias =
=0Anet-pf-31 =0Abluez&nbsp; =0A------&gt; =0Achanged =0Ato =0A-----&gt;&nbs=
p; =0Aalias =0Anet-pf-31 =0Abluetooth<br>-&gt; =0Aalias =0Abt-proto-0 =0Al2=
cap<br>-&gt; =0Aalias =0Abt-proto-2 =0Asco<br>-&gt; =0Aalias =0Abt-proto-3 =
=0Arfcomm<br>-&gt; =0AAdded =0A"options <br>-&gt; =0Ahci_usb <br>-&gt; =0Af=
orce_scofix=3D1" =0Ato&nbsp; =0A/etc/modprobe.conf =0Afile...<br><br>Hopefu=
lly =0Aon =0Aone =0Aline?<br><br>options&nbsp;&nbsp;&nbsp; =0Ahci_usb =0Afo=
rce_scofix=3D1<br><br>You =0Acan =0Atry =0Ato =0Asee =0Aif =0Asome =0Aof =
=0Athe =0Aother =0Aoptions =0Awork =0Afor =0Ayou. =0ASee =0Athem =0Awith <b=
r>'modinfo =0Ahci_usb'.<br><br><br>-&gt; =0ANow =0AI =0Arebooted =0A..<br><=
br><br>If =0Athey =0Awere =0Amodules, =0Ayou =0Awon't =0Ahave =0Ato =0Arebo=
ot =0Aevery =0Atime =0Ayou =0Achange =0Aan <br>options. =0AJust<br><br>modp=
robe =0A-r =0Ahci_usb<br>modprobe =0Ahci_usb =0Aforce_scofix=3D1<br><br>or =
=0Aany =0Aother =0Aoption. =0AIf =0Ait =0Asays =0A'module =0Awhatever =0Ais=
 =0Ain =0Ause' =0Akill =0Athe =0Athings <br>using =0Ait =0Afirst, =0Athen =
=0Arestart =0Athem. =0AUsually =0Aanything =0Awith =0A'blue' =0Aor =0A'hci'=
 =0Ain <br>the =0Aname. =0A'pkill' =0Aworks =0Agood =0Afor =0Athat, =0Aif =
=0Ayou =0Ahave =0A'pkill'.<br><br><br>-&gt; =0AWhen =0AI =0Arestarted =0Amy=
 =0Ahcid(with =0Asdpd, =0Aaudi-service =0Aautostart) =0AI =0Afound =0Asome =
=0Athings =0Athat =0AI =0Anever =0Aseen <br>-&gt; =0Abefore =0Ain =0A/var/l=
og/messages =0Athese =0Aare<br>-&gt; =0A/***This =0Alog =0Aappeared =0Afor =
=0Afirst =0Atime*****/<br>-&gt; =0AFeb =0A13 =0A09:48:40 =0Alocalhost =0Aau=
dio[2473]: =0ALoading =0Adevice =0A00:0F:DE:B1:02:42 =0A(headset =0A)<br>-&=
gt; =0AFeb =0A13 =0A09:48:40 =0Alocalhost =0Aaudio[2473]: =0ASetting =0A00:=
0F:DE:B1:02:42 =0Aas =0Adefault =0Adevice<br>-&gt; <br>-&gt; =0AThen =0AI =
=0Adid <br>-&gt; =0A[Pramod@localhost =0A~]$ =0Aarecord =0A-D =0Abluetooth =
=0A-f =0AS16_LE =0Atest.raw<br>-&gt; <br>-&gt; =0Aboth =0AACL =0Aand =0ASCO=
 =0Awere =0Aestablished <br>-&gt; =0AI =0Awas =0Aable =0Ato =0Arecord =0Aso=
und =0Afrom =0Aheadset...<br>-&gt; =0ABut =0Awhen =0AI =0Atried<br>-&gt; =
=0A[Pramod@localhost =0A~]$ =0Aaplay =0A-D =0Abluetooth =0A-f =0AS16_LE =0A=
test.raw<br>-&gt; =0APlaying =0Araw =0Adata =0A'test.raw' =0A: =0ASigned =
=0A16 =0Abit =0ALittle =0AEndian, =0ARate =0A8000 =0AHz, =0AMono<br>-&gt; <=
br>-&gt; =0ANo =0Asound =0Awas =0Alistened =0Aon =0Aheadset<br>-&gt; <br>-&=
gt; =0A[root@localhost =0APramod]# =0Ahcitool =0Acon<br>-&gt; =0AConnection=
s:<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A&lt; =0ASCO =0A00:0F=
:DE:B1:02:42 =0Ahandle =0A1 =0Astate =0A1 =0Alm =0ASLAVE<br>-&gt;&nbsp; =0A=
&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A&lt; =0AACL =0A00:0F:DE:B1:02:42 =0Ahandl=
e =0A11 =0Astate =0A1 =0Alm =0AMASTER<br><br>Maybe =0Athe =0Adevice =0Aisn'=
t =0Ain =0Athe =0Aright =0Astate. =0AAfter =0Ayours =0Ait =0Asays =0Aeither=
 =0A'SLAVE' <br>or =0A"MASTER", =0Awhen =0Amine =0Ais =0Aready =0Ato =0Apla=
y =0Ait =0Alists:<br><br>hcitool =0Acon<br>Connections:<br>&nbsp; =0A&nbsp;=
 =0A&nbsp; =0A&nbsp; =0A =0A&gt; =0AACL =0A00:1A:45:01:F9:42 =0Ahandle =0A1=
1 =0Astate =0A1 =0Alm =0AMASTER =0AAUTH =0AENCRYPT =0ASECURE<br><br>If =0AI=
 =0Atry =0Ato =0Aplay =0Awithout =0Athat =0Areading =0Aas =0Aabove, =0AI =
=0Aget =0Anothing, =0Aor =0Asometimes <br>garbage. =0ADoes =0Ayour =0Aheads=
et =0Ahave =0Aa =0Abutton =0Aor =0Aswitch =0Ato =0Amake =0Ait =0Apair?<br><=
br><br>I =0Aset =0Aup =0Aall =0Athe =0Abluetooth =0Astuff =0Afirst, =0Astar=
t<br>passkey-agent =0A--default =0A(PIN =0Anumber) =0A(addr =0Aof =0Aheadse=
t) =0A&amp;<br>auth-agent =0A&amp;<br><br>then =0Aturn =0Aon =0Athe =0Ahead=
set, =0Await =0Aa =0Afew =0Aseconds. =0ALook =0Aat =0A'hcitool =0Acon' =0Aa=
nd =0Aif =0Aif <br>the =0Aparameters =0Aare =0Athere. =0AIf =0Aso, =0Aplay =
=0Asound, =0Aif =0Anot, =0Apress =0Athe =0Abutton =0Aon =0Athe <br>headset,=
 =0Aand =0Alook =0Aagain =0Aat =0A'hcitool =0Acon' =0Afor =0Aparameters =0A=
to =0Abe =0Acorrect. =0AIt's <br>hard =0Ato =0Asay =0Awhat =0Ato =0Ado =0Ae=
xactly =0Afor =0Ayour =0Aheadset, =0Abecause =0AI've =0Anever =0Aseen =0Ait=
, <br>and =0Acan =0Aonly =0Aguess =0Aat =0Ahow =0Ait =0Aworks. =0AIf =0Athi=
s =0Astuff =0Ahere =0Adoesn't =0Awork, =0AI'd =0Asay <br>you'll =0Ajust =0A=
have =0Ato =0Aplay =0Aaround =0Awith =0Ait, =0Aor =0Asee =0Aif =0Ayou =0Aca=
n =0Aget =0Ayour =0Ahands =0Aon <br>some =0Aother =0Aheadsets =0Ato =0Asee =
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
.. =0AIt =0Ashouldn't =0Abe =0Aunknown, =0Acorrect?<br><br><br>-&gt; =0AFeb =
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
div><br>=0A=0A=0A      <!--8--><hr size=3D1></hr> Share files, take polls, =
and discuss your passions - all under one roof. <a href=3D"http://in.rd.yah=
oo.com/tagline_groups_8/*http://in.promos.yahoo.com/groups"> Click here.</a=
></body></html>
--0-1820395392-1203052919=:95245--



--===============0508444356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0508444356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0508444356==--
