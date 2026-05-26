Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6625A2B5
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827946; cv=none; b=cp7SqaiwWGYIGPijBmMhnrmOqzcV7DO4q4tQD01s2MTuMak6DdHAYjvsy8dUS9CzxHK/bvGKx9atJX8i3KJ11FeEy1fFQqJdWykA4pR1+fll1+RwFcTCzBQKFQNVhGti19VSHAbMX8At626jdX9QRrkY7MGCFHTfiINBpe7egMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827946; c=relaxed/simple;
	bh=IUMZa0lO8P9DyZlsOrxNBW6GpWIDn/O/Ebpp6vKNCos=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VQPcreQUNv73Reiw/gbrAAKUUM4FoAqyi+7nW/Qlzpkz10fjQWIcL77tqRIkoeZTUdx7f/tCcMTDpCudHyt9HtdnGPWP5NjHH+8r7+TUMPghXZsIK2KCG1H47lHwvja49AvyrbBKlGeAeqvUvaokN+fdhxTOqXQTNH+ZjsUAHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=ZuO6llyT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0xRrbXE; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="ZuO6llyT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0xRrbXE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BBC84EC0627;
	Tue, 26 May 2026 16:39:03 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Tue, 26 May 2026 16:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779827943;
	 x=1779914343; bh=njQtgqxYHLi+40YMm+L8gY4/DY4t6FwUX+nCnTBVi04=; b=
	ZuO6llyTEiy/jK+Ms7E+w4JpuOqzEJSE7m7+NMOt8L7ppuERq9esTOmYebSDZiLk
	grAB0yoeMSUF8Ipw76VJ23d6W6VoVQOECr/b9+N+mAxMj+lX0IrSU8Y2qY5Li7+u
	AiaYauObodcFe4cSp+zsZnp4VhtiMd6oZBU0omvWYZh4avrkkOnsnr88R616DQLp
	71T2Daialxj58Rac/dLGN6Pbq7YFLREa9asBMa3HlN3Gjf5aiFXVKMRur09cvS9H
	GxINuU66nZwPQ2Mi0bX4ck64wXvgCUoqf78xpQX7X+5h9A3+EDZjHYVwrfXszlhE
	Rgbj95LTB1E5C5Ougq0McQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779827943; x=
	1779914343; bh=njQtgqxYHLi+40YMm+L8gY4/DY4t6FwUX+nCnTBVi04=; b=a
	0xRrbXEJL9IB+JFojI8HMqJVVeMGSaaRcC3El1CD1MuAd2rqNCWOV9sj3tYii9/C
	lbPPLtznKFisDoc+49OtD5oiyxYpbVTxGAgRtfCZBE1CM2ykQV6MsQBWcBVTbT2x
	0Z1oAYza5ZmOqNrSHYNaDWP5bh7H2BKGKRFk+peE+D4MDhP0p4OtmK5kGD0W3XCn
	DMlCoOjp6pFGoygMevUIBtyYKJ5Wy5JO0HD4izF5i5rgkCkM8l2URqtFcESNb79i
	F79dLrID6hs1V57X1xTMZoPpY7/PMkMrAfph0KkeLgru7gTPJGdSzctSey7gAw0y
	lOQ/MxtzHtVolUcw/DCwA==
X-ME-Sender: <xms:5wQWarbh-6bd17IoQm0CRfguXOhAjNk-Oj5v-iG4WI8GQTr6x-WJDg>
    <xme:5wQWalNyXykkk8vVBnJj9eZe8LC4uAAjfwlViRx60hi8otPVbzYapYtQgjr9coVS1
    jHrO_Ji7oaO0KixDnDj8-tl5_h7HqORKCnXqz95hce1E7sPZ0A-svo>
