Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA63FFAC6;
	Tue, 14 Jul 2026 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018476; cv=pass; b=WklKpu1kq3CT9QHzgpMteTkiXoQcjuZBOdO1JKl0IXYSEnUxKcUbj5ahMEmE7IGbZWqI7W3GwfPaQBd1Uzl0GeGoBb/iDJ2kedMrYHK18D9ELenb2K5b1C3Ktv8Jud9sC+pyeUJINdf8lvNgrm9N689dQ51iBOLtGeXg2ou2dC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018476; c=relaxed/simple;
	bh=nbSPde3UkSVASsOM4r9b2J4uWTBw0+497lxH2wBCk1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lF9JD1njLbRpK3AFZFMtyAQGKDE0qSyfhCcKiDGtIuvrFuodj2m5hKaVlJKiDqQbwU3AtMRDSvNtBDm600tSj4ZkGBMTBmb6VUSu5YNISS8PxqExZQr7hsBBUVKkO+yhoFX/Rvph39gJd+f0ZlIqDPUF0MtsrUCJ3AQ+06WiRwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=v0ZvMMw8; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="v0ZvMMw8"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gzt7J3c1Gz49Q40;
	Tue, 14 Jul 2026 11:41:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784018461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qfKwqt20ln/lNPj08FQSGLMybK9KhqCVH3d4zCDXX1U=;
	b=v0ZvMMw8K8/WjpuoKV+Z+nByXF8LzZkI9k9aYmpRWgxXYQSU3jUXDnAdr3REjdJS/C3+ee
	p9rB16M/l0C5c6xLp+9vG7+v2fgkcxwl38b2cXd7pX9wKL2OTt1OGHeQs631ghB/VEv5QR
	zMnWlJnI6m7pEbfDafqsjEa40IE1WT9C8fuV5VnHeFlL06c23U5yyMaOpTuj6fVurwQMsg
	nJIDrosSQwTrHmplH5r7TpPbJwZ5DFrP71zugMeo0GNOR39D/NCsY6fdekBVMKWjoNBRqM
	KDb+sv6TsbamVcUTHHVyu9ahvJmt4zaXU1YbqtkStxoK6FH2W/NZiYMhq3UJtg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784018461;
	b=hum3WxCumSkNr8+6Ac4AxaXiUaC17Xg191o5z0CrFxSWHkYNs2ktWxZ80KTuROT6Dl77j6
	rRDwDyVKIWHhwa/Ba8xF72fLigMPM4yV5vftGZqpBqBkkXmAmHIKjwefgO9aFBgTzv9ySC
	x5I5eQPZhdO6ijOYXVf0LKkXXGErHoBb2S79S7Fjc0AP/ReqDQ9pYkscjxy7SKePTDCrw1
	DQdUTk3PccVU65qxU1pSUvWJuSgz15oBMiEKiS8pSHOsJeZEbZ4C3ElT0otNpOolhi6pac
	PSK/JUeEkRpvrRF50Hj1ObhsytXHP2HlOz5/Hy9o5XYFj4mn6xqO+DZ3NDUt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784018461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qfKwqt20ln/lNPj08FQSGLMybK9KhqCVH3d4zCDXX1U=;
	b=sxutrsi88ntQgIeNG0+LAZgzcsfFyexVpDzocSG44eeH90qt2Ekc5Kae8mxUdjSa7+RVYX
	qRORN+aS1pBDGSM+7OuwwKyvwTATyKo3gQNHW/sliyXhbTRhupga7afi4P3O09GMWVJ44m
	LmenZFmTj4PmXrog4Ufv0PMb8rmLxcrs1u3hMimCeovY2mtArxl7mgVcpbZCgQICfxVvZg
	CvAdhnwecs8MYdcf4zEMssZgZkvcsG3I7RzLns68iFLm6grrURpHY3HXfMe7UUwbEHUBEK
	YiJFBt+SjkG0wmWKY640KfFYdHDZ2zz5lc5CDCsWc3ElxAIavqdTCqinkIW9Yg==
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
Subject: [PATCH v2 1/3] Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid
Date: Tue, 14 Jul 2026 11:40:49 +0300
Message-ID: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the maybe-return-locked pattern in l2cap_get_chan_by_scid/dcid()
by doing locking in the caller after NULL check. This allows adding
context analysis annotations for the locking.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - split code changes and adding annotations to separate patches
    - remove self-evident comment

 net/bluetooth/l2cap_core.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 538ae9aa3479..322a1895c1bd 100644
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
@@ -117,18 +117,14 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 	struct l2cap_chan *c;
 
 	c = __l2cap_get_chan_by_scid(conn, cid);
-	if (c) {
-		/* Only lock if chan reference is not 0 */
+	if (c)
 		c = l2cap_chan_hold_unless_zero(c);
-		if (c)
-			l2cap_chan_lock(c);
-	}
 
 	return c;
 }
 
 /* Find channel with given DCID.
- * Returns a reference locked channel.
+ * Returns a reference.
  */
 static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 						 u16 cid)
@@ -136,12 +132,8 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 	struct l2cap_chan *c;
 
 	c = __l2cap_get_chan_by_dcid(conn, cid);
-	if (c) {
-		/* Only lock if chan reference is not 0 */
+	if (c)
 		c = l2cap_chan_hold_unless_zero(c);
-		if (c)
-			l2cap_chan_lock(c);
-	}
 
 	return c;
 }
@@ -4364,6 +4356,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
 	    chan->state != BT_CONNECTED) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
@@ -4475,6 +4469,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	l2cap_chan_lock(chan);
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4581,6 +4577,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_lock(chan);
+
 	rsp.dcid = cpu_to_le16(chan->scid);
 	rsp.scid = cpu_to_le16(chan->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
@@ -4618,6 +4616,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_DISCONN) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
@@ -5115,6 +5115,8 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	if (!chan)
 		return -EBADSLT;
 
+	l2cap_chan_lock(chan);
+
 	max_credits = LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
 	if (credits > max_credits) {
 		BT_ERR("LE credits overflow");
@@ -6974,6 +6976,8 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 		return;
 	}
 
+	l2cap_chan_lock(chan);
+
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
 	/* If we receive data on a fixed channel before the info req/rsp
-- 
2.55.0

