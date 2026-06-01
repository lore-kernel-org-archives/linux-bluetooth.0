Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8872D7814
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322706; cv=none; b=uDyZJVK1WjpKeILU2UtOCwav3vyEmoYsw1kTzNYTzOk7vD01nv/dRbdkGLLQz8ExFLQ4MLRtW68qAIskGWIsALfktChSNjAU7Rbj1T4eS8lrh84BhhbTLClYFVx15fPliDzn1iLuXE2nQ6DKMe/sgx4u+MvYOy/BtH+OJ9QOzcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322706; c=relaxed/simple;
	bh=hxVLS8JDU/gWbqJ+JhWL0Q+eKGu5h4sk2Tlz2mOCiJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdF61tOrpEqmF7tCzZbuMSud9EvcvMfVxroywym3UWLjE3D1FSkaMbqqPCBsKzXPgnS+3vgTCNLb7dNMSEZi5tOKolnYvzo2jBvLlB1BFMfOgRFKJi6I0UzZXicY60Yqh/Yh2HLmR8WEXMHHpvIGs4RJ65DFrqOqXRRA8XJM71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=OIOliIeC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIveb2U5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="OIOliIeC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIveb2U5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25110140009B;
	Mon,  1 Jun 2026 10:05:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 10:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780322704; x=
	1780409104; bh=7usMlLRjYj96fX/cQhMBKp6yWBn3cghlX1r6mpjwBu4=; b=O
	IOliIeCPe3IalXerjQiyHS3QqHR5nBUGhKE8cxIXk0YXvQbE8T2a8kDOvRlALJ7D
	ZTluoll8zEU36IxlJzF8fVnmbCdjKWVHK/uCJ+amqfEuDfgQT6yU/vcF3nF/dGGK
	D9AGJoxpBYePoIA1lbqcuMvmLQ/PKUjMg87i1FKqxUr2hBLUzpnCbxFHz/SQao2h
	GisJ+iZt/+bkUsPSegKHsSKESOYnD5urvHfqpEKuN15bpgV1HyEVFI5lM2W0h2sg
	QwOoE4rz13JM6fpASBh0zU4H+rmpS3JHPAolfhya23D/+hLu/AFMWd7dNHugd+4b
	l4v7SyFANtNjKOHv0Hq1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780322704; x=1780409104; bh=7
	usMlLRjYj96fX/cQhMBKp6yWBn3cghlX1r6mpjwBu4=; b=JIveb2U5vhdeES3i/
	ylLqCih73in5idcYksK5VjESTARQkf0ou73BKQzZ3eVmwqQ7QWzYeLNll3IgChfL
	c6XBSR4cDOg1xV0OrzL2p0Z8EibRQSinvxco44bvNU4uySnw2GP7be6Luicr/EW7
	MX9axFm/svEQYXNI0PzBp3torPu9mi/8bXN037w9iHQHLwAQ4MAi7tfSqErCC1R3
	TVP4VRtYD6jz20FOa1i+oP0pJ79T24qRyEF2Qh6yINlsBUC4HIdxSTryaO1rivXC
	/KDts+VqY1vczEVtvB/FMQdoFJt11PWuqbmlA9T+b56wjFvplMSehkJTeQdNM01V
	rvNpg==
X-ME-Sender: <xms:kJEdamXsy2PF1VbAl4jElVE6K9zVY7c90BaZJFIa2gIis1oxVXrdHQ>
    <xme:kJEdapklgZrv1XdPu-N3Sw0MftmMLNEMNDjic-cWnxBCkos512uL1bOsUNxZqk1gC
    93Ssw9pqyGnlkJQEJx646Lqe7FS3hAdLrCawa8owjN0Dl4bv5EUkg>
