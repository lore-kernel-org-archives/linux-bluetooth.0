Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E7C391E52;
	Tue,  1 Sep 2026 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296698; cv=pass; b=F8zffNPVm/hg/ZvK5/+r69JEjO2U2BCtZHWO3NUCk6A41FnowtR8KBUrZmFsFQZENm7zMLAyg8N3RyUIC3QyPsxhWtIGQhkeVKfcJVQ6HRfrXilEw1tcX325DwQpXPi2/4gm1us8wiG/F71NK0+uAXgZ9d+0OdbqMeSMW7fspQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296698; c=relaxed/simple;
	bh=5zibq57D/j/jK/mPVGQ1sOwhhWnQ3QcU0GgC7ICYfeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSBXgGfsA5lqBO8bkeSWbvGmgV3fX8az2ORqqGyy7b8JjV3qUTvCG7RpOMH92jTxsv86Bfqc6WCqIMfU2In6SpgUW1DrV/UrF8l0rTo4BLQd0mbbrivZLeZvCFyUZc7rTxJhImFaPcPROW9eSOxpE/CmLboOME63PTT80AcGoHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=DVmD5dnX; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="DVmD5dnX"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::dd01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hZJJy2k5LzywJ;
	Wed, 02 Sep 2026 00:04:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788296690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPvEKoTtP7yiNM3rOQJTmK+baCfbSTa8KD7bYAKS+Ig=;
	b=DVmD5dnXajWshfGatGIZMvjG7duMOeKhGxUZ7rRaJE2Kh9ElMcJOjr93X6QGTBRLmhDUG8
	aoU6RMQVLDpeay3uweBgjIhnSzTPGOqt/iqmFTXkHUzdpdY4Z34RgW3Q+C+uvU0tcbL9Nb
	2W9PqbrOjeCAFSmoU2a7jv7xJSATv2E=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788296690;
	b=LRrtCzbAZVD5KINExUZpl0hJ1Kk4G+kKpiFx93FFwxz3ryDTYPCIQW3Dnq1Xap8MSahBP7
	hA7LYlZVD/avOypcDw4WITyddh6RQaVdux68Sp8kU/HdE/OQy5bHrsVLxaHgkBmlTH/bs6
	1MmZjDNlELrC/6/VG7yVPO926614PXM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788296690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPvEKoTtP7yiNM3rOQJTmK+baCfbSTa8KD7bYAKS+Ig=;
	b=kwSA+JU8ABWJrcV29dHFBU6yfydfFgnqMOijuTYZsNhn841uWoc0Ghhq46jSkIiMYMKqDw
	YwCW3apYfaRonTqMiIBolXmiM5lueyqo9pdN/tOxnVKo4IqiAvGcNAZ/5clrsi8GvxhiVJ
	5jovkRzIcBJVZ61hO3QMi/pT/9qP88U=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
Date: Wed,  2 Sep 2026 00:04:34 +0300
Message-ID: <16a30a04f28b2b93023b6e32b361543384af499b.1788296635.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788296635.git.pav@iki.fi>
References: <cover.1788296635.git.pav@iki.fi>
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
index c7e642abe404..3e1e2b36d7b6 100644
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
@@ -983,7 +986,8 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
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
index 805623a48bae..219d92431be0 100644
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
@@ -1471,6 +1476,7 @@ static void l2cap_ecred_connect(struct l2cap_chan *chan)
 }
 
 static void l2cap_le_start(struct l2cap_chan *chan)
+	__must_hold(&chan->lock)
 	__must_hold(&chan->conn->lock)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1492,6 +1498,7 @@ static void l2cap_le_start(struct l2cap_chan *chan)
 }
 
 static void l2cap_start_connection(struct l2cap_chan *chan)
+	__must_hold(&chan->lock)
 	__must_hold(&chan->conn->lock)
 {
 	if (chan->conn->hcon->type == LE_LINK) {
@@ -1542,6 +1549,7 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
+	__must_hold(&chan->lock)
 	__must_hold(&chan->conn->lock)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1893,6 +1901,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		l2cap_chan_del(chan, err);
 
 		chan->ops->close(chan);
@@ -4218,6 +4228,8 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 
 	__l2cap_chan_add(conn, chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	if (pchan->ops->new_connection &&
 	    pchan->ops->new_connection(pchan, chan) < 0) {
 		l2cap_chan_del(chan, 0);
@@ -4419,6 +4431,8 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4520,6 +4534,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
 	    chan->state != BT_CONNECTED) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
@@ -4634,6 +4650,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4743,6 +4761,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	rsp.dcid = cpu_to_le16(chan->scid);
 	rsp.scid = cpu_to_le16(chan->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
@@ -4783,6 +4803,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	if (chan->state != BT_DISCONN) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
@@ -4995,6 +5017,8 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	switch (result) {
 	case L2CAP_CR_LE_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -5213,6 +5237,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	bacpy(&chan->src, &conn->hcon->src);
 	bacpy(&chan->dst, &conn->hcon->dst);
 	chan->src_type = bdaddr_src_type(conn->hcon);
@@ -5444,6 +5470,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		bacpy(&chan->src, &conn->hcon->src);
 		bacpy(&chan->dst, &conn->hcon->dst);
 		chan->src_type = bdaddr_src_type(conn->hcon);
@@ -5533,6 +5561,8 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		/* Check that there is a dcid for each pending channel */
 		if (cmd_len < sizeof(dcid)) {
 			l2cap_chan_del(chan, ECONNREFUSED);
@@ -5760,6 +5790,8 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 			continue;
 		l2cap_chan_lock(chan);
 
+		lockdep_assert_held(&chan->conn->lock);
+
 		l2cap_chan_del(chan, ECONNRESET);
 
 		l2cap_chan_unlock(chan);
@@ -5789,6 +5821,7 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 		goto done;
 
 	l2cap_chan_lock(chan);
+	lockdep_assert_held(&chan->conn->lock);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
@@ -7176,6 +7209,8 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 
 	l2cap_chan_lock(chan);
 
+	lockdep_assert_held(&chan->conn->lock);
+
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
 	/* If we receive data on a fixed channel before the info req/rsp
-- 
2.55.0

