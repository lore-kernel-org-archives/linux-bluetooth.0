Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4B35C696;
	Sat, 29 Aug 2026 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788043753; cv=pass; b=TIuT16pXopuQ71Ov+QCRBdLkTrKDSbZkY420BLnmw4XW0RyNGmB2/PpbeJGO+eSZDgzXgLrUud9eK9BMjKNbeK4QXLi05Q0D1h/WCrlj051XM1TVMd7ueLPrpewAeavMIWF9M4QfKCIeDPHQXIaN8JlyckCBxYUutCiOExqju54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788043753; c=relaxed/simple;
	bh=yCtF48zhAT2eqNOvR9pAn0ykJAWxRLEx3nkhxqMJH5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwa2U18WXOAj5t6AQ50TxqOIeWx84QQUbVv96weXcMMktQ+flN3/oPQoNpWyLRCFH1M0hKcPJq8r8wf3SFEN9y01UyQ2w8Yb3crmsCP0q9UbledMQOBdb2ejR4aaIhk7mtfSqCKCLRL6ZrsaThdhO9ucqoYK0BIg5jYZRLEjPjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LxyqURee; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LxyqURee"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXVmd2LjkzyS4;
	Sun, 30 Aug 2026 01:49:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788043746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T0yL7ipdMQHWOoBOuU4ceX3vMk9BjhKEuPwLBKaPnQw=;
	b=LxyqUReePyDkpiQdrk7Q8Wv32N2tzdVTab65/9oxQ4MVkep4LClv/9q/4jpMDoAoNxuIsX
	LqIiNgsnmSQoUbET0rYfC8rR1Sg9ecfnfwepaj5fx0Dc9wk2QouSX42OJ12gi4zmfVlp48
	aEG+TDv1CDZ48bNKs3Tum9q7lVhV0yQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788043746;
	b=J0s7quV+7+CIyfNUbGi2xzl0PoA3XRn+kkfPaq4M5X3uhjneLPnu1RYdAD+lMfoWubY4kl
	TnbBwOWjIVTNwFOYMYyTKD8FwCSLh+H9khPORaWyeswnywzvWGoDrfUCrfYDkdYWMsTpA+
	mt6MzwB6L6YykHa/55rSihybZTv2ZQ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788043746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T0yL7ipdMQHWOoBOuU4ceX3vMk9BjhKEuPwLBKaPnQw=;
	b=a4xwlyWDZcTktI12jkIeVya8k3r6LpfssdaTOy+bhSQPoJ2Q6KpeBPWszjMGlwMrcejcVe
	7q6MZivWglsVmoTFWQNYxuUTK9wyE4EYVCJbAcQsqJs1kiwdqFYjPEXWrB+6FUzgcqAPS3
	KP+UqoutbNhznVEPNLkNu6D9JaN21GI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
Date: Sun, 30 Aug 2026 01:49:01 +0300
Message-ID: <42d4d3cd947746c677c00f2c8aae0a0c2189f1c6.1788043687.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_chan_connect() tries to ensure there are no more than
L2CAP_ECRED_CONN_SCID_MAX pending ECRED channels, so they fit in the
same L2CAP_ECRED_CONN_REQ that l2cap_ecred_connect() constructs.

However, the check only counts deferred channels.  If 6 L2CAP sockets
are connected at the same time in order DDDDND (D=deferred,
N=non-deferred), the last can bump the total to max+1.  It results to
one __le16 written out of bounds of the scid array, and an invalid
ECRED_CONN_REQ being sent.

Fix by including non-deferred pending ECRED channels in the counting in
l2cap_chan_connect(), so the limit can't be exceeded.

Also add WARN_ON_ONCE check in l2cap_ecred_defer_connect() to make this
less brittle.

Fixes: da49b602f7f7 ("Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Bug found as pre-existing in sashiko.dev report

 net/bluetooth/l2cap_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 358b11eabd4f..6edf207e6345 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1329,7 +1329,7 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 struct l2cap_ecred_conn_data {
 	struct {
 		struct l2cap_ecred_conn_req_hdr req;
-		__le16 scid[5];
+		__le16 scid[L2CAP_ECRED_CONN_SCID_MAX];
 	} __packed pdu;
 	struct l2cap_chan *chan;
 	struct pid *pid;
@@ -1357,6 +1357,9 @@ static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
 	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
 		return;
 
+	if (WARN_ON_ONCE(conn->count >= ARRAY_SIZE(conn->pdu.scid)))
+		return;
+
 	l2cap_ecred_init(chan, 0);
 
 	/* Set the same ident so we can match on the rsp */
@@ -7240,12 +7243,9 @@ static void l2cap_chan_by_pid(struct l2cap_chan *chan, void *data)
 	if (chan == d->chan)
 		return;
 
-	if (!test_bit(FLAG_DEFER_SETUP, &chan->flags))
-		return;
-
 	pid = chan->ops->get_peer_pid(chan);
 
-	/* Only count deferred channels with the same PID/PSM */
+	/* Count all channels to be gathered into same ECRED_CONN_REQ */
 	if (d->pid != pid || chan->psm != d->chan->psm || chan->ident ||
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL || chan->state != BT_CONNECT)
 		return;
-- 
2.55.0

