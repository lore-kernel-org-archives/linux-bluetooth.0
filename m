Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F188A2E92BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035920; cv=none; b=BEbodIilGDcho2XuWUNLp1PtoCAJ0PTVGisSWML8zrtq9GHM75bZH+jjytiqieC0mLAjIK9jjZfM9jtJbzDLz03HT/UFRs87ujpjqJ1jN9dTSLZkHCT1TOnvipjNaoN9mLu4aM4+XVlm/7Nc0HHrUUG1ukX9kjTbRNIMaJ8izI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035920; c=relaxed/simple;
	bh=lMeScscwfTxMOUGzu+/9edBarOFw8BAUInA0zkZ8WnY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WC1ZqMsUEza8NxaJuXQMZwJabU3mmGECY7hmoVhl9jA2W4/lyn5ch/nH9ws/n5GQtPrd6wqwBCCZhIEFLWuL7uZc3LWDFpDgcaWZPCP0lrhmy/dqrG4qcrvsjR/TNFb4mHEE+Mu4Uo0AuRfdS27Xdv8Rd3NI2Zn82/iwWdUNyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YOE5xZvP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YOE5xZvP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035908;
	bh=lMeScscwfTxMOUGzu+/9edBarOFw8BAUInA0zkZ8WnY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YOE5xZvPCf1ZIV8bWKOlSwG6uG/iJPAXVKDkcAWL41Bfh8RldWn30ZAM8czQsuy3/
	 Nxjx+7tMORKw00MA9Yhmxxs1qwJxnA6TDZewJz7AoMckHzORG87eXURBWJ9n/PFqFO
	 koOLGBNLXiIhCl6+ZEYFjm5eAk7pMLpRGdKerJfFMpnqa2e0USb86OqwxGK8w9MHhu
	 QZCDWf+qM9h2bS6z5uVpXbGnetxiXF1jxCaiUZDUUhFjS7sY1K8d18jp+dqQxhkya/
	 lNvHLbVXNF6Re5v2766u1ThwZimFLcBwJM100xG8ii9w9dzxePuv+2bnDS6bPpdLd+
	 aNDGVp7Y3x5Xw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ED27C17E0B8C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:47 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 20/27] audio/hfp-hf: Add operator name support
Date: Fri, 27 Jun 2025 16:51:29 +0200
Message-ID: <20250627145136.421853-21-frederic.danis@collabora.com>
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

This adds the AT+COPS command.
---
 profiles/audio/hfp-hf.c | 48 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index b49d40a43..ebe87d8db 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -107,6 +107,8 @@
 				HFP_HF_FEAT_ENHANCED_CALL_STATUS |\
 				HFP_HF_FEAT_ESCO_S4_T2)
 
+#define MAX_OPERATOR_NAME_LEN 17
+
 enum hfp_indicator {
 	HFP_INDICATOR_SERVICE = 0,
 	HFP_INDICATOR_CALL,
@@ -354,6 +356,49 @@ static void ciev_cb(struct hfp_context *context, void *user_data)
 	}
 }
 
+static void cops_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	unsigned int format;
+	char name[MAX_OPERATOR_NAME_LEN];
+
+	DBG("");
+
+	/* Not interested in mode */
+	hfp_context_skip_field(context);
+
+	if (!hfp_context_get_number(context, &format))
+		return;
+
+	if (format != 0) {
+		warn("hf-client: Not correct string format in +COPS");
+		return;
+	}
+
+	if (!hfp_context_get_string(context, name, MAX_OPERATOR_NAME_LEN)) {
+		error("hf-client: incorrect +COPS response");
+		return;
+	}
+
+	telephony_set_operator_name(dev->telephony, name);
+}
+
+static void cops_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: COPS error: %d", result);
+		return;
+	}
+
+	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev, "AT+COPS?"))
+		info("hf-client: Could not send AT+COPS?");
+}
+
 static void slc_completed(struct hfp_device *dev)
 {
 	int i;
@@ -376,8 +421,9 @@ static void slc_completed(struct hfp_device *dev)
 	/* TODO: register unsolicited results handlers */
 
 	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
+	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
 
-	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS=3,0"))
+	if (!hfp_hf_send_command(dev->hf, cops_resp, dev, "AT+COPS=3,0"))
 		info("hf-client: Could not send AT+COPS=3,0");
 }
 
-- 
2.43.0

