Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC62C21E7
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936328; cv=none; b=Fi0IiiUptivEwjOAbhnPu0hhgW3EUnPPGB30bHPyChZb4reOPlnffJSucWYaisWoiWSMc9xZAqOF4hfc92T892V8B+QffaEB/0gJTZVWA15pOH/SB6DHQrKz2Mq47DQ2DHP8kE+fp8qDiKPfIqxxwh3CeyJ6knRQ2DBk7N+ZupY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936328; c=relaxed/simple;
	bh=dL8sBy7nef3Hx1kYCkLRy2jU7/46edcGiO/KzzjsoVA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E5vPy94KCtXM2BPQFwqcNJ+OK8qM83kbTmk4OB2AFBUh2sqVwZRhfhRrJeOHy3J87IOEGHxhqRO7GA5xVjzZifFkr8Sa5PtsuItTRfazG6rQyLOvBNJEOPy0dfJIxCDvWNszMc+QCch6zofc24w8jPK73+yaNUm9W7gDMAZW/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M42TIJL9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M42TIJL9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762936317;
	bh=dL8sBy7nef3Hx1kYCkLRy2jU7/46edcGiO/KzzjsoVA=;
	h=From:To:Subject:Date:From;
	b=M42TIJL9wIBo48NFnjt+VUdrHWztgogrBHUNB524rgRDUZyjbIecqPShF6ja0TsRr
	 OWQlzQ+Y6HU9GlqChMlmm/cnOq+6p9wuWZLLhGJrxKpI5vsJCsEyvW8q0GfVzHEudS
	 0wTHCJ7m4bNIGpwhCZLuAlTxxQBFR6NEUIBTgE2g02VQrRqPVY9KeKIAmZ92XPGKEK
	 9K/0FlpmiYlS1ynDk1JGYer+eMvuZ6FFtLFIVz1SNlmWcAvhNdX0zpteRaWp1vBzj+
	 p0HGxm1LP4vVIgsOWupfyd35MLn7DPWyumlTN2uFdT7JnvLLBeQCEgt4v16WcWcL0f
	 kIVFXgBWRMgmQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-Af44-1001-094F-3df2-fbF5-546C.rev.sfr.net [IPv6:2a02:8428:af44:1001:94f:3df2:fbf5:546c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C470C17E1318
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 09:31:57 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/hfp: Add simple 3way calls support
Date: Wed, 12 Nov 2025 09:31:49 +0100
Message-ID: <20251112083150.54641-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This adds support for the AT+CHLD=0 (Releases all held calls or set
User Determined User Busy for a waiting call), =1 (Releases all active
calls and accept the other call, held or waiting) and =2 (Places all
active calls on hold and accept the other call, held or waiting)
commands and the +CCWA (Call waiting notification) event.
---
 src/shared/hfp.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/hfp.h |  15 ++++
 unit/test-hfp.c  |   5 ++
 3 files changed, 234 insertions(+), 4 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index b5e84bf2b..e4f5161b6 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -32,6 +32,7 @@
 
 #define HFP_HF_FEATURES	( \
 	HFP_HF_FEAT_ECNR | \
+	HFP_HF_FEAT_3WAY | \
 	HFP_HF_FEAT_CLIP | \
 	HFP_HF_FEAT_ENHANCED_CALL_STATUS | \
 	HFP_HF_FEAT_ESCO_S4_T2 \
@@ -105,6 +106,7 @@ struct hfp_hf {
 	uint8_t signal;
 	bool roaming;
 	uint8_t battchg;
+	uint8_t chlds;
 
 	bool session;
 	bool clcc_in_progress;
@@ -396,6 +398,12 @@ bool hfp_context_close_container(struct hfp_context *context)
 	return true;
 }
 
+bool hfp_context_is_container_close(struct hfp_context *context)
+{
+	return context->data[context->offset] == ')';
+}
+
+
 bool hfp_context_get_string(struct hfp_context *context, char *buf,
 								uint8_t len)
 {
@@ -1852,6 +1860,20 @@ static bool call_active_match(const void *data, const void *match_data)
 	return (call->status == CALL_STATUS_ACTIVE);
 }
 
+static bool call_waiting_match(const void *data, const void *match_data)
+{
+	const struct hf_call *call = data;
+
+	return (call->status == CALL_STATUS_WAITING);
+}
+
+static bool call_held_match(const void *data, const void *match_data)
+{
+	const struct hf_call *call = data;
+
+	return (call->status == CALL_STATUS_HELD);
+}
+
 static void bsir_cb(struct hfp_context *context, void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -1866,6 +1888,43 @@ static void bsir_cb(struct hfp_context *context, void *user_data)
 		hfp->callbacks->update_inband_ring(!!val, hfp->callbacks_data);
 }
 
+static void ccwa_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	char number[255];
+	unsigned int type;
+	struct hf_call *call;
+	uint id;
+
+	DBG(hfp, "");
+
+	if (hfp->features & HFP_AG_FEAT_ENHANCED_CALL_STATUS) {
+		send_clcc(hfp);
+		return;
+	}
+
+	if (!hfp_context_get_string(context, number, sizeof(number))) {
+		DBG(hfp, "hf: Could not get string");
+		return;
+	}
+
+	if (!hfp_context_get_number(context, &type))
+		return;
+
+	call = queue_find(hfp->calls, call_waiting_match, NULL);
+	if (call) {
+		DBG(hfp, "hf: waiting call already in progress");
+		return;
+	}
+
+	id = next_call_index(hfp);
+	if (id == 0) {
+		DBG(hfp, "hf: No new call index available");
+		return;
+	}
+	call_new(hfp, id, CALL_STATUS_WAITING, number, type, false);
+}
+
 static void ciev_callsetup_cb(uint8_t val, void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -2240,7 +2299,7 @@ failed:
 						hfp->callbacks_data);
 }
 
