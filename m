Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3F3A9852;
	Sat, 29 Aug 2026 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013380; cv=pass; b=KfWy5BbuOjbqsTAIQi5j3ZuEpaYns/KfAZLRPSbwCmO2FI2xPsuXi/WQPElv8Tk+Fx/BCTfgiZOV5ViSSr/QBjyM0BScv8ar/zYs5/QxAlOuow059/wBEOpyuO/KVTsXNrT/js24X96v9gV1XYVSRbZsxoEG7Ds1prELR4u5aCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013380; c=relaxed/simple;
	bh=pTHzh4eQ8mCTR6dt5vGwye1R30GzARfdXxaG6bd7vGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJBdejeghptN1QEa3KXumnMm27stDW5ynyWVIiAcX4LEos6bcxnzC5wZ85U7dv8REcuTjQFkTigCXlvGstVoMybTWPQJaRQRrnokriJdHU5xIZ6bnG0gNRWEUcOayojc7x3gZeKSBUfAygpzWTN9FOkrQNCQoJ/XUinxm9TqZXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dASPUpoQ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dASPUpoQ"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHXV6ZrHzyhS;
	Sat, 29 Aug 2026 17:22:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smDW8/X0qUSSTi8iK3Yh7F62eVeKdDWtA4TFlSKr6rQ=;
	b=dASPUpoQS+NfHRDgH2LKcNPdBkueewyvSx0KK0sj+hBrtQVycJlrInZdJqvZHgoFFqaQYF
	NVl1GsaQBur3QJxgNcMLi9vZFvNq9iN6HRrkK8c+74u8RuRJTH1E6uuMXhwDiVO0bi3bnH
	0uXnlvR8ktwu7s6qQyfjkRoVebcZhzA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013371;
	b=jqcflGs7zkFKIoeA28+SzwJlGQ3FVPZFgZAqedPc7px666kY9viNjS19YIoTUkWtk6yRoh
	axxtdJrFyu3aXAy7EuJrGVaj2UT7qOFGZWqX/jWMZgp2w1bWGzcsLH05XKuaohRhbl5VCr
	iB9946Le3kwCXzdfBN9I2K+7MPuin9o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smDW8/X0qUSSTi8iK3Yh7F62eVeKdDWtA4TFlSKr6rQ=;
	b=H7/S5VfBQpFQyS1tEsburkDlDJtOmgMut2BIfoBMDLhJE+jLUwzUK9EVJmjgawn7M/7TmO
	XigozMLshbArbUSTudCWUvKRtAaY+oXY+PjQ57r/hV3hWsT9XU1BTV0OXnMGh3pCSEzWWe
	MnQIxgAUU2KyzzExdIHiZ9Lg3xaQlmE=
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
Subject: [PATCH 12/16] Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
Date: Sat, 29 Aug 2026 17:20:07 +0300
Message-ID: <74b398ab221cfefe33a4ddf850da6ad5570bbe76.1788013041.git.pav@iki.fi>
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

Add context analysis annotations for chan->lock and chan->conn->lock
involving l2cap_chan_del() usage.

Add necessary annotations and related lockdep_assert_held to callers.

Move struct l2cap_ops definition after struct l2cap_conn, so that the
callbacks can be annotated.

In l2cap_chan_close_unlocked() we consider chan->conn->lock as locked
even if chan->conn == NULL, to avoid needing to define separate
__l2cap_chan_close/del for this NULL case.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/l2cap.h | 56 +++++++++++++++++++----------------
 net/bluetooth/6lowpan.c       |  2 ++
 net/bluetooth/l2cap_core.c    | 49 +++++++++++++++++++++++++-----
 3 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index efd59b6f8afd..f612c9f884d1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -614,31 +614,6 @@ struct l2cap_chan {
 	struct mutex		lock;
 };
 