X-ME-Received: <xmr:kJEdavaFupWbh-nFL1F2w_7O15OJRyHRP5DkiHb2ajwyubbu4GRF6gOwK2McP2VmLn8df1s>
X-ME-Proxy-Cause: dmFkZTGUtjAYSPK6fAhQBZksAB5nZCr/DYCy3puR02fY20ioYA8Dyj9KAYc/zRUy6BKJzF
    AQ59qU5i4kK4fe87EK/vPLdzenMFIpabKv9cZHeoLUkAnYPcO09gf72gFnFf4wYCppCTE2
    rXLak3IdHIDiigzCiRTjTLMsGqwL53fXpFfalYdmoKP6345JdcUvdkg0BBaPhSqGKGk2QS
    o6ujGAZjM/Wo+xBqMl6+/Sep289vTfgRSiMf/36hRl/PXSWH4hklR2F7qnSL8qFMFQp2rG
    zldq0eqZaLpmfzmuy/4G+GTU7VgDtN5cwCqUPFBbaeMy1DwR+i2sRt2OQVo1o/mpW7gXaz
    55NYD3lRE8Osb/TZUaWgGhsedQ7HmPGMw4kEGnUbBW8racAOlFUrBqewwgzES/nJrz/2Qf
    Vy+ueCEsSmy1pY1ZzXe+lXMLeT/1s5fEI+R/DxOaq0FpMWhyHdGPX/Fmk2TzlqNyHcx84K
    EILkGg2/hz6scfD48gzkfCQCCS4Z8ejJgLjRR9Fp+gWN5Wz2Aq+muU8jx27tHOT/zBQM6m
    /LemXqg5UfLk6XetbJBMi6xhnmaogfhMAZH7jRiEBes7tjlYQAmYgCwHSfEiOMIoweOKjX
    hx3w1kV44lxRZpGditWhDtNEoPxtCJgpxl6R1LRo4iWIwvtMRziqnlb/pxzQ
X-ME-Proxy: <xmx:kJEdasMbrgBXktY54VQJSNbL_BZw_vm_y-vSH3cAVPrIOJaz1qO-ng>
    <xmx:kJEdasY5GBY24n5iiR48IIKJAmTbVMGbdKilP9pFlX-LqJGwhbMrmA>
    <xmx:kJEdai3LVnFu1sWX6jC_vj54kTt61x93nf47CrjSyIAtltm9OwS3ug>
    <xmx:kJEdaqcD5hdHhFfdfQTD0AALfLd4sKap3G535tFqmx89niad38CB5w>
    <xmx:kJEdagI6wfbj26RvoFjgpHXhYZOg5dUrnXQDXZxMBC6cUCIWdM7bgLjJ>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 10:05:02 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v7 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Mon,  1 Jun 2026 10:03:59 -0400
Message-ID: <20260601140444.1676239-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601140444.1676239-1-oss@fourdim.xyz>
References: <20260601140444.1676239-1-oss@fourdim.xyz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
release_sock(parent). Once the parent lock is released, the child
socket sk can be freed by another task.

Allocate the channel outside the func to prevent this.

Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2cap_core.c")
Cc: stable@kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 include/net/bluetooth/l2cap.h |  8 +++--
 net/bluetooth/6lowpan.c       | 32 +++++++++++--------
 net/bluetooth/l2cap_core.c    | 60 ++++++++++++++++++++++++++---------
 net/bluetooth/l2cap_sock.c    | 48 ++++++++++++++++------------
 net/bluetooth/smp.c           | 18 +++++------
 5 files changed, 106 insertions(+), 60 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5172afee5494..f7a11e6431f0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -619,7 +619,8 @@ struct l2cap_chan {
 struct l2cap_ops {
 	char			*name;
 
-	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
+	int			(*new_connection)(struct l2cap_chan *chan,
+						  struct l2cap_chan *new_chan);
 	int			(*recv) (struct l2cap_chan * chan,
 					 struct sk_buff *skb);
 	void			(*teardown) (struct l2cap_chan *chan, int err);
@@ -883,9 +884,10 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
 	return (seq + 1) % (chan->tx_win_max + 1);
 }
 
-static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2cap_chan *chan)
+static inline int l2cap_chan_no_new_connection(struct l2cap_chan *chan,
+					       struct l2cap_chan *new_chan)
 {
-	return NULL;
+	return -EOPNOTSUPP;
 }
 
 static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct sk_buff *skb)
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 23a229ab6a33..284eefb73e94 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -622,6 +622,15 @@ static bool is_bt_6lowpan(struct hci_conn *hcon)
 	return true;
 }
 
+static void chan_init(struct l2cap_chan *chan)
+{
+	l2cap_chan_set_defaults(chan);
+
+	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
+	chan->mode = L2CAP_MODE_LE_FLOWCTL;
+	chan->imtu = 1280;
+}
+
 static struct l2cap_chan *chan_create(void)
 {
 	struct l2cap_chan *chan;
@@ -630,11 +639,7 @@ static struct l2cap_chan *chan_create(void)
 	if (!chan)
 		return NULL;
 
-	l2cap_chan_set_defaults(chan);
-
-	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
-	chan->mode = L2CAP_MODE_LE_FLOWCTL;
-	chan->imtu = 1280;
+	chan_init(chan);
 
 	return chan;
 }
