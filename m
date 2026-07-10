Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73779136358
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700711; cv=pass; b=uRMAH9I2Wi76PuflU6ctqVqTdI7FInVeJ19d+wFRSMSq516S15t9g8CfW0d/1gVisfxp41ZEcAZBQxVM3LgySKegae2aSjdRHUthdLbPQEwdZLKRNSwsjqgyZbKW99GjB5Tca/Prn4XCOnxjo0x0Emt0PfVhqQCvYKI42wmfQTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700711; c=relaxed/simple;
	bh=bc0wYBRH3VXW+CT+D5uAtylEz0mTp1YSRFiX1kJy80Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFuED5JR2ytGE6p3h4FdmF59GfOkGr3saOj0SxwJeDThR0DOvGGpVGxp09HXdmDDwJSHEG1STCvQks1RUPi1lojzHUolWXMw4Gmzq2LHJODQh1VbCYB7LWhQ1UzjBjVwHxB0/gQnRFNeOIT6SMbyQR5secrkgq7Ki7srMN7XSZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=IKYM+OU6; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="IKYM+OU6"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gxccf6M2NzyRb;
	Fri, 10 Jul 2026 19:25:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783700707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vd2N2CE7bWDIZEUPvjiOcxZNB1LPqMoIShQwbMPpPa4=;
	b=IKYM+OU6eo0U/1vReihviaSHMDG6kgwimPC6fd2O3XiMqUTEEFlpWGEUB8C0FMIlLctD2f
	bQ/yi5cUesCVfm3vLhAZfA1kReXSVZTYTgejjqCo64ucPQyFsx9H4TJfoFr/58atxq6xwy
	lYpRh4eInKiWsALIUif6lu2exBR8vuI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783700707;
	b=Som/pHmFL+7pRUW1Ye8AjtE2MfZxeIp3a7Fs3Sra9jPILTxPQNSn449x/9bpYQ2FJu+19/
	3ZpZobybA/6vL23i00xbI3YhKlPESgoKv7QuDcANqe0rnAlSzp08w77kPPFKt+bKzHkwQR
	u9kyhtcUD/T5vZjOxv5m7S/pHnOU/3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783700707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vd2N2CE7bWDIZEUPvjiOcxZNB1LPqMoIShQwbMPpPa4=;
	b=hxPnFKJJpKu6BzNQxNWS58KfooyJf+W8LDRVe55jjYvH9G29OSaF07pDKRFu/hFbQqAyeo
	/EEiagxtjaIiC5wzzcapvKjoRf1h+CWERcSsPN/ii3KfPoTaJawWF/u8GBDftKWNj1p33B
	/qn1cNgBSfI5oAoaila2BlCey1qsKMY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] lib: add iso_data_* macros to hci.h
Date: Fri, 10 Jul 2026 19:25:01 +0300
Message-ID: <e2b3c5425a653eb198700cb28c453607e2d82840.1783700260.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add macros for parsing ISO Data Packet header items.
---
 lib/bluetooth/hci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bluetooth/hci.h b/lib/bluetooth/hci.h
index 732477ec4..2e4aa394e 100644
--- a/lib/bluetooth/hci.h
+++ b/lib/bluetooth/hci.h
@@ -2335,6 +2335,12 @@ typedef struct {
 #define iso_flags_ts(f)		((f >> 2) & 0x0001)
 #define iso_flags_pack(pb, ts)	((pb & 0x03) | ((ts & 0x01) << 2))
 
+/* ISO data length and flags pack/unpack */
+#define iso_data_len_pack(h, f)	((__u16) (((h) & 0x0fff) | \
+						  (((f) & 0x3) << 14)))
+#define iso_data_len(h)		((h) & 0x0fff)
+#define iso_data_flags(h)	((h) >> 14)
+
 #endif /* _NO_HCI_DEFS */
 
 /* HCI Socket options */
-- 
2.55.0

