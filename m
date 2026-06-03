Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEB3911C1
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499354; cv=none; b=WQ9LWqhLz6UJIvMoTx9Ss0TOwfJ8Xx433FzGPUWmoKJbSAKq7KHTcNk5cByYLWxE4REwGn+OzzWWkWSmRORezXt1+t2YBdiTneEaoj/J4K4sHs/lELCiXpRjhBb0fDyjCSAcitoOSB8hwia0//jZjiX9YBhVLLK4zs8FpIpP4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499354; c=relaxed/simple;
	bh=nOLz9B5+rcSVpuKhPWNoHdWtvQTWmFevgjQN98VT7jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqtCZ0QPKWLXxoKASUvddYVyc/hA5otbgzdzDPeSddq3XMxiQM3n8iJVM/ish3NMa0FKDJF2IzmaPqjAUQ+xtz1G9nnCxAqMhfzq4MildPQGN86FpKPPtI2kcS4DR3BdSa9/DeehpD8d5gqvJNvLW5wdF5rTQruExhFg7WX9qIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=Wir6j4b+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tc9z6gzh; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="Wir6j4b+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tc9z6gzh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 700347A011B;
	Wed,  3 Jun 2026 11:09:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 03 Jun 2026 11:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780499351; x=
	1780585751; bh=77Kqbciim4T4leW8fl4m7pJn8x2jS9GeUv1+8wRGils=; b=W
	ir6j4b+bzuzlZEDb5AFbjlxpzvQJBGv5Sf+b4HVeLXDw7hEGnWMzronUUA1vwrbp
	J/mhBQb5ZjqETI30sxEdihCHRnhBJIYYL5R9cI5qkxcSK1Y6bEyMkFEP2/GmQckl
	jF7GPAQihUJ0e2/c2krefk6VF8kQc7yLbeQJRG4q9dn2LM3wTgNKNPMpi0zYNFr0
	EirqIiEZOvWg7OpJ0i3FVPSNXD9ZOWOKXnk/yq2unC7eDA7IrXjaOl1c9tvJT/Mu
	2N08pOLP53PiObfhcmMisk4Wn9KMDWo1Uvrz2ZqoalGrQ0MnPMOG/AgFT+RrhjEr
	9JPi4iSiQlKi+HDtdhbag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780499351; x=1780585751; bh=7
	7Kqbciim4T4leW8fl4m7pJn8x2jS9GeUv1+8wRGils=; b=Tc9z6gzhi6COk4YLR
	0QwXOWIza38cW9cgDm7e6BxAbN1kWpbnyaHNiJRWaJo7NcBQ++KdK855ryS7dpZh
	sDvJnIWlLp5K3MpLdSOS4hzMCyJfs2e53eMn1l7OkOWb5xQbu6G540NMw2zbEnV1
	59wxqRdIR7vnGViP6olbNcFaXE+oQ7cehx47SzaVBtnThdGkBcHQmcOM0lZSe9KW
	ItWUp18XhXlNPnJchpfvlcid8z/KklaoXBdBKgw82udPQtGR2UI6cfkz9Sg5TZoK
	BXH4xgCJvSKHFGT5RcTMikuKR6wpF+Tc175nvDPrnY8PFEJsTXHtoHtfFOdJLVhL
	Rr0cQ==
X-ME-Sender: <xms:l0MgaoAM_ZpY3pQknXXeujeiFUJKE5QPcRXkha2iO3NtvePtZDnDsQ>
    <xme:l0MgahgTKEAsBaTN-iCm2QeCEn4nnZduDdYkLR0wCGwcVK4gR2wrJ2pNpe0pDy0v3
    dgwvhn02CjnUzSXTLF5qX04Gogom2ZXAOqIomWnmwNe7KhSVVF7YjQ>
X-ME-Received: <xmr:l0Mgagm_QSoXH5lm3Q4KU22Q07hdnLh7jGeLy3cOz7mEm3EYQxVMGAZ_L_3AB9guqoicYl4>
X-ME-Proxy-Cause: dmFkZTFaVo7AeqEsjlTS8txQbxSXCtsNVoUXz+ZSmmPfphLD4AR/Z9MyOAbkDS2CDaWHzD
    xNe0EMlBaMj97TxQ7+K5oulbVwCQ0zRtOKUnyi9+7Mzzl75f4k/5vwniT5uU4KXXFIKf6y
    uwBNvRULs/YaeZXdyeGfjso/t0W52Z63/uixxFAb1jzHPvWeiOCSVJ7Jtf/AWF3yXlM6w/
    BbP+26JyvO8kFtPQD10ZZSH/tOIsVwjHXBl8EZ9h1RMg9GfAk7Y93Ck8bI9XWm2Blc+JYA
    GzP4JTJUJOu12Wx2YvBZd+pV60LTLJMDeE3Wkao6X8lJi+ndK1UfQVPUYGccB/1DdWo5re
    P6i9K8RHcWd5JwF4zB4bVHRToBlhnWxynztnK7hUmCDDARC1Cv11JPofi9Z/PtDcvfmAjW
    jKjNwaIGBPy0wPq9EOoK/KL3g1Ep5zPzUSrQkKoOedwW7Qwg0Vt9ypzsKq5PalSpfN/NsD
    vZgRFMuVuslQCu/JfdFz7ItFGNWil6KFhq3yC5SXdfqqiPGjKeAMa64Xrked5doiCFecf/
    +Y12dDWVu4D9slibaUFnQDvRqCrg4J1/AB6VT0vIVKyna8a8nJc/Yu5/AXLezM8qmiT6sM
    W/orW2q8oJ6HbOTDgyBX0zYLW9QzRBy8juoybFJ8EKvOHpWs27zULODvJgwA
