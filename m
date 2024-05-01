Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3133CD1
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560218; cv=pass; b=CF/ezWatA8jElvYue5MTV+npp8tFajtCE/Ftx42N/GFrDtcfN5tLdo5L5Rn0mHO0/Qmel0BAMQ1XgmDXLwnLnNtr9aOtgah5NqRMTZVwyTRejKjt2bqrjasHv8MitEJm0n4veqdRMtwjyLYDSzj2l36D8JuukDlD/sVBK1jUnNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560218; c=relaxed/simple;
	bh=zCMcYo6KJ9d7m22aIGswP6Ma59TG9vLoa5+EimZWkEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FftjDEu8ekowaAPHuAk7ZjlwzJOM2AtV/sd71INUd3oXTgwg73VlTu9AAZfxj/ATNCdk+mlPa2nvmVGVJIgqx/a+NjV280gB7McMYfA8gQY0o+SuEpAP3WyvwTmFk7Ygl3gSkgCyagbxqiDJLT0yYwc+BTFNDfB56juRjnJ8q1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=txsKd67S; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="txsKd67S"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VTtvf21PZz49PxX;
	Wed,  1 May 2024 13:43:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1714560207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OareTFvfI8q2hZn4HJPPiZ2DPkvxzWfxpnJxUsnw2Pk=;
	b=txsKd67SjMugb167eIXuJ2NwmhzH5XtNZcURVwvM87sgKfD2rGMpoIX7NZ0VIaTpAFTH4r
	vF4F1TsZT1JMLLHB5+5wl2dMDNZvZjK54CPnjAGB+QJNcvsOI4cjaiivnGpyaUL5/OVqVk
	QUyH6Ptmuv8nTa5McaWtEhulbeQZadAEWqvMQbqWbPn1OMp7Q4EaPENtMvaDNxh6L6U5P8
	Fb/Qa57K36lyadn9LokfxfSDf8OxuV9JFpI3SUJO8lPQF4CePQiVc9lKAZgdvoE+jRJw4m
	9kq5eYqkZe+s0EYq7bWPcyxC8nnwdKnEV/Rhg2eXLBxGLjdO3JxjTIGTqyBiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1714560207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OareTFvfI8q2hZn4HJPPiZ2DPkvxzWfxpnJxUsnw2Pk=;
	b=aBQvVttZoO5fzeDjLQG/UweLFl/VIBYxjg6QKoQwrH4DGwypecbn8CZdfHmJusn1tgzHB8
	JoWTbK49XPtw/m7eNcFH7AlOxqMo5yZjrZZg2eYZodAJBkw8PB9PKV35N2BKdrsKDngLRj
	4RgnPLbD8/zxYlihxYkWkU169KcteUXpqAO6XaxjcvzC3YV6GI+tSuICUUAVtFi56WElUH
	BhTFbiI87o4AAqDWOYSy5SeshXexrPOSxmjWrPBJcRoGInHQIFG5NwLvZI55kqR+mOCEnp
	Yp74YGhhnW9FfI38pXsJhW2KDJnB/SUoIC7yMdssKwGluxj9HxeKDQpvaHQTgw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1714560207; a=rsa-sha256;
	cv=none;
	b=Sz3v+vr1jxzohlAgAZmI31cyGFx2bsRrkWUUF3Oy1bq3w8jRs9bTiiXXfUf36ltYmicUAQ
	HHxHeQBYHrUsJeyMhpqfni8G7oHuRAEHci1lfRzn0ARiXEQiWb+W0ssT1Sflmza8aJpKKe
	NXC63KBecNm6YocLt3jL4/cpJn9cSsX6DmBx6ktCgHSwiOHR/p7VZUJrvT5wRi6VvsuWfV
	8bp2h89zujSBilSIFEdBE1EzhhTcaStKvSAOsdFrpHfkUD/lEqjqAU5mCT9B/iqcmoRqcL
	7oMgHY+mwAXKJqtTk8+nXxy01G2UPFFBYBvPHyZBQXzU6vAmLVpBX0b50USroA==
