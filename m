Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Sep 2012 10:01:52 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCH 1/6] Bluetooth: Fix deadlock when closing socket
In-Reply-To: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.02.1209060946190.22884@mathewm-linux>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei -

On Thu, 6 Sep 2012, Andrei Emeltchenko wrote:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> If we have unacked frames when closing bluetooth socket we deadlock
> since conn->chan_lock, chan->lock and socket lock are taken. Remove
> __l2cap_wait_ack completely.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

I don't think you want to remove this code completely, at least not 
without giving some thought to the problem it is solving.

The problem is that programs may have an open socket which they send 
some data on, then immediately close.  There is no feedback when data 
is actually sent over the air, so the socket may end up getting torn 
down while there is still data in the HCI tx buffer or some data was 
lost and needs to be retransmitted.  Waiting for an acknowledgement 
confirms that the application's sent data made it to the remote 
device.

Without this code, it's difficult to use l2test on a number of 
qualification tests.  Profiles or applications using ERTM may depend 
on the "wait for ack before closing" behavior in order to have a clean 
disconnect.

It is not reasonable to deadlock while waiting for unacked packets to 
go to 0, so maybe more needs to be done in __l2cap_wait_ack to limit 
the wait time.


> ---
> include/net/bluetooth/l2cap.h |    1 -
> net/bluetooth/l2cap_core.c    |   32 --------------------------------
> net/bluetooth/l2cap_sock.c    |    3 ---
> 3 files changed, 36 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 4e188dc..0330894 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -753,7 +753,6 @@ int l2cap_init_sockets(void);
> void l2cap_cleanup_sockets(void);
>
> void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
> -int __l2cap_wait_ack(struct sock *sk);
>
> int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
> int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 3686506..8e4b57b 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1633,38 +1633,6 @@ done:
> 	return err;
> }
>
> -int __l2cap_wait_ack(struct sock *sk)
> -{
> -	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> -	DECLARE_WAITQUEUE(wait, current);
> -	int err = 0;
> -	int timeo = HZ/5;
> -
> -	add_wait_queue(sk_sleep(sk), &wait);
> -	set_current_state(TASK_INTERRUPTIBLE);
> -	while (chan->unacked_frames > 0 && chan->conn) {
> -		if (!timeo)
> -			timeo = HZ/5;
> -
> -		if (signal_pending(current)) {
> -			err = sock_intr_errno(timeo);
> -			break;
> -		}
> -
> -		release_sock(sk);
> -		timeo = schedule_timeout(timeo);
> -		lock_sock(sk);
> -		set_current_state(TASK_INTERRUPTIBLE);
> -
> -		err = sock_error(sk);
> -		if (err)
> -			break;
> -	}
> -	set_current_state(TASK_RUNNING);
> -	remove_wait_queue(sk_sleep(sk), &wait);
> -	return err;
> -}
> -
> static void l2cap_monitor_timeout(struct work_struct *work)
> {
> 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 997e0cb..cc26b1f 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -866,9 +866,6 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
> 	lock_sock(sk);
>
> 	if (!sk->sk_shutdown) {
> -		if (chan->mode == L2CAP_MODE_ERTM)
> -			err = __l2cap_wait_ack(sk);
> -
> 		sk->sk_shutdown = SHUTDOWN_MASK;
>
> 		release_sock(sk);
> -- 
> 1.7.9.5


Regards,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
