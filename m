Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934AD3FADFD
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073732; cv=none; b=Jf4wZnXwz1tXrLNl1rHwLdLM1rJIMxWhCenmT8ohun7RbAkdoqDIyut0u7ddh2vEjvjXOi8KcPjGDR0CzaM2Dgw5vaG3FQfHiZXoEUpA3tYy8VIe2n/mA68xCXUxvhQQ1FlnvIgYi4VoUDYgH4I53ClHZ1810OTV+TTuUMXJmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073732; c=relaxed/simple;
	bh=hcxAtaoOYIZywCj/IYa0I13CF8kPfrNOw0degN79JaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHWjOn78TnuGXkUQusT1Uy7syReu1biNbUfq2p1RQrLkWho6jgTYjn38IOOzg1D/YQOHinrkjHBP+dCr+qZvpXSS7Ona4QURtmLanS4vvM28D9Q6nrtxyfCmqkQQ1y7ujLSAM68b2C2/+adR2tmqUNmHjN/QGAR7ZVYoiYrTlpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=pFeabKQo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RIoPuh4R; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="pFeabKQo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RIoPuh4R"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B578B1D000EB;
	Fri, 29 May 2026 12:55:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 29 May 2026 12:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780073729; x=
	1780160129; bh=JInkwEX+vdLg7tGdVRkC3xFetPp4eduHShnPFqChzRE=; b=p
	FeabKQouvbPQkQovoBC8CEUNolirTrLcslUyQfxWZ8+0TDKxSGWB3H3SdxpRZ3XI
	Av4ERPaGLJ8PMYzhSyMyVnIPnh7QgQVxKEdU9Aqlw7GJyGhZoRZ8DCMVOBweg3qZ
	A+zf+keG0mbDKCbK/iLZZJ4kz7HJbbTGA3rLmTQlcoWGdS+8fSRa1DB3M44BjL62
	BjJaKQaliEAVs2gNPQmtJbYRq+PMRbyGgaspTaQTMA4KFUb9NdALdMNNxJ8mPWRJ
	MSQQwyifF9yCE6hozpp3Uew8BAdTTvH1sQe9OUhoijEuJupyZ1d4KuBaqnmJGsx6
	DR/pslTY8EKyURG3uR4HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1780073729; x=1780160129; bh=J
	InkwEX+vdLg7tGdVRkC3xFetPp4eduHShnPFqChzRE=; b=RIoPuh4R/6tTPqGbt
	VWYqskTg71Ynn8/v6AuFELV3IgTngvl7e+40rghCfyc9aaKeY0/6gjAp7gl5xIfA
	iY/Yw4v2sjR8hJZm5OvF+ezrxNAhJaZ7raECZYZcFoa2yEhTpM6GSQqfkuyvapg3
	TccRUKpTiap+FAtL9Uga38EkuzjT08VUihSEm15IKIfLktcweqEp+OjLjQzbqawK
	xoLErmdezZ8kS0v2FnIMGxyg6zQhhIB8zkUQNEVjr9RYsWqYTnuEmVSZW5ErK9XD
	67RnPd7F78ea6HXkplPxjkUo6X3eYEHDekGVl3kUqpLEAy4jX3fWqXWnhFBFC7mT
	GjFJQ==
X-ME-Sender: <xms:AcUZasSndNSkjug9-jL7KGc5GBEaRZ0nZ8vl5FZuID2Pjd1x2g2rMQ>
    <xme:AcUZakWU_1IqZEKtMONgQts35PcVhXTFXtRdubxzU8Ku2Kfl4fepvuMVZpSjKQ0hG
    6qkhiSw83N5Q-HYrDl-wIhwnGxTg3N2op26X3ytYtmaf5rCKLWfG6Q>