Message-ID: <4d3f75c22f6f07ffd34ad78f1868e6c0d4969537.camel@iki.fi>
Subject: Re: [PATCH v8] Bluetooth: compute LE flow credits based on recvbuf
 space
From: Pauli Virtanen <pav@iki.fi>
To: Sebastian Urban <surban@surban.net>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 01 May 2024 13:43:22 +0300
In-Reply-To: <20240501100859.175690-1-surban@surban.net>
References: <20240501100859.175690-1-surban@surban.net>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2024-05-01 kello 12:08 +0200, Sebastian Urban kirjoitti:
> Previously LE flow credits were returned to the
> sender even if the socket's receive buffer was
> full. This meant that no back-pressure
> was applied to the sender, thus it continued to
> send data, resulting in data loss without any
> error being reported. Furthermore, the amount
> of credits was essentially fixed to a small
> amount, leading to reduced performance.
>=20
> This is fixed by computing the number of returned
> LE flow credits based on the estimated available
> space in the receive buffer of an L2CAP socket.
> Consequently, if the receive buffer is full, no
> credits are returned until the buffer is read and
> thus cleared by user-space.
>=20
> Since the computation of available receive buffer
> space can only be performed approximately (due to
> sk_buff overhead) and the receive buffer size may
> be changed by user-space after flow credits have
> been sent, superfluous received data is temporary
> stored within l2cap_pinfo. This is necessary
> because Bluetooth LE provides no retransmission
> mechanism once the data has been acked by the
> physical layer.
>=20
> If receive buffer space estimation is not possible
> at the moment, we fall back to providing credits
> for one full packet as before. This is currently
> the case during connection setup, when MPS is not
> yet available.
>=20
> Signed-off-by: Sebastian Urban <surban@surban.net>
> ---
>  include/net/bluetooth/l2cap.h | 11 ++++-
>  net/bluetooth/l2cap_core.c    | 56 ++++++++++++++++++---
>  net/bluetooth/l2cap_sock.c    | 91 ++++++++++++++++++++++++++++-------
>  3 files changed, 132 insertions(+), 26 deletions(-)
>=20
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index b6eac37f5b74..2dd77de38d1d 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -554,6 +554,9 @@ struct l2cap_chan {
>  	__u16		tx_credits;
>  	__u16		rx_credits;
> =20
> +	/* estimated available receive buffer space or -1 if unknown */
> +	ssize_t		rx_avail;
> +
>  	__u8		tx_state;
>  	__u8		rx_state;
> =20
> @@ -688,10 +691,15 @@ struct l2cap_user {
>  /* ----- L2CAP socket info ----- */
>  #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
> =20
> +struct l2cap_rx_busy {
> +	struct list_head	list;
> +	struct sk_buff		*skb;
> +};
> +
>  struct l2cap_pinfo {
>  	struct bt_sock		bt;
>  	struct l2cap_chan	*chan;
> -	struct sk_buff		*rx_busy_skb;
> +	struct list_head	rx_busy;

Does it need to be custom list, or could this be skb queue instead
(struct sk_buff_head)?

AFAICS, if these skb are going to go to __sock_queue_rcv_skb() they
probably can be put to queue before that.

> =20
>  enum {
> @@ -950,6 +958,7 @@ int l2cap_chan_reconfigure(struct l2cap_chan *chan, _=
_u16 mtu);
>  int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t =
len,
>  		    const struct sockcm_cookie *sockc);
>  void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
> +void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
>  int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
>  void l2cap_chan_set_defaults(struct l2cap_chan *chan);
>  int l2cap_ertm_init(struct l2cap_chan *chan);
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 142cc1eaeefa..b818660ae170 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -454,6 +454,9 @@ struct l2cap_chan *l2cap_chan_create(void)
>  	/* Set default lock nesting level */
>  	atomic_set(&chan->nesting, L2CAP_NESTING_NORMAL);
> =20
> +	/* Available receive buffer space is initially unknown */
> +	chan->rx_avail =3D -1;
> +
>  	write_lock(&chan_list_lock);
>  	list_add(&chan->global_l, &chan_list);
>  	write_unlock(&chan_list_lock);
> @@ -535,6 +538,28 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan=
)
>  }
>  EXPORT_SYMBOL_GPL(l2cap_chan_set_defaults);
> =20
> +static __u16 l2cap_le_rx_credits(struct l2cap_chan *chan)
> +{
> +	size_t sdu_len =3D chan->sdu ? chan->sdu->len : 0;
> +
> +	if (chan->mps =3D=3D 0)
> +		return 0;
> +
> +	/* If we don't know the available space in the receiver buffer, give
> +	 * enough credits for a full packet.
> +	 */
> +	if (chan->rx_avail =3D=3D -1)
> +		return (chan->imtu / chan->mps) + 1;
> +
> +	/* If we know how much space is available in the receive buffer, give
> +	 * out as many credits as would fill the buffer.
> +	 */
> +	if (chan->rx_avail <=3D sdu_len)
> +		return 0;
> +
> +	return DIV_ROUND_UP(chan->rx_avail - sdu_len, chan->mps);
> +}
> +
>  static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credit=
s)
>  {
>  	chan->sdu =3D NULL;
> @@ -543,8 +568,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *=
chan, u16 tx_credits)
>  	chan->tx_credits =3D tx_credits;
>  	/* Derive MPS from connection MTU to stop HCI fragmentation */
>  	chan->mps =3D min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
> -	/* Give enough credits for a full packet */
> -	chan->rx_credits =3D (chan->imtu / chan->mps) + 1;
> +	chan->rx_credits =3D l2cap_le_rx_credits(chan);
> =20
>  	skb_queue_head_init(&chan->tx_q);
>  }
> @@ -556,7 +580,7 @@ static void l2cap_ecred_init(struct l2cap_chan *chan,=
 u16 tx_credits)
