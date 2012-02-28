Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 28 Feb 2012 20:49:35 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
	marcel@holtmann.org, luiz.dentz@gmail.com,
	andrei.emeltchenko.news@gmail.com
Subject: Re: [RFC 2/2] Bluetooth: L2CAP ERTM state machine replacement
Message-ID: <20120228234935.GB30668@joana>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
 <1330029469-8565-3-git-send-email-mathewm@codeaurora.org>
 <CAA37ikYHwKfBV8Ojgqoc8XYQpgv2oHFkzZA6NEZgFkF9nVjBSw@mail.gmail.com>
 <4F483477.2050907@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F483477.2050907@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-02-24 17:08:07 -0800]:

> On 2/24/2012 12:13 PM, Ulisses Furquim wrote:
> >Hi Mat,
> >
> >On Thu, Feb 23, 2012 at 6:37 PM, Mat Martineau<mathewm@codeaurora.org>  wrote:
> >>The previous ERTM implementation had a handler for each frame type,
> >>and each handler had to figure out what the current state was and
> >>handle each frame accordingly.
> >>
> >>This implementation has a state machine that chooses an execution path
> >>first based on the receive or transmit state, then each state has
> >>handlers for the frame types. This is easier to match up with the
> >>spec, which is defined similarly.
> >>
> >>Signed-off-by: Mat Martineau<mathewm@codeaurora.org>
> >
> ><snip>
> >
> >@@ -1245,7 +1457,8 @@ int __l2cap_wait_ack(struct sock *sk)
> >
> >         add_wait_queue(sk_sleep(sk),&wait);
> >         set_current_state(TASK_INTERRUPTIBLE);
> >-       while (chan->unacked_frames>  0&&  chan->conn) {
> >+       while (chan->unacked_frames>  0&&  chan->conn&&
> >+               atomic_read(&chan->ertm_queued)) {
> >                 if (!timeo)
> >                         timeo = HZ/5;
> >
> >Can we have unacked_frames>  0 and nothing queued? Or have I misinterpreted?
> 
> In normal operation, there should be unacked frames when ertm_queued
> is non-zero.  I think I ran in to a corner case with AMP, where
> unacked_frames can be forced to 0 during a channel move.  There are
> AMP components to the state machine that are not included in this
> patch.
> 
> >
> ><snip>
> >
> >+               BT_DBG("Sent txseq %d", (int)control->txseq);
> >
> >-               skb = skb_queue_next(&chan->tx_q, skb);
> >+               chan->next_tx_seq = __next_seq(chan->next_tx_seq, chan);
> >+               chan->frames_sent += 1;
> >+               sent += 1;
> >
> >Nitpick here. frames_sent++ and sent++ ? Happens in other places as
> >well so I won't copy all of them here.
> 
> Ok, will fix.
> 
> >
> ><snip>
> >
> >-               if (bt_cb(skb)->retries == 1) {
> >-                       chan->unacked_frames++;
> >+               l2cap_chan_hold(chan);
> >+               sock_hold(chan->sk);
> >+               tx_skb->sk = chan->sk;
> >
> >Do we really need these? Do we always have chan->sk? (We have that in
> >l2cap_ertm_send() and l2cap_ertm_resend()).
> 
> The upstream ERTM code still relies on having chan->sk, so I didn't
> try to finish splitting channels & sockets within this patch.  skb
> destructors expect to have an sk pointer, so it is critical to
> modify these reference counts so the socket and chan are around when
> the skb leaves the hci tx queue.
> 
> >
> ><snip>
> >
> >+               keep_sk = schedule_work(&chan->tx_work);
> >
> >Would make sense to schedule this in hdev->workqueue?
> 
> It's a tradeoff.  If this is scheduled on hdev->workqueue, then that
> workqueue can get blocked waiting for the socket lock.  If these are
> scheduled on the system workqueue, there is potential for more
> latency (but it hasn't been a problem in practice, even with AMP
> data rates).
> 
> >
> ><snip>
> >
> >+static void l2cap_ertm_tx_worker(struct work_struct *work)
> >  {
> >
> >Why do we need this worker?
> 
> To control the depth of the hci tx queue.  Without this, you end up
> with an entire tx window of iframes queued up at the hci layer.
> When an sframe shows up from the remote device and you have to
> retransmit, or when an sframe needs to be sent, then retransmissions
> and sframes have to get queued behind that full tx window of
> iframes.  It adds a HUGE amount of latency in those situations,
> which leads to ERTM timeouts and disconnects that are not necessary.
> ERTM works much, much better with lossy connections (like AMP) if it
> does not flood the hci tx queue.
> 
> We had a discussion on the list about how to solve this.  The idea
> is to push most queuing up to the L2CAP layer, and have the hci
> scheduler call up to L2CAP to fetch frames.  However, this hasn't
> been implemented yet.

Ok, I can see why you added tx_work now. We really need to move to the new
proposal here.

Also I think the most important thing here is not point out wrong stuff in
this huge patch but find ways to split it in many patches. If we could get a
cleaner and rebased patch fixing the unnecessary renames and functions move,
etc. that would be good for us. :)

	Gustavo
