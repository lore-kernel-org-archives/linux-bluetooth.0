Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Feb 2008 09:25:32 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <581008.8393.qm@web8407.mail.in.yahoo.com>
Subject: Re: [Bluez-users] BT headset doesn't work: SCO packet for unknown
	connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0663696462=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0663696462==
Content-Type: multipart/alternative; boundary="0-1575237811-1203306932=:8393"

--0-1575237811-1203306932=:8393
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi =0ASame problem here=0A =0AFeb =0A13 =0A09:52:43 =0Alocalhost =0Akernel:=
 =0Ahci_scodata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown =0Aconne=
ction =0Ahandle =0A1=0ANo sound on HS, But I can record my voice through HS=
.=0Athis is my hciconfig    =0A[root@localhost =0APramod]# =0A/usr/local/sb=
in/hciconfig =0A-a=0A-> =0Ahci0:  =0A =0AType: =0AUSB=0A->  =0A  =0A  =0A  =
=0A =0ABD =0AAddress: =0A00:02:72:CE:5B:80 =0AACL =0AMTU: =0A1017:8 =0ASCO =
=0AMTU: =0A64:0=0A->  =0A  =0A  =0A  =0A =0AUP =0ARUNNING =0APSCAN =0AISCAN=
=0A->  =0A  =0A  =0A  =0A =0ARX =0Abytes:5057856 =0Aacl:233 =0Asco:99008 =
=0Aevents:218 =0Aerrors:0=0A->  =0A  =0A  =0A  =0A =0ATX =0Abytes:4708 =0Aa=
cl:165 =0Asco:0 =0Acommands:102 =0Aerrors:0=0A->  =0A  =0A  =0A  =0A =0AFea=
tures: =0A0xff =0A0xff =0A0x8d =0A0xfe =0A0x9b =0A0xf9 =0A0x00 =0A0x80=0A->=
  =0A  =0A  =0A  =0A =0APacket =0Atype: =0ADM1 =0ADM3 =0ADM5 =0ADH1 =0ADH3 =
=0ADH5 =0AHV1 =0AHV2 =0AHV3=0A->  =0A  =0A  =0A  =0A =0ALink =0Apolicy: =0A=
RSWITCH =0AHOLD =0ASNIFF =0APARK=0A->  =0A  =0A  =0A  =0A =0ALink =0Amode: =
=0ASLAVE =0AACCEPT=0A->  =0A  =0A  =0A  =0A =0AName: =0A'BlueZ =0A(0)'=0A->=
  =0A  =0A  =0A  =0A =0AClass: =0A0x080000=0A->  =0A  =0A  =0A  =0A =0AServ=
ice =0AClasses: =0ACapturing=0A->  =0A  =0A  =0A  =0A =0ADevice =0AClass: =
=0AMiscellaneous,=0A->  =0A  =0A  =0A  =0A =0AHCI =0AVer: =0A2.0 =0A(0x3) =
=0AHCI =0ARev: =0A0x204d =0ALMP =0AVer: =0A2.0 =0A(0x3) =0ALMP =0ASubver: =
=0A0x4127=0A->  =0A  =0A  =0A  =0A =0AManufacturer: =0ABroadcom =0ACorporat=
ion =0A(15)=0A =0ASCO =0AMTU: =0A64:0=0A=0Ais this same for ur adapter too.=
 =0A=0A=0AThanks and Best regards =0APramod=0A=0A----- Original Message ---=
-=0AFrom: Vladimir Pouzanov <farcaller@gmail.com>=0ATo: bluez-users@lists.s=
ourceforge.net=0ASent: Saturday, 16 February, 2008 11:20:38 PM=0ASubject: [=
Bluez-users] BT headset doesn't work: SCO packet for unknown connection=0A=
=0AI've =0Agot =0A2.6.24 =0Awith =0Abluez =0Alibs/utils =0A3.25=0A=0AI =0Ah=
ave =0Asuccessfully =0Apaired =0Amy =0Aheadset =0Aand =0APC, =0AI =0Acan =
=0Al2ping =0Ait =0Aand =0Aget =0Ainfo.=0AAs =0Asoon =0Aas =0AI =0Atry =0Ato=
 =0Aplay =0Asome =0Aaudio =0A(via =0Amplayer) =0AI =0Aget =0Athe =0Afollowi=
