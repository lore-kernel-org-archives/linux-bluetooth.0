Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Thu, 8 May 2003 14:04:06 -0700
Message-ID: <000f01c315a5$5eb197b0$5796fea9@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <000801c3158d$497da950$5796fea9@baked>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> > >         3.) TP/COS/CFD/BV-02: Tests that IUT is able to perform
> > > negotiation while the tester rejects the configuration of a data=20
> > > channel. The IUT sends a configuration request and the=20
> > tester rejects
> > > it. The IUT should send another configuration request, but it does
> > > not.
> >=20
> > Currently the channel is closed if they reject our config
> > request, because we don't know how to proceed if they don't=20
> > like our settings. We can sent them again, but they will be=20
> > rejected again. For this case I also have to read the L2CAP=20
> in detail.
>=20
> Yeah, it seemed a bit odd to me too. But that's what the test=20
> case tests. I'll get some clarification on this one.

Here's what happens in that test:

1. The IUT sends a L2CAP_ConfigReq.
2. The tester responds with a L2CA_ConfigCfm with result=3Drejected and wit=
h
acceptable InMTU, OutFlow, and Flush TO.
3. The IUT sends an L2CAP_ConfigReq containing the acceptable values which
the tester sent in the response. The tester will be told (manually) what
values the IUT can accept and it will use those values in its response abov=
e
in step 2.
4. The tester responds with an L2CA_ConfigCfm with result=3Dsuccess and the
values that it accepted (the same values that were requested in step 3 and
in the response in step 2).

The basic idea is that the IUT asks for the channel to be configured in som=
e
way, the tester rejects it and tells the IUT what it would like to see. If
the IUT is ok with that, then it acknowledges the tester's response by
sending another config request with the values the tester wanted.  If the
tester asked for settings that we can't handle then we can give up and clos=
e
the connection.

Make sense?

-Daryl.
