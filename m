Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Feb 2008 17:10:52 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <561238.29568.qm@web8406.mail.in.yahoo.com>
Subject: Re: [Bluez-users] BT Headset connected but no sound
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0170691633=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0170691633==
Content-Type: multipart/alternative; boundary="0-1099448865-1202211652=:29568"

--0-1099448865-1202211652=:29568
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi same thing here=0ABut i was asked to update my kernel(2.6.15)=0ANow I co=
mpiled 2.6.22 But no difference ..headset get connected but =0Athe system h=
angs with white screen ...=0AWhich kernel are you using...?=0AHave you appl=
ied patch for :SCO flow control from plugs..=0Ai tried it but failing with =
both the kernel....=0AWhich patch did you apply=0APlease reply as your done=
 things may help me...=0A=0A =0AThanks and Best regards =0APramod=0A=0A----=
- Original Message ----=0AFrom: Daniel Stumpner <bigstumpi@gmx.de>=0ATo: Bl=
ueZ users <bluez-users@lists.sourceforge.net>=0ASent: Saturday, 2 February,=
 2008 3:02:54 PM=0ASubject: Re: [Bluez-users] BT Headset connected but no s=
ound=0A=0ADaniel =0AStumpner =0Awrote:=0A> =0AHi,=0A> =0A> =0Acan =0Aconnec=
t =0Ato =0Amy =0ABT =0AHeadset =0Abut =0Aif =0AI =0Atry =0Ato =0Aplay =0Aa =
=0Asound, =0Ait =0Adoes =0Aonly=0A> =0Abeep =0Aat =0Athe =0Astart =0Aand =
=0Aat =0Athe =0Aend =0Aof =0Athe =0Aconnection =0Abut =0Athere =0Ais =0Ano =
=0Asound.=0A> =0A> =0Amplayer =0A-ao =0Aalsa:device=3Dbluetooth =0Atest.wav=
=0A> =0A- =0Abeep =0A-=0A> =0A(pressing =0A'q')=0A> =0A- =0Abeep =0A-=0A> =
=0A> =0AI =0Aam =0Arunning =0AGentoo =0Awith =0Alinux =0A2.6.23 =0A(x86)=0A=
> =0Abluez-libs-3.24=0A> =0Ablues-utils-3.24=0A> =0A> =0A> =0A=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A>  =0A  =0A  =0A  =
=0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0ASome =0ADebug =0AInformation:=0A=
> =0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> =0A> =0A# =0Alsusb=0A> =0ABus =0A002 =0ADevice =0A002: =0AID =0A046d:c012=
 =0ALogitech, =0AInc. =0AOptical =0AMouse=0A> =0ABus =0A002 =0ADevice =0A00=
1: =0AID =0A0000:0000=0A> =0ABus =0A004 =0ADevice =0A001: =0AID =0A0000:000=
0=0A> =0ABus =0A003 =0ADevice =0A002: =0AID =0A03f0:011d =0AHewlett-Packard=
  =0A  =0A =0A/* =0ACritical =0Aline =0A*/=0A> =0ABus =0A003 =0ADevice =0A0=
01: =0AID =0A0000:0000=0A> =0ABus =0A001 =0ADevice =0A001: =0AID =0A0000:00=
00=0A> =0A> =0A------------------------------------------------------------=
------------=0A> =0A> =0A# =0Acat =0A/proc/bus/usb/devices =0A| =0Agrep =0A=
-e^[TPD] =0A| =0Agrep =0A-e =0ACls=3De0 =0A-B1 =0A-A1=0A> =0AT:  =0ABus=3D0=
3 =0ALev=3D01 =0APrnt=3D01 =0APort=3D01 =0ACnt=3D01 =0ADev#=3D  =0A2 =0ASpd=
=3D12  =0AMxCh=3D =0A0=0A> =0AD:  =0AVer=3D =0A1.10 =0ACls=3De0(unk. =0A) =
=0ASub=3D01 =0AProt=3D01 =0AMxPS=3D64 =0A#Cfgs=3D  =0A1=0A> =0AP:  =0AVendo=
r=3D03f0 =0AProdID=3D011d =0ARev=3D =0A0.17=0A> =0A> =0A-------------------=
-----------------------------------------------------=0A> =0A> =0A# =0Ahcic=
onfig =0A-a=0A> =0Ahci0:    =0AType: =0AUSB=0A> =0A    =0ABD =0AAddress: =
=0A00:10:C6:F8:11:7C =0AACL =0AMTU: =0A377:10 =0ASCO =0AMTU: =0A16:0=0A> =
=0A    =0AUP =0ARUNNING =0APSCAN =0AISCAN=0A> =0A    =0ARX =0Abytes:87191 =
=0Aacl:27 =0Asco:1676 =0Aevents:53 =0Aerrors:0=0A> =0A    =0ATX =0Abytes:80=
9 =0Aacl:21 =0Asco:0 =0Acommands:30 =0Aerrors:0=0A> =0A    =0AFeatures: =0A=
0xff =0A0xfe =0A0x0d =0A0x38 =0A0x08 =0A0x08 =0A0x00 =0A0x00=0A> =0A    =0A=
Packet =0Atype: =0ADM1 =0ADM3 =0ADM5 =0ADH1 =0ADH3 =0ADH5 =0AHV1 =0AHV2 =0A=
HV3=0A> =0A    =0ALink =0Apolicy: =0ARSWITCH =0AHOLD =0ASNIFF =0APARK=0A> =
=0A    =0ALink =0Amode: =0ASLAVE =0AACCEPT=0A> =0A    =0AName: =0A'BlueZ =
=0A(0)'=0A> =0A    =0AClass: =0A0x080100=0A> =0A    =0AService =0AClasses: =
=0ACapturing=0A> =0A    =0ADevice =0AClass: =0AComputer, =0AUncategorized=
=0A> =0A    =0AHCI =0AVer: =0A1.2 =0A(0x2) =0AHCI =0ARev: =0A0x11 =0ALMP =
=0AVer: =0A1.2 =0A(0x2) =0ALMP =0ASubver: =0A0x6963=0A> =0A    =0AManufactu=
rer: =0ABroadcom =0ACorporation =0A(15)=0A> =0A> =0A-----------------------=
-------------------------------------------------=0A> =0A> =0A# =0Ahcitool =
=0Ainfo =0A00:0D:44:30:4B:11  =0A  =0A  =0A/* =0AMy =0ALogitech =0Aheadset =
=0A*/=0A> =0ARequesting =0Ainformation =0A...=0A> =0A    =0ABD =0AAddress: =
 =0A00:0D:44:30:4B:11=0A> =0A    =0ALMP =0AVersion: =0A1.2 =0A(0x2) =0ALMP =