@@ -743,19 +748,20 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
 	ifup(dev->netdev);
 }
 
-static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
+static inline int chan_new_conn_cb(struct l2cap_chan *pchan,
+				   struct l2cap_chan *chan)
 {
-	struct l2cap_chan *chan;
-
-	chan = chan_create();
-	if (!chan)
-		return NULL;
-
+	chan_init(chan);
 	chan->ops = pchan->ops;
 
+	/* Take a reference to match the put in chan_close_cb(). The caller
+	 * drops its own local reference after __l2cap_chan_add().
+	 */
+	l2cap_chan_hold(chan);
+
 	BT_DBG("chan %p pchan %p", chan, pchan);
 
-	return chan;
+	return 0;
 }
 
 static void unregister_dev(struct lowpan_btle_dev *dev)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fdccd62ccca8..3edf6680899e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4005,6 +4005,36 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 	return 0;
 }
 
+/* Allocate and initialise a channel for an incoming connection. The returned
+ * channel carries the caller's local reference, which must be dropped once
+ * __l2cap_chan_add() has pinned it via the conn list.
+ */
+static struct l2cap_chan *l2cap_new_connection(struct l2cap_chan *pchan)
+{
+	struct l2cap_chan *chan;
+
+	chan = l2cap_chan_create();
+	if (!chan)
+		return NULL;
+
+	if (pchan->ops->new_connection(pchan, chan) < 0) {
+		l2cap_chan_put(chan);
+		return NULL;
+	}
+
+	return chan;
+}
+
+/* Link a channel from l2cap_new_connection() into conn and release the local
+ * reference it carried. __l2cap_chan_add() pins the channel via the conn list,
+ * so it remains valid after this returns.
+ */
+static void l2cap_chan_add_new(struct l2cap_conn *conn, struct l2cap_chan *chan)
+{
+	__l2cap_chan_add(conn, chan);
+	l2cap_chan_put(chan);
+}
+
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 			  u8 *data, u8 rsp_code)
 {
@@ -4051,7 +4081,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		goto response;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(pchan);
 	if (!chan)
 		goto response;
 
@@ -4069,7 +4099,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	chan->psm  = psm;
 	chan->dcid = scid;
 
-	__l2cap_chan_add(conn, chan);
+	l2cap_chan_add_new(conn, chan);
 
 	dcid = chan->scid;
 
@@ -4881,6 +4911,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	struct l2cap_le_conn_rsp rsp;
 	struct l2cap_chan *chan, *pchan;
 	u16 dcid, scid, credits, mtu, mps;
+	u16 rsp_mtu, rsp_mps;
 	__le16 psm;
 	u8 result;
 
@@ -4893,6 +4924,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	psm  = req->psm;
 	dcid = 0;
 	credits = 0;
+	rsp_mtu = 0;
+	rsp_mps = 0;
 
 	if (mtu < 23 || mps < 23)
 		return -EPROTO;
@@ -4953,7 +4986,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(pchan);
 	if (!chan) {
 		result = L2CAP_CR_LE_NO_MEM;
 		goto response_unlock;
@@ -4968,12 +5001,14 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
 
-	__l2cap_chan_add(conn, chan);
+	l2cap_chan_add_new(conn, chan);
 
 	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
 	credits = chan->rx_credits;
+	rsp_mtu = chan->imtu;
+	rsp_mps = chan->mps;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
@@ -5001,13 +5036,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		return 0;
 
 response:
-	if (chan) {
-		rsp.mtu = cpu_to_le16(chan->imtu);
-		rsp.mps = cpu_to_le16(chan->mps);
-	} else {
-		rsp.mtu = 0;
-		rsp.mps = 0;
-	}
+	rsp.mtu = cpu_to_le16(rsp_mtu);
+	rsp.mps = cpu_to_le16(rsp_mps);
 
 	rsp.dcid    = cpu_to_le16(dcid);
 	rsp.credits = cpu_to_le16(credits);
@@ -5177,7 +5207,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			continue;
 		}
 
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(pchan);
 		if (!chan) {
 			result = L2CAP_CR_LE_NO_MEM;
 			continue;
@@ -5192,7 +5222,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		chan->omtu = mtu;
 		chan->remote_mps = mps;
 
-		__l2cap_chan_add(conn, chan);
+		l2cap_chan_add_new(conn, chan);
 
 		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
 
@@ -7399,14 +7429,14 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 			goto next;
 
 		l2cap_chan_lock(pchan);
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(pchan);
 		if (chan) {
 			bacpy(&chan->src, &hcon->src);
 			bacpy(&chan->dst, &hcon->dst);
 			chan->src_type = bdaddr_src_type(hcon);
 			chan->dst_type = dst_type;
 
-			__l2cap_chan_add(conn, chan);
+			l2cap_chan_add_new(conn, chan);
 		}
 
 		l2cap_chan_unlock(pchan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index dede550d6031..598f24c8f704 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list = {
 static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern);
+				     int proto, gfp_t prio, int kern,
+				     struct l2cap_chan *chan);
 static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
@@ -1507,12 +1508,13 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	}
 }
 
