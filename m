Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1213AC0C7;
	Sat, 29 Aug 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013299; cv=pass; b=apTLLMDtBqaB4NglEF5lME2Stxz07pjDQHExLFx9hlT4aZCe1DbeGHj6pdmw91M2Z/bfHX9ppNkli/k8rRdXcOpBiKtuokS/d0O0TuVcgepnh10Pgrwrz9i/9fv0BJdEiCSfzo9wXsaBc3R/PWubweoy+p5fN/WyWsGfFfgcivY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013299; c=relaxed/simple;
	bh=4A80eD5xwidok+58mtUypsm2Iw2a5DyAk8v6yteLOfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjX7nE0WF119DbKEEfQcb78FA55eGryVSFfJ79ijSC2KBwgcOu6yltc3yDzHxCFslp1i9Vc2Q4JM3BgH1CcbV/uKHzVK8jISV1ly2r0MgxOqEoCFjJL4LEuMFZaSVGHBk5SxL0ArRfS8qhX1X6j1wqnG2X7zBs5U87l/eLxFTaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=KWuunrqx; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="KWuunrqx"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHVy1FgrzyhS;
	Sat, 29 Aug 2026 17:21:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjOIMhVLC+nsWWzCfKDzi3jjGsGTOBHVGZxo+sRUpzM=;
	b=KWuunrqxmks8bf1rqNjBq9BoI8qM2uJgiop/dCNQNHgj0if54tDoPmONMiZ+b+BLJsmw29
	gBPcFtfkOZ7ZvG4PjcJakilXgvNbOnt9oznYegs9gS6vvSJkR05Hd1fjTrSWlaFowUC6FD
	8CkVSDDC19gfI1Z+IDr4qW8IlZJxCT8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013291;
	b=Y8mnAmcffBczekWmdieVQ7PAnpzWCHvLkhWrZ2TIpyDGz4UyNlofn9D0gCu/6JeGuHkDUJ
	q9PAgkuCD2GI1K0+s9iJ9c2J+QCaYitTp6ZwW69jpS/WVfKq7scGOvJ3coM91jdjZt0hTk
	Sw9Di6gsN6NkNGDLJ9YOjmaUZTHsybA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjOIMhVLC+nsWWzCfKDzi3jjGsGTOBHVGZxo+sRUpzM=;
	b=NVw8ad2zWA1o7wvjXxTqu3NrnkVqGXo8KvVh5z26rvilsphlgTm9ZKJYUiGs3vaIw39/cI
	JjtlpQGXT9whA0qmKAo9lvbyCr9mvIwvX//ZeB4kuY3ZlCwdWCg95JLVosbMqRlPWZWnYE
	dVPn5k3ghHXIPOViR/c5YMxzGQdY/PQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	error27@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/16] Bluetooth: L2CAP: add annotations for l2cap_chan list locking
Date: Sat, 29 Aug 2026 17:20:04 +0300
Message-ID: <8fbc346b0cd372f35b0ab6e348b8034263f84a08.1788013041.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788013041.git.pav@iki.fi>
References: <cover.1788013041.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add context analysis annotations for l2cap_conn::chan_l and chan_list
locking.

Add corresponding required annotations to accessors and callers.

This is not complete chan_l annotation, l2cap_chan::list and
l2cap_chan_del() locking is currently not fully correct, and needs
separate fix + annotations.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/l2cap.h |  7 ++--
 net/bluetooth/l2cap_core.c    | 61 ++++++++++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e395ab5493f7..a991fc07515c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -668,7 +668,7 @@ struct l2cap_conn {
 
 	struct l2cap_chan	*smp;
 
-	struct list_head	chan_l;
+	struct list_head	chan_l __guarded_by(&lock);
 	struct mutex		lock;
 	struct kref		ref;
 	struct list_head	users;
@@ -954,7 +954,8 @@ void l2cap_cleanup_sockets(void);
 bool l2cap_is_socket(struct socket *sock);
 
 void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan);
-void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan);
+void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
+	__must_hold(&chan->lock) __must_hold(&chan->conn->lock);
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
 
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
@@ -975,7 +976,7 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
-	__must_hold(&chan->lock);
+	__must_hold(&conn->lock) __must_hold(&chan->lock);
 typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data);
 void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
 		     void *data);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 44077e3d1e2d..ce51b0b0b37d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -44,8 +44,8 @@ bool enable_ecred = IS_ENABLED(CONFIG_BT_LE_L2CAP_ECRED);
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
 
