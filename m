Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 7/8] Bluetooth:  Use a stream-oriented recvmsg with
 SOCK_STREAM L2CAP sockets.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1280776810-18213-8-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
	 <1280776810-18213-8-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 12:53:55 -0700
Message-ID: <1280778835.12579.53.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 582975b..8e9fa51 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1923,6 +1923,7 @@ done:
>  static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
>  {
>  	struct sock *sk = sock->sk;
> +	int len_or_err;
>  
>  	lock_sock(sk);
>  
> @@ -1956,7 +1957,13 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
>  
>  	release_sock(sk);
>  
> -	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
> +	if (sock->type == SOCK_STREAM)
> +		len_or_err = bt_sock_stream_recvmsg(iocb, sock, msg, len,
> +						flags);
> +	else
> +		len_or_err = bt_sock_recvmsg(iocb, sock, msg, len, flags);
> +
> +	return len_or_err;
>  }

I don't like this variable name. Just call it "len" or just use "ret"
here. Check what other parts of net/bluetooth/ are using.

Also since you are not checking is value anyway, why not return right
away from the if.

	if (sock->type == SOCK_STREAM)
		return bt_sock_stream_recvmsg(...);

	return bt_sock_recvmsg(...);

That way the compiler should also not complain. And in addition your
patch looks dead simple ;)

Regards

Marcel