-static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
+static int l2cap_sock_new_connection_cb(struct l2cap_chan *chan,
+					struct l2cap_chan *new_chan)
 {
 	struct sock *sk, *parent = chan->data;
 
 	if (!parent)
-		return NULL;
+		return -EINVAL;
 
 	lock_sock(parent);
 
@@ -1520,15 +1522,15 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
 		release_sock(parent);
-		return NULL;
+		return -ENOBUFS;
 	}
 
 	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
-			      GFP_ATOMIC, 0);
+			      GFP_ATOMIC, 0, new_chan);
 	if (!sk) {
 		release_sock(parent);
-		return NULL;
-        }
+		return -ENOMEM;
+	}
 
 	bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
 
@@ -1538,7 +1540,7 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	release_sock(parent);
 
-	return l2cap_pi(sk)->chan;
+	return 0;
 }
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
@@ -1939,10 +1941,10 @@ static struct proto l2cap_proto = {
 };
 
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern)
+				     int proto, gfp_t prio, int kern,
+				     struct l2cap_chan *chan)
 {
 	struct sock *sk;
-	struct l2cap_chan *chan;
 
 	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
 	if (!sk)
@@ -1953,14 +1955,11 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
 
-	chan = l2cap_chan_create();
-	if (!chan) {
-		sk_free(sk);
-		if (sock)
-			sock->sk = NULL;
-		return NULL;
-	}
-
+	/* The sock owns two refs on chan, matching the puts in
+	 * l2cap_sock_kill() and l2cap_sock_destruct(). The caller keeps
+	 * its own ref independent of these.
+	 */
+	l2cap_chan_hold(chan);
 	l2cap_chan_hold(chan);
 
 	l2cap_pi(sk)->chan = chan;
@@ -1972,6 +1971,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 			     int kern)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("sock %p", sock);
 
@@ -1986,10 +1986,18 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &l2cap_sock_ops;
 
-	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
-	if (!sk)
+	chan = l2cap_chan_create();
+	if (!chan)
 		return -ENOMEM;
 
+	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, chan);
+	if (!sk) {
+		l2cap_chan_put(chan);
+		return -ENOMEM;
+	}
+	/* Sock has taken its own refs on chan; drop the chan_create() ref. */
+	l2cap_chan_put(chan);
+
 	l2cap_sock_init(sk, NULL);
 	bt_sock_link(&l2cap_sk_list, sk);
 	return 0;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1739c1989dbd..887a2fc34391 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3204,16 +3204,11 @@ static const struct l2cap_ops smp_chan_ops = {
 	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
 };
 
-static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
+static inline int smp_new_conn_cb(struct l2cap_chan *pchan,
+				  struct l2cap_chan *chan)
 {
-	struct l2cap_chan *chan;
-
 	BT_DBG("pchan %p", pchan);
 
-	chan = l2cap_chan_create();
-	if (!chan)
-		return NULL;
-
 	chan->chan_type	= pchan->chan_type;
 	chan->ops	= &smp_chan_ops;
 	chan->scid	= pchan->scid;
@@ -3229,9 +3224,14 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 	 */
 	atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
 
-	BT_DBG("created chan %p", chan);
+	/* Take a reference to match the put in smp_teardown_cb(). The caller
+	 * drops its own local reference after __l2cap_chan_add().
+	 */
+	l2cap_chan_hold(chan);
 
-	return chan;
+	BT_DBG("initialised chan %p", chan);
+
+	return 0;
 }
 
 static const struct l2cap_ops smp_root_chan_ops = {
-- 
2.54.0

