Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: Fix potential NULL dereference
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1431519246-8136-1-git-send-email-jaganath.k@samsung.com>
Date: Wed, 13 May 2015 22:34:34 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F204CC62-B13F-4BB1-BC3B-72B613B5B6D6@holtmann.org>
References: <1431519246-8136-1-git-send-email-jaganath.k@samsung.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> addr can be NULL and it should not be dereferenced before NULL checking.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
> net/bluetooth/rfcomm/sock.c |    8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 825e8fb..e576374 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -336,14 +336,16 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
> {
> 	struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
> 	struct sock *sk = sock->sk;
> -	int chan = sa->rc_channel;
> +	int chan;
> 	int err = 0;
> 
> -	BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
> -
> 	if (!addr || addr->sa_family != AF_BLUETOOTH)
> 		return -EINVAL;
> 
> +	BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
> +
> +	chan = sa->rc_channel;
> +

if we start changing things here, then we better change the code into something that all the other socket handling code is doing anyway. So do the min comparison and copy the data into a local copy of the sockaddr_rc.

And on a side note, I wonder if addr can actually be NULL. It might be interesting to check the generic socket code if this really can happen if you provide no address structure to the bind() system call or if this gets filtered out by the core socket code.

Regards

Marcel

