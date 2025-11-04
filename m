Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67929D270
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248503; cv=none; b=JegfbyBHsHbzYVtGsMPd+bz5UG1HUjtsTVVDWbZbt9HRTmXF0Zbb+r2RhETWj0P81NYcCwM3C7z49GmOHcFIcDb3WroFtb47tuFkV3GokEnQdNgzMWSkccvOorRKXpeGA5S/DJsnQTQI+Y1Huk+ko1lrASpuJ9TtZ9yfS1qbAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248503; c=relaxed/simple;
	bh=gJB5Xap/HRBGF4IiPYxOD6++7lnBTr1aJwen7JlsOOE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sgyg442/KnN23e31b4fVQh54/zMuWDJhkH7DIprQQnlVA/UV3GrPFAzsj1n3Mulcp0EtkOopdNOOWM6a3RVIKzubnlhqvTaBQwt7KtHIX2hvy9GMQy1FMcsT6ECEAhCR8Yr2j2ya51Ge5vdCNIn2n3HQ66C7uAQLJ/i5hjZ8FsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AXGQ9FT4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AXGQ9FT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762248494;
	bh=gJB5Xap/HRBGF4IiPYxOD6++7lnBTr1aJwen7JlsOOE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AXGQ9FT47zIB3be4Ao8HigBW4THFuzOYTsgQVK2GdTZMALiDqYdyM7Am4ZnqCT9Xj
	 jAREnDZb1Zxgj7J8gHPlhjESbz3CoMOS09oUU69ZRO0oaKEM+tqsWjntF076gKEyXs
	 oNghj/p8vPayfKoR2wARGsUlzPc6wvd/QiXBqXXa3LtmuToe8YdMXyAlHdEO1RaP31
	 fYjQbybm/2tXMgBrf52uDyTyKGifO8aIKUy+LtKdrQYENpP7rkkCF0iL96jqNfpK1q
	 cohPrbOedWeVG8KW8DZBvWArW9MP7YQMi9RfZ5T6HT7/Cr158tZDpbsegrw7PHzQTo
	 7zz/PsBrpfGXg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-AF44-1001-2EF7-962e-01c6-D201.rev.sfr.net [IPv6:2a02:8428:af44:1001:2ef7:962e:1c6:d201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 08C3117E1398
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 10:28:14 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/hfp: Add NREC disable command
Date: Tue,  4 Nov 2025 10:28:07 +0100
Message-ID: <20251104092808.128726-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104092808.128726-1-frederic.danis@collabora.com>
References: <20251104092808.128726-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 src/shared/hfp.c | 42 +++++++++++++++++++++++++++++++++++++++---
 unit/test-hfp.c  |  1 +
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 2342c24df..c2028ac2b 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -30,7 +30,11 @@
 	hfp_debug(_hfp->debug_callback, _hfp->debug_data, "%s:%s() " fmt, \
 						__FILE__, __func__, ## arg)
 
-#define HFP_HF_FEATURES	(HFP_HF_FEAT_CLIP | HFP_HF_FEAT_ESCO_S4_T2)
+#define HFP_HF_FEATURES	( \
+	HFP_HF_FEAT_ECNR | \
+	HFP_HF_FEAT_CLIP | \
+	HFP_HF_FEAT_ESCO_S4_T2 \
+)
 
 struct hfp_gw {
 	int ref_count;
@@ -1996,7 +2000,7 @@ static void clip_cb(struct hfp_context *context, void *user_data)
 							hfp->callbacks_data);
 }
 
-static void cmee_resp(enum hfp_result result, enum hfp_error cme_err,
+static void nrec_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -2004,7 +2008,7 @@ static void cmee_resp(enum hfp_result result, enum hfp_error cme_err,
 	DBG(hfp, "");
 
 	if (result != HFP_RESULT_OK) {
-		DBG(hfp, "hf: CMEE error: %d", result);
+		DBG(hfp, "hf: NREC error: %d", result);
 		goto failed;
 	}
 
@@ -2020,6 +2024,38 @@ failed:
 						hfp->callbacks_data);
 }
 
+static void cmee_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "");
+
+	if (result != HFP_RESULT_OK) {
+		DBG(hfp, "hf: CMEE error: %d", result);
+		goto failed;
+	}
+
+	if (!(hfp->features & HFP_AG_FEAT_ECNR)) {
+		/* Jump to next setup state */
+		nrec_resp(HFP_RESULT_OK, cme_err, user_data);
+		return;
+	}
+
+	if (!hfp_hf_send_command(hfp, nrec_resp, hfp, "AT+NREC=0")) {
+		DBG(hfp, "hf: Could not send AT+NREC=0");
+		result = HFP_RESULT_ERROR;
+		goto failed;
+	}
+
+	return;
+
+failed:
+	if (hfp->callbacks->session_ready)
+		hfp->callbacks->session_ready(result, cme_err,
+						hfp->callbacks_data);
+}
+
 static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index fc9fb1865..94553d62c 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -763,6 +763,7 @@ static void test_hf_robustness(gconstpointer data)
 		'0', ',', '\"', 'T', 'E', 'S', 'T', '\"', '\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
 
 static void hf_cmd_complete(enum hfp_result res, enum hfp_error cme_err,
-- 
2.43.0