-static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
+static void ccwa_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -2248,7 +2307,7 @@ static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
 	DBG(hfp, "");
 
 	if (result != HFP_RESULT_OK) {
-		DBG(hfp, "hf: CLIP error: %d", result);
+		DBG(hfp, "hf: CCWA error: %d", result);
 		goto failed;
 	}
 
@@ -2272,6 +2331,39 @@ failed:
 						hfp->callbacks_data);
 }
 
+static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "");
+
+	if (result != HFP_RESULT_OK) {
+		DBG(hfp, "hf: CLIP error: %d", result);
+		goto failed;
+	}
+
+	if (!(hfp->features & HFP_AG_FEAT_3WAY)) {
+		/* Jump to next setup state */
+		ccwa_resp(HFP_RESULT_OK, cme_err, user_data);
+		return;
+	}
+
+	if (!hfp_hf_send_command(hfp, ccwa_resp, hfp,
+		"AT+CCWA=1")) {
+		DBG(hfp, "hf: Could not send AT+CCWA=1");
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
 static void cops_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
@@ -2328,15 +2420,56 @@ failed:
 						hfp->callbacks_data);
 }
 
-static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
+static void slc_chld_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	if (!hfp_context_open_container(context)) {
+		DBG(hfp, "hf: Could not open container for CHLD");
+		return;
+	}
+
+	while (hfp_context_has_next(context) &&
+		!hfp_context_is_container_close(context)) {
+		char val[3];
+
+		if (!hfp_context_get_unquoted_string(context, val,
+							sizeof(val))) {
+			DBG(hfp, "hf: Could not get string");
+			goto failed;
+		}
+
+		if (strcmp(val, "0") == 0)
+			hfp->chlds |= HFP_CHLD_0;
+		else if (strcmp(val, "1") == 0)
+			hfp->chlds |= HFP_CHLD_1;
+		else if (strcmp(val, "2") == 0)
+			hfp->chlds |= HFP_CHLD_2;
+		else
+			DBG(hfp, "CHLD not supported: %s", val);
+	}
+
+	if (!hfp_context_close_container(context)) {
+		DBG(hfp, "hf: Could not close container");
+		goto failed;
+	}
+
+	return;
+failed:
+	DBG(hfp, "hf: Error on CHLD response");
+}
+
+static void slc_chld_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
 
 	DBG(hfp, "");
 
+	hfp_hf_unregister(hfp, "+CHLD");
+
 	if (result != HFP_RESULT_OK) {
-		DBG(hfp, "hf: CMER error: %d", result);
+		DBG(hfp, "hf: CHLD=? error: %d", result);
 		goto failed;
 	}
 
@@ -2351,6 +2484,8 @@ static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
 	/* Register unsolicited results handlers */
 	if (hfp->features & HFP_AG_FEAT_IN_BAND_RING_TONE)
 		hfp_hf_register(hfp, bsir_cb, "+BSIR", hfp, NULL);
+	if (hfp->features & HFP_AG_FEAT_3WAY)
+		hfp_hf_register(hfp, ccwa_cb, "+CCWA", hfp, NULL);
 	hfp_hf_register(hfp, ciev_cb, "+CIEV", hfp, NULL);
 	hfp_hf_register(hfp, clcc_cb, "+CLCC", hfp, NULL);
 	hfp_hf_register(hfp, clip_cb, "+CLIP", hfp, NULL);
@@ -2364,6 +2499,44 @@ failed:
 						hfp->callbacks_data);
 }
 
