Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 22:27:12 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/7] Bluetooth: Add support for reusing the same hci_conn
 for LE links
Message-ID: <20110825012712.GF5462@joana>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798816-8647-5-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798816-8647-5-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-19 21:06:53 -0300]:

> As most LE devices leave advertising mode when they enter the connected
> state, we may want to "pass" that connection to other users.
> 
> The first user will be the pairing procedure, the connection is
> established without an associated socket, after the pairing is
> complete, userspace may want to discover via GATT what services the
> newly bonded device has.
> 
> If userspace establishes the connection while the timeout still
> hasn't expired, the connection will be re-used.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c   |   31 ++++++++++++-----------
>  net/bluetooth/l2cap_core.c |   56 ++++++++++++++++++++++++++++++-------------
>  2 files changed, 55 insertions(+), 32 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index fa6820e..f5e2bd8 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -501,23 +501,24 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>  	BT_DBG("%s dst %s", hdev->name, batostr(dst));
>  
>  	if (type == LE_LINK) {
> -		struct adv_entry *entry;
> +		struct adv_entry *entry = NULL;
>  
>  		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
> -		if (le)
> -			return ERR_PTR(-EBUSY);
> -
> -		entry = hci_find_adv_entry(hdev, dst);
> -		if (!entry)
> -			return ERR_PTR(-EHOSTUNREACH);
> -
> -		le = hci_conn_add(hdev, LE_LINK, dst);
> -		if (!le)
> -			return ERR_PTR(-ENOMEM);
> -
> -		le->dst_type = entry->bdaddr_type;
> -
> -		hci_le_connect(le);
> +		if (!le) {
> +			entry = hci_find_adv_entry(hdev, dst);
> +			if (!entry)
> +				return ERR_PTR(-EHOSTUNREACH);
> +
> +			le = hci_conn_add(hdev, LE_LINK, dst);
> +			if (!le)
> +				return ERR_PTR(-ENOMEM);
> +
> +			le->dst_type = entry->bdaddr_type;
> +			le->pending_sec_level = sec_level;
> +			le->sec_level = BT_SECURITY_LOW;
> +			le->auth_type = auth_type;
> +			hci_le_connect(le);
> +		}
>  
>  		hci_conn_hold(le);
>  
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d5ef9a2..ed1d2bd 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -627,10 +627,32 @@ static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
>  	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
>  }
>  
> +static void l2cap_chan_ready(struct sock *sk)
> +{
> +	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> +	struct sock *parent = bt_sk(sk)->parent;
> +
> +	BT_DBG("sk %p, parent %p", sk, parent);
> +
> +	chan->conf_state = 0;
> +	__clear_chan_timer(chan);
> +
> +	l2cap_state_change(chan, BT_CONNECTED);
> +	sk->sk_state_change(sk);
> +
> +	if (parent)
> +		parent->sk_data_ready(parent, 0);
> +}
> +
>  static void l2cap_do_start(struct l2cap_chan *chan)
>  {
>  	struct l2cap_conn *conn = chan->conn;
>  
> +	if (conn->hcon->type == LE_LINK) {
> +		l2cap_chan_ready(chan->sk);
> +		return;
> +	}
> +
>  	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) {
>  		if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
>  			return;
> @@ -881,23 +903,6 @@ clean:
>  	bh_unlock_sock(parent);
>  }
>  
> -static void l2cap_chan_ready(struct sock *sk)
> -{
> -	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> -	struct sock *parent = bt_sk(sk)->parent;
> -
> -	BT_DBG("sk %p, parent %p", sk, parent);
> -
> -	chan->conf_state = 0;
> -	__clear_chan_timer(chan);
> -
> -	l2cap_state_change(chan, BT_CONNECTED);
> -	sk->sk_state_change(sk);
> -
> -	if (parent)
> -		parent->sk_data_ready(parent, 0);
> -}
> -
>  static void l2cap_conn_ready(struct l2cap_conn *conn)
>  {
>  	struct l2cap_chan *chan;
> @@ -1087,6 +1092,17 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr
>  	return c1;
>  }
>  
> +static int l2cap_chan_empty(struct l2cap_conn *conn)
> +{
> +	int ret;
> +
> +	read_lock(&conn->chan_lock);
> +	ret = list_empty(&conn->chan_l);
> +	read_unlock(&conn->chan_lock);
> +
> +	return ret;
> +}
> +
>  int l2cap_chan_connect(struct l2cap_chan *chan)
>  {
>  	struct sock *sk = chan->sk;
> @@ -1128,6 +1144,12 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
>  		goto done;
>  	}
>  
> +	if (hcon->type == LE_LINK && !l2cap_chan_empty(conn)) {
> +		hci_conn_put(hcon);
 
The lock (in l2cap_chan_empty) have to be release after conn put. So just get
rid of l2cap_chan_empty and do an inline locking here.

	Gustavo
