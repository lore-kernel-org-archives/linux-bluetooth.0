Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Oct 2014 10:00:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix locking issue when creating l2cap
 connection
Message-ID: <20141002070010.GA11550@t440s.lan>
References: <1412158707-26604-1-git-send-email-jukka.rissanen@linux.intel.com>
 <20141001120944.GA25046@t440s.lan>
 <542C09D5.9050405@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <542C09D5.9050405@hurleysoftware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Wed, Oct 01, 2014, Peter Hurley wrote:
> > As Szymon pointed out on IRC this version is also problematic in that
> > the check for chan->state is not inside the same atomic section as where
> > we change to a new state.
> > 
> > After some further analysis it seems like this lockdep warning is a
> > false-positive because of the way that all other places besides
> > l2cap_chan_connect() treat the locks. Most of these depend on the chan
> > being available in conn->chan_l:
> > 
> > 	lock(conn->chan_lock);
> > 	for_each(chan, conn->chan_l) {
> > 		lock(chan->lock);
> > 		...
> > 		unlock(chan->lock);
> > 	}
> > 	unlock(conn->chan_lock);
> > 
> > Because the l2cap_chan_connect() code (or l2cap_chan_add actually) takes
> > conn->chan_lock before attempting to add to conn->chan_l it makes the
> > loop described above unable to reach the chan and therefore the deadlock
> > is not possible.
> > 
> > There are at three exceptions I could find that don't follow exactly the
> > above pattern (by depending on conn->chan_l content), and should
> > therefore be considered separately:
> > 
> > 	l2cap_connect()
> > 	l2cap_le_connect_req()
> > 	l2cap_chan_timeout()
> > 
> > All three of these require the channel to be in a state that will make
> > l2cap_chan_connect() return early failure before getting anywhere close
> > to the risky l2cap_chan_add() call, so I would conclude that these are
> > also safe from the deadlock.
> 
> Ok, but a lockdep report disables lockdep, which means that
> 
> 1. There could be other lockdep errors after this one
> 2. Lockdep gets disabled for all subsystems so this can be masking
> problems in other places.
> 
> So still worth fixing this lock inversion.

Agreed.

> Why does chan->lock need to be held when adding the channel to the
> conn->chan_l if the chan is not retrievable until it's found on the
> list?

That's a good point. As long as the L2CAP user (e.g. l2cap_sock.c)
hasn't taken action to associate a chan object with a connection we
could assume that it needs to itself take care of mutual exclusion.
Looking at l2cap_sock.c this already seems to be a long-time assumption:
there are plenty of places where the code reads and writes chan members
without taking the chan->lock.

The chan->lock still needs to be held when adding to the list since we
want to make sure no other code touches it until l2cap_chan_connect
returns, but by moving the lock taking later we can ensure that we take
the conn->chan_lock first. I'll send a patch proposal for this soon.

Johan
