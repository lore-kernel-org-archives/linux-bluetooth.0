Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7C22F76F
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759301679; cv=none; b=sJs+C87FG72/Zq7+WHAPNz1O29KEr09DEBiD4AeQhkcMvkoie6yrjWS/G6RWwLMnbmY4h2LNpxdaooVKUHbmFbAOqeB3b4zvJ9t8QA/y14uzDSRPLS2IWvm9jBhXLurlMaMtqhePq/r9SiYKcpRP9EQaQdVV0m6hzN86MJLaLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759301679; c=relaxed/simple;
	bh=TrsRPGeZWPagukJhYXSg5d3fZRSey2uSkFdmcx+594U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kol3NmlQvhky45TBTT1qmw54JEv+yxREGkQdcZCeacrQ5QMDutEI1qoDTnm4KGUMTgzMDfI8PYIx3fOCZG9+e01xWyYIPjsxx/gREe5v6Np5M1qONsAL1UhgcJsJCGYH/K7DSaph93yhBKzowWpDT3atbQfRKObmYQk9veqYyR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c4pIi8d4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c4pIi8d4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759301676;
	bh=TrsRPGeZWPagukJhYXSg5d3fZRSey2uSkFdmcx+594U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c4pIi8d4NKB1ida2W2Q7WeLpPp2M/Hl/2GHKg9nxqLCttGKoOb3mfWW/ewbgRf2LV
	 Kgp974bj3RpNnHVXjIpV/Rqdzrbr0SHb/k88JhJET5B1Eq/dMlDv53h3aZLbEelSN/
	 O3JpjPAj1aqiDPLQcN50Dvaxe1rjagJKQICZ/5N9/IFHgHkm1gzi3isHtD3IxsQLDM
	 Pgd3VkwZoTLJDqYZEzW/TQHHpB+osfmdK2jB37gZsqH67LbvuEoKNajTolht7Lbv89
	 iQ6cSqIXzfVlya8I9LgxnkVd7eesks7iz/zujrujG0RJwZBhk/ifcKYiZp6x9sn50Q
	 NmVqhVBPuuZJA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-2e77-3033-4926-5452.rev.sfr.net [IPv6:2a02:8428:af44:1001:2e77:3033:4926:5452])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 182B017E0154
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 08:54:36 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] shared/hfp: Add in-band ring tone setting support
Date: Wed,  1 Oct 2025 08:54:26 +0200
Message-ID: <20251001065429.268068-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001065429.268068-1-frederic.danis@collabora.com>
References: <20251001065429.268068-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 src/shared/hfp.c | 16 ++++++++++++++++
 src/shared/hfp.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index c7a04b536..15627f650 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -1752,6 +1752,20 @@ static bool call_active_match(const void *data, const void *match_data)
 	return (call->status == CALL_STATUS_ACTIVE);
 }
 
+static void bsir_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	unsigned int val;
+
+	DBG(hfp, "");
+
+	if (!hfp_context_get_number(context, &val))
+		return;
+
+	if (hfp->callbacks && hfp->callbacks->update_inband_ring)
+		hfp->callbacks->update_inband_ring(!!val, hfp->callbacks_data);
+}
+
 static void ciev_callsetup_cb(uint8_t val, void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -2083,6 +2097,8 @@ static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
 	}
 
 	/* Register unsolicited results handlers */
+	if (hfp->features & HFP_AG_FEAT_IN_BAND_RING_TONE)
+		hfp_hf_register(hfp, bsir_cb, "+BSIR", hfp, NULL);
 	hfp_hf_register(hfp, ciev_cb, "+CIEV", hfp, NULL);
 	hfp_hf_register(hfp, clip_cb, "+CLIP", hfp, NULL);
 	hfp_hf_register(hfp, cops_cb, "+COPS", hfp, NULL);
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 21214eee4..27315bfa0 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -201,6 +201,7 @@ struct hfp_hf_callbacks {
 	void (*update_indicator)(enum hfp_indicator indicator, uint32_t val,
 							void *user_data);
 	void (*update_operator)(const char *operator_name, void *user_data);
+	void (*update_inband_ring)(bool enabled, void *user_data);
 
 	void (*call_added)(uint id, enum hfp_call_status status,
 							void *user_data);
-- 
2.43.0

