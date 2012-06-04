Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Jun 2012 10:14:19 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Release all locks before sleep
In-Reply-To: <1338492344-1474-2-git-send-email-gustavo@padovan.org>
Message-ID: <alpine.DEB.2.02.1206040954120.31902@mathewm-linux>
References: <1338492344-1474-1-git-send-email-gustavo@padovan.org> <1338492344-1474-2-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Gustavo -

On Thu, 31 May 2012, Gustavo Padovan wrote:

> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> To avoid deadlock we need to release locks while waiting for a ack to
> arrive.
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
> net/bluetooth/l2cap_core.c |    5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 1cb3ca0..94273dc 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1553,13 +1553,14 @@ done:
> int __l2cap_wait_ack(struct sock *sk)
> {
> 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> +	struct l2cap_conn *conn = chan->conn;

I don't think you want to store the l2cap_conn pointer on the stack, 
the structure can be freed when the locks are released.

> 	DECLARE_WAITQUEUE(wait, current);
> 	int err = 0;
> 	int timeo = HZ/5;
>
> 	add_wait_queue(sk_sleep(sk), &wait);
> 	set_current_state(TASK_INTERRUPTIBLE);
> -	while (chan->unacked_frames > 0 && chan->conn) {
> +	while (chan->unacked_frames > 0 && conn) {
> 		if (!timeo)
> 			timeo = HZ/5;
>
> @@ -1570,7 +1571,9 @@ int __l2cap_wait_ack(struct sock *sk)
>
> 		release_sock(sk);
> 		l2cap_chan_unlock(chan);
> +		mutex_unlock(&conn->chan_lock);
> 		timeo = schedule_timeout(timeo);
> +		mutex_lock(&conn->chan_lock);
> 		l2cap_chan_lock(chan);
> 		lock_sock(sk);
> 		set_current_state(TASK_INTERRUPTIBLE);
> -- 
> 1.7.10.2

I think it would be better to only acquire the chan_lock mutex when 
calling l2cap_chan_close in l2cap_sock_shutdown.  However, you will 
have to be careful to avoid deadlocks.  I think it's only safe to 
acquire the conn->chan_lock when both the l2cap_chan and the socket 
are unlocked.  Can you collapse all the locking changes in to one 
patch?

Since __l2cap_wait_ack is only called from l2cap_sock.c, would it 
make sense to move the function to l2cap_sock.c?

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

