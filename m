Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4282E7F34
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035920; cv=none; b=u9H0KT1IF1bfN1fOHrWYVd0gcO50OWxQIE0/0noEReHg7d8fi98C3d6zgatjZEDWZUW+25CihUOc1n1We4wnNl6wvWUyyq32OiBiyx4KbhePcNV6HpeV9tG3bYOJCYgv/RgQT0pquZy+MMDIEQsTVNIGuClhOFPIz0GBNEmxCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035920; c=relaxed/simple;
	bh=wGlNCA1Nl9p4UX0Qfe5s3NpiKWknId1SW78RIr8su6c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rK6XHwkPTkFlHr+cNthPFaKQEJeGV9OiqnBg4fgxEUL2IQpr+ue4JIMLSBZ4/SvmDby7DcDTFRABm8j3t+OQY1TKxisG87/Ex9HPL3Y0WKtZ0gDMZSOHc4KyBSjtft3SZMK2bqOMS0/apggfBGEz/MK/3erQ8bQy22hhwfYARSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dfiFCidk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dfiFCidk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035909;
	bh=wGlNCA1Nl9p4UX0Qfe5s3NpiKWknId1SW78RIr8su6c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dfiFCidk8svC961R03xjXGzxC+0HM442mAk0uiLNqCFKiWqyvJlY7w+zHijzAJ6DM
	 VFX/OLU91n6OjxnopaV6265QoxuHe+nWj9MaXP2LCKlDbQGtICaKEcdJf0YxzwZUxn
	 Gh2VJ6SClA+4cuHguDc+zzYrc6mOOWyMTot0nSjZzuY4/peFWhENOP5B4lGMFGLV8y
	 b4zri2UAhBd/RYWuknsp6WvKJjw9wIMRiNU9qnWT6DhHiuT3fQMf3cYKq91oCm1Ce0
	 lkC8tv3Jc3regYDaAFMHv2BUNIC04Y6EXCODSWi09WPoQN+x9sfHpKfyp0y3NXyDhn
	 tzLPgTX52efxA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D1B4217E0CB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 23/27] audio/hfp-hf: Disable NREC during connection setup
Date: Fri, 27 Jun 2025 16:51:32 +0200
Message-ID: <20250627145136.421853-24-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627145136.421853-1-frederic.danis@collabora.com>
References: <20250627145136.421853-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 profiles/audio/hfp-hf.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 287523f28..5e3c9fcba 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -407,6 +407,26 @@ static void cops_cb(struct hfp_context *context, void *user_data)
 	telephony_set_operator_name(dev->telephony, name);
 }
 
+static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CLIP error: %d", result);
+		return;
+	}
+
+	if ((dev->hfp_hf_features & HFP_HF_FEAT_ECNR) &&
+			(dev->features & HFP_AG_FEAT_ECNR)) {
+		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
+								"AT+NREC=0"))
+			info("hf-client: Could not send AT+NREC=0");
+	}
+}
+
 static void cops_status_resp(enum hfp_result result, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -419,7 +439,7 @@ static void cops_status_resp(enum hfp_result result, enum hfp_error cme_err,
 		return;
 	}
 
-	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev, "AT+CLIP=1"))
+	if (!hfp_hf_send_command(dev->hf, clip_resp, dev, "AT+CLIP=1"))
 		info("hf-client: Could not send AT+CLIP=1");
 }
 
-- 
2.43.0

