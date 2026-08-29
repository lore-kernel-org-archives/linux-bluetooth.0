Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C553ABD80;
	Sat, 29 Aug 2026 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013260; cv=pass; b=TyMWNDe5mD1DLoBmU9+tzSNzs/FcnFU8+JNNqWgEPs6f9cq9NKInLJeWd8FywaSvHp6TSRAKuuIl+k9LRM+PLjy3UEPfOnbE7lXCH6XvNsgyhfoKHi8lk83aXhcqGzC32lJJgvcksAh32YqYUoG75Lv8jrOW/9pFUbXRdcXno6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013260; c=relaxed/simple;
	bh=y1mmnI7DF7MHoYSEhAOGbWaboreUA8FXN+9Yen71T6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QX8hGWWAmC2ykq9YdatbJuTbH3inMFzJdnI2Xqytc5pD8lOkff3Dk1tcSJu9c98UI76yGX6s7+kyzi/HSb4TOZ7n6aNa/Yg9T8E79bLyTvS7gMTfS59QeUzYUZBqJpV9iXnR8V9X9WwUPZ+A4jZdk2+CClqMth0bH1I4ncrGD0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=loNRmo1y; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="loNRmo1y"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHVB6DXvz11Fv;
	Sat, 29 Aug 2026 17:20:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHRCViVmqRUSwDuzHIJl4IxoLCXvYL46WleLf0VR724=;
	b=loNRmo1y2QmWduo0hASO+y/gRfUzx1HiKrWLtPOzrBlc0fYVV7V99rcZtNh3mO0RRByvn4
	6iPPAuJKXAfKPcoUa45id3em49q1Id8PnM+Wcxb1VA9uFWmM9ly69d0GvjOi282OQil4i/
	bHibXWsEkua5zt0oaYHVWmMqB0JigPQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013251;
	b=ZLy9edeVTHphIZAEekQ79bPzmF8jM91+hmKA22w699BcW0NizKsWeeaFwtjz8EE54wJGtn
	QzvCBjkPNzqkdFD3HaOZ+94Al/2Es18TCPXJ8Hu+9Uht+dGjOar4CUEXPN3XmGn+9lfdWQ
	nu3BLKwNbJ60le8GtlWmjHcKpcpvg+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHRCViVmqRUSwDuzHIJl4IxoLCXvYL46WleLf0VR724=;
	b=c0m4m8ZpM2pRiaWqlkwuvPYiGMXWKnUsQ/qdyjJ3/aqtKLdS/m7M3elBmSMDBYqgBaRI9B
	WqudSeOzQWz2xvJTwWFXNSPomhaGmFRWcN5B5JV8ZEmTSMSpTF0SLDnJn5Gn8T5xY1IX6O
	AcV6YoVQQJbv+4auR2mOz8iM1BaO9bQ=
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
Subject: [PATCH 02/16] Bluetooth: L2CAP: add l2cap_chan_close_unlocked() and locking helpers
Date: Sat, 29 Aug 2026 17:19:57 +0300
Message-ID: <fc6ef10f3e62dcd8f1a9eb5b446755bf522b307f.1788013041.git.pav@iki.fi>
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

l2cap_chan_close() requires holding chan->lock and chan->conn->lock if
associated chan->conn exists, to guard eg. conn->chan_l. Taking the
locks with right ordering requires handling a race condition.

Add helper function l2cap_chan_(un)lock_conn that do the locking right.

Add l2cap_chan_close_unlocked() that does not require locks to be held,
as all callsites do this lock -> close -> unlock pattern.

Link: https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/l2cap.h | 17 ++++++++++
 net/bluetooth/l2cap_core.c    | 61 ++++++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 43a67562b238..84f557d354ca 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -962,6 +962,8 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 struct l2cap_chan *l2cap_chan_create(void);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
+void l2cap_chan_close_unlocked(struct l2cap_chan *chan, int reason)
+	__must_not_hold(&chan->lock);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type, u16 timeout);
 int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu);
@@ -988,4 +990,19 @@ void l2cap_conn_put(struct l2cap_conn *conn);
 int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user);
 void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user);
 