X-ME-Proxy-Cause: dmFkZTEe1Q6CeobFu9HY5BUJBau+RDCf9ZSxsjloKTk36wgiUjoYC9HrQjcyZXgtjvAZeN
    0Tw8cow3Z4YA2pjDmGk9Nt34iWZ2ASxPvA9oT8Vjid2tdtIp8VjzYvLwzdtUthBWJ1fFY2
    Fz4LnqD5dgzKl/hwBP8o4fid3sjaNqvJzYjBILMXpUJtKC2sIpJ1Mo0XYsLL7LmK/FzmcZ
    Vt0eKRTgvXoD2K8prHmEsaECdsHGpJBG9hK47vKR3NnPl1C3xJQn5NpE8L773fgi22LqSN
    UCXLO1cVVI7vo0etdwDk9S9XJXEUCr6z1/q/X/B0L9mXiZUTR5xaFWR9nNxh81ySloliO5
    km1JhT8HZXhhAgz71pRowPhb2RGtDTb8q9ocffG9pV85/vBNryJ4Dyy/CEFTHDi+FEYgDS
    VoNVI4GEp3T6mJJjf2EIiZSNzBEOVca9k2AAqPwv0yu7ETVLvl0QO3TBPMrEefu3mlvtnv
    Iy4XBp5ewvQM8Z6w0TU/MGyn9p4EhgebtNbw+RLyWiRN3KnwAUonGmoQFRi4lMVP+50LWh
    KNI74KExruHYvGcqhoAWp4fbANBou15IgZSX6Iy2f8S+ATe6UZn1TOTpCtO+z69K63JMrV
    ri8t0+NbNH3sbHqyzevREebLEYHMvmsZKRvqUaJOwL0rNJvhUfOdce9aj12w
X-ME-Proxy: <xmx:5wQWat2-VxuiTmDWGhCynF8NE8M829H24gHahXZRmyXghDXPn_X6tQ>
    <xmx:5wQWar1VXfy2yHEoSvHBZ4as3ejgI3n8mxYZsJJxbsFU0sIo8aX3ew>
    <xmx:5wQWag_LYqmihHn7A3tYNoWHqMSB7x1ZDhAI6QX1oWpqc1GpIpn9NA>
    <xmx:5wQWao1w5R-T_8J6WaHCVnwdSVdHvuWwxifV2PBlR-PcO0RKf4G7FQ>
    <xmx:5wQWasoXFsHFyqCseNmXRonkze0zao5VCilCTkEbqidnTDtGTxSaRmbX>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 82C95216008A; Tue, 26 May 2026 16:39:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvY6Iv3jnud7
Date: Tue, 26 May 2026 16:38:43 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, "Marcel Holtmann" <marcel@holtmann.org>
Message-Id: <8344cbe8-f539-4da3-a965-a297ef2952d2@app.fastmail.com>
In-Reply-To: <20260520162030.2842543-2-oss@fourdim.xyz>
References: <20260520162030.2842543-1-oss@fourdim.xyz>
 <20260520162030.2842543-2-oss@fourdim.xyz>