-struct l2cap_ops {
-	char			*name;
-
-	int			(*new_connection)(struct l2cap_chan *chan,
-						  struct l2cap_chan *new_chan);
-	int			(*recv) (struct l2cap_chan * chan,
-					 struct sk_buff *skb);
-	void			(*teardown) (struct l2cap_chan *chan, int err);
-	void			(*close) (struct l2cap_chan *chan);
-	void			(*state_change) (struct l2cap_chan *chan,
-						 int state, int err);
-	void			(*ready) (struct l2cap_chan *chan);
-	void			(*defer) (struct l2cap_chan *chan);
-	void			(*resume) (struct l2cap_chan *chan);
-	void			(*suspend) (struct l2cap_chan *chan);
-	void			(*set_shutdown) (struct l2cap_chan *chan);
-	long			(*get_sndtimeo) (struct l2cap_chan *chan);
-	struct pid		*(*get_peer_pid) (struct l2cap_chan *chan);
-	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
-					       unsigned long hdr_len,
-					       unsigned long len, int nb);
-	int			(*filter) (struct l2cap_chan * chan,
-					   struct sk_buff *skb);
-};
-
 struct l2cap_conn {
 	struct hci_conn		*hcon;
 	struct hci_chan		*hchan;
@@ -674,6 +649,34 @@ struct l2cap_conn {
 	struct list_head	users;
 };
 
+struct l2cap_ops {
+	char			*name;
+
+	int			(*new_connection)(struct l2cap_chan *chan,
+						  struct l2cap_chan *new_chan);
+	int			(*recv) (struct l2cap_chan * chan,
+					 struct sk_buff *skb);
+	void			(*teardown) (struct l2cap_chan *chan, int err)
+					__must_hold(&chan->lock);
+	void			(*close) (struct l2cap_chan *chan);
+	void			(*state_change) (struct l2cap_chan *chan,
+						 int state, int err);
+	void			(*ready) (struct l2cap_chan *chan)
+					__must_hold(&chan->lock)
+					__must_hold(&chan->conn->lock);
+	void			(*defer) (struct l2cap_chan *chan);
+	void			(*resume) (struct l2cap_chan *chan);
+	void			(*suspend) (struct l2cap_chan *chan);
+	void			(*set_shutdown) (struct l2cap_chan *chan);
+	long			(*get_sndtimeo) (struct l2cap_chan *chan);
+	struct pid		*(*get_peer_pid) (struct l2cap_chan *chan);
+	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
+					       unsigned long hdr_len,
+					       unsigned long len, int nb);
+	int			(*filter) (struct l2cap_chan * chan,
+					   struct sk_buff *skb);
+};
+
 struct l2cap_user {
 	struct list_head list;
 	int (*probe) (struct l2cap_conn *conn, struct l2cap_user *user);
@@ -984,7 +987,8 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data);
 void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
 		     void *data);
-void l2cap_chan_del(struct l2cap_chan *chan, int err);
+void l2cap_chan_del(struct l2cap_chan *chan, int err)
+	__must_hold(&chan->lock) __must_hold(&chan->conn->lock);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
 
 struct l2cap_conn *l2cap_conn_get(struct l2cap_conn *conn);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index ddcdd2aff91f..836add41f5d1 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -722,6 +722,8 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
 }
 
 static inline void chan_ready_cb(struct l2cap_chan *chan)
