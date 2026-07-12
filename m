Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C023769F6;
	Sun, 12 Jul 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783860183; cv=pass; b=BUoAhtJ5WifIoy8wp4XOQBnzVhAmpk+SJhH9UPx7NLmFwEtk5QasjoL4ymQUjIajVHBLNO3eUmcygyjebmKAOyyGAAIumOx/ZvpQwNw8sRtyLr/6iKlIdcC4iI+XUN7kUZG5npSMXENNxeZMFcQXbLw/OT4ZJOOkxdyCOEgLRL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783860183; c=relaxed/simple;
	bh=jU3PcpTR1QlnFIDXkG+WTqd0Lh3ixFjhrOZokEX6Xb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZrdwmsFsKdU+QOgNnVae+VPwU3ZeVXXGrUqI6zWZqycSzPL9rpnG8V5VdzSs/A5yzZWs+1dzeiRgy6wkkfG3HGvJ7j7SMEHFVT1jbW648G284uCy5/iz+oHtp8ZQDkzy/RgLMz/QFsHCL6iiaH3T/StfTHD4Qjk/yuB0LJCk8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ic7dw0Hf; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ic7dw0Hf"
Received: from monolith.lan (unknown [185.65.133.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gylbH21tVz10Y4;
	Sun, 12 Jul 2026 15:42:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783860173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jZRkVzX/u9U+IPOo7SrMEFUtVB7zvSSobp2J+upYakQ=;
	b=Ic7dw0HfoSX6/YwMlBmk3ea8AMoWzWoIe/uxyaWDoOPSAlkLXfddx4dYVbM2zipzn7HRnr
	ac9rBdwVipxtH3mb3Vi19XR0n6rF+r8fYjtCPnChrgXruIR/P8klsNWlb6x/5TyIFs1ZuM
	YWJq43LWtW4t+crq5SK+lej7NH7koDg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783860173;
	b=aerzkxVTHKLlB9EGJc9Mty0cPimLfi3jOymtW8dwgl0JpIVV6a8m39U/dYygSR3idnw7jM
	XohquIlI6VUj+YV6xzup3Uq0rSrXyxN5jbqxEjULUnB8SkOcIRZQuGBuYbarbXiN+I4Kod
	1ardIxmzZB3s426s5fArP4YQehLZxqA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783860173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jZRkVzX/u9U+IPOo7SrMEFUtVB7zvSSobp2J+upYakQ=;
	b=Gvc9+ynlx5wI1ne2qCetVFFuSQnFqRKzMT7Z4SMW+M8mfht4tp48PNGKp2QR4Hd6ckKkKL
	jzheQ4kWGjuUftKvIAvjRES7NLJVhmjUk4VHmP8nGRjjJUbePzjCPtQCxX39T73TZ+xJA0
	7Cwj6c4h3Eem/j88ZcJ7mpdKOgWBYE0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	elver@google.com,
	bvanassche@acm.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/2] Bluetooth: L2CAP: avoid maybe-return-locked and add locking annotations
Date: Sun, 12 Jul 2026 15:42:45 +0300
Message-ID: <9a718ecfbeb46077d8100dcb687e1ab6073986f6.1783860121.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the maybe-return-locked behavior of
l2cap_get_chan_by_scid/dcid() by doing locking in the caller after NULL
check. This allows the static context analysis to handle this.  No
functional change intended.

Add context analysis annotations related to l2cap_chan_lock/unlock().

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Possibly the l2cap_ops::alloc_skb callback should have generally
    __must_hold(&chan->lock) and not just in l2cap_sock.c
    
    This would imply l2cap_chan_send() should hold the lock, but trying to
    add the annotations reveals l2cap_chan_send is called without chan->lock
    from some places:
    
    net/bluetooth/smp.c:589:2: warning: calling function 'l2cap_chan_send' requires holding mutex 'conn->smp->lock' exclusively [-Wthread-safety-analysis]
      589 |         l2cap_chan_send(chan, &msg, 1 + len, NULL);
          |         ^
    1 warning generated.
    net/bluetooth/6lowpan.c:455:8: warning: calling function 'l2cap_chan_send' requires holding mutex 'chan->lock' exclusively [-Wthread-safety-analysis]
      455 |         err = l2cap_chan_send(chan, &msg, skb->len, NULL);
          |               ^
    
    Don't know now if the context in these places allows l2cap_chan_lock()

 include/net/bluetooth/l2cap.h |  2 ++
 net/bluetooth/l2cap_core.c    | 25 +++++++++++++++++--------
 net/bluetooth/l2cap_sock.c    |  1 +
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ef6ce1c20a4f..53a68fc32f10 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -825,11 +825,13 @@ struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c);
 void l2cap_chan_put(struct l2cap_chan *c);
 
 static inline void l2cap_chan_lock(struct l2cap_chan *chan)
+	__acquires(&chan->lock)
 {
 	mutex_lock_nested(&chan->lock, atomic_read(&chan->nesting));
 }
 
 static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
+	__releases(&chan->lock)
 {
 	mutex_unlock(&chan->lock);
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 538ae9aa3479..ba8e69dfbe11 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -109,7 +109,7 @@ static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 }
 
 /* Find channel with given SCID.
- * Returns a reference locked channel.
+ * Returns a reference.
  */
 static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 						 u16 cid)
@@ -118,17 +118,15 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 
 	c = __l2cap_get_chan_by_scid(conn, cid);
 	if (c) {
-		/* Only lock if chan reference is not 0 */
+		/* Only hold if chan reference is not 0 */
 		c = l2cap_chan_hold_unless_zero(c);
-		if (c)
-			l2cap_chan_lock(c);
 	}
 
 	return c;
 }
 
 /* Find channel with given DCID.
- * Returns a reference locked channel.
+ * Returns a reference.
  */
 static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 						 u16 cid)
@@ -137,10 +135,8 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 
 	c = __l2cap_get_chan_by_dcid(conn, cid);
 	if (c) {
-		/* Only lock if chan reference is not 0 */
+		/* Only hold if chan reference is not 0 */
 		c = l2cap_chan_hold_unless_zero(c);
-		if (c)
-			l2cap_chan_lock(c);
 	}
 
 	return c;
@@ -4086,6 +4082,7 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 			  u8 *data, u8 rsp_code)
+	__context_unsafe(/* conditional locking */)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
@@ -4364,6 +4361,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
 	    chan->state != BT_CONNECTED) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
@@ -4475,6 +4474,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	l2cap_chan_lock(chan);
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4581,6 +4582,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_lock(chan);
+
 	rsp.dcid = cpu_to_le16(chan->scid);
 	rsp.scid = cpu_to_le16(chan->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
@@ -4618,6 +4621,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_DISCONN) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
@@ -5115,6 +5120,8 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	if (!chan)
 		return -EBADSLT;
 
+	l2cap_chan_lock(chan);
+
 	max_credits = LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
 	if (credits > max_credits) {
 		BT_ERR("LE credits overflow");
@@ -6974,6 +6981,8 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 		return;
 	}
 
+	l2cap_chan_lock(chan);
+
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
 	/* If we receive data on a fixed channel before the info req/rsp
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 735167f73f31..4afc5b370b97 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1740,6 +1740,7 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 					       unsigned long hdr_len,
 					       unsigned long len, int nb)
+	__must_hold(&chan->lock)
 {
 	struct sock *sk = chan->data;
 	struct sk_buff *skb;
-- 
2.55.0

