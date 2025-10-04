Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA32257836
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759577864; cv=pass; b=XhkuhOYNMR/OqpONtSzl7n0a6qg12ntwp/tctBKDGfCebkmGeIeeXojLY++SIRUZBh2MpnIBHkEIU/PPxLrcO1o4pddRDJBLnb+8BssvOQ55NJXLKYl/SjMHsQDisX0BX61soSE2uC6jixDKyQ/zp6vDvZBGVC5y6nargIAs9xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759577864; c=relaxed/simple;
	bh=/LEWF24Le18wOPQTeOp3dSTwHYODzrj1FZ4oFjvt1Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzvshdN7RyIp1p6Q4reRAW56mSHI7zqSBzqvhlMmpsKCb+dUMJzWXVBENSWMHjNeRk+49zR2hAxT2omMEzr49GIs6p5zsdJ90dL5rg25Vj3pzNYtq9Bgq3cgzyxsVKvfJkxm8DH9zuUowpF2goE0ZH+60kp+vLBT5l6iTf95FFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ucuIX695; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ucuIX695"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cf3Rl1cyFzyRk;
	Sat,  4 Oct 2025 14:37:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759577859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FUyvtm8Z3ihaIxTG2/tH/rAWz3qiYM37tpmF/JTq9G4=;
	b=ucuIX695qtjMwn2+tXJKmDD0e0vkLw9kIwxUJuDc/IIizGuPJ+RE54u4OpV/cUyhcOOsB/
	DsoFpXdWhNl445WPTMCcNTXiqYbdu0kGNMz7V9Q/F6KkBD8oScotSeeauS5gb6CSxdgFw6
	v2b2ZCbKFe8AIQMvAsJhEPvIDBKAm48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759577859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FUyvtm8Z3ihaIxTG2/tH/rAWz3qiYM37tpmF/JTq9G4=;
	b=b/ub9lP4X98j4ngxVdDGniGWuNy2pqs4kLhm02Y+d//DX83uFVDj8rmwbc6MPaTbvcqKac
	RDodOhjK4il9rzRUyH22/H/Q7xWrBCcjYxfSwupNV743hD1XXCnGtZ1mROt/t+7SIRUcH3
	is3ljsQsBexg5tth8gnMHArjWXwl+ko=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759577859; a=rsa-sha256; cv=none;
	b=SpWn0QOT6UTiyIJN5zz3x+0oVwmLVgznPfYybFVAQ33V1Mw0Ho7mag3kHD3J268zkl90GC
	Sa7GZMGtugxxu19RHBUENfg6zoG2VKodwFOComycATyVzdSpEM+yzlqpiDLxwi5vnFWZ1c
	EEIB7j5n+8bcXN4yJpoKpJyu2G5FY3Q=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2] Bluetooth: ISO/SCO: hold sock in recv_frame
Date: Sat,  4 Oct 2025 14:37:35 +0300
Message-ID: <b1d0f88cdb992967daf6806116599d1b29711d6b.1759577633.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sco_recv_frame(), sk is accessed without holding lock or refcount.
conn->sk is obtained under lock, it guards data race on conn->sk versus
sco_chan_del() / sco_sock_kill(), but does not prevent sk from being
destroyed after unlock.  Similarly for ISO. (L2CAP holds chan_lock so is
OK).

Use sock_hold()/sock_put() during the section sk is accessed.

Simultaneous socket release in theory could cause UAF here, but probably
hard to hit in practice.

Fixes: ccf74f2390d60 ("Bluetooth: Add BTPROTO_ISO socket type")
Fixes: eb5a4de80f266 ("Bluetooth: Remove sco_chan_get helper function")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - handle NULL conn->sk properly

 net/bluetooth/iso.c | 7 ++++++-
 net/bluetooth/sco.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 954e1916506b..1f9a4c784ba3 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -572,6 +572,8 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 
 	iso_conn_lock(conn);
 	sk = conn->sk;
+	if (sk)
+		sock_hold(sk);
 	iso_conn_unlock(conn);
 
 	if (!sk)
@@ -583,10 +585,13 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 		goto drop;
 
 	if (!sock_queue_rcv_skb(sk, skb))
-		return;
+		goto done;
 
 drop:
 	kfree_skb(skb);
+done:
+	if (sk)
+		sock_put(sk);
 }
 
 /* -------- Socket interface ---------- */
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ab0cf442d57b..e7273dc8a073 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -402,6 +402,8 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 
 	sco_conn_lock(conn);
 	sk = conn->sk;
+	if (sk)
+		sock_hold(sk);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -413,10 +415,13 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 		goto drop;
 
 	if (!sock_queue_rcv_skb(sk, skb))
-		return;
+		goto done;
 
 drop:
 	kfree_skb(skb);
+done:
+	if (sk)
+		sock_put(sk);
 }
 
 /* -------- Socket interface ---------- */
-- 
2.51.0