+static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "");
+
+	if (result != HFP_RESULT_OK) {
+		DBG(hfp, "hf: CMER error: %d", result);
+		goto failed;
+	}
+
+	if (!(hfp->features & HFP_AG_FEAT_3WAY)) {
+		/* Jump to next setup state */
+		slc_chld_resp(HFP_RESULT_OK, cme_err, user_data);
+		return;
+	}
+
+	if (!hfp_hf_register(hfp, slc_chld_cb, "+CHLD", hfp, NULL)) {
+		DBG(hfp, "hf: Could not register +CHLD");
+		result = HFP_RESULT_ERROR;
+		goto failed;
+	}
+
+	if (!hfp_hf_send_command(hfp, slc_chld_resp, hfp, "AT+CHLD=?")) {
+		DBG(hfp, "hf: Could not send AT+CHLD=?");
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
 static void slc_cind_status_cb(struct hfp_context *context,
 	void *user_data)
 {
@@ -2745,6 +2918,38 @@ bool hfp_hf_dial(struct hfp_hf *hfp, const char *number,
 	return hfp_hf_send_command(hfp, resp_cb, user_data, "ATD%s;", number);
 }
 
+bool hfp_hf_release_and_accept(struct hfp_hf *hfp,
+				hfp_response_func_t resp_cb,
+				void *user_data)
+{
+	if (!hfp)
+		return false;
+
+	DBG(hfp, "");
+
+	if (!(hfp->chlds & HFP_CHLD_1) ||
+		(!queue_find(hfp->calls, call_waiting_match, NULL) &&
+		!queue_find(hfp->calls, call_held_match, NULL)))
+		return false;
+
+	return hfp_hf_send_command(hfp, resp_cb, user_data, "AT+CHLD=1");
+}
+
+bool hfp_hf_swap_calls(struct hfp_hf *hfp,
+				hfp_response_func_t resp_cb,
+				void *user_data)
+{
+	if (!hfp)
+		return false;
+
+	DBG(hfp, "");
+
+	if (!(hfp->chlds & HFP_CHLD_2))
+		return false;
+
+	return hfp_hf_send_command(hfp, resp_cb, user_data, "AT+CHLD=2");
+}
+
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data)
@@ -2791,6 +2996,11 @@ bool hfp_hf_call_hangup(struct hfp_hf *hfp, uint id,
 	if (call_setup_match(call, NULL) || call_active_match(call, NULL)) {
 		return hfp_hf_send_command(hfp, resp_cb, user_data,
 								"AT+CHUP");
+	} else if ((call_waiting_match(call, NULL) ||
+		call_held_match(call, NULL)) &&
+		(hfp->chlds & HFP_CHLD_0)) {
+		return hfp_hf_send_command(hfp, resp_cb, user_data,
+								"AT+CHLD=0");
 	}
 
 	return false;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 6e3d4c213..045e1f7ab 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -38,6 +38,14 @@
 #define HFP_AG_FEAT_ENHANCED_VOICE_RECOGNITION_STATUS	0x00001000
 #define HFP_AG_FEAT_VOICE_RECOGNITION_TEXT		0x00002000
 
+#define HFP_CHLD_0	1 << 0
+#define HFP_CHLD_1	1 << 1
+#define HFP_CHLD_2	1 << 2
+#define HFP_CHLD_3	1 << 3
+#define HFP_CHLD_4	1 << 4
+#define HFP_CHLD_1x	1 << 5
+#define HFP_CHLD_2x	1 << 6
+
 enum hfp_result {
 	HFP_RESULT_OK		= 0,
 	HFP_RESULT_CONNECT	= 1,
@@ -177,6 +185,7 @@ bool hfp_context_get_number_default(struct hfp_context *context,
 						unsigned int default_val);
 bool hfp_context_open_container(struct hfp_context *context);
 bool hfp_context_close_container(struct hfp_context *context);
+bool hfp_context_is_container_close(struct hfp_context *context);
 bool hfp_context_get_string(struct hfp_context *context, char *buf,
 								uint8_t len);
 bool hfp_context_get_unquoted_string(struct hfp_context *context,
@@ -242,6 +251,12 @@ const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id);
 bool hfp_hf_dial(struct hfp_hf *hfp, const char *number,
 				hfp_response_func_t resp_cb,
 				void *user_data);
+bool hfp_hf_release_and_accept(struct hfp_hf *hfp,
+				hfp_response_func_t resp_cb,
+				void *user_data);
+bool hfp_hf_swap_calls(struct hfp_hf *hfp,
+				hfp_response_func_t resp_cb,
+				void *user_data);
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data);
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 67a88a1cc..5252ed316 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -758,12 +758,17 @@ static void test_hf_robustness(gconstpointer data)
 		',', '5', '\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', '+', 'C', 'H', 'L', 'D', ':', '(', '0', \
+		',', '1', ',', '1', 'x', ',', '2', ',', '2', 'x', \
+		',', '3', ',', '4', ')', '\r', '\n'), \
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', '+', 'C', 'O', 'P', 'S', ':', ' ', '0', ',', \
 		'0', ',', '\"', 'T', 'E', 'S', 'T', '\"', '\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
 
 static void hf_cmd_complete(enum hfp_result res, enum hfp_error cme_err,
-- 
2.43.0