ng =0Ain =0Athe=0Alogs:=0A=0Aaudio[21835]: =0ARegistered =0Amanager =0Apath=
:/org/bluez/audio=0Aaudio[21835]: =0ALoading =0Adevice =0A00:05:A1:08:00:B1=
 =0A(headset =0A)=0Aaudio[21835]: =0AGot =0Apath =0A/org/bluez/hci0 =0Afor =
=0Aadapter =0Awith=0Aaddress =0A00:18:F3:8D:AF:67=0Aaudio[21835]: =0ASelect=
ing =0Adefault =0Adevice=0Aaudio[21835]: =0ASetting =0A00:05:A1:08:00:B1 =
=0Aas =0Adefault =0Adevice=0Aaudio[21835]: =0AAccepted =0Anew =0Aclient =0A=
connection =0Aon =0Aunix=0Asocket =0A(fd=3D9)=0Aaudio[21835]: =0AAudio =0AA=
PI: =0Areceived =0ABT_GETCAPABILITIES_REQ=0Aaudio[21835]: =0AAudio =0AAPI: =
=0Asending =0ABT_GETCAPABILITIES_RSP=0Aaudio[21835]: =0AAudio =0AAPI: =0Are=
ceived =0ABT_SETCONFIGURATION_REQ=0Aaudio[21835]: =0Aconfig =0Asbc =0A- =0A=
frequency =0A=3D =0A0 =0Achannel_mode =0A=3D=0A0 =0Aallocation =0A=3D =0A0 =
=0Asubbands =0A=3D =0A0 =0Ablocks =0A=3D =0A0 =0Abitpool =0A=3D =0A0=0Aaudi=
o[21835]: =0AState =0Achanged =0A/org/bluez/audio/device0:=0AHEADSET_STATE_=
DISCONNECTED =0A-> =0AHEADSET_STATE_CONNECT_IN_PROGRESS=0ANetworkManager: =
=0A<debug> =0A[1203182486.201530]=0Anm_hal_device_added(): =0ANew =0Adevice=
 =0Aadded =0A(hal =0Audi =0Ais=0A'/org/freedesktop/Hal/devices/bluetooth_ac=
l_5a10800b1').=0Ahcid[21832]: =0Alink_key_request =0A(sba=3D00:18:F3:8D:A3:=
67,=0Adba=3D00:05:A1:08:00:B1)=0Aaudio[21835]: =0A/org/bluez/audio/device0:=
 =0AConnecting =0Ato=0A00:05:A1:08:00:B1 =0Achannel =0A1=0Aaudio[21835]: =
=0AState =0Achanged =0A/org/bluez/audio/device0:=0AHEADSET_STATE_CONNECT_IN=
_PROGRESS =0A-> =0AHEADSET_STATE_CONNECTED=0Aaudio[21835]: =0A/org/bluez/au=
dio/device0: =0AConnected =0Ato=0A00:05:A1:08:00:B1=0Aaudio[21835]: =0AStat=
e =0Achanged =0A/org/bluez/audio/device0:=0AHEADSET_STATE_CONNECTED =0A-> =
=0AHEADSET_STATE_PLAY_IN_PROGRESS=0ANetworkManager: =0A<debug> =0A[12031824=
89.924061]=0Anm_hal_device_added(): =0ANew =0Adevice =0Aadded =0A(hal =0Aud=
i =0Ais=0A'/org/freedesktop/Hal/devices/bluetooth_acl_ffffffffffffffff').=
=0Ahci_scodata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown=0Aconnect=
ion =0Ahandle =0A45=0Ahci_scodata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =
=0Aunknown=0Aconnection =0Ahandle =0A45=0Ahci_scodata_packet: =0Ahci0 =0ASC=
O =0Apacket =0Afor =0Aunknown=0Aconnection =0Ahandle =0A45=0A........=0A=0A=
force_scofix=3D1 =0Adoesn't =0Ahelp.=0A=0AAny =0Ahints?=0A=0A-- =0ASincerel=
y,=0AVladimir =0A"Farcaller" =0APouzanov  =0A  =0A  =0A  =0A  =0A  =0A  =0A=
  =0A  =0A  =0A =0AHack&Dev =0ATeam=0APGP/GPG: =0A0x3A40FF29  =0A  =0A  =0A=
  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A =0A<http://hackndev.com>=0AFingerp=
