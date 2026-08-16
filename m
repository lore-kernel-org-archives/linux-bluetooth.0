Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703E327BFA;
	Sun, 16 Aug 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786873652; cv=pass; b=cesxZ7C9xde8AyvFOolLvtb5dii5FRX8IOeb7kEQ+Rkb2D54ZZRwH+DJJiRf5O64epfJG26s6Aq3O4TdUYp4EtSufG3fsCQiwyNzNy8JOyCh/9ixavNV1jJoZK1fiFofxgKe/zWvseQ+eJ8ELQaQfOiRw1XQ/I1wb3KO0LEIO6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786873652; c=relaxed/simple;
	bh=6ejippPszx/Z1b+UVWUgh/v7H/P233/XVnyftkvOh8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fF7AlcVNEJie3OR3lVam8X3d3zDbdnUdjV+4Y/0iTnc7R4B06Mj3QOx83R6ajypMVJrkvSVNgbwjV9K6B2dnVq3BUbehBZ+x0Glbxa3gNXG8/kMuYMjkpbMYJpD9dWYfMwMR21bNyTROmxI7PO09Zg+a8t/E2pCnz9ABZuAaqnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VJKJynEJ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VJKJynEJ"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::de01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hNB2g0G1nzyRf;
	Sun, 16 Aug 2026 12:47:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786873644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NkzqQX0iLQpTbk3r389OtilBENhriAoEnLJdOuLjgLc=;
	b=VJKJynEJSeMkr8ZfQ8tOVpTmO7VH3OIFST50yr7IUWyG7b2wi5yE/ot4b960HZx2pSOAkK
	vzn+JdCuoOZHilkWSiicl+cxepZNkAOOAXM2mTwTOlxkC1Yd44sQQ0i/fe+gWZYqQ7aiUQ
	qoxu3FGBxxfh7/6EjXCMEHH1cqP0+L4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786873644;
	b=gVzl300FN1vgP4zxvXl7zsh1O9RrfO3TWSDjB1Z6t9PVde595YOo1FFFrat6YkQfUXFgGg
	K3pkSZCUBiyNy5FVR3ZOhWVB4Hp+GD29dRaXsAIDva/jK2nHIa3Qmy41+U+JX67q1aqghn
	y8DtYqADFYPmxYY9Yw99MCA2cJ3t9WM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786873644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NkzqQX0iLQpTbk3r389OtilBENhriAoEnLJdOuLjgLc=;
	b=hRNtE4rLUIXAhHAVLpFkdc973PUAtXOrukkZbSRQhSd2mB+CpaZJkIUnmcEXPbInxMEJO8
	Ec4Bf7piv6OdgUx3b2HkrKvli75nMgenw+Oo9ST1+9Engwyyewv6X1LU0uYxtTt2/eShxI
	kxAei3RUMbHC+bvWT2NPrbU7BA4obrc=
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
Subject: [PATCH RESEND v2 1/3] Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid
Date: Sun, 16 Aug 2026 12:47:03 +0300
Message-ID: <35f8d2856ef35e1c6314101ee60b16af39d88e78.1786871620.git.pav@iki.fi>
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

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    resend:
    - no changes
    
    v2:
    - split code changes and adding annotations to separate patches
    - remove self-evident comment

 net/bluetooth/l2cap_core.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ee459dd411f5..df41ef952500 100644
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
@@ -4368,6 +4360,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
 	    chan->state != BT_CONNECTED) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
@@ -4479,6 +4473,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	l2cap_chan_lock(chan);
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4585,6 +4581,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_lock(chan);
+
 	rsp.dcid = cpu_to_le16(chan->scid);
 	rsp.scid = cpu_to_le16(chan->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
@@ -4622,6 +4620,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_DISCONN) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
@@ -5124,6 +5124,8 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	if (!chan)
 		return -EBADSLT;
 
+	l2cap_chan_lock(chan);
+
 	max_credits = LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
 	if (credits > max_credits) {
 		BT_ERR("LE credits overflow");
@@ -6983,6 +6985,8 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 		return;
 	}
 
+	l2cap_chan_lock(chan);
+
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
 	/* If we receive data on a fixed channel before the info req/rsp
-- 
2.55.0

