Return-Path: <cyrus@holtmann.org>
Message-ID: <1361395331.1583.85.camel@aeonflux>
Subject: Re: [PATCH 07/16] Bluetooth: duplicate DEFER_SETUP flag on
 l2cap_chan
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Wed, 20 Feb 2013 22:22:11 +0100
In-Reply-To: <1361391103-30738-8-git-send-email-gustavo@padovan.org>
References: <1361391103-30738-1-git-send-email-gustavo@padovan.org>
	 <1361391103-30738-8-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Now l2cap_chan also has the DEFER_SETUP flag, so we don't need to access
> the bt_sk(sk) to read this flag inside l2cap_core.c. We need to kep it
> duplicate since it is used in Bluetooth socket code as well.

can we phrase this in a way that everybody understands what it means.
Since I do not actually.

> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 16 +++++++---------
>  net/bluetooth/l2cap_sock.c    |  7 +++++--
>  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 4f28a8c..0c76c55 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -635,6 +635,7 @@ enum {
>  	CONN_REJ_ACT,
>  	CONN_SEND_FBIT,
>  	CONN_RNR_SENT,
> +	CONN_DEFER_SETUP,
>  };
>  
>  /* Definitions for flags in l2cap_chan */
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index fd7fe5e..2c7ec1b 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -620,10 +620,8 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
>  void l2cap_chan_close(struct l2cap_chan *chan, int reason)
>  {
>  	struct l2cap_conn *conn = chan->conn;
> -	struct sock *sk = chan->sk;
>  
> -	BT_DBG("chan %p state %s sk %p", chan, state_to_string(chan->state),
> -	       sk);
> +	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
>  
>  	switch (chan->state) {
>  	case BT_LISTEN:
> @@ -646,7 +644,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
>  			struct l2cap_conn_rsp rsp;
>  			__u16 result;
>  
> -			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
> +			if (test_bit(CONN_DEFER_SETUP, &chan->conn_state))
>  				result = L2CAP_CR_SEC_BLOCK;
>  			else
>  				result = L2CAP_CR_BAD_PSM;
> @@ -1255,8 +1253,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>  
>  			if (l2cap_chan_check_security(chan)) {
>  				lock_sock(sk);
> -				if (test_bit(BT_SK_DEFER_SETUP,
> -					     &bt_sk(sk)->flags)) {
> +				if (test_bit(CONN_DEFER_SETUP,
> +					     &chan->conn_state)) {
>  					rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
>  					rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
>  					chan->ops->defer(chan);
> @@ -3642,7 +3640,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
>  
>  	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
>  		if (l2cap_chan_check_security(chan)) {
> -			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> +			if (test_bit(CONN_DEFER_SETUP, &chan->conn_state)) {
>  				__l2cap_state_change(chan, BT_CONNECT2);
>  				result = L2CAP_CR_PEND;
>  				status = L2CAP_CS_AUTHOR_PEND;
> @@ -6413,8 +6411,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  			lock_sock(sk);
>  
>  			if (!status) {
> -				if (test_bit(BT_SK_DEFER_SETUP,
> -					     &bt_sk(sk)->flags)) {
> +				if (test_bit(CONN_DEFER_SETUP,
> +					     &chan->conn_state)) {
>  					res = L2CAP_CR_PEND;
>  					stat = L2CAP_CS_AUTHOR_PEND;
>  					chan->ops->defer(chan);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 8adea0f..9cd6fba 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -659,10 +659,13 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>  			break;
>  		}
>  
> -		if (opt)
> +		if (opt) {
>  			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> -		else
> +			set_bit(CONN_DEFER_SETUP, &chan->conn_state);
> +		} else {
>  			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> +			clear_bit(CONN_DEFER_SETUP, &chan->conn_state);
> +		}
>  		break;
>  
>  	case BT_FLUSHABLE:

Regards

Marcel