Subject: Re: [PATCH v5 1/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Luiz,

On Wed, May 20, 2026, at 12:20 PM, Siwei Zhang wrote:
> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
> release_sock(parent). Once the parent lock is released, the child
> socket sk can be freed by another task.
>
> Allocate the channel outside the func to prevent this.
>
> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2cap_core.c")
> Cc: stable@kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  include/net/bluetooth/l2cap.h |  8 +++--
>  net/bluetooth/6lowpan.c       | 14 ++++-----
>  net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++-------
>  net/bluetooth/l2cap_sock.c    | 48 +++++++++++++++++------------
>  net/bluetooth/smp.c           | 13 +++-----
>  5 files changed, 91 insertions(+), 50 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 5172afee5494..f7a11e6431f0 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -619,7 +619,8 @@ struct l2cap_chan {
>  struct l2cap_ops {
>  	char			*name;
> 
> -	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
> +	int			(*new_connection)(struct l2cap_chan *chan,
> +						  struct l2cap_chan *new_chan);
>  	int			(*recv) (struct l2cap_chan * chan,
>  					 struct sk_buff *skb);
>  	void			(*teardown) (struct l2cap_chan *chan, int err);
> @@ -883,9 +884,10 @@ static inline __u16 __next_seq(struct l2cap_chan 
> *chan, __u16 seq)
>  	return (seq + 1) % (chan->tx_win_max + 1);
>  }
> 
> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct 
> l2cap_chan *chan)
> +static inline int l2cap_chan_no_new_connection(struct l2cap_chan *chan,
> +					       struct l2cap_chan *new_chan)
>  {
> -	return NULL;
> +	return -EOPNOTSUPP;
>  }
> 
>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct 
> sk_buff *skb)
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 23a229ab6a33..286c0b45055b 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -743,19 +743,19 @@ static inline void chan_ready_cb(struct 
> l2cap_chan *chan)
>  	ifup(dev->netdev);
>  }
> 
> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
> +static inline int chan_new_conn_cb(struct l2cap_chan *pchan,
> +				   struct l2cap_chan *chan)
>  {
> -	struct l2cap_chan *chan;
> -
> -	chan = chan_create();
> -	if (!chan)
> -		return NULL;
> +	l2cap_chan_set_defaults(chan);
> 
> +	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
> +	chan->mode = L2CAP_MODE_LE_FLOWCTL;
> +	chan->imtu = 1280;
>  	chan->ops = pchan->ops;
> 
>  	BT_DBG("chan %p pchan %p", chan, pchan);
> 
> -	return chan;
> +	return 0;
>  }
> 
>  static void unregister_dev(struct lowpan_btle_dev *dev)
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index fdccd62ccca8..505f32034971 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4051,10 +4051,16 @@ static void l2cap_connect(struct l2cap_conn 
> *conn, struct l2cap_cmd_hdr *cmd,
>  		goto response;
>  	}
> 
> -	chan = pchan->ops->new_connection(pchan);
> +	chan = l2cap_chan_create();
>  	if (!chan)
>  		goto response;
> 
> +	if (pchan->ops->new_connection(pchan, chan) < 0) {
> +		l2cap_chan_put(chan);
> +		chan = NULL;
> +		goto response;
> +	}
> +
>  	/* For certain devices (ex: HID mouse), support for authentication,
>  	 * pairing and bonding is optional. For such devices, inorder to avoid
>  	 * the ACL alive for too long after L2CAP disconnection, reset the ACL
> @@ -4132,6 +4138,10 @@ static void l2cap_connect(struct l2cap_conn 
> *conn, struct l2cap_cmd_hdr *cmd,
>  		chan->num_conf_req++;
>  	}
> 
> +	/* Drop our local ref; __l2cap_chan_add() pinned chan via the conn list. */
> +	if (chan)
> +		l2cap_chan_put(chan);
> +
>  	l2cap_chan_unlock(pchan);
>  	l2cap_chan_put(pchan);
>  }
> @@ -4881,6 +4891,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
>  	struct l2cap_le_conn_rsp rsp;
>  	struct l2cap_chan *chan, *pchan;
>  	u16 dcid, scid, credits, mtu, mps;
> +	u16 rsp_mtu, rsp_mps;
>  	__le16 psm;
>  	u8 result;
> 
> @@ -4893,6 +4904,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
>  	psm  = req->psm;
>  	dcid = 0;
>  	credits = 0;
> +	rsp_mtu = 0;
> +	rsp_mps = 0;
> 
>  	if (mtu < 23 || mps < 23)
>  		return -EPROTO;
> @@ -4953,12 +4966,19 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
>  		goto response_unlock;
>  	}
> 
> -	chan = pchan->ops->new_connection(pchan);
> +	chan = l2cap_chan_create();
>  	if (!chan) {
>  		result = L2CAP_CR_LE_NO_MEM;
>  		goto response_unlock;
>  	}
> 
> +	if (pchan->ops->new_connection(pchan, chan) < 0) {
> +		l2cap_chan_put(chan);
> +		chan = NULL;
> +		result = L2CAP_CR_LE_NO_MEM;
> +		goto response_unlock;
> +	}
> +
>  	bacpy(&chan->src, &conn->hcon->src);
>  	bacpy(&chan->dst, &conn->hcon->dst);
>  	chan->src_type = bdaddr_src_type(conn->hcon);
> @@ -4974,6 +4994,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
> 
>  	dcid = chan->scid;
>  	credits = chan->rx_credits;
> +	rsp_mtu = chan->imtu;
> +	rsp_mps = chan->mps;
> 
>  	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
> 
> @@ -4993,6 +5015,9 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
>  		result = L2CAP_CR_LE_SUCCESS;
>  	}
> 
> +	/* Drop our local ref; __l2cap_chan_add() pinned chan via the conn list. */
> +	l2cap_chan_put(chan);
> +
>  response_unlock:
>  	l2cap_chan_unlock(pchan);
>  	l2cap_chan_put(pchan);
> @@ -5001,13 +5026,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
>  		return 0;
> 
>  response:
> -	if (chan) {
> -		rsp.mtu = cpu_to_le16(chan->imtu);
> -		rsp.mps = cpu_to_le16(chan->mps);
> -	} else {
> -		rsp.mtu = 0;
> -		rsp.mps = 0;
> -	}
> +	rsp.mtu = cpu_to_le16(rsp_mtu);
> +	rsp.mps = cpu_to_le16(rsp_mps);
> 
>  	rsp.dcid    = cpu_to_le16(dcid);
>  	rsp.credits = cpu_to_le16(credits);
> @@ -5177,12 +5197,18 @@ static inline int l2cap_ecred_conn_req(struct 
> l2cap_conn *conn,
>  			continue;
>  		}
> 
> -		chan = pchan->ops->new_connection(pchan);
> +		chan = l2cap_chan_create();
>  		if (!chan) {
>  			result = L2CAP_CR_LE_NO_MEM;
>  			continue;
>  		}
> 
> +		if (pchan->ops->new_connection(pchan, chan) < 0) {
> +			l2cap_chan_put(chan);
> +			result = L2CAP_CR_LE_NO_MEM;
> +			continue;
> +		}
> +
>  		bacpy(&chan->src, &conn->hcon->src);
>  		bacpy(&chan->dst, &conn->hcon->dst);
>  		chan->src_type = bdaddr_src_type(conn->hcon);
> @@ -5217,6 +5243,9 @@ static inline int l2cap_ecred_conn_req(struct 
> l2cap_conn *conn,
>  		} else {
>  			l2cap_chan_ready(chan);
>  		}
> +
> +		/* Drop our local ref; __l2cap_chan_add() pinned chan via the conn 
> list. */
> +		l2cap_chan_put(chan);
>  	}
> 
>  unlock:
> @@ -7399,7 +7428,11 @@ static void l2cap_connect_cfm(struct hci_conn 
> *hcon, u8 status)
>  			goto next;
> 
>  		l2cap_chan_lock(pchan);
> -		chan = pchan->ops->new_connection(pchan);
> +		chan = l2cap_chan_create();
> +		if (chan && pchan->ops->new_connection(pchan, chan) < 0) {
> +			l2cap_chan_put(chan);
> +			chan = NULL;
> +		}
>  		if (chan) {
>  			bacpy(&chan->src, &hcon->src);
>  			bacpy(&chan->dst, &hcon->dst);
> @@ -7407,6 +7440,9 @@ static void l2cap_connect_cfm(struct hci_conn 
> *hcon, u8 status)
>  			chan->dst_type = dst_type;
> 
>  			__l2cap_chan_add(conn, chan);
> +
> +			/* Drop our local ref; __l2cap_chan_add() pinned chan via the conn list. */
> +			l2cap_chan_put(chan);
>  		}
> 
>  		l2cap_chan_unlock(pchan);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index dede550d6031..598f24c8f704 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list = {
>  static const struct proto_ops l2cap_sock_ops;
>  static void l2cap_sock_init(struct sock *sk, struct sock *parent);
>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
> -				     int proto, gfp_t prio, int kern);
> +				     int proto, gfp_t prio, int kern,
> +				     struct l2cap_chan *chan);
>  static void l2cap_sock_cleanup_listen(struct sock *parent);
> 
>  bool l2cap_is_socket(struct socket *sock)
> @@ -1507,12 +1508,13 @@ static void l2cap_sock_cleanup_listen(struct 
> sock *parent)
>  	}
>  }
> 
> -static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
> +static int l2cap_sock_new_connection_cb(struct l2cap_chan *chan,
> +					struct l2cap_chan *new_chan)
>  {
>  	struct sock *sk, *parent = chan->data;
> 
>  	if (!parent)
> -		return NULL;
> +		return -EINVAL;
> 
>  	lock_sock(parent);
> 
> @@ -1520,15 +1522,15 @@ static struct l2cap_chan 
> *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
>  	if (sk_acceptq_is_full(parent)) {
>  		BT_DBG("backlog full %d", parent->sk_ack_backlog);
>  		release_sock(parent);
> -		return NULL;
> +		return -ENOBUFS;
>  	}
> 
>  	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
> -			      GFP_ATOMIC, 0);
> +			      GFP_ATOMIC, 0, new_chan);
>  	if (!sk) {
>  		release_sock(parent);
> -		return NULL;
> -        }
> +		return -ENOMEM;
> +	}
> 
>  	bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
> 
> @@ -1538,7 +1540,7 @@ static struct l2cap_chan 
> *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
> 
>  	release_sock(parent);
> 
> -	return l2cap_pi(sk)->chan;
> +	return 0;
>  }
> 
>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
> @@ -1939,10 +1941,10 @@ static struct proto l2cap_proto = {
>  };
> 
>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
> -				     int proto, gfp_t prio, int kern)
> +				     int proto, gfp_t prio, int kern,
> +				     struct l2cap_chan *chan)
>  {
>  	struct sock *sk;
> -	struct l2cap_chan *chan;
> 
>  	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
>  	if (!sk)
> @@ -1953,14 +1955,11 @@ static struct sock *l2cap_sock_alloc(struct net 
> *net, struct socket *sock,
> 
>  	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
> 
> -	chan = l2cap_chan_create();
> -	if (!chan) {
> -		sk_free(sk);
> -		if (sock)
> -			sock->sk = NULL;
> -		return NULL;
> -	}
> -
> +	/* The sock owns two refs on chan, matching the puts in
> +	 * l2cap_sock_kill() and l2cap_sock_destruct(). The caller keeps
> +	 * its own ref independent of these.
> +	 */
> +	l2cap_chan_hold(chan);
>  	l2cap_chan_hold(chan);
> 
>  	l2cap_pi(sk)->chan = chan;
> @@ -1972,6 +1971,7 @@ static int l2cap_sock_create(struct net *net, 
> struct socket *sock, int protocol,
>  			     int kern)
>  {
>  	struct sock *sk;
> +	struct l2cap_chan *chan;
> 
>  	BT_DBG("sock %p", sock);
> 
> @@ -1986,10 +1986,18 @@ static int l2cap_sock_create(struct net *net, 
> struct socket *sock, int protocol,
> 
>  	sock->ops = &l2cap_sock_ops;
> 
> -	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
> -	if (!sk)
> +	chan = l2cap_chan_create();
> +	if (!chan)
>  		return -ENOMEM;
> 
> +	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, chan);
> +	if (!sk) {
> +		l2cap_chan_put(chan);
> +		return -ENOMEM;
> +	}
> +	/* Sock has taken its own refs on chan; drop the chan_create() ref. */
> +	l2cap_chan_put(chan);
> +
>  	l2cap_sock_init(sk, NULL);
>  	bt_sock_link(&l2cap_sk_list, sk);
>  	return 0;
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 1739c1989dbd..25cb5dc580bf 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -3204,16 +3204,11 @@ static const struct l2cap_ops smp_chan_ops = {
>  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
>  };
> 
> -static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
> +static inline int smp_new_conn_cb(struct l2cap_chan *pchan,
> +				  struct l2cap_chan *chan)
>  {
> -	struct l2cap_chan *chan;
> -
>  	BT_DBG("pchan %p", pchan);
> 
> -	chan = l2cap_chan_create();
> -	if (!chan)
> -		return NULL;
> -
>  	chan->chan_type	= pchan->chan_type;
>  	chan->ops	= &smp_chan_ops;
>  	chan->scid	= pchan->scid;
> @@ -3229,9 +3224,9 @@ static inline struct l2cap_chan 
> *smp_new_conn_cb(struct l2cap_chan *pchan)
>  	 */
>  	atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
> 
> -	BT_DBG("created chan %p", chan);
> +	BT_DBG("initialised chan %p", chan);
> 
> -	return chan;
> +	return 0;
>  }
> 
>  static const struct l2cap_ops smp_root_chan_ops = {
> -- 
> 2.54.0

Could you please check this?

Best,
Siwei
