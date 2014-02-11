Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Fix channel check when binding RFCOMM sock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392119413-26341-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Tue, 11 Feb 2014 07:58:27 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <52F8F4E9-BCAF-4137-B21C-101F11DE1519@holtmann.org>
References: <1392119413-26341-1-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> When binding RFCOMM socket we should only check if there is another
> socket bound or listening on the same channel number. In other case,
> it won't be possible to bind/listen on a channel in case we have
> connection made to remote device on the same channel number.

since this has been used for years now, you need to be more specific on when this fails.

> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
> net/bluetooth/rfcomm/sock.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 00573fb..9912e23 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -331,6 +331,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
> {
> 	struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
> 	struct sock *sk = sock->sk;
> +	struct sock *sk1;
> 	int err = 0;
> 
> 	BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
> @@ -352,7 +353,9 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
> 
> 	write_lock(&rfcomm_sk_list.lock);
> 
> -	if (sa->rc_channel && __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr)) {
> +	sk1 = __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr);
> +	if (sa->rc_channel && sk1 && (sk1->sk_state == BT_BOUND ||
> +						sk1->sk_state == BT_LISTEN)) {
> 		err = -EADDRINUSE;

can we find a better name than sk1 here.

> 	} else {
> 		/* Save source address */

Regards

Marcel

