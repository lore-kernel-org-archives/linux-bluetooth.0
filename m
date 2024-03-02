Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301CC40847
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Mar 2024 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410074; cv=pass; b=dTLi3y/Z9MtcJv1h0FFeb4fvOf+1leGtQ0wGqq546/7m79C9jyiD1ruJokChccPF0WO3zTiPTDSWBpXOV3HJ145uzY5dcacc1uJ0rCp8dAmYjIbo8CZT2Fk6VL8XFchkso+GqUopbo9sz+hJpdjxgqcH5d3WWIBAc0+AUbo1jIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410074; c=relaxed/simple;
	bh=+/xvom5mfne17LXSydbTnDY/e4A8mQIUOXTRL6flW+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+2Vk2F7XpPSrvankmAq0dbyu0qs27Uupj9KOXU+HQy9B4zAbpvIeIgtHugQohhL68UZNtqBytCu3LWMlqdhVnzflXDkHvQH9LKmgNaMyqusE3LxA5lqqd04kH8oTuHgErAQ6Vk3pkXwsaIuQZzVny26ylkmYEfiuKqdYEG7IgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=maXbWl8w; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="maXbWl8w"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TnGGZ2ssYzyys;
	Sat,  2 Mar 2024 22:07:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709410071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsLZgdDHfimWlUePJ4AqPklJXSpJwRJMFjiDb6ZlYj8=;
	b=maXbWl8wzC7QIljbAVK8Cf82w7hAeenyLRsrtV3r7+D7U8N996Q3ymIPat/KNN4T2e0ePc
	utq+1MJW54dNe45/8i0McZeGRLokBTdlYmSJrb805FEdWPfUqXxlubAKFdNVxjai8NKo0Q
	2aV4o8zKMI6agg6BdNvZNenmHH2991A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709410071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsLZgdDHfimWlUePJ4AqPklJXSpJwRJMFjiDb6ZlYj8=;
	b=NLtIXP1NZ25I7bq5OJN5Eer3qH3vLo6vVTQn7frOHCTQoZ8Zbv1KcPnR5z7angj+blfpxe
	7cXEVrCO+m2lXHYz9a/WgWAQ/Dw5Oqq4FLd8jpLsGvIpFI715DR02wRuQtMTbPcF6fN73i
	apwv1h28bKm8mMkQ2DNAUC9Eq2mo7x0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709410071; a=rsa-sha256; cv=none;
	b=DkCoIBnUfQ2NA5TJh32JquBLNMHJo/3A+6clI45P/u5MPFMdsI323p3120Zf6pkXnWkeMg
	CvpcsD0/qq2fP1FvBEZNSyQXZt0O5LbLFgi9Mlh4oMQqUUTCFaZiMaXh31BczxTachoiOh
	bTTiE1/NoNuHjAuubN+hHZKlj7oe34s=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 3/3] Bluetooth: L2CAP: add TX timestamping
Date: Sat,  2 Mar 2024 22:07:38 +0200
Message-ID: <68605b0923b5b57785cb00c7f60dc50d92c770b3.1709409547.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709409547.git.pav@iki.fi>
References: <cover.1709409547.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support TX timestamping in L2CAP sockets.

Support MSG_ERRQUEUE recvmsg.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/l2cap.h |  3 ++-
 net/bluetooth/6lowpan.c       |  2 +-
 net/bluetooth/l2cap_core.c    | 11 ++++++++++-
 net/bluetooth/l2cap_sock.c    | 15 ++++++++++++++-
 net/bluetooth/smp.c           |  2 +-
 5 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a4278aa618ab..3f4057ced971 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -941,7 +941,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type, u16 timeout);
 int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu);
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
+int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
+		    const struct sockcm_cookie *sockc);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 27520a8a486f..24635f9e758a 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -443,7 +443,7 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 	memset(&msg, 0, sizeof(msg));
 	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iv, 1, skb->len);
 
-	err = l2cap_chan_send(chan, &msg, skb->len);
+	err = l2cap_chan_send(chan, &msg, skb->len, NULL);
 	if (err > 0) {
 		netdev->stats.tx_bytes += err;
 		netdev->stats.tx_packets++;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 467b242d8be0..cf3b8e9b7b3b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2488,7 +2488,8 @@ static void l2cap_le_flowctl_send(struct l2cap_chan *chan)
 	       skb_queue_len(&chan->tx_q));
 }
 
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
+int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
+		    const struct sockcm_cookie *sockc)
 {
 	struct sk_buff *skb;
 	int err;
@@ -2503,6 +2504,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
+		hci_tx_timestamp(skb, sockc);
+
 		l2cap_do_send(chan, skb);
 		return len;
 	}
@@ -2526,6 +2529,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (err)
 			return err;
 
+		hci_tx_timestamp(skb_peek(&seg_queue), sockc);
+
 		skb_queue_splice_tail_init(&seg_queue, &chan->tx_q);
 
 		l2cap_le_flowctl_send(chan);
@@ -2547,6 +2552,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
+		hci_tx_timestamp(skb, sockc);
+
 		l2cap_do_send(chan, skb);
 		err = len;
 		break;
@@ -2570,6 +2577,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (err)
 			break;
 
+		hci_tx_timestamp(skb_peek(&seg_queue), sockc);
+
 		if (chan->mode == L2CAP_MODE_ERTM)
 			l2cap_tx(chan, NULL, &seg_queue, L2CAP_EV_DATA_REQUEST);
 		else
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4287aa6cc988..9a9f933a748b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1115,6 +1115,7 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct sockcm_cookie sockc;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -1129,6 +1130,14 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (sk->sk_state != BT_CONNECTED)
 		return -ENOTCONN;
 
+	sockcm_init(&sockc, sk);
+
+	if (msg->msg_controllen) {
+		err = sock_cmsg_send(sk, msg, &sockc);
+		if (err)
+			return err;
+	}
+
 	lock_sock(sk);
 	err = bt_sock_wait_ready(sk, msg->msg_flags);
 	release_sock(sk);
@@ -1136,7 +1145,7 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		return err;
 
 	l2cap_chan_lock(chan);
-	err = l2cap_chan_send(chan, msg, len);
+	err = l2cap_chan_send(chan, msg, len, &sockc);
 	l2cap_chan_unlock(chan);
 
 	return err;
@@ -1149,6 +1158,10 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int err;
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
+					  BT_SCM_ERROR);
+
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECT2 && test_bit(BT_SK_DEFER_SETUP,
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1e7ea3a4b7ef..4612115ec09a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -608,7 +608,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 
 	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iv, 2, 1 + len);
 
-	l2cap_chan_send(chan, &msg, 1 + len);
+	l2cap_chan_send(chan, &msg, 1 + len, NULL);
 
 	if (!chan->data)
 		return;
-- 
2.44.0

