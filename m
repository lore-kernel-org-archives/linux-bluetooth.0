Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EF2E8886
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035922; cv=none; b=DeLPSw0OWj5kEKn+W6NElJ2sXX9a+9O3zZqYRftuoY26o9LIewnG0qS1drGtQp7vr/9T8AuHu5WO6s2YknVwvQcTl0EijQAMaGAhai5dFkAkvBpgs9URMT3IXutctWY4tzUbMs6Gb4vlfqNCyc4tzOvRYG2AtbF5V2GjE8JVOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035922; c=relaxed/simple;
	bh=ydXHlf665v7gNNWw4kSDl0wPv5I8j/adBDEKRp+M5bQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFCCE5ouCjWN8n/wtlBGiZmk+K49LfxIFxA3WNKO3K7iT9DH4/rbmWzFUfu9TQDWoEpL8OPuSHn60PtCobFqMb9ez1qprJtrdDc9CZ4SRY5A2SH7Cp95nNqUhqVa8V3o6Ur6z7sWsDKMOWHTRZV3GDcL1TKflwvjrw/4ucqvrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K0kzpD+Q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K0kzpD+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035910;
	bh=ydXHlf665v7gNNWw4kSDl0wPv5I8j/adBDEKRp+M5bQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K0kzpD+QpyZOj6PJGI/+5KijcYIJCiAaYgt8wuTlgn7PYKZvSq+1H0J6GsRGZztUq
	 zkhnilwXYtzonJeiFn760kF0LqxR7x0HxIJ/20Ust3m9t06UxpowM40wHK2eDi+STn
	 ACtaNRaekz4BuUmfqf7OKXOsNtee3Oqk0MxejGrQgktKxd+FDjekhngNbrIJ6x9h+g
	 b9FQ5DoeHNW7d+DzqvrUfFoq/sdnkDy1CY11OHWQkz+coqtWoBoCurkIr9xit3oZE9
	 Jrp/pr8XVPdqUF3vDU30J0OChqvrHDITN47z/PQQbdaACnv2ZbjgpjZe9DNeHBWNsk
	 gkxECpSIcz8UA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 115F617E0CF6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 27/27] audio/hfp-hf: Enable enhanced call status if supported by remote AG
Date: Fri, 27 Jun 2025 16:51:36 +0200
Message-ID: <20250627145136.421853-28-frederic.danis@collabora.com>
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

On reception of OK result from AT+CLCC command, and based on the calls
listed by +CLCC results, this updates, removes or creates calls.
---
 profiles/audio/hfp-hf.c | 197 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 191 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 5542bce96..5f03556dd 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -147,6 +147,15 @@ struct indicator {
 	ciev_func_t cb;
 };
 
