Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Subject: RE: [Bluez-devel] Qualification - L2CA_DisconnectCfm
Date: Mon, 12 May 2003 15:43:25 -0700
Message-ID: <000701c318d7$e6598e90$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <000a01c31687$c06757a0$1a01010a@baked>
List-ID: <bluez-devel.lists.sourceforge.net>

Max, Marcel,

What happens when you close an L2CAP connection?

There is a test (see below) where the IUT sends an L2CAP disconnect request
but the tester ignores it (doesn't send a disconnect response). To pass the
test we must at least show an "L2CAP_DisconnectCfm" to the application.
Indicating that a timeout ocurred is optional.

What happens if the remote side doesn't respond with a disconnect confirm?
Will the stack wait 60 seconds and then close the link anyway? Or will it
close it immediately and not even look for a diconnect confirm? Will close(=
)
return success?

Thanks,

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net=20
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
> Daryl Van Vorst
> Sent: May 9, 2003 5:05 PM
> To: BlueZ Mailing List
> Subject: [Bluez-devel] Qualification - L2CA_DisconnectCfm
>=20
>=20
> Max, Marcel,
>=20
> In order to pass TP/COS/CED/BV-08 we're supposed to be able=20
> to indicate that there was a timeout waiting for an L2CAP=20
> disconnect confirm from the remote device. I'm waiting for=20
> clarification that this is indeed necessary.
>=20
> The test works like this:
>=20
> 1. We send a disconnect request
> 2. The tester ignores it.
> 3. optionally - we resend the disconnect request following a=20
> timeout pattern where each retransmission happens after a=20
> delay equal to twice the previous delay. 4. After 60 seconds=20
> the channel must be closed - we indicated to the app that the=20
> channel is indeed closed (even though we didn't get a=20
> confirmation from the remote side) and indicate that a=20
> timeout ocurred.
>=20
> I think there's a standard way of doing that sort of thing by=20
> setting a socket option which causes close() to block until=20
> things are closed. Not sure though.
>=20
> Can we do this with BlueZ?
>=20
> -Daryl.
>=20
>=20
>=20
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003,=20
> Santa Clara The only event dedicated to issues related to=20
> Linux enterprise solutions www.enterpriselinuxforum.com
>=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net=20
> https://lists.sourceforge.net/lists/listinfo/b> luez-devel
>=20