X-ME-Received: <xmr:AcUZamYtxFQH-wjaKSk-Uok3GrLYhMOoNE8Xnbwq7unjTXS7mBzmidmQy_KsJPfJKvjMhS0>
X-ME-Proxy-Cause: dmFkZTG4P+xRfWrS/Pzm+0OVMarHpr2npjjI/a8U0YkQA5TGZ1E0G9VM7trSWSOEDVvdAZ
    JT/2Xus3p0dAxrPDe88kKRJYtu2hbZ3peRFgQUo59s6Ap/+W+ksR9LU9vRd8HSkCAheMAw
    355CSD47KH8VSRMhrhw0dwyBfde2pCftGkcGEMiHYKecYl+hAQJo88sQ0S3fGkHZT9RTF/
    8d7EOFKb2TCn+R2Yesufpdk/1ONaMOPTt2mLbCeTdC3vjZAPiF2GwtMEyRq5Z44p49GyD/
    wKi51o/fw0KI91VYMITB+Eh8/LOvBAmYkcHhkeEUhBdPDjN4C1eKwx/LmWPr9FkivtcVXf
    pFB1Tb7n0ChGg1QFFWPVAkSE37dYGJHg3lxMN1px4OBWhpR1wmEgiOgUNjaIYtu+9jVzIX
    +74f1WTmril0HdDhy2HajSvOOrgZWH30C3kwgnHWQZYni38Uux8G4r/gLuTcrG4Ayi6zeO
    OqEDP7BjRSeIhFbkEHNyp00ewUxSB9AUtsKUEPXgOHRd7JZfFb1owl8k75HagyrhEg7bUE
    vmKaNsWK1W5f4TfAq6RyodHPn4iVVjzISop+OZZI+q37NNB3u8t+gXGjT9Ov/ioI19Jrxo
    NMDiklTcnl9FCW/JYns1JgEc4TPRKyj/GyK3PrF1ohxDEwxhqjyfG/p31voA
X-ME-Proxy: <xmx:AcUZai0umlN0AyVkRhNS5NSf7e-uQE7mOGb_KKSGKXEW_qYfvaB08A>
    <xmx:AcUZaghlNATPKfapBgN3_OO_ecLuaC7-ku77ZVAL8ZY7c8ue_ceQSA>
    <xmx:AcUZauZHX3hYVngmlIiqKBUXMOzd6njzfBrVjB9FU7Mu-lorlPjeUg>
    <xmx:AcUZaoQnX7KVyoK0PW5XXhVfDjE3phpg27TENZHlo293ZvgcOspG2w>
    <xmx:AcUZavjPbjnKasmFXOEZ37KPiaiKRHUwbAQn0uVEtp8ziZvBDi81CTK9>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 12:55:29 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v6 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Fri, 29 May 2026 12:54:26 -0400
Message-ID: <20260529165449.3553936-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529165449.3553936-1-oss@fourdim.xyz>
References: <20260529165449.3553936-1-oss@fourdim.xyz>
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
 net/bluetooth/6lowpan.c       | 27 ++++++++--------
 net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++-------
 net/bluetooth/l2cap_sock.c    | 48 +++++++++++++++++------------
 net/bluetooth/smp.c           | 13 +++-----
 5 files changed, 98 insertions(+), 56 deletions(-)

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
index 23a229ab6a33..a5830b5746d8 100644
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
@@ -743,19 +748,15 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
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
 
 	BT_DBG("chan %p pchan %p", chan, pchan);
 
-	return chan;
+	return 0;
 }
 
 static void unregister_dev(struct lowpan_btle_dev *dev)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fdccd62ccca8..505f32034971 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4051,10 +4051,16 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		goto response;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_chan_create();
 	if (!chan)
 		goto response;
 
+	if (pchan->ops->new_connection(pchan, chan) < 0) {
+		l2cap_chan_put(chan);
+		chan = NULL;
+		goto response;
+	}
+
 	/* For certain devices (ex: HID mouse), support for authentication,
 	 * pairing and bonding is optional. For such devices, inorder to avoid
 	 * the ACL alive for too long after L2CAP disconnection, reset the ACL
@@ -4132,6 +4138,10 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		chan->num_conf_req++;
 	}
 
+	/* Drop our local ref; __l2cap_chan_add() pinned chan via the conn list. */
+	if (chan)
+		l2cap_chan_put(chan);
+
 	l2cap_chan_unlock(pchan);
 	l2cap_chan_put(pchan);
 }