rint: =0AFA36 =0A877A =0A2DC3 =0AB56F =0ACAB5  =0A7DB3 =0A4C97 =0AA596 =0A3=
A40 =0AFF29=0A=0A=0A-----Inline Attachment Follows-----=0A=0A--------------=
-----------------------------------------------------------=0AThis =0ASF.ne=
t =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft=0ADefy =0Aall =0Achalleng=
es. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.=0Ahttp://clk.atdmt.com/MRT=
/go/vse0120000070mrt/direct/01/=0A=0A=0A-----Inline Attachment Follows-----=
=0A=0A_______________________________________________=0ABluez-users =0Amail=
ing =0Alist=0ABluez-users@lists.sourceforge.net=0Ahttps://lists.sourceforge=
.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=0A=0A=0A=0A      Why delete =
messages? Unlimited storage is just a click away. Go to http://help.yahoo.c=
om/l/in/yahoo/mail/yahoomail/tools/tools-08.html
--0-1575237811-1203306932=:8393
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi <br>Same problem here<br> =0AFeb =0A13 =0A09:52:43 =0Alo=
calhost =0Akernel: =0Ahci_scodata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =
=0Aunknown =0Aconnection =0Ahandle =0A1<br>No sound on HS, But I can record=
 my voice through HS.<br>this is my hciconfig&nbsp;&nbsp;  <br>[root@localh=
ost =0APramod]# =0A/usr/local/sbin/hciconfig =0A-a<br>-&gt; =0Ahci0:&nbsp; =
=0A =0AType: =0AUSB<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ABD =
=0AAddress: =0A00:02:72:CE:5B:80 =0AACL =0AMTU: =0A1017:8 =0A<span style=3D=
"text-decoration: underline; font-style: italic; font-weight: bold;">SCO =
=0AMTU: =0A64:0</span><br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A=
UP =0ARUNNING =0APSCAN =0AISCAN<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp=
; =0A =0ARX =0Abytes:5057856 =0Aacl:233 =0Asco:99008 =0Aevents:218 =0Aerror=
s:0<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ATX =0Abytes:4708 =
=0Aacl:165 =0Asco:0 =0Acommands:102 =0Aerrors:0<br>-&gt;&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A =0AFeatures: =0A0xff =0A0xff =0A0x8d =0A0xfe =0A0x9=
b =0A0xf9 =0A0x00 =0A0x80<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =
=0APacket =0Atype: =0ADM1 =0ADM3 =0ADM5 =0ADH1 =0ADH3 =0ADH5 =0AHV1 =0AHV2 =
=0AHV3<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0ALink =0Apolicy: =
=0ARSWITCH =0AHOLD =0ASNIFF =0APARK<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&=
nbsp; =0A =0ALink =0Amode: =0ASLAVE =0AACCEPT<br>-&gt;&nbsp; =0A&nbsp; =0A&=
nbsp; =0A&nbsp; =0A =0AName: =0A'BlueZ =0A(0)'<br>-&gt;&nbsp; =0A&nbsp; =0A=
&nbsp; =0A&nbsp; =0A =0AClass: =0A0x080000<br>-&gt;&nbsp; =0A&nbsp; =0A&nbs=
p; =0A&nbsp; =0A =0AService =0AClasses: =0ACapturing<br>-&gt;&nbsp; =0A&nbs=
p; =0A&nbsp; =0A&nbsp; =0A =0ADevice =0AClass: =0AMiscellaneous,<br>-&gt;&n=
bsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0AHCI =0AVer: =0A2.0 =0A(0x3) =0AHC=
I =0ARev: =0A0x204d =0ALMP =0AVer: =0A2.0 =0A(0x3) =0ALMP =0ASubver: =0A0x4=
127<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0AManufacturer: =0ABr=
oadcom =0ACorporation =0A(15)<br><div>&nbsp;<br><span style=3D"text-decorat=
ion: underline; font-style: italic; font-weight: bold;">SCO =0AMTU: =0A64:0=
<br><span style=3D"font-weight: bold;"><span style=3D"font-style: italic;">=
<span style=3D"text-decoration: underline;"><span style=3D"text-decoration:=
 underline;"><span style=3D"font-style: italic;"><span style=3D"font-weight=
