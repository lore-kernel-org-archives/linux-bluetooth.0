Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A92957C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521212; cv=pass; b=GAjJNe94e1XhS6JmvxkBLyRD02U3BFG8XPyO4aBpqsHv8ZvwrBu8yzM0g0zf1hk+4zYT95+qlvD42zhsDwdp6wGDGcJ0YkBtNKxdO8a0o6lKZqILeODbkropzg+52ErllvBfN5RKbyUktT/58XRE2Sl5whVhmNHtVyqHw1/8KO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521212; c=relaxed/simple;
	bh=bKpHq59WsSLZpW7kWgNwpcDlIFisrX0YxIpCIrx81cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AqU81Vsufw9u4NTBC9i8qGlPKB7F6RKhHqZQHqYoNNMn25UBQlJuAJLWEuhkLu1yz/+k0pwkDysCsjDY0J4bbGJ2gd5qgED6hB4icRj7iAnV90z7Cs5whDEebiXF02P5w98I2Y/BfWeASJF19Ncq1wzXrPH7xOl8OuugK9roex8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qDAIey/c; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qDAIey/c"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zk4zN3L2MzyQr;
	Thu, 24 Apr 2025 22:00:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1745521201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0n1cGZoC+maGoijnjwHew7+fdYz+OhtgyX2HhEGDSf4=;
	b=qDAIey/c40e3EmS7rM4RwoWg9umuWJTxzU7S8H8UsUTHfJS9pQdNr81RHpPNl6pGTv/oap
	bQEujqWZJd8I2G96ML+gBX/5cX/86K+pOjuAJfQK/mmi8C1fGn1gbt9jmhKEohslUxrx3J
	+XfScw8o5JT/MAnVADc5Y6/UFiIaA5c=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1745521201; a=rsa-sha256; cv=none;
	b=EtUkb0sWwxYzyvNFI53IVqgqrRvHunWJ8Ww+4cGzkPF7lBmHRwK6T3OH9WwJu6xMlKxotj
	HXxTmNfG25N3gaZPWgnSJo3khGzyNszWgWKSVS6i9sC8+FOfQWL//MrZLJMjp8/swd9UK8
	luOSjrb1RCHLInpH9Fq/wIrkoUPHmDs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1745521201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0n1cGZoC+maGoijnjwHew7+fdYz+OhtgyX2HhEGDSf4=;
	b=E4QEvA3ujCegildzWSrtI4Mrg+8hZM6yDKlFfrMqgb1rWwWaCVJweJhWhzahYD0FFKqDZK
	q/OmadaYn+hPb14jXTuyMQ9mdNyBiMZuNSXqlh5WG6NWjGj54ZDMWLuTzucjs2aJeb/nBt
	sS6eoVRdzkZm85/ox6G39oO+oqFoeWM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: L2CAP: copy RX timestamp to new fragments
Date: Thu, 24 Apr 2025 21:59:55 +0300
Message-ID: <66d361ea708bec460cb214662421cc9295ee2c7a.1745521149.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy timestamp too when allocating new skb for received fragment.
Fixes missing RX timestamps with fragmentation.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5ca7ac43c58d..73472756618a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7415,6 +7415,9 @@ static int l2cap_recv_frag(struct l2cap_conn *conn, struct sk_buff *skb,
 			return -ENOMEM;
 		/* Init rx_len */
 		conn->rx_len = len;
+
+		skb_set_delivery_time(conn->rx_skb, skb->tstamp,
+				      skb->tstamp_type);
 	}
 
 	/* Copy as much as the rx_skb can hold */
-- 
2.49.0

