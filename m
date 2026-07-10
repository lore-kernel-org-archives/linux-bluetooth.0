Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5A3793CA
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707181; cv=pass; b=gzCR33DiM5LfA3RPvNvtg2wuRr8k7CHO+N3JiVKPVJZJ8cjiUF+9jk2kurFyDFxedAYXH08lUM3ItNkB3BIw/bKNl0O4KVm3mKAA+gJKOszrRrncYPx0GLhq+d8ij/DBYRUxDiNUifGaDQu4Rja4DxUwf1Ttybqntuq+fiHbN0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707181; c=relaxed/simple;
	bh=lBlPz0PPqL4nhrOlZuVFB6XFE6DxsQevyeydGJ/p7Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fINqEGvBY0ctkac7EYZufT5TQRkqQBR6f29ZnC2X5vqp7mExwBGexDfokfxo37KQZWPjef5nBIsM/bORFtIqW/824/JhqFI9MWuuL1++2P3xAGQ1fyZ6I76eP2bkadztEahIOiomxWs5Wsooi74o1SiZLD770inseBK6Ac3XBgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=svDhoxk/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="svDhoxk/"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gxg1526dxzyRb;
	Fri, 10 Jul 2026 21:12:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783707177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Zpzzy6fcqfc8kwYITm+dnt34RZTgLNRrss0ie1uRws=;
	b=svDhoxk/rMTq9WJFlAhLc6CavTNHz1LveseAubACeO2JSmIa0KsBSq9HW8/Qykdzf4XII5
	O96CjJ56NF3BXAQI33oOmU+ZGBRBh5lDoTT/dvC2P86IGBK02daWS4iCpL7e3f6Xt/ohFV
	QZVFNYms6zvVtjVisnO2qacnh1Nph/M=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783707177;
	b=wYmzjEhaypP3UaKCXEx1wBMxvSbHCtAwq6tkqqpJhcRc1rlUy3JcCYIKPlIU4MEDNM8MnJ
	qzKJ/zaBuu0fIjbLlbclNqEgB1MSAow/MY5JNsJNGAUlaLQVfcTmVkO5qvzdn1HlY0QZ64
	D4MKo4t+jnnGqp9a2op36Kn+cL65xHw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783707177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Zpzzy6fcqfc8kwYITm+dnt34RZTgLNRrss0ie1uRws=;
	b=QLfzUjsnaRgFWkX2Gkw83TXea4nohhwJNAe4BI+wYP6RYkoRwd3PpM/PoC7aiAsR9xLoSb
	/PxJaSBa1zBoZdv2SDz0G3ahLdEkYx2Wc8G7iruBf94+qR1h+DzbxaAX4dXqsomLMClouo
	cI2q2QMOFy+xOT3SZHEJfN7uIUVgMiM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] lib: add iso_data_* macros to hci.h
Date: Fri, 10 Jul 2026 21:12:54 +0300
Message-ID: <e2b3c5425a653eb198700cb28c453607e2d82840.1783707145.git.pav@iki.fi>
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

Notes:
    v2:
    - no change

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

