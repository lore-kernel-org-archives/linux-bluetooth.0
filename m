Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Thu, 29 May 2003 15:51:22 -0700
Message-ID: <001b01c32634$d3cd5530$1a01010a@baked>
MIME-Version: 1.0
In-Reply-To: <5.1.0.14.2.20030519141834.0951b330@unixmail.qualcomm.com>
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

Here's where we're at with this one:  We either need to pass this test, or
issue an erratum. Issuing an erratum is going to be a very time-consuming
task and we can't be certain of the outcome.

About the only scenario we could come up with where this makes any sense at
all is if the remote device wants to send data larger than the default MTU
of 672, and the local application doesn't specifically tell the stack that
it can handle a larger MTU before calling connect().  Is it in our interest
to handle this?

Is it possible to give the app control during the CONFIG state so that it
can do the negotiation with the remote side? Am I correct in assuming that
as it is now the app only gets control once we enter the OPEN state?

The original test MSC (Message Sequence Chart) showed the application
sending L2CA_ConfigReq to the top end of the stack and the stack sending
L2CAP_ConfigReq to the remote device. The L2CAP_ConfigReq was also sent up
to the application as L2CA_ConfigCfm (with status=3Dreject and the values t=
hat
the remote device wants to see). It was then up to the app to send another
L2CA_ConfigReq to the stack to be forwarded to the remote device. The MSC
was later updated to remove the involvement of the application, but the sam=
e
reject-then-re-request sequence is there.

Perhaps we could put in a "hack" (if we're going to call it that) which
allows us to pass the test. We could, at the same time, write up an errata
requesting that this test be optional or changed so that we would pass the
test without the "hack". Once the erratum is accepted, we could remove the
hack.

Is there any chance that you could make this change?  Or, if not, could you
help me determine where in the code to do it? The behaviour that would make
it pass is as follows:

1. We send a config request.
2. We get a config response rejecting our request which contains the
tester's desired values.
3. We re-send the config request with those values (the tester will accept
this request).
4. At this point if the config request is not accepted we can close the lin=
k
like we would normally.

Maybe we could add a setsockopt() l2cap option like LM_FLEXIBLEINMTU to tur=
n
on this behaviour (not sure if making it optional will pass - I'll check).

Apparently, in step 3 above, if we send a config request with no options it
will also pass the test. How silly is that? (specially considering that's
what we send by default in the first place!)

-Daryl.


> -----Original Message-----
> From: Max Krasnyansky [mailto:maxk@qualcomm.com]=20
> Sent: May 19, 2003 2:19 PM
> To: Daryl Van Vorst; 'Marcel Holtmann'
> Cc: 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] Qualification Testing
>=20
>=20
> At 11:01 AM 5/16/2003, Daryl Van Vorst wrote:
> >Max,
> >
> >> >> I sent the above quote to Cetecom last week. They=20
> responded saying=20
> >> >> that MTU isn't the only negotiated parameter.
> >>=20
> >> FlushTO _must_ be 0xffff for reliable ACL link. So far none
> >> of the profiles specified use of unreliable links.=20
> >>=20
> >> Support for QOS is totally optional. We're only required to
> >> support 'best effort'. Which means that even if they want=20
> >> something other than 'best effort' (i.e. they reject=20
> >> default settings) we won't be able to accept it simply=20
> >> because we don't support it.
> >>=20
> >> So I'm not sure what can be negotiated there.
> >
> >Ok. I'll see what they say about that too.
> >
> >> btw Can this fancy Merlin viewer export trace in plain text ?
> >> I'm too lazy to install that stuff. And it looks like I=20
> need to see=20
> >> what is it exactly that they request/reject.
> >
> >
> >Before we start the test, we must specify to the tester the=20
> parameters=20
> >that we'll accept. The tester will reject the first set of=20
> values, no=20
> >matter what they are. In its response it will send new=20
> values (which we=20
> >specify) that it expects to see in the next request from the IUT.
>=20
> Any updates on this one ?
>=20
> Max
>=20
>=20
>=20