>  	/* L2CAP implementations shall support a minimum MPS of 64 octets */
>  	if (chan->mps < L2CAP_ECRED_MIN_MPS) {
>  		chan->mps =3D L2CAP_ECRED_MIN_MPS;
> -		chan->rx_credits =3D (chan->imtu / chan->mps) + 1;
> +		chan->rx_credits =3D l2cap_le_rx_credits(chan);
>  	}
>  }
> =20
> @@ -6519,9 +6543,7 @@ static void l2cap_chan_le_send_credits(struct l2cap=
_chan *chan)
>  {
>  	struct l2cap_conn *conn =3D chan->conn;
>  	struct l2cap_le_credits pkt;
> -	u16 return_credits;
> -
> -	return_credits =3D (chan->imtu / chan->mps) + 1;
> +	u16 return_credits =3D l2cap_le_rx_credits(chan);
> =20
>  	if (chan->rx_credits >=3D return_credits)
>  		return;
> @@ -6540,6 +6562,19 @@ static void l2cap_chan_le_send_credits(struct l2ca=
p_chan *chan)
>  	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
>  }
> =20
> +void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail)
> +{
> +	if (chan->rx_avail =3D=3D rx_avail)
> +		return;
> +
> +	BT_DBG("chan %p has %zd bytes avail for rx", chan, rx_avail);
> +
> +	chan->rx_avail =3D rx_avail;
> +
> +	if (chan->state =3D=3D BT_CONNECTED)
> +		l2cap_chan_le_send_credits(chan);
> +}
> +
>  static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb=
)
>  {
>  	int err;
> @@ -6549,6 +6584,12 @@ static int l2cap_ecred_recv(struct l2cap_chan *cha=
n, struct sk_buff *skb)
>  	/* Wait recv to confirm reception before updating the credits */
>  	err =3D chan->ops->recv(chan, skb);
> =20
> +	if (err < 0 && chan->rx_avail !=3D -1) {
> +		BT_ERR("Queueing received LE L2CAP data failed");
> +		l2cap_send_disconn_req(chan, ECONNRESET);
> +		return err;
> +	}
> +
>  	/* Update credits whenever an SDU is received */
>  	l2cap_chan_le_send_credits(chan);
> =20
> @@ -6571,7 +6612,8 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *=
chan, struct sk_buff *skb)
>  	}
> =20
>  	chan->rx_credits--;
> -	BT_DBG("rx_credits %u -> %u", chan->rx_credits + 1, chan->rx_credits);
> +	BT_DBG("chan %p: rx_credits %u -> %u",
> +	       chan, chan->rx_credits + 1, chan->rx_credits);
> =20
>  	/* Update if remote had run out of credits, this should only happens
>  	 * if the remote is not using the entire MPS.
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 53a4c0db3be7..03d904d6bfc7 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1140,6 +1140,34 @@ static int l2cap_sock_sendmsg(struct socket *sock,=
 struct msghdr *msg,
>  	return err;
>  }
> =20
> +static void l2cap_publish_rx_avail(struct l2cap_chan *chan)
> +{
> +	struct sock *sk =3D chan->data;
> +	ssize_t avail =3D sk->sk_rcvbuf - atomic_read(&sk->sk_rmem_alloc);
> +	int expected_skbs, skb_overhead;
> +
> +	if (avail <=3D 0) {
> +		l2cap_chan_rx_avail(chan, 0);
> +		return;
> +	}
> +
> +	if (!chan->mps) {
> +		l2cap_chan_rx_avail(chan, -1);
> +		return;
> +	}
> +
> +	/* Correct available memory by estimated sk_buff overhead.
> +	 * This is significant due to small transfer sizes. However, accept
> +	 * at least one full packet if receive space is non-zero.
> +	 */
> +	expected_skbs =3D DIV_ROUND_UP(avail, chan->mps);
> +	skb_overhead =3D expected_skbs * sizeof(struct sk_buff);
> +	if (skb_overhead < avail)
> +		l2cap_chan_rx_avail(chan, avail - skb_overhead);
> +	else
> +		l2cap_chan_rx_avail(chan, -1);
> +}
> +
>  static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  			      size_t len, int flags)
>  {
> @@ -1180,28 +1208,33 @@ static int l2cap_sock_recvmsg(struct socket *sock=
, struct msghdr *msg,
>  	else
>  		err =3D bt_sock_recvmsg(sock, msg, len, flags);
> =20
> -	if (pi->chan->mode !=3D L2CAP_MODE_ERTM)
> +	if (pi->chan->mode !=3D L2CAP_MODE_ERTM &&
> +	    pi->chan->mode !=3D L2CAP_MODE_LE_FLOWCTL &&
> +	    pi->chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL)
>  		return err;
> =20
> -	/* Attempt to put pending rx data in the socket buffer */
> -
>  	lock_sock(sk);
> =20
> -	if (!test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state))
> -		goto done;
> +	l2cap_publish_rx_avail(pi->chan);
> =20
> -	if (pi->rx_busy_skb) {
> -		if (!__sock_queue_rcv_skb(sk, pi->rx_busy_skb))
> -			pi->rx_busy_skb =3D NULL;
> -		else
> +	/* Attempt to put pending rx data in the socket buffer */
> +	while (!list_empty(&pi->rx_busy)) {
> +		struct l2cap_rx_busy *rx_busy =3D
> +			list_first_entry(&pi->rx_busy,
> +					 struct l2cap_rx_busy,
> +					 list);
> +		if (__sock_queue_rcv_skb(sk, rx_busy->skb) < 0)
>  			goto done;
> +		list_del(&rx_busy->list);
> +		kfree(rx_busy);
>  	}
> =20
>  	/* Restore data flow when half of the receive buffer is
>  	 * available.  This avoids resending large numbers of
>  	 * frames.
>  	 */
> -	if (atomic_read(&sk->sk_rmem_alloc) <=3D sk->sk_rcvbuf >> 1)
> +	if (test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
> +	    atomic_read(&sk->sk_rmem_alloc) <=3D sk->sk_rcvbuf >> 1)
>  		l2cap_chan_busy(pi->chan, 0);
> =20
>  done:
> @@ -1462,17 +1495,20 @@ static struct l2cap_chan *l2cap_sock_new_connecti=
on_cb(struct l2cap_chan *chan)
>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *s=
kb)
>  {
>  	struct sock *sk =3D chan->data;
> +	struct l2cap_pinfo *pi =3D l2cap_pi(sk);
>  	int err;
> =20
>  	lock_sock(sk);
> =20
> -	if (l2cap_pi(sk)->rx_busy_skb) {
> +	if (chan->mode =3D=3D L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
>  		err =3D -ENOMEM;
>  		goto done;
>  	}
> =20
>  	if (chan->mode !=3D L2CAP_MODE_ERTM &&
> -	    chan->mode !=3D L2CAP_MODE_STREAMING) {
> +	    chan->mode !=3D L2CAP_MODE_STREAMING &&
> +	    chan->mode !=3D L2CAP_MODE_LE_FLOWCTL &&
> +	    chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL) {
>  		/* Even if no filter is attached, we could potentially
>  		 * get errors from security modules, etc.
>  		 */
> @@ -1483,7 +1519,9 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *ch=
an, struct sk_buff *skb)
> =20
>  	err =3D __sock_queue_rcv_skb(sk, skb);
> =20
> -	/* For ERTM, handle one skb that doesn't fit into the recv
> +	l2cap_publish_rx_avail(chan);
> +
> +	/* For ERTM and LE, handle a skb that doesn't fit into the recv
>  	 * buffer.  This is important to do because the data frames
>  	 * have already been acked, so the skb cannot be discarded.
>  	 *
> @@ -1492,8 +1530,18 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *c=
han, struct sk_buff *skb)
>  	 * acked and reassembled until there is buffer space
>  	 * available.
>  	 */
> -	if (err < 0 && chan->mode =3D=3D L2CAP_MODE_ERTM) {
> -		l2cap_pi(sk)->rx_busy_skb =3D skb;
> +	if (err < 0 &&
> +	    (chan->mode =3D=3D L2CAP_MODE_ERTM ||
> +	     chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> +	     chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL)) {
> +		struct l2cap_rx_busy *rx_busy =3D
> +			kmalloc(sizeof(*rx_busy), GFP_KERNEL);
> +		if (!rx_busy) {
> +			err =3D -ENOMEM;
> +			goto done;
> +		}
> +		rx_busy->skb =3D skb;
> +		list_add_tail(&rx_busy->list, &pi->rx_busy);
>  		l2cap_chan_busy(chan, 1);
>  		err =3D 0;
>  	}
> @@ -1719,6 +1767,8 @@ static const struct l2cap_ops l2cap_chan_ops =3D {
> =20
>  static void l2cap_sock_destruct(struct sock *sk)
>  {
> +	struct l2cap_rx_busy *rx_busy, *next;
> +
>  	BT_DBG("sk %p", sk);
> =20
>  	if (l2cap_pi(sk)->chan) {
> @@ -1726,9 +1776,10 @@ static void l2cap_sock_destruct(struct sock *sk)
>  		l2cap_chan_put(l2cap_pi(sk)->chan);
>  	}
> =20
> -	if (l2cap_pi(sk)->rx_busy_skb) {
> -		kfree_skb(l2cap_pi(sk)->rx_busy_skb);
> -		l2cap_pi(sk)->rx_busy_skb =3D NULL;
> +	list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, list) {
> +		kfree_skb(rx_busy->skb);
> +		list_del(&rx_busy->list);
> +		kfree(rx_busy);
>  	}
> =20
>  	skb_queue_purge(&sk->sk_receive_queue);
> @@ -1812,6 +1863,8 @@ static void l2cap_sock_init(struct sock *sk, struct=
 sock *parent)
> =20
>  	chan->data =3D sk;
>  	chan->ops =3D &l2cap_chan_ops;
> +
> +	l2cap_publish_rx_avail(chan);
>  }
> =20
>  static struct proto l2cap_proto =3D {
> @@ -1833,6 +1886,8 @@ static struct sock *l2cap_sock_alloc(struct net *ne=
t, struct socket *sock,
>  	sk->sk_destruct =3D l2cap_sock_destruct;
>  	sk->sk_sndtimeo =3D L2CAP_CONN_TIMEOUT;
> =20
> +	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
> +
>  	chan =3D l2cap_chan_create();
>  	if (!chan) {
>  		sk_free(sk);

--=20
Pauli Virtanen