=0ASubversion: =0A0x611=0A> =0A    =0AManufacturer: =0ACambridge =0ASilicon=
 =0ARadio =0A(10)=0A> =0A    =0AFeatures: =0A0xfc =0A0xfe =0A0x0f =0A0x00 =
=0A0x08 =0A0x08 =0A0x00 =0A0x00=0A> =0A    =0A    =0A<encryption> =0A<slot =
=0Aoffset> =0A<timing =0Aaccuracy> =0A<role =0Aswitch>=0A> =0A    =0A    =
=0A<hold =0Amode> =0A<sniff =0Amode> =0A<RSSI> =0A<channel =0Aquality> =0A<=
SCO =0Alink>=0A> =0A    =0A    =0A<HV2 =0Apackets> =0A<HV3 =0Apackets> =0A<=
u-law =0Alog> =0A<A-law =0Alog> =0A<CVSD>=0A> =0A    =0A    =0A<paging =0As=
cheme> =0A<power =0Acontrol> =0A<transparent =0ASCO>=0A> =0A    =0A    =0A<=
AFH =0Acap. =0Aslave> =0A<AFH =0Acap. =0Amaster>=0A> =0A> =0A--------------=
----------------------------------------------------------=0A> =0A> =0A# =
=0Arfcomm=0A> =0Arfcomm0: =0A00:0D:44:30:4B:11 =0Achannel =0A1 =0Aclean=0A>=
 =0A> =0A------------------------------------------------------------------=
------=0A> =0A> =0A# =0Al2ping =0A00:0D:44:30:4B:11=0A> =0APing: =0A00:0D:4=
4:30:4B:11 =0Afrom =0A00:10:C6:F8:11:7C =0A(data =0Asize =0A44) =0A...=0A> =
=0A44 =0Abytes =0Afrom =0A00:0D:44:30:4B:11 =0Aid =0A0 =0Atime =0A34.40ms=
=0A> =0A44 =0Abytes =0Afrom =0A00:0D:44:30:4B:11 =0Aid =0A1 =0Atime =0A52.7=
2ms=0A> =0A2 =0Asent, =0A2 =0Areceived, =0A0% =0Aloss=0A> =0A> =0A---------=
---------------------------------------------------------------=0A> =0A> =
=0A# =0Acat =0A/etc/asound.conf=0A> =0Apcm.bluetooth =0A{=0A>  =0A  =0A  =
=0A  =0A =0Atype =0Abluetooth=0A> =0A    =0Adevice =0A00:0D:44:30:4B:11=0A>=
 =0A}=0A> =0A> =0A---------------------------------------------------------=
---------------=0A> =0A> =0A# =0Acat =0A/proc/asound/cards=0A>  =0A0 =0A[IC=
H6  =0A  =0A  =0A  =0A  =0A =0A]: =0AICH4 =0A- =0AIntel =0AICH6=0A>  =0A  =
=0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A =0AIntel =0AICH6 =0Awith =
=0AAD1981B =0Aat =0Airq =0A21=0A>  =0A1 =0A[Modem  =0A  =0A  =0A  =0A  =0A]=
: =0AICH-MODEM =0A- =0AIntel =0AICH6 =0AModem=0A>  =0A  =0A  =0A  =0A  =0A =
 =0A  =0A  =0A  =0A  =0A  =0A =0AIntel =0AICH6 =0AModem =0Aat =0Airq =0A19=
=0A> =0A> =0A--------------------------------------------------------------=
----------=0A> =0A> =0A# =0Atail =0A-f =0A/var/log/messages  =0A  =0A/* =0A=
before =0Aexecuting =0Athe =0Aabove =0Amplayer=0A> =0Acommand =0A*/=0A> =0A=
Feb  =0A1 =0A00:36:25 =0Asnake =0Aaudio[8329]: =0AAccepted =0Anew =0Aclient=
 =0Aconnection =0Aon=0A> =0Aunix =0Asocket =0A(fd=3D9)=0A> =0AFeb  =0A1 =0A=
00:36:25 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived=0A> =0ABT_GE=
TCAPABILITIES_REQ=0A> =0AFeb  =0A1 =0A00:36:25 =0Asnake =0Aaudio[8329]: =0A=
Audio =0AAPI: =0Asending =0ABT_GETCAPABILITIES_RSP=0A> =0AFeb  =0A1 =0A00:3=
6:25 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived=0A> =0ABT_SETCON=
FIGURATION_REQ=0A> =0AFeb  =0A1 =0A00:36:25 =0Asnake =0Aaudio[8329]: =0ASta=
te =0Achanged=0A> =0A/org/bluez/audio/device0: =0AHEADSET_STATE_DISCONNECTE=
D =0A->=0A> =0AHEADSET_STATE_CONNECT_IN_PROGRESS=0A> =0AFeb  =0A1 =0A00:36:=
29 =0Asnake =0Ahcid[8156]: =0Alink_key_request=0A> =0A(sba=3D00:10:C6:F8:11=
:7C, =0Adba=3D00:0D:44:30:4B:11)=0A> =0AFeb  =0A1 =0A00:36:29 =0Asnake =0Aa=
udio[8329]: =0A/org/bluez/audio/device0: =0AConnecting=0A> =0Ato =0A00:0D:4=
4:30:4B:11 =0Achannel =0A1=0A> =0AFeb  =0A1 =0A00:36:30 =0Asnake =0Aaudio[8=
329]: =0AState =0Achanged=0A> =0A/org/bluez/audio/device0: =0AHEADSET_STATE=
_CONNECT_IN_PROGRESS =0A->=0A> =0AHEADSET_STATE_CONNECTED=0A> =0AFeb  =0A1 =
=0A00:36:30 =0Asnake =0Aaudio[8329]: =0A/org/bluez/audio/device0: =0AConnec=
ted=0A> =0Ato =0A00:0D:44:30:4B:11=0A> =0AFeb  =0A1 =0A00:36:30 =0Asnake =
=0Aaudio[8329]: =0AState =0Achanged=0A> =0A/org/bluez/audio/device0: =0AHEA=
DSET_STATE_CONNECTED =0A->=0A> =0AHEADSET_STATE_PLAY_IN_PROGRESS=0A> =0AFeb=
  =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0ASCO =0Asocket =0Aopened =0Af=