: bold;"><br></span></span></span></span></span></span></span>is this same =
for ur adapter too. <span style=3D"text-decoration: underline; font-style: =
italic; font-weight: bold;"><span style=3D"font-weight: bold;"><span style=
=3D"font-style: italic;"><span style=3D"text-decoration: underline;"><span =
style=3D"text-decoration: underline;"><span style=3D"font-style: italic;"><=
span style=3D"font-weight: bold;"><br></span></span></span></span></span></=
span><br></span></div>Thanks and Best regards<div>&nbsp;</div><div>Pramod<d=
iv style=3D"font-family: times new roman,new york,times,serif; font-size: 1=
2pt;"><br><br><div style=3D"font-family: times new roman,new york,times,ser=
if; font-size: 12pt;">----- Original Message ----<br>From: Vladimir Pouzano=
v
 &lt;farcaller@gmail.com&gt;<br>To: bluez-users@lists.sourceforge.net<br>Se=
nt: Saturday, 16 February, 2008 11:20:38 PM<br>Subject: [Bluez-users] BT he=
adset doesn't work: SCO packet for unknown connection<br><br>I've =0Agot =
=0A2.6.24 =0Awith =0Abluez =0Alibs/utils =0A3.25<br><br>I =0Ahave =0Asucces=
sfully =0Apaired =0Amy =0Aheadset =0Aand =0APC, =0AI =0Acan =0Al2ping =0Ait=
 =0Aand =0Aget =0Ainfo.<br>As =0Asoon =0Aas =0AI =0Atry =0Ato =0Aplay =0Aso=
me =0Aaudio =0A(via =0Amplayer) =0AI =0Aget =0Athe =0Afollowing =0Ain =0Ath=
e<br>logs:<br><br>audio[21835]: =0ARegistered =0Amanager =0Apath:/org/bluez=
/audio<br>audio[21835]: =0ALoading =0Adevice =0A00:05:A1:08:00:B1 =0A(heads=
et =0A)<br>audio[21835]: =0AGot =0Apath =0A/org/bluez/hci0 =0Afor =0Aadapte=
r =0Awith<br>address =0A00:18:F3:8D:AF:67<br>audio[21835]: =0ASelecting =0A=
default =0Adevice<br>audio[21835]: =0ASetting =0A00:05:A1:08:00:B1 =0Aas =
=0Adefault =0Adevice<br>audio[21835]: =0AAccepted =0Anew =0Aclient =0Aconne=
ction =0Aon =0Aunix<br>socket =0A(fd=3D9)<br>audio[21835]: =0AAudio =0AAPI:=
 =0Areceived =0ABT_GETCAPABILITIES_REQ<br>audio[21835]: =0AAudio =0AAPI: =