@@ -4881,6 +4891,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	struct l2cap_le_conn_rsp rsp;
 	struct l2cap_chan *chan, *pchan;
 	u16 dcid, scid, credits, mtu, mps;
+	u16 rsp_mtu, rsp_mps;
 	__le16 psm;
 	u8 result;
 
@@ -4893,6 +4904,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	psm  = req->psm;
 	dcid = 0;
 	credits = 0;
+	rsp_mtu = 0;
+	rsp_mps = 0;
 
 	if (mtu < 23 || mps < 23)
 		return -EPROTO;
@@ -4953,12 +4966,19 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_chan_create();
 	if (!chan) {
 		result = L2CAP_CR_LE_NO_MEM;
 		goto response_unlock;
 	}
 
+	if (pchan->ops->new_connection(pchan, chan) < 0) {
+		l2cap_chan_put(chan);
+		chan = NULL;
+		result = L2CAP_CR_LE_NO_MEM;
+		goto response_unlock;
+	}
+
 	bacpy(&chan->src, &conn->hcon->src);
 	bacpy(&chan->dst, &conn->hcon->dst);
 	chan->src_type = bdaddr_src_type(conn->hcon);
@@ -4974,6 +4994,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	dcid = chan->scid;
 	credits = chan->rx_credits;
+	rsp_mtu = chan->imtu;
+	rsp_mps = chan->mps;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
@@ -4993,6 +5015,9 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		result = L2CAP_CR_LE_SUCCESS;
 	}
 
+	/* Drop our local ref; __l2cap_chan_add() pinned chan via the conn list. */
+	l2cap_chan_put(chan);
+
 response_unlock:
 	l2cap_chan_unlock(pchan);
 	l2cap_chan_put(pchan);
@@ -5001,13 +5026,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
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
@@ -5177,12 +5197,18 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			continue;
 		}
 
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_chan_create();
 		if (!chan) {
 			result = L2CAP_CR_LE_NO_MEM;
 			continue;
 		}
 
+		if (pchan->ops->new_connection(pchan, chan) < 0) {
+			l2cap_chan_put(chan);
+			result = L2CAP_CR_LE_NO_MEM;
+			continue;
+		}
+
 		bacpy(&chan->src, &conn->hcon->src);
 		bacpy(&chan->dst, &conn->hcon->dst);
 		chan->src_type = bdaddr_src_type(conn->hcon);
@@ -5217,6 +5243,9 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		} else {
 			l2cap_chan_ready(chan);
 		}
+
+		/* Drop our local ref; __l2cap_chan_add() pinned chan via the conn list. */
+		l2cap_chan_put(chan);
 	}
 
 unlock:
@@ -7399,7 +7428,11 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 			goto next;
 
 		l2cap_chan_lock(pchan);
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_chan_create();
+		if (chan && pchan->ops->new_connection(pchan, chan) < 0) {
+			l2cap_chan_put(chan);
+			chan = NULL;
+		}
 		if (chan) {
 			bacpy(&chan->src, &hcon->src);
 			bacpy(&chan->dst, &hcon->dst);
@@ -7407,6 +7440,9 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 			chan->dst_type = dst_type;
 
 			__l2cap_chan_add(conn, chan);
+
+			/* Drop our local ref; __l2cap_chan_add() pinned chan via the conn list. */
+			l2cap_chan_put(chan);
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
index 1739c1989dbd..25cb5dc580bf 100644
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
@@ -3229,9 +3224,9 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 	 */
 	atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
 
-	BT_DBG("created chan %p", chan);
+	BT_DBG("initialised chan %p", chan);
 
-	return chan;
+	return 0;
 }
 
 static const struct l2cap_ops smp_root_chan_ops = {
-- 
2.54.0