or =0Aheadset=0A> =0A/org/bluez/audio/device0=0A> =0AFeb  =0A1 =0A00:36:30 =
=0Asnake =0Aaudio[8329]: =0ASCO =0Afd=3D11=0A> =0AFeb  =0A1 =0A00:36:30 =0A=
snake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending=0A> =0ABT_SETCONFIGURATIO=
N_RSP=0A> =0AFeb  =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AState =0Acha=
nged=0A> =0A/org/bluez/audio/device0: =0AHEADSET_STATE_PLAY_IN_PROGRESS =0A=
->=0A> =0AHEADSET_STATE_PLAYING=0A> =0AFeb  =0A1 =0A00:36:30 =0Asnake =0Aau=
dio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_REQ=0A> =0AFeb  =
=0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT=
_STREAMSTART_RSP=0A> =0AFeb  =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AA=
udio =0AAPI: =0Asending =0ABT_STREAMFD_IND=0A> =0AFeb  =0A1 =0A00:36:30 =0A=
snake =0Ahci_scodata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown=0A>=
 =0Aconnection =0Ahandle =0A0=0A> =0AFeb  =0A1 =0A00:36:30 =0Asnake =0Ahci_=
scodata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown=0A> =0Aconnectio=
n =0Ahandle =0A0=0A> =0AFeb  =0A1 =0A00:36:30 =0Asnake =0Ahci_scodata_packe=
t: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown=0A> =0Aconnection =0Ahandle =
=0A0=0A> =0AFeb  =0A1 =0A00:36:30 =0Asnake =0Ahci_scodata_packet: =0Ahci0 =
=0ASCO =0Apacket =0Afor =0Aunknown=0A> =0Aconnection =0Ahandle =0A0=0A> =0A=
Feb  =0A1 =0A00:36:30 =0Asnake =0Ahci_scodata_packet: =0Ahci0 =0ASCO =0Apac=
ket =0Afor =0Aunknown=0A> =0Aconnection =0Ahandle =0A0=0A> =0AFeb  =0A1 =0A=
00:36:30 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAM=
START_REQ=0A> =0AFeb  =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AAudio =
=0AAPI: =0Asending =0ABT_STREAMSTART_RSP=0A> =0AFeb  =0A1 =0A00:36:30 =0Asn=
ake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IND=0A> =0AF=
eb  =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =
=0ABT_STREAMSTART_REQ=0A> =0AFeb  =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]:=
 =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART_RSP=0A> =0AFeb  =0A1 =0A00:3=
6:30 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IN=
D=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =
=0Areceived =0ABT_STREAMSTART_REQ=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0A=
audio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART_RSP=0A> =0AFeb  =
=0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT=
_STREAMFD_IND=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudi=
o =0AAPI: =0Areceived =0ABT_STREAMSTART_REQ=0A> =0AFeb  =0A1 =0A00:36:31 =
=0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART_RSP=
=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0A=
sending =0ABT_STREAMFD_IND=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8=
329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_REQ=0A> =0AFeb  =0A1 =
=0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STRE=
AMSTART_RSP=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =
=0AAPI: =0Asending =0ABT_STREAMFD_IND=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake=
 =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_REQ=0A> =0A=
Feb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =
=0ABT_STREAMSTART_RSP=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]:=
 =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IND=0A> =0AFeb  =0A1 =0A00:36:3=
1 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_R=
EQ=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =
=0Asending =0ABT_STREAMSTART_RSP=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aa=
udio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IND=0A> =0AFeb  =0A1=
 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_ST=
REAMSTART_REQ=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudi=
o =0AAPI: =0Asending =0ABT_STREAMSTART_RSP=0A> =0AFeb  =0A1 =0A00:36:31 =0A=
snake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IND=0A> =
=0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Arecei=
ved =0ABT_STREAMSTART_REQ=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[83=
29]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART_RSP=0A> =0AFeb  =0A1 =0A=
00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMF=
D_IND=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI=
: =0Areceived =0ABT_STREAMSTART_REQ=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =
=0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART_RSP=0A> =0AFe=
b  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =
=0ABT_STREAMFD_IND=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =
=0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_REQ=0A> =0AFeb  =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART=
_RSP=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI:=
 =0Asending =0ABT_STREAMFD_IND=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaud=
