Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10C2367AD
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482096; cv=pass; b=STLRY0ywx/DfgWIUcxsL1/iNUVRelovwvvuNzd57lYvb+7pdvPXw3WztajI++4jn4f3wqY0Nbv1V9FbHYfG8f9m7LP3+cDaiaB3wYRXL3An17c4XwxqZjcCKp23LlcmoODWpujqSs6eemSVRZp35TQ87T/YuUpULvrXtREpB5ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482096; c=relaxed/simple;
	bh=Ez1oPeNZwLs2nokT9Oz1Pryz7GpoL2ZAw9SiN2cW8Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMpQBD5Xm1IjqT/12xRMbMwQ6wlX9MBb1j0+H7oBnh6MW8w3+aNdN+FuivIAbtXuQIGOqp6oJXQDjfCO9Dxa8woqAiR7QTnovo7nnEs9SxljJ50tFbvdaCljhdLD1udq7MUDNYXhX7wPFNFPSF4YKmMuUHB4Q8RMK/rkIH9F7g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=xka1+ab9; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="xka1+ab9"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCB4vcDz107P;
	Sun, 21 Sep 2025 22:14:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1/oO1dAiOR7l6TBKj1ymR7yCcH8SkT44VeHHiW//Lg=;
	b=xka1+ab9R1AC5OQirvKWoqOJC0nqWa1Jp2A9RS2n6Xdgmn97CKu9NChU1dqxy9iaW6jnnz
	D+RKn746hBcv7mdPjeyaTiOEm6A4EZZXPD2jmXYEaieH/OqHWXwQoFgogHCxylHDlNcyaV
	LsdOYI0wRULhz5wqXuJiT2KA7wIYFcI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1/oO1dAiOR7l6TBKj1ymR7yCcH8SkT44VeHHiW//Lg=;
	b=ocW9byNL8d4gwqnBqsVaUTRxWOIgB41CxHuquQXJb11EEFEVcFUXUvSLBsNCUcAYAu/VbJ
	udh+ChfOURaEf2vMk2Z0qj7kEElXAgnRB3+kMUFHX1V4vj/EGinP8YMP7/7q6AoCQzB1e0
	wE34Qd2fwzTJLHtThapv3fM3oWVnHIg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482086; a=rsa-sha256; cv=none;
	b=FIIhFHql97dDLiUJyh11CZ9AjJXBQv2kJYog4oUQPW/ncPel2pVuuUub09rCr1JFRtqIdp
	j97v0eDvLfFTWAr5ypQ3XHq08URBgZM7BTCJ3s2O+f5YaSDICTPXCqA49vWukgX5eQcHoH
	ujX9aylhMurx5cGwW3G8Q5rQ/IZFOGQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 02/24] Bluetooth: ISO: don't leak skb in ISO_CONT RX
Date: Sun, 21 Sep 2025 22:14:17 +0300
Message-ID: <c898fec290b68d341f4b47232c69f2125f9c3f8d.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ISO_CONT RX, the data from skb is copied to conn->rx_skb, but the
skb is leaked.

Free skb after copying its data.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d63d4d6f874c..f5a9a13317df 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2420,7 +2420,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-		return;
+		break;
 
 	case ISO_END:
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
-- 
2.51.0