X-ME-Proxy: <xmx:l0Mgatp6DNOxJMpve0S3e9rcTURRatWfh-klVA_UhPYTtidoyZ_9Kw>
    <xmx:l0MgapFg6Qx8lMi1ibVBzSqf-ppejvMv-jPoCxEz7dWKnQoILrEKDg>
    <xmx:l0MgapyxYj7Ry_6F3AbNL4Rk5CCUSyxGvyhskeAntOsQV3MUIZf6Eg>
    <xmx:l0MgauraUseHkr8mue2Aj2wLv5DAPlchBPOn_YFHscFGwVKdVOK-Jg>
    <xmx:l0Mgaszi7SCaGp6EY_lYOTtTw2aCnSzMfRUdDaxtopyCQ43rtXYchSMP>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 11:09:10 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v9 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Wed,  3 Jun 2026 11:06:28 -0400
Message-ID: <20260603150835.3539963-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603150835.3539963-1-oss@fourdim.xyz>
References: <20260603150835.3539963-1-oss@fourdim.xyz>
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
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 include/net/bluetooth/l2cap.h | 10 +++--
 net/bluetooth/6lowpan.c       | 31 +++++++------
 net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
 net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++--------------
 net/bluetooth/smp.c           | 17 ++++---
 5 files changed, 113 insertions(+), 69 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e0a1f2293679..7f5e4647f6e0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -620,7 +620,9 @@ struct l2cap_chan {
 struct l2cap_ops {
 	char			*name;
 
-	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
+	int			(*new_connection)(struct l2cap_conn *conn,
+						  struct l2cap_chan *chan,
+						  struct l2cap_chan *new_chan);
 	int			(*recv) (struct l2cap_chan * chan,
 					 struct sk_buff *skb);
 	void			(*teardown) (struct l2cap_chan *chan, int err);
@@ -884,9 +886,11 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
 	return (seq + 1) % (chan->tx_win_max + 1);
 }
 
-static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2cap_chan *chan)
+static inline int l2cap_chan_no_new_connection(struct l2cap_conn *conn,
+					       struct l2cap_chan *chan,
+					       struct l2cap_chan *new_chan)
 {
-	return NULL;
+	return -EOPNOTSUPP;
 }
 
 static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct sk_buff *skb)
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cb1e329d66fd..94863af97a44 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_conn *hcon)
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
@@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(void)
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
@@ -745,19 +750,19 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
 	ifup(dev->netdev);
 }
 
-static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
+static inline int chan_new_conn_cb(struct l2cap_conn *conn,
+				   struct l2cap_chan *pchan,
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
 
+	/* Take the conn list reference; see l2cap_new_connection(). */
+	__l2cap_chan_add(conn, chan);
+
 	BT_DBG("chan %p pchan %p", chan, pchan);
 
-	return chan;
+	return 0;
 }
 
 static void unregister_dev(struct lowpan_btle_dev *dev)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4ccfbda9d78..62acf90837fb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4007,6 +4007,31 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 	return 0;
 }
 