io[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_REQ=0A> =0AFeb  =
=0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT=
_STREAMSTART_RSP=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AA=
udio =0AAPI: =0Asending =0ABT_STREAMFD_IND=0A> =0AFeb  =0A1 =0A00:36:31 =0A=
snake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_REQ=0A=
> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asen=
ding =0ABT_STREAMSTART_RSP=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8=
329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IND=0A> =0AFeb  =0A1 =0A00=
:36:31 =0Asnake =0Aaudio[8329]: =0AUnix =0Aclient =0Adisconnected =0A(fd=3D=
9)=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AState =0Achange=
d=0A> =0A/org/bluez/audio/device0: =0AHEADSET_STATE_PLAYING =0A->=0A> =0AHE=
ADSET_STATE_DISCONNECTED=0A> =0AFeb  =0A1 =0A00:36:31 =0Asnake =0Ahci_scoda=
ta_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown=0A> =0Aconnection =0A=
handle =0A1=0A> =0A> =0A> =0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0A>  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A=
  =0A  =0A  =0A =0AEnd =0Aof =0Adebug =0Ainfo=0A> =0A=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A> =0A> =0A> =0A> =0AI =0Aha=
ve =0Ano =0AIdea =0Awhere =0Ato =0Astart =0Asearching =0Athe =0Aproblem...=
=0A> =0ASomewhere =0AI =0Aread =0Athat =0ABroadcom =0AChips =0Aaren't =0Afu=
lly =0Asupported. =0AMay =0AI =0Aneed=0A> =0Afirmware =0Aperhaps? =0AWould =
=0Al2ping =0Awork =0Ain =0Athis =0Acase? =0A(In =0Amy =0Acase =0Ait =0ADOES=
=0A> =0Awork!?)=0A> =0AQuote:=0A> =0A"If =0Ayou =0Ahave =0Aa =0ABroadcom =
=0AChipset =0Aor =0AHewlett-Packard =0AIntegrated =0AChipset=0A> =0A(such =
=0Aas =0Amine =0Aon =0AHP =0Anx8220) =0Athen =0Ayou =0Areally =0Awant =0Ato=
 =0Apass=0A> =0A'force_scofix=3D1' =0Aas =0Aargument =0Ato =0Akernel: =0Ait=
 =0Awas =0Athe =0Aonly =0Away =0Ato =0Amake =0Awork=0A> =0Ahci_usb =0Aprope=
rly =0Awith =0Amy =0Achip. =0ANOTE: =0Abcm203x =0Awon't =0Arecognize =0AHP=
=0A> =0AIntegrated =0Aas =0Aa =0Avalid =0Achip =0A(03f0:011d =0Ainstead =0A=
of =0A0a5c:2033 =0A- =0Ayou =0Acan=0A> =0Acheck =0Athis =0Awith =0Alsusb), =
=0Athen =0Adon't =0Aeven =0Atry =0Ato =0Amake =0Ait =0Awork."=0A> =0A> =0AM=
ay =0AI =0Ahave =0Aan =0Aerror =0Ain =0Amy =0Aalsa-config? =0AThere =0Ais =
=0Ano =0Acard =0Adisplayed...=0A> =0A> =0A> =0AThanks =0Afor =0Ayour =0Atim=
e!=0A> =0ABest =0Aregards, =0ADaniel=0A> =0A> =0A> =0A---------------------=
----------------------------------------------------=0A> =0AThis =0ASF.net =
=0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft=0A> =0ADefy =0Aall =0Achall=
enges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.=0A> =0Ahttp://clk.atdmt=
.com/MRT/go/vse0120000070mrt/direct/01/=0A> =0A____________________________=
___________________=0A> =0ABluez-users =0Amailing =0Alist=0A> =0ABluez-user=
s@lists.sourceforge.net=0A> =0Ahttps://lists.sourceforge.net/lists/listinfo=
/bluez-users=0A> =0A=0AHi =0Aagain,=0A=0AI =0Agot =0Anew =0Ainfo:=0A=0Athis=
 =0Ais =0Aa =0Apart =0Aof =0Athe =0Ahcid-log =0Ain =0Amy =0Amessages =0Awhe=
n =0AI =0Aswitch =0Aon =0Amy=0Aheadset. =0ASeems =0Athat =0AI =0Ahave =0Ano=
 =0AKey-Agent...=0A=0A#passkey-agent =0A--help  =0A =0A/* =0Atells =0Ame =
=0Athat =0AI =0Ahave =0AVersion =0A3.24 =0A*/=0A=0ADo =0AI =0Ahave =0Ato =
=0Aset =0Ait =0Aup =0Amanually?=0ASo =0AI =0Adid =0Athe =0Afollowing:=0A=0A=
#passkey-agent =0A--default =0A0000 =0A/* =0Atest =0Akey =0A*/=0A=0AI =0Ase=
e:=0Ahcid[14592]: =0ADefault =0Apasskey =0Aagent =0A(:1.41,=0A/org/bluez/pa=
sskey_agent_14605) =0Aregistered=0A=0ABut =0Athe =0Aerrors =0Adon't =0Achan=
ge...=0AWhat =0Ado =0AI =0Ahave =0Ato =0Ado =0Ato =0Aget =0Amy =0Akey-agent=
 =0Aworking?=0A=0A=0ABest =0Aregards, =0ADaniel=0A=0A=0A=0A=0ALOG =0A(when =
=0Aswitching =0Aon =0Aheadset):=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0Ahcid[10257]: =0Alink_key_request =0A(sb=
a=3D00:10:C6:F8:11:7C, =0Adba=3D00:0D:44:30:4B:11)=0Ahcid[10257]: =0A/org/b=
luez: =0Aorg.bluez.Database.RequestAuthorization()=0Ahcid[10257]: =0Ahandle=
_authorize_request=0Ahcid[10257]: =0Ano =0Adefault =0Aagent=0Aaudio[10261]:=
 =0ARequesting =0Aauthorization =0Afor =0Adevice =0A00:0D:44:30:4B:11,=0AUU=
ID =0A0000111F-0000-1000-8000-00805F9B34FB=0Aaudio[10261]: =0AState =0Achan=
ged =0A/org/bluez/audio/device0:=0AHEADSET_STATE_DISCONNECTED =0A-> =0AHEAD=
SET_STATE_CONNECT_IN_PROGRESS=0Aaudio[10261]: =0AAccess =0Adenied: =0AAutho=
rization =0Aagent =0Adoes =0Anot =0Aexist=0Aaudio[10261]: =0AState =0Achang=
ed =0A/org/bluez/audio/device0:=0AHEADSET_STATE_CONNECT_IN_PROGRESS =0A-> =
=0AHEADSET_STATE_DISCONNECTED=0Ahcid[10257]: =0Alink_key_notify =0A(sba=3D0=
0:10:C6:F8:11:7C, =0Adba=3D00:0D:44:30:4B:11)=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=0A------------------------=
-------------------------------------------------=0AThis =0ASF.net =0Aemail=
 =0Ais =0Asponsored =0Aby: =0AMicrosoft=0ADefy =0Aall =0Achallenges. =0AMic=
rosoft(R) =0AVisual =0AStudio =0A2008.=0Ahttp://clk.atdmt.com/MRT/go/vse012=
0000070mrt/direct/01/=0A_______________________________________________=0AB=
luez-users =0Amailing =0Alist=0ABluez-users@lists.sourceforge.net=0Ahttps:/=
/lists.sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=0A=0A=0A  =
    Forgot the famous last words? Access your message archive online at htt=
p://in.messenger.yahoo.com/webmessengerpromo.php
--0-1099448865-1202211652=:29568
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi same thing here<br>But i was asked to update my kernel(2=
.6.15)<br>Now I compiled 2.6.22 But no difference ..headset get connected b=
ut <br>the system hangs with white screen ...<br>Which kernel are you using=
...?<br>Have you applied patch for :SCO flow control from plugs..<br>i trie=
d it but failing with both the kernel....<br>Which patch did you apply<br>P=
lease reply as your done things may help me...<br><br><div>&nbsp;</div>Than=
ks and Best regards<div>&nbsp;</div><div>Pramod<div style=3D"font-family: t=
imes new roman,new york,times,serif; font-size: 12pt;"><br><br><div style=
=3D"font-family: times new roman,new york,times,serif; font-size: 12pt;">--=
--- Original Message ----<br>From: Daniel Stumpner &lt;bigstumpi@gmx.de&gt;=
<br>To: BlueZ users &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent:
 Saturday, 2 February, 2008 3:02:54 PM<br>Subject: Re: [Bluez-users] BT Hea=
dset connected but no sound<br><br>Daniel =0AStumpner =0Awrote:<br>&gt; =0A=
Hi,<br>&gt; <br>&gt; =0Acan =0Aconnect =0Ato =0Amy =0ABT =0AHeadset =0Abut =
=0Aif =0AI =0Atry =0Ato =0Aplay =0Aa =0Asound, =0Ait =0Adoes =0Aonly<br>&gt=
; =0Abeep =0Aat =0Athe =0Astart =0Aand =0Aat =0Athe =0Aend =0Aof =0Athe =0A=
connection =0Abut =0Athere =0Ais =0Ano =0Asound.<br>&gt; <br>&gt; =0Amplaye=
r =0A-ao =0Aalsa:device=3Dbluetooth =0Atest.wav<br>&gt; =0A- =0Abeep =0A-<b=
r>&gt; =0A(pressing =0A'q')<br>&gt; =0A- =0Abeep =0A-<br>&gt; <br>&gt; =0AI=
 =0Aam =0Arunning =0AGentoo =0Awith =0Alinux =0A2.6.23 =0A(x86)<br>&gt; =0A=
bluez-libs-3.24<br>&gt; =0Ablues-utils-3.24<br>&gt; <br>&gt; <br>&gt; =0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt;&=
nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp;=
 =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0ASome =0ADebug =0AInformation:<b=
r>&gt; =0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>&gt; <br>&gt; =0A# =0Alsusb<br>&gt; =0ABus =0A002 =0ADevice =0A002: =
=0AID =0A046d:c012 =0ALogitech, =0AInc. =0AOptical =0AMouse<br>&gt; =0ABus =
=0A002 =0ADevice =0A001: =0AID =0A0000:0000<br>&gt; =0ABus =0A004 =0ADevice=
 =0A001: =0AID =0A0000:0000<br>&gt; =0ABus =0A003 =0ADevice =0A002: =0AID =
=0A03f0:011d =0AHewlett-Packard&nbsp; =0A&nbsp; =0A =0A/* =0ACritical =0Ali=
ne =0A*/<br>&gt; =0ABus =0A003 =0ADevice =0A001: =0AID =0A0000:0000<br>&gt;=
 =0ABus =0A001 =0ADevice =0A001: =0AID =0A0000:0000<br>&gt; <br>&gt; =0A---=
---------------------------------------------------------------------<br>&g=
t; <br>&gt; =0A# =0Acat =0A/proc/bus/usb/devices =0A| =0Agrep =0A-e^[TPD] =
=0A| =0Agrep =0A-e =0ACls=3De0 =0A-B1 =0A-A1<br>&gt; =0AT:&nbsp; =0ABus=3D0=
3 =0ALev=3D01 =0APrnt=3D01 =0APort=3D01 =0ACnt=3D01 =0ADev#=3D&nbsp; =0A2 =
=0ASpd=3D12&nbsp; =0AMxCh=3D =0A0<br>&gt; =0AD:&nbsp; =0AVer=3D =0A1.10 =0A=
Cls=3De0(unk. =0A) =0ASub=3D01 =0AProt=3D01 =0AMxPS=3D64 =0A#Cfgs=3D&nbsp; =
=0A1<br>&gt; =0AP:&nbsp; =0AVendor=3D03f0 =0AProdID=3D011d =0ARev=3D =0A0.1=
7<br>&gt; <br>&gt; =0A-----------------------------------------------------=
-------------------<br>&gt; <br>&gt; =0A# =0Ahciconfig =0A-a<br>&gt; =0Ahci=
0:&nbsp;&nbsp;&nbsp; =0AType: =0AUSB<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0ABD =
=0AAddress: =0A00:10:C6:F8:11:7C =0AACL =0AMTU: =0A377:10 =0ASCO =0AMTU: =
=0A16:0<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0AUP =0ARUNNING =0APSCAN =0AISCAN<br=
>&gt; =0A&nbsp;&nbsp;&nbsp; =0ARX =0Abytes:87191 =0Aacl:27 =0Asco:1676 =0Ae=
vents:53 =0Aerrors:0<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0ATX =0Abytes:809 =0Aac=
l:21 =0Asco:0 =0Acommands:30 =0Aerrors:0<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0AF=
eatures: =0A0xff =0A0xfe =0A0x0d =0A0x38 =0A0x08 =0A0x08 =0A0x00 =0A0x00<br=
>&gt; =0A&nbsp;&nbsp;&nbsp; =0APacket =0Atype: =0ADM1 =0ADM3 =0ADM5 =0ADH1 =
=0ADH3 =0ADH5 =0AHV1 =0AHV2 =0AHV3<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0ALink =
=0Apolicy: =0ARSWITCH =0AHOLD =0ASNIFF =0APARK<br>&gt; =0A&nbsp;&nbsp;&nbsp=
; =0ALink =0Amode: =0ASLAVE =0AACCEPT<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0AName=
: =0A'BlueZ =0A(0)'<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0AClass: =0A0x080100<br>=
&gt; =0A&nbsp;&nbsp;&nbsp; =0AService =0AClasses: =0ACapturing<br>&gt; =0A&=
nbsp;&nbsp;&nbsp; =0ADevice =0AClass: =0AComputer, =0AUncategorized<br>&gt;=
 =0A&nbsp;&nbsp;&nbsp; =0AHCI =0AVer: =0A1.2 =0A(0x2) =0AHCI =0ARev: =0A0x1=
1 =0ALMP =0AVer: =0A1.2 =0A(0x2) =0ALMP =0ASubver: =0A0x6963<br>&gt; =0A&nb=
sp;&nbsp;&nbsp; =0AManufacturer: =0ABroadcom =0ACorporation =0A(15)<br>&gt;=
 <br>&gt; =0A--------------------------------------------------------------=
----------<br>&gt; <br>&gt; =0A# =0Ahcitool =0Ainfo =0A00:0D:44:30:4B:11&nb=
sp; =0A&nbsp; =0A&nbsp; =0A/* =0AMy =0ALogitech =0Aheadset =0A*/<br>&gt; =
=0ARequesting =0Ainformation =0A...<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0ABD =0A=
Address:&nbsp; =0A00:0D:44:30:4B:11<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0ALMP =
=0AVersion: =0A1.2 =0A(0x2) =0ALMP =0ASubversion: =0A0x611<br>&gt; =0A&nbsp=
;&nbsp;&nbsp; =0AManufacturer: =0ACambridge =0ASilicon =0ARadio =0A(10)<br>=
&gt; =0A&nbsp;&nbsp;&nbsp; =0AFeatures: =0A0xfc =0A0xfe =0A0x0f =0A0x00 =0A=
0x08 =0A0x08 =0A0x00 =0A0x00<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&=
nbsp; =0A&lt;encryption&gt; =0A&lt;slot =0Aoffset&gt; =0A&lt;timing =0Aaccu=
racy&gt; =0A&lt;role =0Aswitch&gt;<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0A&nbsp;&=
nbsp;&nbsp; =0A&lt;hold =0Amode&gt; =0A&lt;sniff =0Amode&gt; =0A&lt;RSSI&gt=
; =0A&lt;channel =0Aquality&gt; =0A&lt;SCO =0Alink&gt;<br>&gt; =0A&nbsp;&nb=
sp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0A&lt;HV2 =0Apackets&gt; =0A&lt;HV3 =0Apac=
kets&gt; =0A&lt;u-law =0Alog&gt; =0A&lt;A-law =0Alog&gt; =0A&lt;CVSD&gt;<br=
>&gt; =0A&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0A&lt;paging =0Ascheme&g=
t; =0A&lt;power =0Acontrol&gt; =0A&lt;transparent =0ASCO&gt;<br>&gt; =0A&nb=
sp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0A&lt;AFH =0Acap. =0Aslave&gt; =0A&l=
t;AFH =0Acap. =0Amaster&gt;<br>&gt; <br>&gt; =0A---------------------------=
---------------------------------------------<br>&gt; <br>&gt; =0A# =0Arfco=
mm<br>&gt; =0Arfcomm0: =0A00:0D:44:30:4B:11 =0Achannel =0A1 =0Aclean<br>&gt=
; <br>&gt; =0A-------------------------------------------------------------=
-----------<br>&gt; <br>&gt; =0A# =0Al2ping =0A00:0D:44:30:4B:11<br>&gt; =
=0APing: =0A00:0D:44:30:4B:11 =0Afrom =0A00:10:C6:F8:11:7C =0A(data =0Asize=
 =0A44) =0A...<br>&gt; =0A44 =0Abytes =0Afrom =0A00:0D:44:30:4B:11 =0Aid =
=0A0 =0Atime =0A34.40ms<br>&gt; =0A44 =0Abytes =0Afrom =0A00:0D:44:30:4B:11=
 =0Aid =0A1 =0Atime =0A52.72ms<br>&gt; =0A2 =0Asent, =0A2 =0Areceived, =0A0=
% =0Aloss<br>&gt; <br>&gt; =0A---------------------------------------------=
---------------------------<br>&gt; <br>&gt; =0A# =0Acat =0A/etc/asound.con=
f<br>&gt; =0Apcm.bluetooth =0A{<br>&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp;=
 =0A =0Atype =0Abluetooth<br>&gt; =0A&nbsp;&nbsp;&nbsp; =0Adevice =0A00:0D:=
44:30:4B:11<br>&gt; =0A}<br>&gt; <br>&gt; =0A------------------------------=
------------------------------------------<br>&gt; <br>&gt; =0A# =0Acat =0A=
/proc/asound/cards<br>&gt;&nbsp; =0A0 =0A[ICH6&nbsp; =0A&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A =0A]: =0AICH4 =0A- =0AIntel =0AICH6<br>&gt;&nbsp; =
=0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&n=
bsp; =0A&nbsp; =0A&nbsp; =0A =0AIntel =0AICH6 =0Awith =0AAD1981B =0Aat =0Ai=
rq =0A21<br>&gt;&nbsp; =0A1 =0A[Modem&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =
=0A&nbsp; =0A]: =0AICH-MODEM =0A- =0AIntel =0AICH6 =0AModem<br>&gt;&nbsp; =
=0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&n=
bsp; =0A&nbsp; =0A&nbsp; =0A =0AIntel =0AICH6 =0AModem =0Aat =0Airq =0A19<b=
r>&gt; <br>&gt; =0A--------------------------------------------------------=
----------------<br>&gt; <br>&gt; =0A# =0Atail =0A-f =0A/var/log/messages&n=
bsp; =0A&nbsp; =0A/* =0Abefore =0Aexecuting =0Athe =0Aabove =0Amplayer<br>&=
gt; =0Acommand =0A*/<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:25 =0Asnake =0Aaudi=
o[8329]: =0AAccepted =0Anew =0Aclient =0Aconnection =0Aon<br>&gt; =0Aunix =
=0Asocket =0A(fd=3D9)<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:25 =0Asnake =0Aaud=
io[8329]: =0AAudio =0AAPI: =0Areceived<br>&gt; =0ABT_GETCAPABILITIES_REQ<br=
>&gt; =0AFeb&nbsp; =0A1 =0A00:36:25 =0Asnake =0Aaudio[8329]: =0AAudio =0AAP=
I: =0Asending =0ABT_GETCAPABILITIES_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:=
25 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived<br>&gt; =0ABT_SETC=
ONFIGURATION_REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:25 =0Asnake =0Aaudio[83=
29]: =0AState =0Achanged<br>&gt; =0A/org/bluez/audio/device0: =0AHEADSET_ST=
ATE_DISCONNECTED =0A-&gt;<br>&gt; =0AHEADSET_STATE_CONNECT_IN_PROGRESS<br>&=
gt; =0AFeb&nbsp; =0A1 =0A00:36:29 =0Asnake =0Ahcid[8156]: =0Alink_key_reque=
st<br>&gt; =0A(sba=3D00:10:C6:F8:11:7C, =0Adba=3D00:0D:44:30:4B:11)<br>&gt;=
 =0AFeb&nbsp; =0A1 =0A00:36:29 =0Asnake =0Aaudio[8329]: =0A/org/bluez/audio=
/device0: =0AConnecting<br>&gt; =0Ato =0A00:0D:44:30:4B:11 =0Achannel =0A1<=
br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AState =0A=
changed<br>&gt; =0A/org/bluez/audio/device0: =0AHEADSET_STATE_CONNECT_IN_PR=
OGRESS =0A-&gt;<br>&gt; =0AHEADSET_STATE_CONNECTED<br>&gt; =0AFeb&nbsp; =0A=
1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0A/org/bluez/audio/device0: =0AConn=
ected<br>&gt; =0Ato =0A00:0D:44:30:4B:11<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36=
:30 =0Asnake =0Aaudio[8329]: =0AState =0Achanged<br>&gt; =0A/org/bluez/audi=
o/device0: =0AHEADSET_STATE_CONNECTED =0A-&gt;<br>&gt; =0AHEADSET_STATE_PLA=
Y_IN_PROGRESS<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]=
: =0ASCO =0Asocket =0Aopened =0Afor =0Aheadset<br>&gt; =0A/org/bluez/audio/=
device0<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AS=
CO =0Afd=3D11<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]=
: =0AAudio =0AAPI: =0Asending<br>&gt; =0ABT_SETCONFIGURATION_RSP<br>&gt; =
=0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AState =0Achanged<=
br>&gt; =0A/org/bluez/audio/device0: =0AHEADSET_STATE_PLAY_IN_PROGRESS =0A-=
&gt;<br>&gt; =0AHEADSET_STATE_PLAYING<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30=
 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_RE=