-static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
+static __guarded_by(&chan_list_lock) LIST_HEAD(chan_list);
 
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				       u8 code, u8 ident, u16 dlen, void *data);
@@ -87,6 +87,7 @@ static inline u8 bdaddr_dst_type(struct hci_conn *hcon)
 
 static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 						   u16 cid)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *c;
 
@@ -99,6 +100,7 @@ static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 
 static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 						   u16 cid)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *c;
 
@@ -114,6 +116,7 @@ static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn,
  */
 static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 						 u16 cid)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *c;
 
@@ -129,6 +132,7 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
  */
 static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 						 u16 cid)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *c;
 
@@ -141,6 +145,7 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 
 static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 						    u8 ident)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *c;
 
@@ -153,6 +158,7 @@ static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 
 static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src,
 						      u8 src_type)
+	__must_hold_shared(&chan_list_lock)
 {
 	struct l2cap_chan *c;
 
@@ -230,6 +236,7 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid)
 }
 
 static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
+	__must_hold(&conn->lock)
 {
 	u16 cid, dyn_end;
 
@@ -728,6 +735,7 @@ EXPORT_SYMBOL_GPL(l2cap_chan_del);
 
 static void __l2cap_chan_list_id(struct l2cap_conn *conn, u16 id,
 				 l2cap_chan_func_t func, void *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *chan, *l;
 
@@ -739,6 +747,7 @@ static void __l2cap_chan_list_id(struct l2cap_conn *conn, u16 id,
 
 static void __l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
 			      void *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *chan;
 
@@ -806,6 +815,9 @@ static void l2cap_chan_ecred_connect_reject(struct l2cap_chan *chan)
 {
 	l2cap_state_change(chan, BT_DISCONN);
 
+	lockdep_assert_held(&chan->lock);
+	lockdep_assert_held(&chan->conn->lock);
+
 	__l2cap_ecred_conn_rsp_defer(chan);
 }
 
@@ -1416,6 +1428,7 @@ static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
 }
 
 static void l2cap_ecred_connect(struct l2cap_chan *chan)
+	__must_hold(&chan->conn->lock)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_ecred_conn_data data;
@@ -1449,6 +1462,7 @@ static void l2cap_ecred_connect(struct l2cap_chan *chan)
 }
 
 static void l2cap_le_start(struct l2cap_chan *chan)
+	__must_hold(&chan->conn->lock)
 {
 	struct l2cap_conn *conn = chan->conn;
 
@@ -1469,6 +1483,7 @@ static void l2cap_le_start(struct l2cap_chan *chan)
 }
 
 static void l2cap_start_connection(struct l2cap_chan *chan)
+	__must_hold(&chan->conn->lock)
 {
 	if (chan->conn->hcon->type == LE_LINK) {
 		l2cap_le_start(chan);
@@ -1518,6 +1533,7 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
+	__must_hold(&chan->conn->lock)
 {
 	struct l2cap_conn *conn = chan->conn;
 
@@ -1584,6 +1600,7 @@ static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err)
 
 /* ---- L2CAP connections ---- */
 static void l2cap_conn_start(struct l2cap_conn *conn)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *chan, *tmp;
 
@@ -1592,6 +1609,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			l2cap_chan_ready(chan);
 			l2cap_chan_unlock(chan);
@@ -1708,6 +1727,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		if (hcon->type == LE_LINK) {
 			l2cap_le_start(chan);
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
@@ -1730,6 +1751,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 /* Notify sockets that we cannot guaranty reliability anymore */
 static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *chan;
 
@@ -3027,6 +3049,7 @@ static void l2cap_pass_to_tx_fbit(struct l2cap_chan *chan,
 
 /* Copy frame to all raw sockets on that connection */
 static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
+	__must_hold(&conn->lock)
 {
 	struct sk_buff *nskb;
 	struct l2cap_chan *chan;
@@ -4073,6 +4096,7 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 static inline int l2cap_command_rej(struct l2cap_conn *conn,
 				    struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				    u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_cmd_rej_unk *rej = (struct l2cap_cmd_rej_unk *) data;
 
@@ -4105,6 +4129,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
  */
 static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 					       struct l2cap_chan *pchan)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *chan;
 
@@ -4134,6 +4159,7 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 			  u8 *data, u8 rsp_code)
+	__must_hold(&conn->lock)
 	__context_unsafe(/* conditional locking */)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
@@ -4264,6 +4290,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 
 static int l2cap_connect_req(struct l2cap_conn *conn,
 			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
+	__must_hold(&conn->lock)
 {
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
@@ -4275,6 +4302,7 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 				    struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				    u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
 	u16 scid, dcid, result, status;
@@ -4392,6 +4420,7 @@ static void cmd_reject_invalid_cid(struct l2cap_conn *conn, u8 ident,
 static inline int l2cap_config_req(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
 	u16 dcid, flags;
@@ -4505,6 +4534,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
 	u16 scid, flags, result;
@@ -4614,6 +4644,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 				       struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				       u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_disconn_req *req = (struct l2cap_disconn_req *) data;
 	struct l2cap_disconn_rsp rsp;
@@ -4655,6 +4686,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 				       struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				       u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_disconn_rsp *rsp = (struct l2cap_disconn_rsp *) data;
 	u16 dcid, scid;
@@ -4742,6 +4774,7 @@ static inline int l2cap_information_req(struct l2cap_conn *conn,
 static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 					struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 					u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) data;
 	u16 type, result;
@@ -4849,6 +4882,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 				struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_le_conn_rsp *rsp = (struct l2cap_le_conn_rsp *) data;
 	struct hci_conn *hcon = conn->hcon;
@@ -4955,6 +4989,7 @@ static void l2cap_put_ident(struct l2cap_conn *conn, u8 code, u8 id)
 static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 				      struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				      u8 *data)
+	__must_hold(&conn->lock)
 {
 	int err = 0;
 
@@ -5016,6 +5051,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 static int l2cap_le_connect_req(struct l2cap_conn *conn,
 				struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_le_conn_req *req = (struct l2cap_le_conn_req *) data;
 	struct l2cap_le_conn_rsp rsp;
@@ -5163,6 +5199,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 static inline int l2cap_le_credits(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_le_credits *pkt;
 	struct l2cap_chan *chan;
@@ -5212,6 +5249,7 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 				       struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				       u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_ecred_conn_req *req = (void *) data;
 	DEFINE_RAW_FLEX(struct l2cap_ecred_conn_rsp, pdu, dcid, L2CAP_ECRED_MAX_CID);
@@ -5384,6 +5422,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 				       struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				       u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
 	struct hci_conn *hcon = conn->hcon;
@@ -5511,6 +5550,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 					 struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 					 u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_ecred_reconf_req *req = (void *) data;
 	struct l2cap_ecred_reconf_rsp rsp;
@@ -5609,6 +5649,7 @@ static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 					 struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 					 u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *chan, *tmp;
 	struct l2cap_ecred_reconf_rsp *rsp = (void *)data;
@@ -5649,6 +5690,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 				       struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				       u8 *data)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_cmd_rej_unk *rej = (struct l2cap_cmd_rej_unk *) data;
 	struct l2cap_chan *chan;
@@ -5676,6 +5718,7 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
+	__must_hold(&conn->lock)
 {
 	int err = 0;
 
@@ -5740,6 +5783,7 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 
 static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 					struct sk_buff *skb)
+	__must_hold(&conn->lock)
 {
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_cmd_hdr *cmd;
@@ -5798,6 +5842,7 @@ static inline void l2cap_sig_send_mtu_rej(struct l2cap_conn *conn, u8 ident)
 
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
+	__must_hold(&conn->lock)
 {
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_cmd_hdr *cmd;
@@ -7035,6 +7080,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 			       struct sk_buff *skb)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_chan *chan;
 
@@ -7143,6 +7189,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 }
 
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
+	__must_hold(&conn->lock)
 {
 	struct l2cap_hdr *lh = (void *) skb->data;
 	struct hci_conn *hcon = conn->hcon;
@@ -7252,9 +7299,9 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	     hci_dev_test_flag(hcon->hdev, HCI_FORCE_BREDR_SMP)))
 		conn->local_fixed_chan |= L2CAP_FC_SMP_BREDR;
 
-	mutex_init(&conn->lock);
-
-	INIT_LIST_HEAD(&conn->chan_l);
+	scoped_guard(mutex_init, &conn->lock) {
+		INIT_LIST_HEAD(&conn->chan_l);
+	}
 	INIT_LIST_HEAD(&conn->users);
 
 	INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
@@ -7466,6 +7513,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	__l2cap_chan_add(conn, chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	/* l2cap_chan_add takes its own ref so we can drop this one */
 	hci_conn_drop(hcon);
 
@@ -7688,6 +7737,8 @@ static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 }
 
 static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
+	__must_hold(&chan->lock)
+	__must_hold(&chan->conn->lock)
 {
 	if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED)
 		return;
@@ -7720,6 +7771,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
 		       state_to_string(chan->state));
 
-- 
2.55.0

