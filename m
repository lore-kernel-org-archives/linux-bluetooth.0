Return-Path: <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
From: Max Krasnyansky <maxk@qualcomm.com>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000301c31656$73bb2930$5796fea9@baked>
References: <000301c31656$73bb2930$5796fea9@baked>
Content-Type: text/plain
Message-Id: <1052514852.10457.163.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 09 May 2003 14:15:04 -0700
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2003-05-09 at 11:11, Daryl Van Vorst wrote:
> > > >>         3.) TP/COS/CFD/BV-02: Tests that IUT is able to perform 
> > > >> negotiation while the tester rejects the configuration of a data 
> > > >> channel. The IUT sends a configuration request and the tester 
> > > >> rejects it. The IUT should send another configuration 
> > request, but 
> > > >> it does not.
> > > >
> > > >Currently the channel is closed if they reject our config request, 
> > > >because we don't know how to proceed if they don't like 
> > our settings. 
> > > >We can sent them again, but they will be rejected again. For this 
> > > >case I also have to read the L2CAP in detail.
> > > Yeah we talked about that. Test is stupid. I'm not sure how to fix 
> > > that without
> > > affecting general logic. 
> > 
> > I put this to the last item on the list. At the moment I 
> > don't care, but I will spent some time to look at it.
> 
> Not sure if you saw a slightly more recent post from me.  The test isn't
> quite as stupid as it seems. When the tester rejects the config request, it
> gives desired configuration values inside that response. We're supposed to
> return those values in the next config request (providing we like them well
> enough). It'll accept those values. This behaviour makes sense to me now.
> Thoughts?
It's still stupid :).
First of all there is an inconsistency between core spec and test spec.
Core spec says that response to config reject is implementation specific
and implementation may chose to close the channel. So test spec has
test case to test _implementation specific_ thing :)
It also doesn't make much sense if you think about real applications.

> > > >>         4.) TP/COS/RCO/BI-01, BI-02: These tests verify that the 
> > > >> IUT performs a consistency check on the data. Both tests 
> > send two 
> > > >> packets to the IUT. In each test, the first packet has a 
> > mistake. 
> > > >> In BI-01 the first packet is too short by one byte, and in BI-02 
> > > >> the first packet is too long by one byte. In both cases 
> > the stack 
> > > >> must correctly receive the second packet, but not the first. The 
> > > >> data should be discarded in the case of the 
> > inconsistencies, and an 
> > > >> error reported to the application.
> > > >
> > > >It seems that we can't handle this case complete correctly, if the 
> > > >data was put only in one fragment. But in the basics this 
> > should work 
> > > >and the malformed packets should be dropped. Did you have 
> > a detailed 
> > > >log of this test which shows us byte by byte which request 
> > was sent?
> > > Hmm, how should we return error to the application. Most socket app 
> > > close
> > > the socket than read() returns error. i.e. Even if we fix 
> > the kernel to
> > > return some BT specific error, test will fail on other apps 
> > which will 
> > > simply close the socket.
> > > Also are those corrupted data packets or signaling packets ?
> > > If signalling we're not supposed to return error to all 
> > L2CAP apps are we ? ;-)
> > 
> > The test should pass if we correctly drop those wrong 
> > packets. But we need to see how the test acts. We need a 
> > "hcidump -w <file>". 
> 
> I sent a raw HCI dump for the two test cases in another message to the list
> yesterday. Is that enough information?
Should be enough. I think I found a bug in that code. We'd incorrectly
handle that case when received l2cap frame is larger than length in the
header. I'll fix that.

Max 
