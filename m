Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330029469-8565-3-git-send-email-mathewm@codeaurora.org>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
	<1330029469-8565-3-git-send-email-mathewm@codeaurora.org>
Date: Fri, 24 Feb 2012 18:13:32 -0200
Message-ID: <CAA37ikYHwKfBV8Ojgqoc8XYQpgv2oHFkzZA6NEZgFkF9nVjBSw@mail.gmail.com>
Subject: Re: [RFC 2/2] Bluetooth: L2CAP ERTM state machine replacement
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org, luiz.dentz@gmail.com,
	andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Feb 23, 2012 at 6:37 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
> The previous ERTM implementation had a handler for each frame type,
> and each handler had to figure out what the current state was and
> handle each frame accordingly.
>
> This implementation has a state machine that chooses an execution path
> first based on the receive or transmit state, then each state has
> handlers for the frame types. This is easier to match up with the
> spec, which is defined similarly.
>
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>

<snip>

@@ -1245,7 +1457,8 @@ int __l2cap_wait_ack(struct sock *sk)

        add_wait_queue(sk_sleep(sk), &wait);
        set_current_state(TASK_INTERRUPTIBLE);
-       while (chan->unacked_frames > 0 && chan->conn) {
+       while (chan->unacked_frames > 0 && chan->conn &&
+               atomic_read(&chan->ertm_queued)) {
                if (!timeo)
                        timeo = HZ/5;

Can we have unacked_frames > 0 and nothing queued? Or have I misinterpreted?

<snip>

+               BT_DBG("Sent txseq %d", (int)control->txseq);

-               skb = skb_queue_next(&chan->tx_q, skb);
+               chan->next_tx_seq = __next_seq(chan->next_tx_seq, chan);
+               chan->frames_sent += 1;
+               sent += 1;

Nitpick here. frames_sent++ and sent++ ? Happens in other places as
well so I won't copy all of them here.

<snip>

-               if (bt_cb(skb)->retries == 1) {
-                       chan->unacked_frames++;
+               l2cap_chan_hold(chan);
+               sock_hold(chan->sk);
+               tx_skb->sk = chan->sk;

Do we really need these? Do we always have chan->sk? (We have that in
l2cap_ertm_send() and l2cap_ertm_resend()).

<snip>

+               keep_sk = schedule_work(&chan->tx_work);

Would make sense to schedule this in hdev->workqueue?

<snip>

+static void l2cap_ertm_tx_worker(struct work_struct *work)
 {

Why do we need this worker?

-       int ret;
+       struct l2cap_chan *chan =
+               container_of(work, struct l2cap_chan, tx_work);

-       if (!skb_queue_empty(&chan->tx_q))
-               chan->tx_send_head = chan->tx_q.next;
+       BT_DBG("%p", chan);

-       chan->next_tx_seq = chan->expected_ack_seq;
-       ret = l2cap_ertm_send(chan);
-       return ret;
+       lock_sock(chan->sk);
+       l2cap_ertm_send(chan);
+       release_sock(chan->sk);

Can't we just use l2cap_chan_lock()/l2cap_chan_unlock() here? (I'm
assuming you saw the patches creating a lock in l2cap_chan to protect
it) Do we always have sk?

+       sock_put(chan->sk);
+       l2cap_chan_put(chan);
 }

<snip>

+static void l2cap_monitor_timeout(struct work_struct *work)
+{
+       struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
+                                                       monitor_timer.work);
+       struct sock *sk = chan->sk;
+
+       BT_DBG("chan %p", chan);
+
+       lock_sock(sk);
+
+       if (!chan->conn) {
+               release_sock(sk);
+               l2cap_chan_put(chan);
+               return;
+       }
+
+       l2cap_ertm_tx(chan, 0, 0, L2CAP_ERTM_EVENT_MONITOR_TIMER_EXPIRES);
+
+       release_sock(sk);
+       l2cap_chan_put(chan);
+}

Here we might need to use l2cap_chan_lock/unlock instead of
lock_sock/release_sock.

+static void l2cap_retrans_timeout(struct work_struct *work)
+{
+       struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
+                                                       retrans_timer.work);
+       struct sock *sk = chan->sk;
+
+       BT_DBG("chan %p", chan);
+
+       lock_sock(sk);
+
+       if (!chan->conn) {
+               release_sock(sk);
+               l2cap_chan_put(chan);
+               return;
+       }
+
+       l2cap_ertm_tx(chan, 0, 0, L2CAP_ERTM_EVENT_RETRANS_TIMER_EXPIRES);
+       release_sock(sk);
+       l2cap_chan_put(chan);

And here as well.

Ok, that's it for now. Have you run this code through PTS or any other
test? I haven't checked the actual bits of ERTM but since we're
replacing the current state machine code we need to be somewhat sure
this code is as good as or even better than the current one.
Introducing too many regressions would be really bad IMHO.

Thanks,
Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
