Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A43403FF;
	Sun, 16 Aug 2026 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786873658; cv=pass; b=q3E6Kp1T+tjaEWLGa11IBA3VaDbrK3AWiDEeteXBSG2EHg4BPRpktBlGuBHp7irTEIl64h1c2fwGy7KuRnd0Ar+r5oSxJEcQ2povp3vRWG286GGOTXUj3REkn1X/ijdc44krVZHS0coZtkX7bKRAr8EW6YnTInoDB1naMQaicKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786873658; c=relaxed/simple;
	bh=0Asz+8JgVd1ocMn717/3FzFKHMY4xGfEZ4L54zBaxmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/i8jcE99XFdxtZk1u9CXPZr1iGSFZeK/IF8zE9ZAx/Y0Bzs1e0hFOU/62VurBpaYiNvPdHFEyYIkHHNQbtxFE7ZRQBIqgaaDuWmlwbbHFwyXd0yE4S4xzLkihj6Wbx/xUL8LDpU4bkpQXk79Kg4iUAk5izomB6kAzKIhMoGCWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=glQ3VZOu; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="glQ3VZOu"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::de01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hNB2n1T7JzyvC;
	Sun, 16 Aug 2026 12:47:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786873650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=raZ5oX1kxBHFXl2R16gSUwOp4yU+OSXqLKRG1/92mSY=;
	b=glQ3VZOufiqZSsupCRkODE1YaFTHGUPp0MxtCFhpIpkkT5l3wLs10UzSo/TyBapIaCdxMW
	Z5fPcnzHCH4zBeMReGL8x3wcD3txVJHYUU6mL20bd6hSVYe/ZYmeEWrFqZjcC7UMP2HbuO
	00xxoUj6l2Zo9BUopbo2u/gzBtzle0E=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786873650;
	b=nDHiFf7m3zdyR9bBoOzVo30F1f69bS6LbPRvs3P6DJITaWTRrky+bft1da2yzsZw73FUXt
	/eCp+XgNET9TBGSRGzqReLiyxOgMscgWLdCNkGywz8djOI8CABkXWfnsfgC2MkIVwT/zNf
	NdCfvWg7y3rj+lKD25iuOMoUh+pq67Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786873650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=raZ5oX1kxBHFXl2R16gSUwOp4yU+OSXqLKRG1/92mSY=;
	b=SvYiURQ8lw2Ws/mGao5ObkiJW38vQ+ANA+yNpJbUezYvWMLYVBhj1uUspmXpEa0x6EuvDQ
	03BMBlFPHwVYibLtGyln1r5XqPHWLrvx6tMo5qiK4yW9hsXakGWXgLdD2EGY3QbD+tWwRq
	vq69PO8/M1aW1ldZpLffwNGxUCiq/ck=
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
Subject: [PATCH RESEND v2 2/3] Bluetooth: L2CAP: add locking annotations for l2cap_chan_lock/unlock
Date: Sun, 16 Aug 2026 12:47:04 +0300
Message-ID: <dbde2b4defc81f3401044512c0127e75f130e3d1.1786871620.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <35f8d2856ef35e1c6314101ee60b16af39d88e78.1786871620.git.pav@iki.fi>
References: <35f8d2856ef35e1c6314101ee60b16af39d88e78.1786871620.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimal context analysis annotations to l2cap_chan_lock/unlock() and
callers required for no warnings.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    resend:
    - no changes
    
    v2:
    - split code changes and adding annotations to separate patches

 include/net/bluetooth/l2cap.h | 2 ++
 net/bluetooth/l2cap_core.c    | 1 +
 net/bluetooth/l2cap_sock.c    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3d9a32094347..69d193fee351 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -830,11 +830,13 @@ struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c);
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
index df41ef952500..358b11eabd4f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4082,6 +4082,7 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 			  u8 *data, u8 rsp_code)
+	__context_unsafe(/* conditional locking */)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1194c37e466f..b553b6356af8 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1784,6 +1784,7 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 					       unsigned long hdr_len,
 					       unsigned long len, int nb)
+	__must_hold(&chan->lock)
 {
 	struct sock *sk = chan->data;
 	struct sk_buff *skb;
-- 
2.55.0

