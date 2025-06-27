Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F92E9721
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035922; cv=none; b=n+VDYSfp8EmHuzzMPVHbZnKLfVzxrxdEKs7AA6aWJtilNySP/aTGhisYiz0Xs604v4AGlSs68EvWjx/dbE+wvZooPc8ea6CXE6FRu6F6YyHp9Uczk6Gd3gi02IoZdMdMwdCYfnScLVs/JMSHSMLMIT/Ojx35BcTxuZ7iLGxw6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035922; c=relaxed/simple;
	bh=vH+BvM8b6mpDRfl67INMUnDWTn+qhTyDnPnw479a4XM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEtt/yqo2/T78VpQH5hwYV+BE9PJu8KuGqKuQpk0/uY64426DotOp1ii7VWQpdgZBauu8dDTPohgLGiz4HkRDV4TlJwPcOjTY4tQfhbCquwF/9e9FCkAvWMdEAun5nPfOPvV/N/nG1MVPf29HG7ooAS8LMHTF+Pl3Xr3k71rahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mU0j48dJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mU0j48dJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035909;
	bh=vH+BvM8b6mpDRfl67INMUnDWTn+qhTyDnPnw479a4XM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mU0j48dJetuCvZYaJSTQ/Sbrxoxrgg7IemPJHaF1kKlIhHbggyaaNpVWgjX0fpd8V
	 6FyWQe+q/AVJoPQyHRqq2oDuoC0P/WupFnNkmECdECK+aWOWifFPS6QRvnm4E9iIx9
	 XnCQNl+gKcnHjhwP2YPzp5fhN2yhaSHO7KHkB9jciwTZMRZPX+xJzLhV0k4Pgd0S6G
	 TsXQYj5GLQ3DtLm/nGNXIUqQH7eQOrbCB0Z6LjMVf2DNVE2qHlXbaAkuk9E+RVFuux
	 l2vSprRxu+aV4xscaAqyJfeT/JoPGFfRQUSm3MmTFFV1Tjvg+cIdwQ2yAGSBnfR3hx
	 7RbAB1pbDoiHQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 281F617E0CE3
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:49 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 24/27] audio/hfp-hf: Enable waiting call if supported by remote AG
Date: Fri, 27 Jun 2025 16:51:33 +0200
Message-ID: <20250627145136.421853-25-frederic.danis@collabora.com>
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
 profiles/audio/hfp-hf.c | 71 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 5e3c9fcba..afe06296d 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -107,6 +107,9 @@
 				HFP_HF_FEAT_ENHANCED_CALL_STATUS |\
 				HFP_HF_FEAT_ESCO_S4_T2)
 
+#define CHLD_3WAY_FEATURES	(CHLD_FEAT_REL | CHLD_FEAT_REL_ACC |\
+				CHLD_FEAT_HOLD_ACC | CHLD_FEAT_MERGE)
+
 #define MAX_NUMBER_LEN 33
 #define MAX_OPERATOR_NAME_LEN 17
 
@@ -331,6 +334,46 @@ static uint8_t next_index(struct hfp_device *dev)
 	return 0;
 }
 
+static void ccwa_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	char number[MAX_NUMBER_LEN];
+	GSList *l;
+	bool found = false;
+
+	DBG("");
+
+	if (!hfp_context_get_string(context, number, MAX_NUMBER_LEN)) {
+		error("hf-client: incorrect +CCWA event");
+		return;
+	}
+
+	for (l = dev->calls; l; l = l->next) {
+		struct call *call = l->data;
+
+		if (call->state == CALL_STATE_WAITING) {
+			info("hf-client: waiting call in progress (id: %d)",
+				call->idx);
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		struct call *call;
+		uint8_t idx = next_index(dev);
+
+		call = telephony_new_call(dev->telephony, idx,
+						CALL_STATE_WAITING, NULL);
+		call->line_id = g_strdup(number);
+		if (telephony_call_register_interface(call)) {
+			telephony_free_call(call);
+			return;
+		}
+		dev->calls = g_slist_append(dev->calls, call);
+	}
+}
+
 static void ciev_cb(struct hfp_context *context, void *user_data)
 {
 	struct hfp_device *dev = user_data;
@@ -407,6 +450,25 @@ static void cops_cb(struct hfp_context *context, void *user_data)
 	telephony_set_operator_name(dev->telephony, name);
 }
 
+static void nrec_resp(enum hfp_result result, enum hfp_error cme_err,
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
+	if ((dev->chld_features & CHLD_3WAY_FEATURES) == CHLD_3WAY_FEATURES) {
+		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
+								"AT+CCWA=1"))
+			info("hf-client: Could not send AT+CCWA=1");
+	}
+}
+
 static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -421,9 +483,13 @@ static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
 
 	if ((dev->hfp_hf_features & HFP_HF_FEAT_ECNR) &&
 			(dev->features & HFP_AG_FEAT_ECNR)) {
-		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
-								"AT+NREC=0"))
+		if (!hfp_hf_send_command(dev->hf, nrec_resp, dev, "AT+NREC=0"))
 			info("hf-client: Could not send AT+NREC=0");
+	} else if ((dev->chld_features & CHLD_3WAY_FEATURES) ==
+			CHLD_3WAY_FEATURES) {
+		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
+								"AT+CCWA=1"))
+			info("hf-client: Could not send AT+CCWA=1");
 	}
 }
 
@@ -480,6 +546,7 @@ static void slc_completed(struct hfp_device *dev)
 
 	/* TODO: register unsolicited results handlers */
 
+	hfp_hf_register(dev->hf, ccwa_cb, "+CCWA", dev, NULL);
 	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
 	hfp_hf_register(dev->hf, clip_cb, "+CLIP", dev, NULL);
 	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
-- 
2.43.0

