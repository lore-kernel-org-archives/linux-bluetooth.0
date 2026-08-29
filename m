Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF842A96;
	Sat, 29 Aug 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013282; cv=pass; b=I/rhoch+jtN6OPNnXBExaWEc1Rq838t3lt5ti9yizVGr5QECgfJFMwwMIYzIxCBh+efPquMkkes0I3qHU9xK63J+fhSacCwzZ7FPzPv+SyesuMAESifQoUh7JOqvr8ggSY/bCXd7Svz+P7yVlNIb4HbgwNc6EgF2ajwwNrzXL4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013282; c=relaxed/simple;
	bh=QdBBRlhHamIErJyEgdDWKQJ4g/jiKHKA1kE82VRzDGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W714O/EWtd3tZ8iS7lEF26RFDFZVlScz+CDMy8kgi6M1A/gcdOKy7CfLGyDGLeKMrxhXfagYI3kdcWJlgkOmpeW5ok+5Rue8N8sm0+hfGLL7KVab8YuKPptBiQpnJ2k7i2qwYkN38GfNz8dlFCFOWY3xKtsceSou6bMtdgRFf5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=tSs4XaKX; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="tSs4XaKX"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHVd6WVLzyWl;
	Sat, 29 Aug 2026 17:21:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29nBADU74ZrC5xPAbw987SaaBfsEBjMitjT7ZQbjhIQ=;
	b=tSs4XaKXNP5qgH5o2aFG2xrJ94li0z2OI/vk9/oI7Ecv7ZJa5LHvPKZVlmtJmYxLCncPXa
	uv2VYle013AHlVrL0NFGyQk+yjs+dHJmfKkV6vogTKcbxTw0Fa+OSL3LbO8VjtOLcScJJv
	/PBqZHy2NDMtHOuh28icmXPNVEpSkSc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013274;
	b=oM+IMMcb79s1ng7EXrfYz+viIwoGchMQB0hvWnGWBmjz06BD1rFaUh/9ybuJSryV26FtZT
	eNnEYBRv6vFv2zKwBp5gAG9IFzVigfh8hExPfd6/LHkmzUtd0zYeQeNpYTXnR/f0KTsDQV
	7qsxwj9hje3csO3FNEu4TXdVWK4Lzbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29nBADU74ZrC5xPAbw987SaaBfsEBjMitjT7ZQbjhIQ=;
	b=c8l3vleegRpJk3nT7SbSxoECB6g0cKL599+nCsc2aQkO0OPIMJdNce7v2b8ZN73phoplWF
	42IbAztNGwp3G42ruVoTWrqOydGSv26BWOWqGcqQXfGjduDlYvyt8fSec9misdj00w/kwF
	pZTbHcNx+AwURh7ACqyjSay/KRvZcSo=
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
Subject: [PATCH 06/16] Bluetooth: 6lowpan: avoid concurrent peer_del() in bt_6lowpan_disconnect
Date: Sat, 29 Aug 2026 17:20:01 +0300
Message-ID: <35b69716d9516c19662d5615a962ceb6be34ffe3.1788013041.git.pav@iki.fi>
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

bt_6lowpan_disconnect() looks up and accesses peer->chan, without
holding locks guaranteeing peer_del() cannot free the peer concurrently.

Take devices_lock to ensure peer can be dereferenced safely.

Fixes: 15f32cabf426 ("Bluetooth: 6lowpan: add missing l2cap_chan_lock()")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/6lowpan.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 4ea55950e599..ddcdd2aff91f 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -912,16 +912,27 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 {
 	struct lowpan_peer *peer;
+	struct l2cap_chan *chan;
 
 	BT_DBG("conn %p dst type %u", conn, dst_type);
 
+	spin_lock(&devices_lock);
+
 	peer = lookup_peer(conn);
-	if (!peer)
+	if (!peer) {
+		spin_unlock(&devices_lock);
 		return -ENOENT;
+	}
 
-	BT_DBG("peer %p chan %p", peer, peer->chan);
+	chan = peer->chan;
+	l2cap_chan_hold(chan);
 
-	l2cap_chan_close_unlocked(peer->chan, ENOENT);
+	spin_unlock(&devices_lock);
+
+	BT_DBG("peer %p chan %p", peer, chan);
+
+	l2cap_chan_close_unlocked(chan, ENOENT);
+	l2cap_chan_put(chan);
 
 	return 0;
 }
-- 
2.55.0

