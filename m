Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF1405C2D
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779013820; cv=pass; b=YBI7dgyGN+9eVnoUB8grOOgC/yxMTqC6nKcRf7le4/UXRnsCg6o3nJOJFAGOZj6yzJUfhbD5OavNF1Sin4LqEuccF8BZXcuk6gD88fYkTBNywdRNCanO4pL+tOhpmdW9wAic4Lolem9o1JrJMUJVZWCYUoDExwD7E4IoCPBKwPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779013820; c=relaxed/simple;
	bh=3AeUstDIICAMASf0H1n3doV6mv0JpUudc598vuKyghw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azbYcpCMVq3Zgf46Ne2RQxbXBQeU90EcZj3TZwvQ+ao7DhrKn5GtIqja9EFPvRZYrzS1Zcp/EEZDr6Ye8HVP7zGUnDsT+uRzv7amNCBRVzfQXJ6wXuHW4JVACP5WSDZqFee+IdHf1LDkJ3ZaY2d7NCc1sZ3J1kicrH01FGEShT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=pMhzzKgS; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="pMhzzKgS"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gJHJ45TfGzyW5;
	Sun, 17 May 2026 13:30:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1779013813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ+80UJdLDtlOCO5VMYS30oxuX6YG4tAnBeMmR5txL0=;
	b=pMhzzKgSZ0vvxFlFkI3zfB82b5olvdNdez/tGbYUr761qWO9eH8I05GtmmEuZR5yfIZxiV
	HDbUzPMl+2txiGC4ngspOdfHx80jVo46fjV7BtVhRFmZihgVyNs77CJaBO5d6T3p2QFKfw
	Ns3kmDQKPzBhadSSD9M3QkAqmTC7jT4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1779013813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ+80UJdLDtlOCO5VMYS30oxuX6YG4tAnBeMmR5txL0=;
	b=HjzcXoDAJ5R3omAMz6M1oMyWz6RE9opNTxaentHvZRT1ZzTaWz0SN+IHzk40SsLN1ytoi8
	jvUoOqo89tBHR++IblpMJCJeS+xX8jhPTIt5voNnQT7x4or43rcnV1ytjvm7zFoafTPMIl
	TpbXPhI7pT0XiT10/cSGuClA26QbnBQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1779013813;
	b=qZ+AUiWMuEeudOmObGk1y+7QiUAT+lWniq5CiPjWOlJPnC7IGEAhZPol73TGXXENnvKay7
	GbQrYNYB4mQKVeG9+S3Jj18sgGENYS0fnEdn48c6BnUJYdsoTuFkfOxcyZfxx1EuhZ5FsG
	DKxxUrun3rzys1Aw3Z6rjtVGgfrc5F0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/3] sdp: Fix integer overflow in sdp_extract_seqtype
Date: Sun, 17 May 2026 13:30:09 +0300
Message-ID: <9deab5286f31cca0c21f4d3c8de1cf06a8a7f7ed.1779013529.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <e7e72c0208f579fd6bb63b76f9d2a1ea3cabd2fc.1779013529.git.pav@iki.fi>
References: <e7e72c0208f579fd6bb63b76f9d2a1ea3cabd2fc.1779013529.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check uint32_t value does not overflow int range.

Link: https://lore.kernel.org/linux-bluetooth/ygH6bncNsvf-0Hco92Ae11Lw8-jOfekFO6O3bUvFK8w0DTueny_rwJIF6ffZg2G_XCB4v8h8xRIcAL2b_KwaweNcGa231ZQDHCMpzyvR5i8=@fluentlogic.org/
---
 lib/bluetooth/sdp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 7210ce0b4..8c0865398 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -1214,6 +1214,7 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, int *siz
 {
 	uint8_t dtd;
 	int scanned = sizeof(uint8_t);
+	uint32_t val32;
 
 	if (bufsize < (int) sizeof(uint8_t)) {
 		SDPERR("Unexpected end of packet");
@@ -1249,7 +1250,12 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, int *siz
 			SDPERR("Unexpected end of packet");
 			return 0;
 		}
-		*size = bt_get_be32(buf);
+		val32 = bt_get_be32(buf);
+		if (val32 > INT_MAX) {
+			SDPERR("Invalid size");
+			return 0;
+		}
+		*size = val32;
 		scanned += sizeof(uint32_t);
 		break;
 	default:
-- 
2.54.0