Q<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AAudio =
=0AAPI: =0Asending =0ABT_STREAMSTART_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36=
:30 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IND=
<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Ahci_scodata_packet: =0Ah=
ci0 =0ASCO =0Apacket =0Afor =0Aunknown<br>&gt; =0Aconnection =0Ahandle =0A0=
<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Ahci_scodata_packet: =0Ah=
ci0 =0ASCO =0Apacket =0Afor =0Aunknown<br>&gt; =0Aconnection =0Ahandle =0A0=
<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Ahci_scodata_packet: =0Ah=
ci0 =0ASCO =0Apacket =0Afor =0Aunknown<br>&gt; =0Aconnection =0Ahandle =0A0=
<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Ahci_scodata_packet: =0Ah=
ci0 =0ASCO =0Apacket =0Afor =0Aunknown<br>&gt; =0Aconnection =0Ahandle =0A0=
<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Ahci_scodata_packet: =0Ah=
ci0 =0ASCO =0Apacket =0Afor =0Aunknown<br>&gt; =0Aconnection =0Ahandle =0A0=
<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AAudio =
=0AAPI: =0Areceived =0ABT_STREAMSTART_REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:30 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART=
_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AAudi=
o =0AAPI: =0Asending =0ABT_STREAMFD_IND<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:=
30 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_=
REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:30 =0Asnake =0Aaudio[8329]: =0AAudio=
 =0AAPI: =0Asending =0ABT_STREAMSTART_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:30 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IN=