+/* Allocate and initialise a channel for an incoming connection.
+ *
+ * ->new_connection() initialises the channel and links it into @conn with
+ * __l2cap_chan_add(). The l2cap_chan_create() reference becomes the one owned
+ * by the parent subsystem (l2cap_pi(sk)->chan, conn->smp or peer->chan) and is
+ * released by its teardown callback; the conn list reference is released by
+ * l2cap_chan_del().
+ */
+static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
+					       struct l2cap_chan *pchan)
+{
+	struct l2cap_chan *chan;
+
+	chan = l2cap_chan_create();
+	if (!chan)
+		return NULL;
+
+	if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
+		l2cap_chan_put(chan);
+		return NULL;
+	}
+
+	return chan;
+}
+
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 			  u8 *data, u8 rsp_code)
 {
@@ -4053,7 +4078,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		goto response;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(conn, pchan);
 	if (!chan)
 		goto response;
 
@@ -4071,8 +4096,6 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	chan->psm  = psm;
 	chan->dcid = scid;
 
-	__l2cap_chan_add(conn, chan);
-
 	dcid = chan->scid;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
@@ -4955,7 +4978,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(conn, pchan);
 	if (!chan) {
 		result = L2CAP_CR_LE_NO_MEM;
 		goto response_unlock;
@@ -4970,8 +4993,6 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
 
-	__l2cap_chan_add(conn, chan);
-
 	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
@@ -5179,7 +5200,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			continue;
 		}
 
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(conn, pchan);
 		if (!chan) {
 			result = L2CAP_CR_LE_NO_MEM;
 			continue;
@@ -5194,8 +5215,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		chan->omtu = mtu;
 		chan->remote_mps = mps;
 
-		__l2cap_chan_add(conn, chan);
-
 		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
 
 		/* Init response */
@@ -7470,14 +7489,12 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 			goto next;
 
 		l2cap_chan_lock(pchan);
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(conn, pchan);
 		if (chan) {
 			bacpy(&chan->src, &hcon->src);
 			bacpy(&chan->dst, &hcon->dst);
 			chan->src_type = bdaddr_src_type(hcon);
 			chan->dst_type = dst_type;
-
-			__l2cap_chan_add(conn, chan);
 		}
 
 		l2cap_chan_unlock(pchan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 025329636353..87f4c0db5c0c 100644
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
@@ -1287,6 +1288,23 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return err;
 }
 
+/* Release the sock's ref on chan and clear the pointer so that the ref is
+ * dropped exactly once even if both l2cap_sock_kill() and
+ * l2cap_sock_destruct() run. Setting chan->data to NULL first stops any other
+ * task from dereferencing the now-dead sock pointer.
+ */
+static void l2cap_sock_put_chan(struct sock *sk)
+{
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+	if (!chan)
+		return;
+
+	chan->data = NULL;
+	l2cap_pi(sk)->chan = NULL;
+	l2cap_chan_put(chan);
+}
+
 /* Kill socket (only if zapped and orphan)
  * Must be called on unlocked socket, with l2cap channel lock.
  */
@@ -1297,13 +1315,9 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
-	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
-	 * sock pointer.
-	 */
-	l2cap_pi(sk)->chan->data = NULL;
-	/* Kill poor orphan */
+	l2cap_sock_put_chan(sk);
 
-	l2cap_chan_put(l2cap_pi(sk)->chan);
+	/* Kill poor orphan */
 	sock_set_flag(sk, SOCK_DEAD);
 	sock_put(sk);
 }
@@ -1546,12 +1560,14 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	}
 }
 
-static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
+static int l2cap_sock_new_connection_cb(struct l2cap_conn *conn,
+					struct l2cap_chan *chan,
+					struct l2cap_chan *new_chan)
 {
 	struct sock *sk, *parent = chan->data;
 
 	if (!parent)
-		return NULL;
+		return -EINVAL;
 
 	lock_sock(parent);
 
@@ -1559,25 +1575,33 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
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
 
 	l2cap_sock_init(sk, parent);
 
+	/* Link the channel into conn before exposing the new socket via the
+	 * accept queue. Once release_sock() below drops the parent lock the
+	 * socket may be freed by another task, dropping its reference on
+	 * new_chan; the conn list reference taken here keeps new_chan alive so
+	 * the caller can safely use it after ->new_connection() returns.
+	 */
+	__l2cap_chan_add(conn, new_chan);
+
 	bt_accept_enqueue(parent, sk, false);
 
 	release_sock(parent);
 
-	return l2cap_pi(sk)->chan;
+	return 0;
 }
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
@@ -1874,10 +1898,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 
 	BT_DBG("sk %p", sk);
 
-	if (l2cap_pi(sk)->chan) {
-		l2cap_pi(sk)->chan->data = NULL;
-		l2cap_chan_put(l2cap_pi(sk)->chan);
-	}
+	l2cap_sock_put_chan(sk);
 
 	list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, list) {
 		kfree_skb(rx_busy->skb);
@@ -1978,10 +1999,10 @@ static struct proto l2cap_proto = {
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
@@ -1992,16 +2013,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
 
-	chan = l2cap_chan_create();
-	if (!chan) {
-		sk_free(sk);
-		if (sock)
-			sock->sk = NULL;
-		return NULL;
-	}
-
-	l2cap_chan_hold(chan);
-
+	/* The sock takes ownership of the caller's reference on chan. */
 	l2cap_pi(sk)->chan = chan;
 
 	return sk;
@@ -2011,6 +2023,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 			     int kern)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("sock %p", sock);
 
@@ -2025,10 +2038,16 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 
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
+
 	l2cap_sock_init(sk, NULL);
 	bt_sock_link(&l2cap_sk_list, sk);
 	return 0;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1739c1989dbd..2d31c3c7bbc0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3204,16 +3204,12 @@ static const struct l2cap_ops smp_chan_ops = {
 	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
 };
 
-static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
+static inline int smp_new_conn_cb(struct l2cap_conn *conn,
+				  struct l2cap_chan *pchan,
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
@@ -3229,9 +3225,12 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 	 */
 	atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
 
-	BT_DBG("created chan %p", chan);
+	/* Take the conn list reference; see l2cap_new_connection(). */
+	__l2cap_chan_add(conn, chan);
 
-	return chan;
+	BT_DBG("initialised chan %p", chan);
+
+	return 0;
 }
 
 static const struct l2cap_ops smp_root_chan_ops = {
-- 
2.54.0

