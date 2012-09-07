Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Sep 2012 17:07:00 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCH 1/6] Bluetooth: Fix deadlock when closing socket
Message-ID: <20120907140659.GB22944@aemeltch-MOBL1>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1209060946190.22884@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1209060946190.22884@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Sep 06, 2012 at 10:01:52AM -0700, Mat Martineau wrote:
> 
> Hi Andrei -
> 
> On Thu, 6 Sep 2012, Andrei Emeltchenko wrote:
> 
> >From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> >If we have unacked frames when closing bluetooth socket we deadlock
> >since conn->chan_lock, chan->lock and socket lock are taken. Remove
> >__l2cap_wait_ack completely.
> >
> >Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> I don't think you want to remove this code completely, at least not
> without giving some thought to the problem it is solving.
> 
> The problem is that programs may have an open socket which they send
> some data on, then immediately close.  There is no feedback when
> data is actually sent over the air, so the socket may end up getting
> torn down while there is still data in the HCI tx buffer or some
> data was lost and needs to be retransmitted.  Waiting for an
> acknowledgement confirms that the application's sent data made it to
> the remote device.
> 
> Without this code, it's difficult to use l2test on a number of
> qualification tests.  Profiles or applications using ERTM may depend
> on the "wait for ack before closing" behavior in order to have a
> clean disconnect.
> 
> It is not reasonable to deadlock while waiting for unacked packets
> to go to 0, so maybe more needs to be done in __l2cap_wait_ack to
> limit the wait time.

Have you seen my previous RFC concerning this? It has 3 tries and then
exits from the loop.

Best regards 
Andrei Emeltchenko 

