Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Sep 2012 17:08:14 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mat Martineau <mathewm@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Subject: Re: [PATCH 1/6] Bluetooth: Fix deadlock when closing socket
Message-ID: <20120907140813.GC22944@aemeltch-MOBL1>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1209060946190.22884@mathewm-linux>
 <1346962251.21200.119.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346962251.21200.119.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Sep 06, 2012 at 01:10:51PM -0700, Marcel Holtmann wrote:
> Hi Mat,
> 
> > > If we have unacked frames when closing bluetooth socket we deadlock
> > > since conn->chan_lock, chan->lock and socket lock are taken. Remove
> > > __l2cap_wait_ack completely.
> > >
> > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > I don't think you want to remove this code completely, at least not 
> > without giving some thought to the problem it is solving.
> > 
> > The problem is that programs may have an open socket which they send 
> > some data on, then immediately close.  There is no feedback when data 
> > is actually sent over the air, so the socket may end up getting torn 
> > down while there is still data in the HCI tx buffer or some data was 
> > lost and needs to be retransmitted.  Waiting for an acknowledgement 
> > confirms that the application's sent data made it to the remote 
> > device.
> > 
> > Without this code, it's difficult to use l2test on a number of 
> > qualification tests.  Profiles or applications using ERTM may depend 
> > on the "wait for ack before closing" behavior in order to have a clean 
> > disconnect.
> 
> isn't that what we have SO_LINGER for?

Looking at the code I suspect that SO_LINGER is not working. Maybe we need
to merge linger code and wait_ack stuff.

Best regards 
Andrei Emeltchenko 
