Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>, "'MaxKrasnyansky'" <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification - L2CA_DisconnectCfm
Date: Mon, 12 May 2003 17:11:27 -0700
Message-ID: <000d01c318e4$32a57460$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1052783343.1132.159.camel@pegasus.local>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

The behaviour you list below makes sense to me. I think there's supposed to
be a 60 second timeout instead of 5 seconds, but that seems a bit excessive
to me. Does it matter? If we close L2CAP and then the remote side sends an
L2CAP_DISCONN_RSP, does the fact that we've already closed the channel caus=
e
any different packets to be exchanged?

The only advantage that I see in the capability of a blocking close is
completeness. I can't think of a scenario where it really matters, but you
never know what someone will cook up.

I don't believe the application actually needs to know that the
disconnection was normal, just that it has definitely been disconnected. I'=
m
a little fuzzy on the definition of "disconnected". Telling the app that
there was a timeout is optional.

If the stack closing the L2CAP connection and then receiving an
L2CAP_DISCONN_RSP afterwards does not cause any different traffic to occurr
(ie: the remote side can't tell the difference), then we're probably ok. Is
this true?  Then the only difference between what we do and what the spec
says is _when_ the "L2CA_DisconnectCfm" gets sent to the app. In our case,
it would be immediately (i.e.: close() returned success). In the test case,
it is 60 seconds after sending the disconnect request.

-Daryl.

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@rvs.uni-bielefeld.de]=20
> Sent: May 12, 2003 4:49 PM
> To: Daryl Van Vorst
> Cc: 'BlueZ Mailing List'; 'MaxKrasnyansky'
> Subject: RE: [Bluez-devel] Qualification - L2CA_DisconnectCfm
>=20
>=20
> Hi Daryl,
>=20
> > What happens when you close an L2CAP connection?
>=20
> if you close() the L2CAP connection, we send a=20
> L2CAP_DISCONN_REQ and set a timeout of 5 seconds. In the case=20
> of L2CAP_DISCONN_RSP or the timeout, we close the L2CAP channel.
>=20
> Max, please correct me if this is wrong, because I am not 100% sure.
>=20
> > There is a test (see below) where the IUT sends an L2CAP disconnect=20
> > request but the tester ignores it (doesn't send a disconnect=20
> > response). To pass the test we must at least show an=20
> > "L2CAP_DisconnectCfm" to the application. Indicating that a timeout=20
> > ocurred is optional.
>=20
> I don't understand why the application needs to now if the=20
> L2CAP channel is correctly disconnected? We close the L2CAP=20
> socket and the rest has to be done by the kernel. If the link=20
> is dead and the other side didn't response, waiting 60=20
> seconds won't help. Or did you see any advantage of a=20
> blocking close()?
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