D<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =
=0AAPI: =0Areceived =0ABT_STREAMSTART_REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART=
_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudi=
o =0AAPI: =0Asending =0ABT_STREAMFD_IND<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:=
31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_=
REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio=
 =0AAPI: =0Asending =0ABT_STREAMSTART_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IN=
D<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =
=0AAPI: =0Areceived =0ABT_STREAMSTART_REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART=
_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudi=
o =0AAPI: =0Asending =0ABT_STREAMFD_IND<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:=
31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_=
REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio=
 =0AAPI: =0Asending =0ABT_STREAMSTART_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IN=
D<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =
=0AAPI: =0Areceived =0ABT_STREAMSTART_REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART=
_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudi=
o =0AAPI: =0Asending =0ABT_STREAMFD_IND<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:=
31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_=
REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio=
 =0AAPI: =0Asending =0ABT_STREAMSTART_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IN=
D<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =
=0AAPI: =0Areceived =0ABT_STREAMSTART_REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART=
_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudi=
o =0AAPI: =0Asending =0ABT_STREAMFD_IND<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:=
31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_=
REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio=
 =0AAPI: =0Asending =0ABT_STREAMSTART_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IN=
D<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =
=0AAPI: =0Areceived =0ABT_STREAMSTART_REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART=
_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudi=
o =0AAPI: =0Asending =0ABT_STREAMFD_IND<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:=
31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Areceived =0ABT_STREAMSTART_=
REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio=
 =0AAPI: =0Asending =0ABT_STREAMSTART_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMFD_IN=
