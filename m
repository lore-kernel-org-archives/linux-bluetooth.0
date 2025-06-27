Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF492E92DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035922; cv=none; b=IZcdeJWnol65dnMbRaMQHMJcnrdETK2vi4Euxx3FJbfenhGyoMejCweSUcNVzCof9NIMGNiL/n3ZlnhaM0p1rBRXjEaIkHQhnMY89ojWsMf0hb9QFsw1FIMbBdlzt5pLpiZ4OSWGxg8wwbxtaK2rm/TVt8T6Y1LjlTIsl+yg8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035922; c=relaxed/simple;
	bh=YHZjPMGxbZKO7/MzbvcxGzi2McIcEeP0lhs8AxNRtFc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyjMlK2lrXIZ11UE2k0J6w/uA0hEVcw2DgcO6/c1OdhM1K+ELJDyOsXfjVR81MKqCsun/j4GDl0ORXlDj0yrEBWXIivyvE2KzT8PvQwh+MbSKUzCW5ECZQIvZioK6MOO5+UltgnmPDagBfPINVw8/uLQqxeux0EcgyY8qGC2Jtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ikqY/iDa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ikqY/iDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035908;
	bh=YHZjPMGxbZKO7/MzbvcxGzi2McIcEeP0lhs8AxNRtFc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ikqY/iDaPCapLBr1XaKyW2IL3BSRagsbXI3JJ/w/WVtU0/Nuj+Fg01r3vaAxACWZ7
	 6zIOcRTg4ZXRCK+eRZfjhTTKPnZo+g/Cvirl+/W7D+HNJEKGf3yHOuJJoe/VT8oopv
	 r+U/5HsVnLiRewVhco3Y1nrz3KFP9ERDnqKoMZMUGG6t5r6ENBPIxWBKDgwEj6UOFu
	 vzzx6m4DSZ/0r+llFCAScpDrRj9hWE9wmpMbgiaXo37uUx3Cy3nV8SwTokwU/dyTnE
	 lmaA1vqRJVG3KBWFtMiQ5mdBWDUpgt7ShWEfBMJJWB2vvh+UYtHvckCcRZTbs0OD8Z
	 4pUMHNrR2QI4g==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 888AF17E0C8C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 22/27] audio/hfp-hf: Add call line idenfication support
Date: Fri, 27 Jun 2025 16:51:31 +0200
Message-ID: <20250627145136.421853-23-frederic.danis@collabora.com>
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
 profiles/audio/hfp-hf.c | 43 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index ebe87d8db..287523f28 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -107,6 +107,7 @@
 				HFP_HF_FEAT_ENHANCED_CALL_STATUS |\
 				HFP_HF_FEAT_ESCO_S4_T2)
 
+#define MAX_NUMBER_LEN 33
 #define MAX_OPERATOR_NAME_LEN 17
 
 enum hfp_indicator {
@@ -356,6 +357,29 @@ static void ciev_cb(struct hfp_context *context, void *user_data)
 	}
 }
 
+static void clip_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	char number[MAX_NUMBER_LEN];
+	GSList *l;
+
+	DBG("");
+
+	if (!hfp_context_get_string(context, number, MAX_NUMBER_LEN)) {
+		error("hf-client: incorrect +CLIP event");
+		return;
+	}
+
+	for (l = dev->calls; l; l = l->next) {
+		struct call *call = l->data;
+
+		if (call->state == CALL_STATE_INCOMING) {
+			telephony_call_set_line_id(call, number);
+			break;
+		}
+	}
+}
+
 static void cops_cb(struct hfp_context *context, void *user_data)
 {
 	struct hfp_device *dev = user_data;
@@ -383,6 +407,22 @@ static void cops_cb(struct hfp_context *context, void *user_data)
 	telephony_set_operator_name(dev->telephony, name);
 }
 
+static void cops_status_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: COPS? error: %d", result);
+		return;
+	}
+
+	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev, "AT+CLIP=1"))
+		info("hf-client: Could not send AT+CLIP=1");
+}
+
 static void cops_resp(enum hfp_result result, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -395,7 +435,7 @@ static void cops_resp(enum hfp_result result, enum hfp_error cme_err,
 		return;
 	}
 
-	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev, "AT+COPS?"))
+	if (!hfp_hf_send_command(dev->hf, cops_status_resp, dev, "AT+COPS?"))
 		info("hf-client: Could not send AT+COPS?");
 }
 
@@ -421,6 +461,7 @@ static void slc_completed(struct hfp_device *dev)
 	/* TODO: register unsolicited results handlers */
 
 	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
+	hfp_hf_register(dev->hf, clip_cb, "+CLIP", dev, NULL);
 	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
 
 	if (!hfp_hf_send_command(dev->hf, cops_resp, dev, "AT+COPS=3,0"))
-- 
2.43.0

