Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Fri, 9 May 2003 14:52:26 -0700
Message-ID: <000f01c31675$4827abd0$5796fea9@baked>
MIME-Version: 1.0
In-Reply-To: <1052514852.10457.163.camel@localhost.localdomain>
Content-Type: text/plain; CHARSET=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

> > > > >>         3.) TP/COS/CFD/BV-02: Tests that IUT is able=20
> to perform
> > > > >> negotiation while the tester rejects the=20
> configuration of a data=20
> > > > >> channel. The IUT sends a configuration request and=20
> the tester=20
> > > > >> rejects it. The IUT should send another configuration=20
> > > request, but
> > > > >> it does not.
> > > > >
> > > > >Currently the channel is closed if they reject our config=20
> > > > >request,
> > > > >because we don't know how to proceed if they don't like=20
> > > our settings.
> > > > >We can sent them again, but they will be rejected=20
> again. For this
> > > > >case I also have to read the L2CAP in detail.
> > > > Yeah we talked about that. Test is stupid. I'm not sure=20
> how to fix
> > > > that without
> > > > affecting general logic.=20
> > >=20
> > > I put this to the last item on the list. At the moment I
> > > don't care, but I will spent some time to look at it.
> >=20
> > Not sure if you saw a slightly more recent post from me.  The test=20
> > isn't quite as stupid as it seems. When the tester rejects=20
> the config=20
> > request, it gives desired configuration values inside that=20
> response.=20
> > We're supposed to return those values in the next config request=20
> > (providing we like them well enough). It'll accept those=20
> values. This=20
> > behaviour makes sense to me now. Thoughts?
> It's still stupid :).
> First of all there is an inconsistency between core spec and=20
> test spec. Core spec says that response to config reject is=20
> implementation specific and implementation may chose to close=20
> the channel. So test spec has test case to test=20
> _implementation specific_ thing :) It also doesn't make much=20
> sense if you think about real applications.

If you're right about the inconsistency then we should be able to argue our
way to a pass verdict on that test. I just had a look at the L2CAP spec and
it sure looks like you're right. I'll pass that along to Cetecom. We'll see
what they say...

> > > > >>         4.) TP/COS/RCO/BI-01, BI-02: These tests verify that=20
> > > > >> the
> > > > >> IUT performs a consistency check on the data. Both tests=20
> > > send two
> > > > >> packets to the IUT. In each test, the first packet has a
> > > mistake.
> > > > >> In BI-01 the first packet is too short by one byte, and in=20
> > > > >> BI-02
> > > > >> the first packet is too long by one byte. In both cases=20
> > > the stack
> > > > >> must correctly receive the second packet, but not the first.=20
> > > > >> The
> > > > >> data should be discarded in the case of the=20
> > > inconsistencies, and an
> > > > >> error reported to the application.
> > > > >
> > > > >It seems that we can't handle this case complete correctly, if=20
> > > > >the
> > > > >data was put only in one fragment. But in the basics this=20
> > > should work
> > > > >and the malformed packets should be dropped. Did you have
> > > a detailed
> > > > >log of this test which shows us byte by byte which request
> > > was sent?
> > > > Hmm, how should we return error to the application. Most socket=20
> > > > app
> > > > close
> > > > the socket than read() returns error. i.e. Even if we fix=20
> > > the kernel to
> > > > return some BT specific error, test will fail on other apps
> > > which will
> > > > simply close the socket.
> > > > Also are those corrupted data packets or signaling packets ? If=20
> > > > signalling we're not supposed to return error to all
> > > L2CAP apps are we ? ;-)
> > >=20
> > > The test should pass if we correctly drop those wrong
> > > packets. But we need to see how the test acts. We need a=20
> > > "hcidump -w <file>".=20
> >=20
> > I sent a raw HCI dump for the two test cases in another=20
> message to the=20
> > list yesterday. Is that enough information?
> Should be enough. I think I found a bug in that code. We'd=20
> incorrectly handle that case when received l2cap frame is=20
> larger than length in the header. I'll fix that.

Good news: I just got a note from Cetecom regarding this.  They say it's ok
if the stack closes the connection after detecting the inconsistency, since
the remote side seems to be screwed up. The next packet is _NOT_ required t=
o
be received (I was wrong about thinking that the next packet needed to be
received). The 2nd packet sent by the tester just has the purpose to give a
L2CAP start packet indication (to avoid waiting for any outstanding data).

So with your fix will L2CAP close the connection and report an error to the
application for these two test malformed l2cap test cases?

-Daryl.