=0Asending =0ABT_GETCAPABILITIES_RSP<br>audio[21835]: =0AAudio =0AAPI: =0Ar=
eceived =0ABT_SETCONFIGURATION_REQ<br>audio[21835]: =0Aconfig =0Asbc =0A- =
=0Afrequency =0A=3D =0A0 =0Achannel_mode =0A=3D<br>0 =0Aallocation =0A=3D =
=0A0 =0Asubbands =0A=3D =0A0 =0Ablocks =0A=3D =0A0 =0Abitpool =0A=3D =0A0<b=
r>audio[21835]: =0AState =0Achanged =0A/org/bluez/audio/device0:<br>HEADSET=
_STATE_DISCONNECTED =0A-&gt; =0AHEADSET_STATE_CONNECT_IN_PROGRESS<br>Networ=
kManager: =0A&lt;debug&gt; =0A[1203182486.201530]<br>nm_hal_device_added():=
 =0ANew =0Adevice =0Aadded =0A(hal =0Audi =0Ais<br>'/org/freedesktop/Hal/de=
vices/bluetooth_acl_5a10800b1').<br>hcid[21832]: =0Alink_key_request =0A(sb=
a=3D00:18:F3:8D:A3:67,<br>dba=3D00:05:A1:08:00:B1)<br>audio[21835]: =0A/org=
/bluez/audio/device0: =0AConnecting =0Ato<br>00:05:A1:08:00:B1 =0Achannel =
=0A1<br>audio[21835]: =0AState =0Achanged =0A/org/bluez/audio/device0:<br>H=
EADSET_STATE_CONNECT_IN_PROGRESS =0A-&gt; =0AHEADSET_STATE_CONNECTED<br>aud=
io[21835]: =0A/org/bluez/audio/device0: =0AConnected =0Ato<br>00:05:A1:08:0=
0:B1<br>audio[21835]: =0AState =0Achanged =0A/org/bluez/audio/device0:<br>H=
EADSET_STATE_CONNECTED =0A-&gt; =0AHEADSET_STATE_PLAY_IN_PROGRESS<br>Networ=
kManager: =0A&lt;debug&gt; =0A[1203182489.924061]<br>nm_hal_device_added():=
 =0ANew =0Adevice =0Aadded =0A(hal =0Audi =0Ais<br>'/org/freedesktop/Hal/de=
vices/bluetooth_acl_ffffffffffffffff').<br>hci_scodata_packet: =0Ahci0 =0AS=
CO =0Apacket =0Afor =0Aunknown<br>connection =0Ahandle =0A45<br>hci_scodata=
_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown<br>connection =0Ahandle=
 =0A45<br>hci_scodata_packet: =0Ahci0 =0ASCO =0Apacket =0Afor =0Aunknown<br=
>connection =0Ahandle =0A45<br>........<br><br>force_scofix=3D1 =0Adoesn't =
=0Ahelp.<br><br>Any =0Ahints?<br><br>-- <br>Sincerely,<br>Vladimir =0A"Farc=
aller" =0APouzanov&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0AHack&amp;Dev =0ATeam<br>PGP/=
GPG: =0A0x3A40FF29&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A&lt;<a href=3D"htt=
p://hackndev.com" target=3D"_blank">http://hackndev.com</a>&gt;<br>Fingerpr=
int: =0AFA36 =0A877A =0A2DC3 =0AB56F =0ACAB5&nbsp; =0A7DB3 =0A4C97 =0AA596 =
=0A3A40 =0AFF29<br><!-- kill --><div><br><br>-----Inline Attachment Follows=
-----<br><br>--------------------------------------------------------------=
-----------<br>This =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicroso=
ft<br>Defy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A200=
8.<br><a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" t=
arget=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a=
></div><!-- kill --><div><br><br>-----Inline Attachment Follows-----<br><br=
>_______________________________________________<br>Bluez-users =0Amailing =
=0Alist<br><a ymailto=3D"mailto:Bluez-users@lists.sourceforge.net" href=3D"=
mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net=
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-user=
s</a><br></div></div><br></div></div></div><br>=0A=0A=0A      <!--4--><hr s=
ize=3D1></hr> Forgot the famous last words? Access your message archive onl=
ine. <a href=3D"http://in.rd.yahoo.com/tagline_webmessenger_4/*http://in.me=
ssenger.yahoo.com/webmessengerpromo.php">Click here.</a></body></html>
--0-1575237811-1203306932=:8393--


--===============0663696462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0663696462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0663696462==--
