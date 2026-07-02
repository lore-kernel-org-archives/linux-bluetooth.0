Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E254428837
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997839; cv=none; b=C/53uhpjHqAU9/EM2N0r+xx9siBiRxz8wf1a2ThgEaX2IQwyvOl0XpQpIXfphzD5r27r7H3mhuwDct6QrRvJ81qHEZ6Gphik2xfOQMbm5CHv4LhYD6CQw+96W2qKW+NJGcPmDhnulQeYvgJ2CPeo88Jvcm9RSM8dkdXfI5CRk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997839; c=relaxed/simple;
	bh=X+PPfLXKE9jgfVEWduP8JMdL2QoTTE/tAv8BUeGsbF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDnlraqmMRx/ZTVhOk9hSU1GvKtdfO8+bHv9uZf6n+yu2sOseirnLjLpnoaD4jBzHG0Lg0ZXIr9AVewVqMgdpZviXiSU2CjU2p+mH6fhaZs9s4abdJAJUHVBidRvWSJ3VnxYoehwH1NBkTQ97r5Pj8CQ32OrDZKFhCROhpABVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LJfMPyAS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LJfMPyAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782997836;
	bh=X+PPfLXKE9jgfVEWduP8JMdL2QoTTE/tAv8BUeGsbF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJfMPyASzTRgjQSz4nCK/6vIDWL+QnvgXW7QpgaJO3R64+Jvmku4wwVsp7JyT2UQj
	 oD9brc7goLTXysOwtlAZZCknqsrJChBvLVI0BlBqReJQrLTJQRTamo7m0ZMFHxJgHB
	 GHs6yrKvUIloXjkyDMVnaGTA9GYlyvVj18kqcd+JJ41SsjjhZeN38OBrhEuBIMlCUK
	 4jogHgbWxDlUx5XZ66r8elSPgF8Om3mmGRypUoh7g5c6hABFv9fWQF8x9+CJKbYzmk
	 sggaFdNzFGN3s5zvRqrcrRrHi6ULtph3Quo3MVjFkwQB3k+eD1UxrJtHr+rAcohiDM
	 oiCcsHun7wCvw==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D9C4917E0CF4;
	Thu,  2 Jul 2026 15:10:35 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 1/4] shared/bap: Validate codec configuration parameters
Date: Thu,  2 Jul 2026 18:39:04 +0530
Message-ID: <20260702130907.49942-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702130907.49942-1-raghavendra.rao@collabora.com>
References: <20260702130907.49942-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

This is required for PTS test ASCS/SR/SPE/BI-07-C
---
 src/shared/bap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1f61227f8..6bc044a63 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -29,6 +29,7 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/bap.h"
 #include "src/shared/ascs.h"
+#include "src/shared/lc3.h"
 #include "src/shared/bap-debug.h"
 
 /* Maximum number of ASE(s) */
@@ -3157,6 +3158,7 @@ static uint8_t ep_config(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 	struct iovec cc;
 	const struct queue_entry *e;
 	struct bt_bap_codec codec;
+	uint8_t *ltv;
 
 	DBG(bap, "ep %p id 0x%02x dir 0x%02x", ep, ep->id, ep->dir);
 
@@ -3190,6 +3192,19 @@ static uint8_t ep_config(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 		return 0;
 	}
 
+	ltv = cc.iov_base;
+
+	if (req->codec.id == LC3_ID && cc.iov_len == 3 &&
+			ltv[0] == 0x02 &&
+			ltv[1] == LC3_CONFIG_DURATION &&
+			ltv[2] != LC3_CONFIG_DURATION_7_5 &&
+			ltv[2] != LC3_CONFIG_DURATION_10) {
+		ascs_ase_rsp_add(rsp, req->ase,
+				BT_ASCS_RSP_CONF_INVALID,
+				BT_ASCS_REASON_CODEC_DATA);
+		return 0;
+	}
+
 	switch (ep->dir) {
 	case BT_BAP_SINK:
 		e = queue_get_entries(bap->ldb->sinks);
@@ -3207,6 +3222,13 @@ static uint8_t ep_config(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 	codec.cid = le16_to_cpu(req->codec.cid);
 	codec.vid = le16_to_cpu(req->codec.vid);
 
+	if (codec.id != 0xff && (codec.cid || codec.vid)) {
+		ascs_ase_rsp_add(rsp, req->ase,
+				BT_ASCS_RSP_CONF_INVALID,
+				BT_ASCS_REASON_CODEC);
+		return 0;
+	}
+
 	for (; e; e = e->next) {
 		struct bt_bap_pac *pac = e->data;
 