+struct clcc_entry {
+	uint8_t idx;
+	uint8_t direction;
+	uint8_t status;
+	uint8_t mode;
+	uint8_t multiparty;
+	char *number;
+};
+
 struct hfp_device {
 	struct telephony	*telephony;
 	uint16_t		version;
@@ -161,6 +170,8 @@ struct hfp_device {
 	enum call_setup		call_setup;
 	enum call_held		call_held;
 	GSList			*calls;
+	bool			clcc_in_progress;
+	GSList			*clcc_entries;
 };
 
 struct hfp_server {
@@ -334,6 +345,92 @@ static uint8_t next_index(struct hfp_device *dev)
 	return 0;
 }
 
+static void clcc_update_call(gpointer data, gpointer user_data)
+{
+	struct call *call = data;
+	struct hfp_device *dev = user_data;
+	GSList *l;
+
+	for (l = dev->clcc_entries; l; l = l->next) {
+		struct clcc_entry *entry = l->data;
+
+		if (call->idx == entry->idx) {
+			telephony_call_set_state(call, entry->status);
+			telephony_call_set_multiparty(call,
+					entry->multiparty);
+			telephony_call_set_line_id(call, entry->number);
+			dev->clcc_entries = g_slist_remove(dev->clcc_entries,
+					entry);
+			g_free(entry->number);
+			g_free(entry);
+			return;
+		}
+	}
+
+	telephony_call_set_state(call, CALL_STATE_DISCONNECTED);
+	dev->calls = g_slist_remove(dev->calls, call);
+	telephony_call_unregister_interface(call);
+}
+
+static void clcc_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	GSList *l;
+
+	DBG("");
+
+	dev->clcc_in_progress = false;
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CLCC error: %d", result);
+		return;
+	}
+
+	g_slist_foreach(dev->calls, clcc_update_call, dev);
+
+	/* Remaining calls should be added */
+	for (l = dev->clcc_entries; l; l = dev->clcc_entries) {
+		struct clcc_entry *entry = l->data;
+		struct call *call;
+
+		call = telephony_new_call(dev->telephony, entry->idx,
+						entry->status,
+						NULL);
+		call->multiparty = entry->multiparty;
+		if (entry->number)
+			call->line_id = g_strdup(entry->number);
+
+		if (telephony_call_register_interface(call))
+			telephony_free_call(call);
+		else
+			dev->calls = g_slist_append(dev->calls, call);
+
+		dev->clcc_entries = g_slist_remove(dev->clcc_entries, entry);
+		g_free(entry->number);
+		g_free(entry);
+	}
+}
+
+static bool request_calls_update(struct hfp_device *dev)
+{
+	if (!(dev->hfp_hf_features & HFP_HF_FEAT_ENHANCED_CALL_STATUS) ||
+		!(dev->features & HFP_AG_FEAT_ENHANCED_CALL_STATUS) ||
+		(telephony_get_state(dev->telephony) != CONNECTED))
+		return false;
+
+	if (dev->clcc_in_progress)
+		return true;
+
+	if (!hfp_hf_send_command(dev->hf, clcc_resp, dev, "AT+CLCC")) {
+		info("hf-client: Could not send AT+CLCC");
+		return false;
+	}
+
+	dev->clcc_in_progress = true;
+	return true;
+}
+
 static void ccwa_cb(struct hfp_context *context, void *user_data)
 {
 	struct hfp_device *dev = user_data;
@@ -359,6 +456,9 @@ static void ccwa_cb(struct hfp_context *context, void *user_data)
 		}
 	}
 
+	if (request_calls_update(dev))
+		return;
+
 	if (!found) {
 		struct call *call;
 		uint8_t idx = next_index(dev);
@@ -400,6 +500,58 @@ static void ciev_cb(struct hfp_context *context, void *user_data)
 	}
 }
 
+static void clcc_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	struct clcc_entry *entry;
+	unsigned int val;
+	char number[MAX_NUMBER_LEN];
+
+	DBG("");
+
+	entry = g_new0(struct clcc_entry, 1);
+
+	if (!hfp_context_get_number(context, &val)) {
+		error("hf-client: Could not get index");
+		goto failed;
+	}
+	entry->idx = val;
+
+	if (!hfp_context_get_number(context, &val) || val > 1) {
+		error("hf-client: Could not get direction");
+		goto failed;
+	}
+	entry->direction = val;
+
+	if (!hfp_context_get_number(context, &val) ||
+			val > CALL_STATE_DISCONNECTED) {
+		error("hf-client: Could not get callstate");
+		goto failed;
+	}
+	entry->status = val;
+
+	if (!hfp_context_get_number(context, &val)) {
+		error("hf-client: Could not get mode");
+		goto failed;
+	}
+	entry->mode = val;
+
+	if (!hfp_context_get_number(context, &val)) {
+		error("hf-client: Could not get multiparty");
+		goto failed;
+	}
+	entry->multiparty = val;
+
+	if (hfp_context_get_string(context, number, MAX_NUMBER_LEN))
+		entry->number = g_strdup(number);
+
+	dev->clcc_entries = g_slist_append(dev->clcc_entries, entry);
+	return;
+
+failed:
+	g_free(entry);
+}
+
 static void clip_cb(struct hfp_context *context, void *user_data)
 {
 	struct hfp_device *dev = user_data;
@@ -450,6 +602,23 @@ static void cops_cb(struct hfp_context *context, void *user_data)
 	telephony_set_operator_name(dev->telephony, name);
 }
 
