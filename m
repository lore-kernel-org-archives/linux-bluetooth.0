Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8811A0BF1
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759574415; cv=pass; b=U58a2xJgmM2kMNJIYdZKAQwNtBe3TMPNHy96AbjUrOo+yEJeB7bDFCH6IHtCNtv61B9r61iIR8lhYAhJsxqGqP7/d8Z+1ZWuH7FCw4aOhTCQCsvzZCCuKbePcyTQQ9b9FdvdJSYdQScnyUUly2zTEPVTl2YsJJsykzkOn+9R5X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759574415; c=relaxed/simple;
	bh=FvEE3C3je8xk723yCOtuVPIy2HuzxTi1+SjIKWDKWko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUGrXX4iq4b83ldbYKY+agJ8XxaSnHdZcK0yVnTgAhby5aD3ohpXG8MkVOACbUtMAxxJatqPnIb1oCgfO8CXPMEuy+XyTqOumFa53dDjJ/YlGFJfEeHLalOECQqN1gxp6WqOpx/yuFkY92HwidwPBiZA9QCJadlTmCWDaW0mbp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=A6YVXS1z; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="A6YVXS1z"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cf29L5hrzzyRk;
	Sat,  4 Oct 2025 13:40:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759574407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C2Ds2At5mqkM35YXw5BaWtp3aTn7X3PNPNn9TQG4u0k=;
	b=A6YVXS1z92pYsuZ75H+1wR0TibbCA/aKv0uFx8PU3grXWQxU9UHv28P5eAfZknwsiaLes8
	8yyIkJZBgI+Nr33WBVh7iV7olwlXsQ4qaydyXkKrVzMVVSK/BSdbBrZrtsjC3plq2y91Wy
	oNQs6YHKnykI+GdW1ysc6N6hwwQFmYY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759574407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C2Ds2At5mqkM35YXw5BaWtp3aTn7X3PNPNn9TQG4u0k=;
	b=AWp1oEYna1o40oDTf2drGVguv1uFKBjUjKuOUXOOTtD0caz3PDuOHo/0URA6KoWm5lwEB7
	yNFnneZO7RwTW7ImM3E6qVDQ5Spttya/hH3IiCEVIcnQ4w0r46mG9TFT35X1wi7dXWZywf
	2wX0b/pkkyy7BK9p7x3V8Skd7XcAM1c=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759574407; a=rsa-sha256; cv=none;
	b=RbMiIMbRre9F1JzpNWqLU1Be1EGqouReLkJ3kYJOxlUlnyUn1rYSv21CeC025dgwrU88w9
	UTiavpJaUwKCknncSU9O1rCwam37O++ve0gydSENOaHrEGQkIIQZl5Sm65tOBuAJ3/wdKQ
	4ktTbO20GILrtqydTP8AWzLWZZZKv5w=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: ISO/SCO: hold sock in recv_frame
Date: Sat,  4 Oct 2025 13:40:02 +0300
Message-ID: <cf27ee8617f375fc6bd2f3076e961f8fa175e07d.1759574275.git.pav@iki.fi>
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
 net/bluetooth/iso.c | 6 +++++-
 net/bluetooth/sco.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 954e1916506b..565410aa6cad 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -572,6 +572,7 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 
 	iso_conn_lock(conn);
 	sk = conn->sk;
+	sock_hold(sk);
 	iso_conn_unlock(conn);
 
 	if (!sk)
@@ -583,10 +584,13 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
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
index ab0cf442d57b..36e316792582 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -402,6 +402,7 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 
 	sco_conn_lock(conn);
 	sk = conn->sk;
+	sock_hold(sk);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -413,10 +414,13 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
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

