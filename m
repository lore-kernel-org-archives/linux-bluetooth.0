Return-Path: <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
From: Max Krasnyansky <maxk@qualcomm.com>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000f01c31675$4827abd0$5796fea9@baked>
References: <000f01c31675$4827abd0$5796fea9@baked>
Content-Type: text/plain
Message-Id: <1052520660.10456.220.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 09 May 2003 15:51:00 -0700
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2003-05-09 at 14:52, Daryl Van Vorst wrote:
> > > Not sure if you saw a slightly more recent post from me.  The test 
> > > isn't quite as stupid as it seems. When the tester rejects 
> > the config 
> > > request, it gives desired configuration values inside that 
> > response. 
> > > We're supposed to return those values in the next config request 
> > > (providing we like them well enough). It'll accept those 
> > values. This 
> > > behaviour makes sense to me now. Thoughts?
> > It's still stupid :).
> > First of all there is an inconsistency between core spec and 
> > test spec. Core spec says that response to config reject is 
> > implementation specific and implementation may chose to close 
> > the channel. So test spec has test case to test 
> > _implementation specific_ thing :) It also doesn't make much 
> > sense if you think about real applications.
> 
> If you're right about the inconsistency then we should be able to argue our
> way to a pass verdict on that test. I just had a look at the L2CAP spec and
> it sure looks like you're right. I'll pass that along to Cetecom. We'll see
> what they say...
Good luck :)

> > > I sent a raw HCI dump for the two test cases in another 
> > message to the 
> > > list yesterday. Is that enough information?
> > Should be enough. I think I found a bug in that code. We'd 
> > incorrectly handle that case when received l2cap frame is 
> > larger than length in the header. I'll fix that.
> 
> Good news: I just got a note from Cetecom regarding this.  They say it's ok
> if the stack closes the connection after detecting the inconsistency, since
> the remote side seems to be screwed up. The next packet is _NOT_ required to
> be received (I was wrong about thinking that the next packet needed to be
> received). The 2nd packet sent by the tester just has the purpose to give a
> L2CAP start packet indication (to avoid waiting for any outstanding data).
> 
> So with your fix will L2CAP close the connection and report an error to the
> application for these two test malformed l2cap test cases?
I was going to just drop the frame and log an error. The thing is, if
the packet header is corrupted (i.e. wrong length, etc) we can't really
trust its content. I mean if length is wrong how do we know that CID is
right. It means that we don't really know which channel should be closed
(i.e. which app should be notified).
 
Max