+static void cmee_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CMEE error: %d", result);
+		return;
+	}
+
+	if (dev->features & HFP_AG_FEAT_ENHANCED_CALL_STATUS) {
+		request_calls_update(dev);
+	}
+}
+
 static void ccwa_resp(enum hfp_result result, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -463,9 +632,10 @@ static void ccwa_resp(enum hfp_result result, enum hfp_error cme_err,
 	}
 
 	if (dev->features & HFP_AG_FEAT_EXTENDED_RES_CODE) {
-		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
-								"AT+CMEE=1"))
+		if (!hfp_hf_send_command(dev->hf, cmee_resp, dev, "AT+CMEE=1"))
 			info("hf-client: Could not send AT+CMEE=1");
+	} else if (dev->features & HFP_AG_FEAT_ENHANCED_CALL_STATUS) {
+		request_calls_update(dev);
 	}
 }
 
@@ -485,9 +655,10 @@ static void nrec_resp(enum hfp_result result, enum hfp_error cme_err,
 		if (!hfp_hf_send_command(dev->hf, ccwa_resp, dev, "AT+CCWA=1"))
 			info("hf-client: Could not send AT+CCWA=1");
 	} else if (dev->features & HFP_AG_FEAT_EXTENDED_RES_CODE) {
-		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
-								"AT+CMEE=1"))
+		if (!hfp_hf_send_command(dev->hf, cmee_resp, dev, "AT+CMEE=1"))
 			info("hf-client: Could not send AT+CMEE=1");
+	} else if (dev->features & HFP_AG_FEAT_ENHANCED_CALL_STATUS) {
+		request_calls_update(dev);
 	}
 }
 
@@ -512,9 +683,13 @@ static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
 		if (!hfp_hf_send_command(dev->hf, ccwa_resp, dev, "AT+CCWA=1"))
 			info("hf-client: Could not send AT+CCWA=1");
 	} else if (dev->features & HFP_AG_FEAT_EXTENDED_RES_CODE) {
-		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
-								"AT+CMEE=1"))
+		if (!hfp_hf_send_command(dev->hf, cmee_resp, dev, "AT+CMEE=1"))
 			info("hf-client: Could not send AT+CMEE=1");
+	} else if (dev->features & HFP_AG_FEAT_ENHANCED_CALL_STATUS) {
+		request_calls_update(dev);
+	}
+}
+
 static void cops_status_resp(enum hfp_result result, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -570,6 +745,7 @@ static void slc_completed(struct hfp_device *dev)
 
 	hfp_hf_register(dev->hf, ccwa_cb, "+CCWA", dev, NULL);
 	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
+	hfp_hf_register(dev->hf, clcc_cb, "+CLCC", dev, NULL);
 	hfp_hf_register(dev->hf, clip_cb, "+CLIP", dev, NULL);
 	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
 
@@ -793,6 +969,9 @@ static void ciev_call_cb(uint8_t val, void *user_data)
 		return;
 	}
 
+	if (request_calls_update(dev))
+		return;
+
 	if (dev->call == val)
 		return;
 
@@ -854,6 +1033,9 @@ static void ciev_callsetup_cb(uint8_t val, void *user_data)
 		return;
 	}
 
+	if (request_calls_update(dev))
+		return;
+
 	if (dev->call_setup == val)
 		return;
 
@@ -935,6 +1117,9 @@ static void ciev_callheld_cb(uint8_t val, void *user_data)
 		return;
 	}
 
+	if (request_calls_update(dev))
+		return;
+
 	dev->call_held = val;
 
 	if (dev->call_held == CIND_CALLHELD_NONE) {
-- 
2.43.0

