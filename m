Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 17 Sep 2010 18:08:35 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: Possible regression with skb_clone() in 2.6.36
Message-ID: <20100917210835.GC7032@vigoh>
References: <1283988727-1456-1-git-send-email-padovan@profusion.mobi>
 <alpine.DEB.2.00.1009100920270.14322@linux-sea-02>
 <20100910194509.GC19693@vigoh>
 <20100916001012.GA5656@vigoh>
 <alpine.DEB.2.00.1009160840080.4394@linux-sea-02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.1009160840080.4394@linux-sea-02>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-09-16 09:40:54 -0700]:

> 
> Gustavo -
> 
> Since this is now a only a discussion of blocking behavior with ERTM 
> (and not a regression with skb_clone()), I've removed linux-kernel and 
> netdev from the cc list.  If you think they still need to see this 
> thread, please add them back in.
> 
> 
> On Wed, 15 Sep 2010, Gustavo F. Padovan wrote:
> 
> > * Gustavo F. Padovan <padovan@profusion.mobi> [2010-09-10 16:45:09 -0300]:
> >
> >> Hi Mat,
> >>
> >> * Mat Martineau <mathewm@codeaurora.org> [2010-09-10 09:53:31 -0700]:
> >>
> >>>
> >>> Gustavo -
> >>>
> >>> I'm not sure why the streaming code used to work, but this does not
> >>> look like an skb_clone() problem.  Your patch to remove the
> >>> skb_clone() call in l2cap_streaming_send() addresses the root cause of
> >>> this crash.
> >>>
> >>> On Wed, 8 Sep 2010, Gustavo F. Padovan wrote:
> >>>
> >>>> I've been experiencing some problems when running the L2CAP Streaming mode in
> >>>> 2.6.36. The system quickly runs in an Out Of Memory condition and crash. That
> >>>> wasn't happening before, so I think we may have a regression here (I didn't
> >>>> find where yet). The crash log is below.
> >>>>
> >>>> The following patch does not fix the regression, but shows that removing the
> >>>> skb_clone() call from l2cap_streaming_send() we workaround the problem. The
> >>>> patch is good anyway because it saves memory and time.
> >>>>
> >>>> By now I have no idea on how to fix this.
> >>>>
> >>>> <snip>
> >>>
> >>> This has to do with the sk->sk_wmem_alloc accounting that controls the
> >>> amount of write buffer space used on the socket.
> >>>
> >>> When the L2CAP streaming mode socket segments its data, it allocates
> >>> memory using sock_alloc_send_skb() (via bt_skb_send_alloc()).  Before
> >>> that allocation call returns, skb_set_owner_w() is called on the new
> >>> skb.  This adds to sk->sk_wmem_alloc and sets skb->destructor so that
> >>> sk->sk_wmem_alloc is correctly updated when the skb is freed.
> >>>
> >>> When that skb is cloned, the clone is not "owned" by the write buffer.
> >>> The clone's destructor is set to NULL in __skb_clone().  The version
> >>> of l2cap_streaming_send() that runs out of memory is passing the
> >>> non-owned skb clone down to the HCI layer.  The original skb (the one
> >>> that's "owned by w") is immediately freed, which adjusts
> >>> sk->sk_wmem_alloc back down - the socket thinks it has unlimited write
> >>> buffer space.  As a result, bt_skb_send_alloc() never blocks waiting
> >>> for buffer space (or returns EAGAIN for nonblocking writes) and the
> >>> HCI send queue keeps growing.
> >>
> >> If the problem is what you are saying, add a skb_set_owner_w(skb, sk) on
> >> the cloned skb should solve the problem, but it doesn't. That's exactly
> >> what tcp_transmit_skb() does. Also that just appeared in 2.6.36, is was
> >> working fine before, i.e, we have a regression here.
> >>
> >>>
> >>> This isn't a problem for the ERTM sends, because the original skbs are
> >>> kept in the ERTM tx queue until they are acked.  Once they're acked,
> >>> the write buffer space is freed and additional skbs can be allocated.
> >>
> >> It affects ERTM as well, but in that case the kernel doesn't crash
> >> because ERTM block on sending trying to allocate memory. Then we are not
> >> able to receive any ack (everything stays queued in sk_backlog_queue as
> >> the sk is owned by the user) and ERTM stalls.
> >
> > By reverting
> >
> > commit 218bb9dfd21472128f86b38ad2eab123205c2991
> > Author: Gustavo F. Padovan <padovan@profusion.mobi>
> > Date:   Mon Jun 21 18:53:22 2010 -0300
> >
> >    Bluetooth: Add backlog queue to ERTM code
> >
> >    backlog queue is the canonical mechanism to avoid race conditions due
> >    interrupts in bottom half context. After the socket lock is released the
> >    net core take care of push all skb in its backlog queue.
> >
> >    Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> >    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >
> >
> > we can workaround the bug. It's not the real cause of the bug because the
> > backlog queue was working before 2.6.36, but removing the backlog queue scheme
> > make L2CAP works again and also give us more time to find the real cause of the
> > problem.
> >
> > Before  implement the backlog queue L2CAP had his own lock scheme to avoid race
> > conditions. The point is that the backlog queue adds too much serialization to
> > L2CAP, that was the cause of the ERTM bug. The old scheme (the one we are going
> > to use after revert this commit) just serialize access to some places.
> >
> > By not using the backlog queue, we can receive the acknowledgement frames more
> > quickly and then free the acked frames quickly. In fact the old scheme is
> > looks better than backlog queue.
> >
> > I think we should proceed with the revert with this commit in mainline, and at the
> > same time try to find the root cause of the problem.
> 
> I don't think the backlog patch should be reverted.  Although the old 
> code would appear to get things working again, it's only because locks 
> were being ignored in some important cases.  Maybe it seems ok most of 
> the time, but the ERTM socket state was not being properly protected. 
> The backlog is the right way to do it, but also depends on correct 
> lock handling in the rest of L2CAP.
> 
> 
> I think this is one of the locking issues from this message to 
> linux-bluetooth ("ERTM known bugs/regressions (was Re: [PATCH 0/8] 
> ...)") on August 2:
> 
> http://www.spinics.net/lists/linux-bluetooth/msg06734.html
> 
> 
> We've both arrived at the root cause already: incoming frames 
> (including acks) get stuck on the backlog queue while the socket is 
> locked waiting for memory -- and no memory gets freed until the acks 
> are processed.
> 
> The only time the socket lock is held for a long time is when waiting 
> for memory, so I think the best solution is to not hold the lock while 
> allocating.  This should be safe, since the only socket state that's 
> changed during bt_skb_send_alloc() is sk->sk_wmem_alloc, which is an 
> atomic_t.
> 
> Then some changes are needed to these functions:
> 
> l2cap_sar_segment_sdu() and l2cap_create_iframe_pdu(): Take some args 
> on the stack (like remote_mps) instead of accessing l2cap_pinfo. 
> Don't add to TX_QUEUE(sk) within these functions (let the caller do 
> that).
> 
> l2cap_sock_sendmsg(): Copy necessary data to local variables from 
> l2cap_pinfo while the lock is held.  release_sock(sk), then call 
> l2cap_sar_segment_sdu() (which will work for the "one PDU" case too) 
> with the new args for mps, fcs, etc.  After l2cap_sar_segment_sdu() 
> returns, check the socket state again (like the code at the beginning 
> of l2cap_sock_sendmsg()) and then lock_sock(sk), queue the data, and 
> send it.

If we are going to release the lock before alloc memory we are assuming
the no one will change the mps, fcs and other things we need inside
those functions, so in the big picture just add a release_lock() before
alloc memory and after that lock the socket again should work nicely and
we won't need any local variable.

However I did find any other code in net/ that release the lock before
alloc memory. ERTM is a similar (and simplified) version of TCP. TCP
uses backlog queues as well and alloc memory with the socket locked.
I'm not completely conviced that this is the better way to fix that, I'm
also looking to others solutions, but haven't figured out them yet. ;)

> 
> (I know it would be better and clearer to send a patch for this, but 
> I have some other things to fix right now!)
> 
> 
> The other locking problem (with ERTM timers) also deserves some 
> attention, but maybe in a new email thread!

Yes, we need to look to it. Let's start a new mail thread.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
