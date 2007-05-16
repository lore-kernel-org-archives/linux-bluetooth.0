Return-Path: <l.t.gao@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Report a bug against "l2cap_conf_output()" in"net/bluetooth/l2cap.c"
Date: Wed, 16 May 2007 09:40:22 +0800
Message-ID: <36BC62FC45C4E949B13C20DEFA8617D5054D2D29@zmy16exm62.ds.mot.com>
References: <AF7E222731C6614DAB496712B5768F2401EB332C@ct11exm65.ds.mot.com>   
From: "GAO LIANG-TAO-W20048" <l.t.gao@motorola.com>
Cc: <bluez-devel@lists.sourceforge.net>, <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>


Hi Marcel,

Are you simply ignoring my "bug" report? Dislike my email?

It's not an easy talk with you. I'm afraid my membership will be wrongly
disabled again after this email.

Regards,
Gao

-----Original Message-----
From: GAO LIANG-TAO-W20048=20
Sent: Tuesday, May 15, 2007 6:55 PM
To: bluez-devel@lists.sourceforge.net
Subject: RE: [Bluez-devel] Report a bug against "l2cap_conf_output()"
in"net/bluetooth/l2cap.c"

Hi Marcel,

Sorry for getting back late.

I think you omitted the local outgoing MTU. The original code will
enlarge the outgoing MTU value, but the Bluetooth SPEC expects a minimum
of the MTU in the config request and the local outgoing MTU.

For example, if Device B starts an L2CAP service with incoming MTU 512,
and an L2CAP client on Device A claiming an outgoing MTU 53 tries to
connect to the service; the service on B sends configuration request to
the BlueZ stack on A with MTU 512, then A shall sends back a positive
response to B with the MTU 53 (not 512 as BlueZ actually does). In fact
this example is from a JSR82 MTU test case.

Here's the whole paragraph in page 1038 (of the total 1230) in Bluetooth
SPEC Core_v2.0_EDR.pdf:
"If the remote device sends a positive configuration response it shall
include the actual MTU to be used on this channel for traffic flowing
into the local device. This is the minimum of the MTU in the
configuration request and the outgoing MTU capability of the device
sending the configuration response. The new agreed value (the default
value in a future re-configuration) is the value specified in the
request."

My understanding is that the MTU can be increased in no cases. Please
let me know your consideration of this paragraph.

Thanks
Gao Liangtao


-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Friday, May 04, 2007 1:56 AM
To: BlueZ development
Cc: Singer Catherine-CSINGER1; Jin Hong-Lei-W19971; Saeed Faisal-EFS015
Subject: Re: [Bluez-devel] Report a bug against "l2cap_conf_output()"
in"net/bluetooth/l2cap.c"

Hi,

>=20
> I want to report a bug against "l2cap_conf_output()" in BlueZ kernel=20
> code "net/bluetooth/l2cap.c":
>=20
>     if (pi->conf_mtu < pi->omtu) {
>=20
>        l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);
>=20
>        result =3D L2CAP_CONF_UNACCEPT;
>=20
>     } else {
>=20
>        pi->omtu =3D pi->conf_mtu;
>=20
>     }
>=20
> I think it's wrong to enlarge the outgoing MTU value (by calling=20
> "pi->omtu =3D pi->conf_mtu") when device B gets the MTU in device A's=20
> configuration request. In fact, Page 1006/1200 of Bluetooth SPEC v1.2=20
> or Page 1038/1230 of Bluetooth SPEC v2.0 EDR both require a minimum of

> the  "If the remote device sends a positive configuration response it=20
> shall include the actual MTU to be used on this channel for traffic=20
> flowing into the local device. This is the minimum of the MTU in the=20
> configuration request and the outgoing MTU capability of the device=20
> sending the configuration response." Here I consider the original=20
> "pi->omtu" as the "outgoing MTU capability".

I need more details from you, because I don't see the issue here. The
MTUs (output + input) for L2CAP are negotiated in both directions.

Regards

Marcel