+	__must_hold(&chan->lock)
+	__must_hold(&chan->conn->lock)
 {
 	struct lowpan_btle_dev *dev;
 	bool new_netdev = false;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cc86399ef0f5..88a9596e4801 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -59,7 +59,8 @@ static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 static void l2cap_retrans_timeout(struct work_struct *work);
 static void l2cap_monitor_timeout(struct work_struct *work);
 static void l2cap_ack_timeout(struct work_struct *work);
-static void __l2cap_chan_close(struct l2cap_chan *chan, int reason);
+static void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
+	__must_hold(&chan->lock) __must_hold(&chan->conn->lock);
 
 static inline u8 bdaddr_type(u8 link_type, u8 bdaddr_type)
 {
@@ -681,6 +682,8 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
+	lockdep_assert(!chan->conn || lockdep_is_held(&chan->conn->lock));
+
 	__clear_chan_timer(chan);
 
 	BT_DBG("chan %p, err %d, state %s", chan, err,
@@ -812,12 +815,11 @@ static void l2cap_chan_le_connect_reject(struct l2cap_chan *chan)
 }
 
 static void l2cap_chan_ecred_connect_reject(struct l2cap_chan *chan)
+	__must_hold(&chan->lock)
+	__must_hold(&chan->conn->lock)
 {
 	l2cap_state_change(chan, BT_DISCONN);
 
-	lockdep_assert_held(&chan->lock);
-	lockdep_assert_held(&chan->conn->lock);
-
 	__l2cap_ecred_conn_rsp_defer(chan);
 }
 
@@ -848,8 +850,6 @@ static void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	lockdep_assert_held(&chan->lock);
-
 	switch (chan->state) {
 	case BT_LISTEN:
 		chan->ops->teardown(chan, 0);
@@ -934,7 +934,10 @@ void l2cap_chan_close_unlocked(struct l2cap_chan *chan, int reason)
 	bool have_conn;
 
 	have_conn = l2cap_chan_lock_conn(chan);
-	__l2cap_chan_close(chan, reason);
+
+	/* Context analysis: consider chan->conn->lock held also if conn NULL */
+	context_unsafe(__l2cap_chan_close(chan, reason));
+
 	l2cap_chan_unlock_conn(chan, have_conn);
 }
 EXPORT_SYMBOL(l2cap_chan_close_unlocked);
@@ -1336,6 +1339,8 @@ void l2cap_send_conn_req(struct l2cap_chan *chan)
 }
 
 static void l2cap_chan_ready(struct l2cap_chan *chan)
+	__must_hold(&chan->lock)
+	__must_hold(&chan->conn->lock)
 {
 	/* The channel may have already been flagged as connected in
 	 * case of receiving data before the L2CAP info req/rsp
@@ -1464,6 +1469,7 @@ static void l2cap_ecred_connect(struct l2cap_chan *chan)
 }
 
 static void l2cap_le_start(struct l2cap_chan *chan)
+	__must_hold(&chan->lock)
 	__must_hold(&chan->conn->lock)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1485,6 +1491,7 @@ static void l2cap_le_start(struct l2cap_chan *chan)
 }
 
 static void l2cap_start_connection(struct l2cap_chan *chan)
+	__must_hold(&chan->lock)
 	__must_hold(&chan->conn->lock)
 {
 	if (chan->conn->hcon->type == LE_LINK) {
@@ -1535,6 +1542,7 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
+	__must_hold(&chan->lock)
 	__must_hold(&chan->conn->lock)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1886,6 +1894,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		l2cap_chan_del(chan, err);
 
 		chan->ops->close(chan);
@@ -4204,6 +4214,8 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 
 	__l2cap_chan_add(conn, chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	if (pchan->ops->new_connection &&
 	    pchan->ops->new_connection(pchan, chan) < 0) {
 		l2cap_chan_del(chan, 0);
@@ -4403,6 +4415,8 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4504,6 +4518,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
 	    chan->state != BT_CONNECTED) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
@@ -4618,6 +4634,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4727,6 +4745,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	rsp.dcid = cpu_to_le16(chan->scid);
 	rsp.scid = cpu_to_le16(chan->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
@@ -4767,6 +4787,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	if (chan->state != BT_DISCONN) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
@@ -4979,6 +5001,8 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	switch (result) {
 	case L2CAP_CR_LE_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -5197,6 +5221,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	bacpy(&chan->src, &conn->hcon->src);
 	bacpy(&chan->dst, &conn->hcon->dst);
 	chan->src_type = bdaddr_src_type(conn->hcon);
@@ -5427,6 +5453,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		bacpy(&chan->src, &conn->hcon->src);
 		bacpy(&chan->dst, &conn->hcon->dst);
 		chan->src_type = bdaddr_src_type(conn->hcon);
@@ -5516,6 +5544,8 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		/* Check that there is a dcid for each pending channel */
 		if (cmd_len < sizeof(dcid)) {
 			l2cap_chan_del(chan, ECONNREFUSED);
@@ -5743,6 +5773,8 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 			continue;
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		l2cap_chan_del(chan, ECONNRESET);
 
 		l2cap_chan_unlock(chan);
@@ -5772,6 +5804,7 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 		goto done;
 
 	l2cap_chan_lock(chan);
+	lockdep_assert_held(&chan->conn->lock);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
@@ -7159,6 +7192,8 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
 	/* If we receive data on a fixed channel before the info req/rsp
-- 
2.55.0