+bool l2cap_chan_lock_conn(struct l2cap_chan *chan)
+	__acquires(&chan->lock) __cond_acquires(true, &chan->conn->lock);
+
+/* Release macro for l2cap_chan_lock_conn, so context analysis understands it */
+#define l2cap_chan_unlock_conn(chan, conn_locked)			\
+	({								\
+		struct l2cap_chan *__chan = (chan);			\
+		struct l2cap_conn *__conn = __chan->conn;		\
+		l2cap_chan_unlock(__chan);				\
+		if (conn_locked) {					\
+			mutex_unlock(&__conn->lock);			\
+			l2cap_conn_put(__conn);				\
+		}							\
+	})
+
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index adcf714ec1ed..58c88e116ddc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -59,6 +59,7 @@ static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 static void l2cap_retrans_timeout(struct work_struct *work);
 static void l2cap_monitor_timeout(struct work_struct *work);
 static void l2cap_ack_timeout(struct work_struct *work);
+static void __l2cap_chan_close(struct l2cap_chan *chan, int reason);
 
 static inline u8 bdaddr_type(u8 link_type, u8 bdaddr_type)
 {
@@ -422,7 +423,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	else
 		reason = ETIMEDOUT;
 
-	l2cap_chan_close(chan, reason);
+	__l2cap_chan_close(chan, reason);
 
 	chan->ops->close(chan);
 
@@ -829,7 +830,7 @@ static void l2cap_chan_connect_reject(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP, sizeof(rsp), &rsp);
 }
 
-void l2cap_chan_close(struct l2cap_chan *chan, int reason)
+static void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 {
 	struct l2cap_conn *conn = chan->conn;
 
@@ -878,8 +879,58 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 	}
 }
+
+void l2cap_chan_close(struct l2cap_chan *chan, int reason)
+{
+	__l2cap_chan_close(chan, reason);
+}
 EXPORT_SYMBOL(l2cap_chan_close);
 
+/* Take chan->lock. If chan->conn is non-NULL, take new reference on it, take
+ * chan->conn->lock, and return true. Otherwise return false.
+ */
+bool l2cap_chan_lock_conn(struct l2cap_chan *chan)
+	__context_unsafe(/* conditional locking */)
+{
+	/* Handle conn->lock > chan->lock ordering + race on chan->conn */
+	for (;;) {
+		struct l2cap_conn *conn;
+
+		l2cap_chan_lock(chan);
+		conn = chan->conn;
+		if (conn)
+			l2cap_conn_get(conn);
+		l2cap_chan_unlock(chan);
+
+		if (conn)
+			mutex_lock(&conn->lock);
+
+		l2cap_chan_lock(chan);
+
+		if (chan->conn != conn) {
+			l2cap_chan_unlock(chan);
+			if (conn) {
+				mutex_unlock(&conn->lock);
+				l2cap_conn_put(conn);
+			}
+			schedule();
+			continue;
+		}
+
+		return chan->conn;
+	}
+}
+
+void l2cap_chan_close_unlocked(struct l2cap_chan *chan, int reason)
+{
+	bool have_conn;
+
+	have_conn = l2cap_chan_lock_conn(chan);
+	__l2cap_chan_close(chan, reason);
+	l2cap_chan_unlock_conn(chan, have_conn);
+}
+EXPORT_SYMBOL(l2cap_chan_close_unlocked);
+
 static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 {
 	switch (chan->chan_type) {
@@ -1563,7 +1614,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			if (!l2cap_mode_supported(chan->mode, conn->feat_mask)
 			    && test_bit(CONF_STATE2_DEVICE,
 					&chan->conf_state)) {
-				l2cap_chan_close(chan, ECONNRESET);
+				__l2cap_chan_close(chan, ECONNRESET);
 				l2cap_chan_unlock(chan);
 				continue;
 			}
@@ -1571,7 +1622,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			if (l2cap_check_enc_key_size(conn->hcon, chan))
 				l2cap_start_connection(chan);
 			else
-				l2cap_chan_close(chan, ECONNREFUSED);
+				__l2cap_chan_close(chan, ECONNREFUSED);
 
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -7648,7 +7699,7 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 			__set_chan_timer(chan, L2CAP_ENC_TIMEOUT);
 		} else if (chan->sec_level == BT_SECURITY_HIGH ||
 			   chan->sec_level == BT_SECURITY_FIPS)
-			l2cap_chan_close(chan, ECONNREFUSED);
+			__l2cap_chan_close(chan, ECONNREFUSED);
 	} else {
 		if (chan->sec_level == BT_SECURITY_MEDIUM)
 			__clear_chan_timer(chan);
-- 
2.55.0

