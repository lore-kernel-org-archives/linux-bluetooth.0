Return-Path: <cyrus@holtmann.org>
Message-ID: <1346962251.21200.119.camel@aeonflux>
Subject: Re: [PATCH 1/6] Bluetooth: Fix deadlock when closing socket
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Date: Thu, 06 Sep 2012 13:10:51 -0700
In-Reply-To: <alpine.DEB.2.02.1209060946190.22884@mathewm-linux>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <alpine.DEB.2.02.1209060946190.22884@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> > If we have unacked frames when closing bluetooth socket we deadlock
> > since conn->chan_lock, chan->lock and socket lock are taken. Remove
> > __l2cap_wait_ack completely.
> >
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> I don't think you want to remove this code completely, at least not 
> without giving some thought to the problem it is solving.
> 
> The problem is that programs may have an open socket which they send 
> some data on, then immediately close.  There is no feedback when data 
> is actually sent over the air, so the socket may end up getting torn 
> down while there is still data in the HCI tx buffer or some data was 
> lost and needs to be retransmitted.  Waiting for an acknowledgement 
> confirms that the application's sent data made it to the remote 
> device.
> 
> Without this code, it's difficult to use l2test on a number of 
> qualification tests.  Profiles or applications using ERTM may depend 
> on the "wait for ack before closing" behavior in order to have a clean 
> disconnect.

isn't that what we have SO_LINGER for?

Regards

Marcel


