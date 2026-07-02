Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1B492195
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997847; cv=none; b=EPMkf7KxFkTSgXQLEXDHffEz11otNSBtgddYNno0/z6+KkfclQNu3J2QKiYLe8VFeb0Ccw4AIzOJl2a7BLelwJVVWwe77iVmDHYNMcscdnsnHLdnyz4dEF5O98hYDC6mrNlbDrCwd23oY6cn4czt2yX7yDvxn/4X531zLZd9CzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997847; c=relaxed/simple;
	bh=g0mrbqtt6RZnMaCkSVdNYJ8+xLCjJWeqQHSoo01ohnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBE5hmxz/JM30bL8TFRvpXJmwphaR8IPmBsHSQHH+SpzOfcBj1Y7C1hCNgHdjrXTrt87uzXA8FO33KE9vJVGqa+qkzqXhXBmQAMnjiZmuGEedWNqKai+5vVKpVW+E8Iak1YPaDelXWl2ikA/SIsf4ixIylx3TjMmeGrWf53YDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pC+7Hukt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pC+7Hukt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782997844;
	bh=g0mrbqtt6RZnMaCkSVdNYJ8+xLCjJWeqQHSoo01ohnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pC+7HuktiAw+1GdfZUjlRobE09gjVG0TF1Tn8WcmNYiPvpz2mVnFEBq6obEjn7iLq
	 7V7Id4sdnDFTKlG+yPq7OeUbYKOMVQJNWc5HoP1OvJ0yt1fmHxutZO6C2IbOliu6Wr
	 hY8MGzFxCG9j5B4biW31/ku93ENkEqnNmKlOaOla3pP2qWGWHtL0YwAa/XbPT6pfeh
	 7Ap/lnBQHoRqK/92YUPN57oBbGvqTns+SlLtxOaxPZ6AiiwehuQCGV6+MvjaOCUFer
	 wn9zOiq4zUtjhXclv/h/O/eljNRIXKMVTEayBSMapXj5OgQR4aVRMbNuLKS8sXPahU
	 UdO0nZLHqOMnw==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 667B417E0475;
	Thu,  2 Jul 2026 15:10:43 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 3/4] shared/bap: Handle ASCS control point protocol errors
Date: Thu,  2 Jul 2026 18:39:06 +0530
Message-ID: <20260702130907.49942-4-raghavendra.rao@collabora.com>
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

This is required for PTS tests ASCS/SR/SPE/BI-01-C and ASCS/SR/SPE/BI-09-C.
---
 src/shared/bap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f2be7c07b..32bb3a894 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3407,7 +3407,7 @@ static uint8_t stream_enable(struct bt_bap_stream *stream, struct iovec *meta,
 static bool ascs_metadata_rsp(struct bt_bap_endpoint *ep, struct iovec *meta,
 							struct iovec *rsp)
 {
-	struct bt_ltv *ltv;
+	struct bt_ltv *ltv, *next;
 	uint16_t supported_context = 0;
 	uint16_t context;
 
@@ -3423,6 +3423,18 @@ static bool ascs_metadata_rsp(struct bt_bap_endpoint *ep, struct iovec *meta,
 		return true;
 	}
 
+	if (meta->iov_len >= sizeof(*ltv) &&
+			meta->iov_len >= (size_t) ltv->len + 1 + sizeof(*next)) {
+		next = (void *)((uint8_t *)meta->iov_base + ltv->len + 1);
+		if (next->type < BAP_METADATA_PREF_CONTEXT_LTV_TYPE ||
+				next->type > BAP_METADATA_LANGUAGE_LTV_TYPE) {
+			ascs_ase_rsp_add(rsp, ep->id,
+					BT_ASCS_RSP_METADATA_UNSUPPORTED,
+					next->type);
+			return true;
+		}
+	}
+
 	if (meta->iov_len >= sizeof(*ltv) + sizeof(context) &&
 			ltv->type == BAP_METADATA_CONTEXT_LTV_TYPE &&
 			ltv->len == sizeof(context) + 1) {
@@ -3921,6 +3933,7 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 	} else {
 		DBG(bap, "Unknown opcode 0x%02x", hdr->op);
 		ascs_ase_rsp_add_errno(rsp, 0x00, -ENOTSUP);
+		ret = 0;
 	}
 
 respond:
