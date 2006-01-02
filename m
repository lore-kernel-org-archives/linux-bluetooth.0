Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-users] SDP problem w/ WM 5 PDA BT stack
Message-ID: <4B7168B4A1DDAE4C97D38B93A8450A188DD21C@WEXMBGBWI001001.corp.internal.symbol.com>
From: "Martinez, JuanAntonio" <JuanAntonio.Martinez@symbol.com>
To: <bluez-users@lists.sourceforge.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 2 Jan 2006 11:38:17 -0000

Hi,

So,=20when=20you=20say=20"This=20is=20valid=20transaction,=20but=20we=20si=
mply
don't=20handle=20this=20correctly."=20do=20you=20mean=20this=20will=20even=
tually=20be=20fixed?

Thanks=20in=20advance
Best=20regards


-----Mensaje=20original-----
De:=20bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net]=20En=20nombre=20de=20Marc=
el
Holtmann
Enviado=20el:=20lunes,=2002=20de=20enero=20de=202006=2012:27
Para:=20bluez-users@lists.sourceforge.net
Asunto:=20Re:=20[Bluez-users]=20SDP=20problem=20w/=20WM=205=20PDA=20BT=20s=
tack

Hi,

>=20We=20have=20a=20problem=20when=20trying=20to=20connect=20a=20certain=20=
WM=205=20PDA=20to=20a=20Linux
>=20box=20(RedHat=209,=20kernel=202.4.20,=20properly=20patched)=20using=20=
the=20ad-hoc=20RPMs.
>=20
>=20This=20PDA=20uses=20SS1=20(Stone=20Street=201)=20BT=20stack=20instead=20=
of=20MS's.
>=20
>=20Linux=20box=20properly=20initiates=20all=20of=20the=20daemons=20and=20=
modules,=20then=20SP
>=20(Serial=20Port)=20is=20added=20("sdptool=20add=20SP"),=20since=20PDA=20=
should=20detect
>=20this=20service.
>
>=20>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2036
>=20
>=20=20=20=20=20L2CAP(d):=20cid=200x40=20len=2032=20[psm=201]
>=20=20=20=20=20=20=20=20=20SDP=20SSA=20Req:=20tid=200x0=20len=200x1b
>=20=20=20=20=20=20=20=20=20=20=20pat=20uuid-16=200x0100=20(L2CAP)
>=20=20=20=20=20=20=20=20=20=20=20max=200x7e8
>=20=20=20=20=20=20=20=20=20=20=20aid(s)=200x0001=20(SrvClassIDList)=200x0=
004=20(ProtocolDescList)
>=200x0009=20(BTProfileDescList)=200x000d=20(IconURL)=200x0100=20-=200xfff=
f
>=20=20=20=20=20=20=20=20=20=20=20cont=2000=20

I=20have=20seen=20this=20problem=20before,=20when=20I=20helped=20debugging=
=20the=20Blooover=20II
application.=20This=20stack=20combines=20a=20list=20of=20attributes=20and=20=
a=20range=20of
attributes=20in=20the=20same=20request.=20This=20is=20valid=20transaction,=
=20but=20we=20simply
don't=20handle=20this=20correctly.

Regards

Marcel




-------------------------------------------------------
This=20SF.net=20email=20is=20sponsored=20by:=20Splunk=20Inc.=20Do=20you=20=
grep=20through=20log
files
for=20problems?=20=20Stop!=20=20Download=20the=20new=20AJAX=20search=20eng=
ine=20that=20makes
searching=20your=20log=20files=20as=20easy=20as=20surfing=20the=20=20web.=20=
=20DOWNLOAD=20SPLUNK!
http://ads.osdn.com/?ad_idv37&alloc_id=16865&op=3Dclick
_______________________________________________
Bluez-users=20mailing=20list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

________________________________________________________________________
This=20email=20has=20been=20scanned=20for=20computer=20viruses.

________________________________________________________________________
This=20email=20has=20been=20scanned=20for=20computer=20viruses.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
