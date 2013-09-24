Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 2/8] Bluetooth: Clean up socket locking in l2cap_sock_recvmsg
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380031363-1266-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Sep 2013 20:16:12 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B28C85BD-ECE9-47F5-BA7D-090B6603CEB6@holtmann.org>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com> <1380031363-1266-3-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch cleans up the locking login in l2cap_sock_recvmsg by pairing
> up each lock_sock call with a release_sock call. The function already
> has a "done" label that handles releasing the socket and returning from
> the function so the fix is rather simple.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index ad95b42..5853c1e 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -795,7 +795,7 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
> {
> 	struct sock *sk = sock->sk;
> 	struct l2cap_pinfo *pi = l2cap_pi(sk);
> -	int err;
> +	int err = 0;
> 
> 	lock_sock(sk);
> 
> @@ -805,8 +805,7 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
> 		pi->chan->state = BT_CONFIG;
> 
> 		__l2cap_connect_rsp_defer(pi->chan);
> -		release_sock(sk);
> -		return 0;

can we just do 

		err = 0;

here instead of declaring it global.

> +		goto done;
> 	}
> 
> 	release_sock(sk);

Regards

Marcel

