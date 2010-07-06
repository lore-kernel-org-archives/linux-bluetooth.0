Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: check l2cap pending status before sending
 l2cap connect request
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1277278237-29377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1277278237-29377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Jul 2010 12:14:38 -0300
Message-ID: <1278429278.2789.48.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Due to race condition in L2CAP state machine L2CAP Connection Request
> may be sent twice for SDP with the same source channel id. Problems
> reported connecting to Apple products, some carkit, Blackberry phones.
> 
> ...
> 2010-06-07 21:18:03.651031 < ACL data: handle 1 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> 2010-06-07 21:18:03.653473 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 1 packets 1
> 2010-06-07 21:18:03.653808 > HCI Event: Auth Complete (0x06) plen 3
>     status 0x00 handle 1
> 2010-06-07 21:18:03.653869 < ACL data: handle 1 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> ...
> 
> Patch uses L2CAP_CONF_CONNECT_PEND flag to mark that L2CAP Connection
> Request has been sent.

patch in general looks fine, but I do have some comments.

> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index bb00015..7f82f7b 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -409,13 +409,16 @@ static void l2cap_do_start(struct sock *sk)
>  		if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
>  			return;
>  
> -		if (l2cap_check_security(sk)) {
> +		if (l2cap_check_security(sk) &&
> +				!(l2cap_pi(sk)->conf_state &
> +				L2CAP_CONF_CONNECT_PEND)) {

I think having some l2cap_check_pending() would be a good idea. This
high indentation is not easy to read.

>  			struct l2cap_conn_req req;
>  			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
>  			req.psm  = l2cap_pi(sk)->psm;
>  
>  			l2cap_pi(sk)->ident = l2cap_get_ident(conn);
>  
> +			l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
>  			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
>  					L2CAP_CONN_REQ, sizeof(req), &req);

If we look at the other cases we have done this, then either have an
empty line between these two commands. Or remove the other empty line.

>  		}
> @@ -464,13 +467,16 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>  		}
>  
>  		if (sk->sk_state == BT_CONNECT) {
> -			if (l2cap_check_security(sk)) {
> +			if (l2cap_check_security(sk) &&
> +					!(l2cap_pi(sk)->conf_state &
> +					L2CAP_CONF_CONNECT_PEND)) {

See above.

>  				struct l2cap_conn_req req;
>  				req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
>  				req.psm  = l2cap_pi(sk)->psm;
>  
>  				l2cap_pi(sk)->ident = l2cap_get_ident(conn);
>  
> +				l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
>  				l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
>  					L2CAP_CONN_REQ, sizeof(req), &req);

See above.

>  			}
> @@ -4407,6 +4413,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  
>  				l2cap_pi(sk)->ident = l2cap_get_ident(conn);
>  
> +				l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
>  				l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
>  					L2CAP_CONN_REQ, sizeof(req), &req);
>  			} else {

See above.

Regards

Marcel


