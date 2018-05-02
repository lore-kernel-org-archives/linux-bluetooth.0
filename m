Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [PATCH] src/device.c : Fix BREDR-ATT MTU issue
Reply-To: nagaraj.dr@samsung.com
From: Nagaraj D R <nagaraj.dr@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        SYAM SIDHARDHAN <s.syam@samsung.com>
In-Reply-To: <CABBYNZ++cdKY256edfNkMU6tsaccRrqg6eN9scdTK5m8t2Okxw@mail.gmail.com>
Message-ID: <20180502121827epcms5p6a7927635ac30d7f3cacb0e1d9ccfe467@epcms5p6>
Date: Wed, 02 May 2018 17:48:27 +0530
Content-Type: text/plain; charset="utf-8"
References: <CABBYNZ++cdKY256edfNkMU6tsaccRrqg6eN9scdTK5m8t2Okxw@mail.gmail.com>
        <1525248985-10990-1-git-send-email-nagaraj.dr@samsung.com>
        <CGME20180502081635epcas2p170eb2b4ed9336425921119b66e554fef@epcms5p6>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz
=C2=A0=0D=0ASender=20:=20Luiz=20Augusto=20von=20Dentz=C2=A0<luiz.dentz=40gm=
ail.com>=0D=0A>Hi=C2=A0Nagaraj,=0D=0A>On=C2=A0Wed,=C2=A0May=C2=A02,=C2=A020=
18=C2=A0at=C2=A011:40=C2=A0AM=C2=A0Nagaraj=C2=A0D=C2=A0R=C2=A0<nagaraj.dr=
=40samsung.com>=C2=A0wrote:=0D=0A=C2=A0=0D=0A>>=C2=A0For=C2=A0BREDR-ATT,=C2=
=A0according=C2=A0to=C2=A0spec,=C2=A0ATT=C2=A0MTU=C2=A0is=C2=A0same=C2=A0ha=
s=0D=0A>>=C2=A0L2CAP=C2=A0configured=C2=A0MTU=C2=A0on=C2=A0which=C2=A0ATT=
=C2=A0is=C2=A0running.=C2=A0So,=C2=A0set=C2=A0the=C2=A0MTU=C2=A0to=0D=0A>>=
=C2=A0L2CAP=C2=A0configuration=C2=A0and=C2=A0for=C2=A0LE-ATT=C2=A0adjust=C2=
=A0the=C2=A0ATT=C2=A0MTU=C2=A0based=C2=A0on=0D=0A>>=C2=A0EXCHANGE_MTU=C2=A0=
request=C2=A0and=C2=A0response.=0D=0A>>=C2=A0---=0D=0A>>=C2=A0=C2=A0=C2=A0s=
rc/device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=7C=C2=A02=C2=A0+-=0D=0A>>=C2=A0=C2=A0=C2=A0src/shared=
/gatt-helpers.c=C2=A0=7C=C2=A01=C2=A0+=0D=0A>>=C2=A0=C2=A0=C2=A02=C2=A0file=
s=C2=A0changed,=C2=A02=C2=A0insertions(+),=C2=A01=C2=A0deletion(-)=0D=0A=C2=
=A0=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/src/device.c=C2=A0b/src/device.c=0D=
=0A>>=C2=A0index=C2=A0f693b70..cf4c8df=C2=A0100644=0D=0A>>=C2=A0---=C2=A0a/=
src/device.c=0D=0A>>=C2=A0+++=C2=A0b/src/device.c=0D=0A>>=C2=A0=40=40=C2=A0=
-4922,7=C2=A0+4922,7=C2=A0=40=40=C2=A0bool=C2=A0device_attach_att(struct=C2=
=A0btd_device=C2=A0*dev,=0D=0AGIOChannel=C2=A0*io)=0D=0A>>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A=C2=A0=0D=0A>>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->att_mtu=C2=A0=3D=
=C2=A0MIN(mtu,=C2=A0BT_ATT_MAX_LE_MTU);=0D=0A>>=C2=A0-=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0attrib=C2=A0=3D=C2=A0g_attrib_new(io,=C2=A0BT_ATT_DEFA=
ULT_LE_MTU,=C2=A0false);=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0attrib=C2=A0=3D=C2=A0g_attrib_new(io,=C2=A0dev->att_mtu,=C2=A0false);=
=0D=0A=C2=A0=0D=0A>This=C2=A0would=C2=A0actually=C2=A0undo=C2=A0the=C2=A0fo=
llowing=C2=A0patch:=0D=0A=C2=A0=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0src/dev=
ice:=C2=A0Use=C2=A0BT_ATT_DEFAULT_LE_MTU=C2=A0as=C2=A0default=C2=A0MTU=0D=
=0A=C2=A0=0D=0A>=C2=A0=C2=A0=C2=A0Use=C2=A0the=C2=A0default=C2=A0MTU=C2=A0u=
ntil=C2=A0an=C2=A0MTU=C2=A0exchange=C2=A0has=C2=A0taken=C2=A0place=C2=A0and=
=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0something=C2=A0else=C2=A0has=C2=A0been=
=C2=A0negotiated.=C2=A0If=C2=A0either=C2=A0side=C2=A0does=C2=A0not=C2=A0sup=
port=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0MTU=C2=A0exchange,=C2=A0the=C2=A0connect=
ion=C2=A0shall=C2=A0continue=C2=A0to=C2=A0use=C2=A0this=C2=A0default=0D=0A>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value=C2=A0instead=C2=A0of=C2=A0the=C2=A0devi=
ce=C2=A0maximum=C2=A0which=C2=A0was=C2=A0the=C2=A0previous=C2=A0behavior.=
=0D=0A=C2=A0=0D=0A>We=C2=A0should=C2=A0probably=C2=A0check=C2=A0if=C2=A0the=
=C2=A0cid=C2=A0is=C2=A0for=C2=A0LE=C2=A0or=C2=A0not=C2=A0and=C2=A0reset=C2=
=A0mtu=C2=A0to=0D=0A>BT_ATT_DEFAULT_LE_MTU=C2=A0that=C2=A0way=C2=A0att_mtu=
=C2=A0should=C2=A0be=C2=A0valid=C2=A0for=C2=A0either=C2=A0LE=C2=A0or=0D=0A>=
BR/EDR.=0D=0A=0D=0AI=20agree,=20we=20should=20check=20for=20CID.=0D=0AIf=20=
it=20is=20BREDR-ATT=20connection=20only=20then=20consider=20L2CAP=20MTU=20o=
therwise=0D=0Aset=20the=20MTU=20to=20min=20value=20and=20set=20it=20through=
=20ATT_MTU=20exchange.=0D=0A=C2=A0=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21attrib)=C2=A0=7B=0D=0A>>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0error(=22Unable=C2=A0to=C2=A0create=C2=A0new=C2=A0GAtt=
rib=C2=A0instance=22);=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0=
false;=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/src/shared/gatt-helpers.c=C2=A0b=
/src/shared/gatt-helpers.c=0D=0A>>=C2=A0index=C2=A06b39bb1..8ec65be=C2=A010=
0644=0D=0A>>=C2=A0---=C2=A0a/src/shared/gatt-helpers.c=0D=0A>>=C2=A0+++=C2=
=A0b/src/shared/gatt-helpers.c=0D=0A>>=C2=A0=40=40=C2=A0-517,6=C2=A0+517,7=
=C2=A0=40=40=C2=A0static=C2=A0void=C2=A0mtu_cb(uint8_t=C2=A0opcode,=C2=A0co=
nst=C2=A0void=C2=A0*pdu,=0D=0Auint16_t=C2=A0length,=0D=0A>>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(opcode=C2=A0=3D=3D=C2=
=A0BT_ATT_OP_ERROR_RSP)=C2=A0=7B=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
success=C2=A0=3D=C2=A0false;=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0att_ec=
ode=C2=A0=3D=C2=A0process_error(pdu,=C2=A0length);=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0bt_att_set_mtu(op->att,=C2=A0BT_ATT_DEFAULT_LE_MTU);=0D=0A=C2=A0=0D=
=0A>I=C2=A0not=C2=A0following=C2=A0this=C2=A0one,=C2=A0we=C2=A0only=C2=A0re=
ally=C2=A0use=C2=A0bt_att_set_mtu=C2=A0if=C2=A0the=C2=A0command=0D=0A>succe=
eds=C2=A0so=C2=A0this=C2=A0should=C2=A0not=C2=A0be=C2=A0necessary,=C2=A0or=
=C2=A0this=C2=A0is=C2=A0due=C2=A0Exchange=C2=A0being=0D=0A>used=C2=A0multip=
le=C2=A0times?=C2=A0I=C2=A0recall=C2=A0the=C2=A0spec=C2=A0not=C2=A0allowing=
=C2=A0that=C2=A0to=C2=A0happen,=C2=A0and=C2=A0if=0D=0A>does=C2=A0Im=C2=A0no=
t=C2=A0sure=C2=A0why=C2=A0we=C2=A0would=C2=A0have=C2=A0to=C2=A0return=C2=A0=
to=C2=A0the=C2=A0default=C2=A0instead=C2=A0of=C2=A0the=0D=0A>value=C2=A0pre=
viously=C2=A0set=C2=A0in=C2=A0case=C2=A0the=C2=A0of=C2=A0error=C2=A0respons=
e.=0D=0A=0D=0AThis=20change=20was=20in=20connection=20with=20my=20proposed=
=20change.=0D=0Ai.e=20We=20set=20the=20MTU=20to=20L2CAP-MTU=20(for=20both=
=20LE-ATT=20and=20BREDR-ATT)=0D=0AIn=20case=20of=20LE-ATT,=20if=20remote=20=
does=20not=20support=20the=20ATT-MTU=20exchange=20procedure,=0D=0Athen=20it=
=20will=20return=20=22BT_ATT_OP_ERROR_RSP=22=20and=20we=20will=20fall=20bac=
k=20to=20default-MTU=0D=0A=0D=0AWith=20CID=20check=20that=20you=20advised,=
=20this=20change=20won't=20be=20necessary.=20=0D=0A=C2=A0=0D=0A=C2=A0=0D=0A