D<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudio =
=0AAPI: =0Areceived =0ABT_STREAMSTART_REQ<br>&gt; =0AFeb&nbsp; =0A1 =0A00:3=
6:31 =0Asnake =0Aaudio[8329]: =0AAudio =0AAPI: =0Asending =0ABT_STREAMSTART=
_RSP<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AAudi=
o =0AAPI: =0Asending =0ABT_STREAMFD_IND<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36:=
31 =0Asnake =0Aaudio[8329]: =0AUnix =0Aclient =0Adisconnected =0A(fd=3D9)<b=
r>&gt; =0AFeb&nbsp; =0A1 =0A00:36:31 =0Asnake =0Aaudio[8329]: =0AState =0Ac=
hanged<br>&gt; =0A/org/bluez/audio/device0: =0AHEADSET_STATE_PLAYING =0A-&g=
t;<br>&gt; =0AHEADSET_STATE_DISCONNECTED<br>&gt; =0AFeb&nbsp; =0A1 =0A00:36=
:31 =0Asnake =0Ahci_scodata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunkn=
own<br>&gt; =0Aconnection =0Ahandle =0A1<br>&gt; <br>&gt; <br>&gt; =0A=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt;&nbs=
p; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0AEnd =0Aof =0Adebug=
 =0Ainfo<br>&gt; =0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>&gt; <br>&gt; <br>&gt; <br>&gt; =0AI =0Ahave =0Ano =0AIdea =
=0Awhere =0Ato =0Astart =0Asearching =0Athe =0Aproblem...<br>&gt; =0ASomewh=
ere =0AI =0Aread =0Athat =0ABroadcom =0AChips =0Aaren't =0Afully =0Asupport=
ed. =0AMay =0AI =0Aneed<br>&gt; =0Afirmware =0Aperhaps? =0AWould =0Al2ping =
=0Awork =0Ain =0Athis =0Acase? =0A(In =0Amy =0Acase =0Ait =0ADOES<br>&gt; =
=0Awork!?)<br>&gt; =0AQuote:<br>&gt; =0A"If =0Ayou =0Ahave =0Aa =0ABroadcom=
 =0AChipset =0Aor =0AHewlett-Packard =0AIntegrated =0AChipset<br>&gt; =0A(s=
uch =0Aas =0Amine =0Aon =0AHP =0Anx8220) =0Athen =0Ayou =0Areally =0Awant =
=0Ato =0Apass<br>&gt; =0A'force_scofix=3D1' =0Aas =0Aargument =0Ato =0Akern=
el: =0Ait =0Awas =0Athe =0Aonly =0Away =0Ato =0Amake =0Awork<br>&gt; =0Ahci=
_usb =0Aproperly =0Awith =0Amy =0Achip. =0ANOTE: =0Abcm203x =0Awon't =0Arec=
ognize =0AHP<br>&gt; =0AIntegrated =0Aas =0Aa =0Avalid =0Achip =0A(03f0:011=
d =0Ainstead =0Aof =0A0a5c:2033 =0A- =0Ayou =0Acan<br>&gt; =0Acheck =0Athis=
 =0Awith =0Alsusb), =0Athen =0Adon't =0Aeven =0Atry =0Ato =0Amake =0Ait =0A=
work."<br>&gt; <br>&gt; =0AMay =0AI =0Ahave =0Aan =0Aerror =0Ain =0Amy =0Aa=
lsa-config? =0AThere =0Ais =0Ano =0Acard =0Adisplayed...<br>&gt; <br>&gt; <=
br>&gt; =0AThanks =0Afor =0Ayour =0Atime!<br>&gt; =0ABest =0Aregards, =0ADa=
niel<br>&gt; <br>&gt; <br>&gt; =0A-----------------------------------------=
--------------------------------<br>&gt; =0AThis =0ASF.net =0Aemail =0Ais =
=0Asponsored =0Aby: =0AMicrosoft<br>&gt; =0ADefy =0Aall =0Achallenges. =0AM=
icrosoft(R) =0AVisual =0AStudio =0A2008.<br>&gt; =0A<a href=3D"http://clk.a=
tdmt.com/MRT/go/vse0120000070mrt/direct/01/" target=3D"_blank">http://clk.a=
tdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>&gt; =0A________________=
_______________________________<br>&gt; =0ABluez-users =0Amailing =0Alist<b=
r>&gt; =0A<a ymailto=3D"mailto:Bluez-users@lists.sourceforge.net" href=3D"m=
ailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net<=
/a><br>&gt; =0A<a href=3D"https://lists.sourceforge.net/lists/listinfo/blue=
z-users" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/blu=
ez-users</a><br>&gt; <br><br>Hi =0Aagain,<br><br>I =0Agot =0Anew =0Ainfo:<b=
r><br>this =0Ais =0Aa =0Apart =0Aof =0Athe =0Ahcid-log =0Ain =0Amy =0Amessa=
ges =0Awhen =0AI =0Aswitch =0Aon =0Amy<br>headset. =0ASeems =0Athat =0AI =
=0Ahave =0Ano =0AKey-Agent...<br><br>#passkey-agent =0A--help&nbsp; =0A =0A=
/* =0Atells =0Ame =0Athat =0AI =0Ahave =0AVersion =0A3.24 =0A*/<br><br>Do =
=0AI =0Ahave =0Ato =0Aset =0Ait =0Aup =0Amanually?<br>So =0AI =0Adid =0Athe=
 =0Afollowing:<br><br>#passkey-agent =0A--default =0A0000 =0A/* =0Atest =0A=
key =0A*/<br><br>I =0Asee:<br>hcid[14592]: =0ADefault =0Apasskey =0Aagent =
=0A(:1.41,<br>/org/bluez/passkey_agent_14605) =0Aregistered<br><br>But =0At=
he =0Aerrors =0Adon't =0Achange...<br>What =0Ado =0AI =0Ahave =0Ato =0Ado =
=0Ato =0Aget =0Amy =0Akey-agent =0Aworking?<br><br><br>Best =0Aregards, =0A=
Daniel<br><br><br><br><br>LOG =0A(when =0Aswitching =0Aon =0Aheadset):<br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>hcid[10257]: =0Alink_key_request =0A(sba=3D00:10:C6:F8:11:7C, =0Adba=3D00:=
0D:44:30:4B:11)<br>hcid[10257]: =0A/org/bluez: =0Aorg.bluez.Database.Reques=
tAuthorization()<br>hcid[10257]: =0Ahandle_authorize_request<br>hcid[10257]=
: =0Ano =0Adefault =0Aagent<br>audio[10261]: =0ARequesting =0Aauthorization=
 =0Afor =0Adevice =0A00:0D:44:30:4B:11,<br>UUID =0A0000111F-0000-1000-8000-=
00805F9B34FB<br>audio[10261]: =0AState =0Achanged =0A/org/bluez/audio/devic=
e0:<br>HEADSET_STATE_DISCONNECTED =0A-&gt; =0AHEADSET_STATE_CONNECT_IN_PROG=
RESS<br>audio[10261]: =0AAccess =0Adenied: =0AAuthorization =0Aagent =0Adoe=
s =0Anot =0Aexist<br>audio[10261]: =0AState =0Achanged =0A/org/bluez/audio/=
device0:<br>HEADSET_STATE_CONNECT_IN_PROGRESS =0A-&gt; =0AHEADSET_STATE_DIS=
CONNECTED<br>hcid[10257]: =0Alink_key_notify =0A(sba=3D00:10:C6:F8:11:7C, =
=0Adba=3D00:0D:44:30:4B:11)<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>-------------------------------------=
------------------------------------<br>This =0ASF.net =0Aemail =0Ais =0Asp=
onsored =0Aby: =0AMicrosoft<br>Defy =0Aall =0Achallenges. =0AMicrosoft(R) =
=0AVisual =0AStudio =0A2008.<br><a href=3D"http://clk.atdmt.com/MRT/go/vse0=
120000070mrt/direct/01/" target=3D"_blank">http://clk.atdmt.com/MRT/go/vse0=
120000070mrt/direct/01/</a><br>____________________________________________=
___<br>Bluez-users =0Amailing =0Alist<br><a ymailto=3D"mailto:Bluez-users@l=
ists.sourceforge.net" href=3D"mailto:Bluez-users@lists.sourceforge.net">Blu=
ez-users@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.=
net/lists/listinfo/bluez-users" target=3D"_blank">https://lists.sourceforge=
.net/lists/listinfo/bluez-users</a><br></div><br></div></div></div><br>=0A=
=0A=0A      <!--10--><hr size=3D1></hr> Chat on a cool, new interface. No d=
ownload required. <a href=3D"http://in.rd.yahoo.com/tagline_webmessenger_10=
/*http://in.messenger.yahoo.com/webmessengerpromo.php">Click here.</a></bod=
y></html>
--0-1099448865-1202211652=:29568--


--===============0170691633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0170691633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0170691633==--
