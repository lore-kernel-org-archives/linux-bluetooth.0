Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAD01FF1C4
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760299; cv=none; b=BA8J4A/QLX4Y7kxZj7Twse7MhFbvrB0Y9yRwq7hbFG6awGw60FIXpijxCzT6kv4tBZ71A/Xr5e7jLtD8sbMYayCdhNInCshRIfhhMFYhfI7vTgEPAZ7TveQl07DItHVtnwnFoqr4KSlIF/EwMXwcaQIldnbkFKDWa2GaJH5SB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760299; c=relaxed/simple;
	bh=l2Wn/yMFF+u0GoKkBDcbILzWL+242RCW8APqJ/ezwqI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qs1jB5AvsRBMb92PIjsfRCj34iWX1+wVGFMsbfG+kxKlIS6ucQtq9rjpTfSUvaeXWiDeiNkAgMhf5eMsP+2IbSGXv/dXXmJ5h2eBGdfQSj4XGsS/l3WymErHbFrw9Puw4bXb5tlSP1G5mhZ4IdN0QJx5SIC7Qa5KCPZRDxNh094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DkDGvw2P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DkDGvw2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762760295;
	bh=l2Wn/yMFF+u0GoKkBDcbILzWL+242RCW8APqJ/ezwqI=;
	h=From:To:Subject:Date:From;
	b=DkDGvw2PF3E9xtw/B8Tau+wsDqzAtVfwLTom7PkKvt5UZ9zexfiQgIe4Zt0ory+uc
	 HXRaBb/dqPVcEHrIxsGzNxiQahTUKxy2D1Z222FL9XmGJYn0gxBJIhKkxbQi1p8ig1
	 mpsH7kCVrJm0kgZBTYkfohIj4l2l4kr54pHnF5tSPeTcO4tjlfkDUPoOx2KZYNZL59
	 ejxaM8H4viGG/TbHsq5wPACsdxPK3/AR2Y1AvhN1abB43UYvAud04r8PjmoqO+xg6u
	 NL7q8dBqa+0g4Jphry6/snNP2Xme6bdspUMwlpdfPnG8nwWZ5AXJJMwD16kkVxpYZ0
	 oGNZLY5lrSHVQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-573E-e254-BC4f-0fC8.rev.sfr.net [IPv6:2a02:8428:af44:1001:573e:e254:bc4f:fc8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C8AC217E00B0
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 08:38:14 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/hfp: Add Enhanced Call Status support
Date: Mon, 10 Nov 2025 08:38:03 +0100
Message-ID: <20251110073804.49651-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In case remote device supports the Enhanced Call Status the calls are
created, updated or removed based on results of AT+CLCC commands.
This implies to send an AT+CLCC command on reception of +CIEV events
for <call>, <callsetup> or <callheld> indicators instead of managing
calls directly.

This updates the tests using FULL_SLC_SESSION:
- /HFP/HF/ENO/BV-01-C
- /HFP/HF/ICA/BV-01-C
- /HFP/HF/ICA/BV-02-C
- /HFP/HF/ICA/BV-03-C
- /HFP/HF/ICA/BV-04-C-full
---
 src/shared/hfp.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/hfp.h |   1 +
 unit/test-hfp.c  |  82 ++++++++++++++++++--
 3 files changed, 264 insertions(+), 12 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index c2028ac2b..b5e84bf2b 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -33,6 +33,7 @@
 #define HFP_HF_FEATURES	( \
 	HFP_HF_FEAT_ECNR | \
 	HFP_HF_FEAT_CLIP | \
+	HFP_HF_FEAT_ENHANCED_CALL_STATUS | \
 	HFP_HF_FEAT_ESCO_S4_T2 \
 )
 
@@ -105,7 +106,11 @@ struct hfp_hf {
 	bool roaming;
 	uint8_t battchg;
 
+	bool session;
+	bool clcc_in_progress;
+
 	struct queue *calls;
+	struct queue *updated_calls;
 	char *dialing_number;
 };
 
@@ -140,6 +145,7 @@ struct hf_call {
 	enum hfp_call_status status;
 	char *line_id;
 	uint type;
+	bool mpty;
 
 	struct hfp_hf *hfp;
 };
@@ -1320,6 +1326,7 @@ struct hfp_hf *hfp_hf_new(int fd)
 	hfp->event_handlers = queue_new();
 	hfp->cmd_queue = queue_new();
 	hfp->calls = queue_new();
+	hfp->updated_calls = queue_new();
 	hfp->writer_active = false;
 
 	if (!io_set_read_handler(hfp->io, hf_can_read_data, hfp,
@@ -1393,6 +1400,9 @@ void hfp_hf_unref(struct hfp_hf *hfp)
 	queue_destroy(hfp->calls, remove_call_cb);
 	hfp->calls = NULL;
 
+	queue_destroy(hfp->updated_calls, NULL);
+	hfp->updated_calls = NULL;
+
 	if (hfp->dialing_number) {
 		free(hfp->dialing_number);
 		hfp->dialing_number = NULL;
@@ -1625,7 +1635,8 @@ static uint next_call_index(struct hfp_hf *hfp)
 
 static struct hf_call *call_new(struct hfp_hf *hfp, unsigned int id,
 						enum hfp_call_status status,
-						char *number)
+						char *number, unsigned int type,
+						bool mpty)
 {
 	struct hf_call *call;
 
@@ -1634,6 +1645,8 @@ static struct hf_call *call_new(struct hfp_hf *hfp, unsigned int id,
 	call->status = status;
 	if (number)
 		call->line_id = strdup(number);
+	call->type = type;
+	call->mpty = mpty;
 	call->hfp = hfp;
 	queue_push_tail(hfp->calls, call);
 
@@ -1662,6 +1675,84 @@ static void ciev_service_cb(uint8_t val, void *user_data)
 							hfp->callbacks_data);
 }
 
+static void clcc_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	const struct queue_entry *call_entry, *id_entry;
+	struct hf_call *call;
+	uint id;
+	bool found;
+	struct queue *to_remove;
+
+	DBG(hfp, "");
+
+	hfp->clcc_in_progress = false;
+
+	if (result != HFP_RESULT_OK) {
+		DBG(hfp, "hf: CLCC error: %d", result);
+		goto failed;
+	}
+
+	/* Removed disconnected calls */
+	to_remove = queue_new();
+	for (call_entry = queue_get_entries(hfp->calls); call_entry;
+		call_entry = call_entry->next) {
+		call = call_entry->data;
+		found = false;
+
+		for (id_entry = queue_get_entries(hfp->updated_calls);
+			id_entry; id_entry = id_entry->next) {
+			id = PTR_TO_UINT(id_entry->data);
+			if (call->id == id) {
+				found = true;
+				break;
+			}
+		}
+		DBG(hfp, "hf: call %d -> %s", call->id,
+			found ? "updated" : "disconnected");
+
+		if (!found)
+			queue_push_tail(to_remove, UINT_TO_PTR(call->id));
+	}
+
+	for (id_entry = queue_get_entries(to_remove);
+		id_entry; id_entry = id_entry->next) {
+		id = PTR_TO_UINT(id_entry->data);
+		call = queue_find(hfp->calls, call_id_match, UINT_TO_PTR(id));
+		if (!call) {
+			DBG(hfp, "hf: Unknown call to remove: %u", id);
+			continue;
+		}
+		queue_remove(hfp->calls, call);
+		remove_call_cb(call);
+	}
+
+	queue_remove_all(hfp->updated_calls, NULL, NULL, NULL);
+	queue_destroy(to_remove, NULL);
+	return;
+
+failed:
+	if (!hfp->session && hfp->callbacks->session_ready)
+		hfp->callbacks->session_ready(result, cme_err,
+						hfp->callbacks_data);
+}
+
+static bool send_clcc(struct hfp_hf *hfp)
+{
+	if (!hfp->session || hfp->clcc_in_progress)
+		return true;
+
+	if (!hfp_hf_send_command(hfp, clcc_resp, hfp, "AT+CLCC")) {
+		DBG(hfp, "hf: Could not send AT+CLCC");
+		return false;
+	}
+
+	hfp->clcc_in_progress = true;
+
+	return true;
+}
+
 static bool update_call_to_active(struct hfp_hf *hfp)
 {
 	const struct queue_entry *entry;
@@ -1695,6 +1786,11 @@ static void ciev_call_cb(uint8_t val, void *user_data)
 
 	DBG(hfp, "%u", val);
 
+	if (hfp->features & HFP_AG_FEAT_ENHANCED_CALL_STATUS) {
+		send_clcc(hfp);
+		return;
+	}
+
 	if (val < hfp->ag_ind[HFP_INDICATOR_CALL].min ||
 			val > hfp->ag_ind[HFP_INDICATOR_CALL].max) {
 		DBG(hfp, "hf: Incorrect call state: %u", val);
@@ -1720,7 +1816,7 @@ static void ciev_call_cb(uint8_t val, void *user_data)
 				DBG(hfp, "hf: No new call index available");
 				return;
 			}
-			call_new(hfp, id, CALL_STATUS_ACTIVE, NULL);
+			call_new(hfp, id, CALL_STATUS_ACTIVE, NULL, 0, false);
 		}
 		break;
 	default:
@@ -1779,6 +1875,11 @@ static void ciev_callsetup_cb(uint8_t val, void *user_data)
 
 	DBG(hfp, "%u", val);
 
+	if (hfp->features & HFP_AG_FEAT_ENHANCED_CALL_STATUS) {
+		send_clcc(hfp);
+		return;
+	}
+
 	if (val < hfp->ag_ind[HFP_INDICATOR_CALLSETUP].min ||
 			val > hfp->ag_ind[HFP_INDICATOR_CALLSETUP].max) {
 		DBG(hfp, "hf: Incorrect call setup state: %u", val);
@@ -1802,7 +1903,7 @@ static void ciev_callsetup_cb(uint8_t val, void *user_data)
 			DBG(hfp, "hf: No new call index available");
 			return;
 		}
-		call_new(hfp, id, CALL_STATUS_INCOMING, NULL);
+		call_new(hfp, id, CALL_STATUS_INCOMING, NULL, 0, false);
 		break;
 	case CIND_CALLSETUP_DIALING:
 	case CIND_CALLSETUP_ALERTING:
@@ -1832,7 +1933,7 @@ static void ciev_callsetup_cb(uint8_t val, void *user_data)
 			DBG(hfp, "hf: No new call index available");
 			return;
 		}
-		call_new(hfp, id, status, hfp->dialing_number);
+		call_new(hfp, id, status, hfp->dialing_number, 0, false);
 		if (hfp->dialing_number) {
 			free(hfp->dialing_number);
 			hfp->dialing_number = NULL;
@@ -1847,6 +1948,11 @@ static void ciev_callheld_cb(uint8_t val, void *user_data)
 
 	DBG(hfp, "%u", val);
 
+	if (hfp->features & HFP_AG_FEAT_ENHANCED_CALL_STATUS) {
+		send_clcc(hfp);
+		return;
+	}
+
 	if (val < hfp->ag_ind[HFP_INDICATOR_CALLHELD].min ||
 			val > hfp->ag_ind[HFP_INDICATOR_CALLHELD].max) {
 		DBG(hfp, "hf: Incorrect call held state: %u", val);
@@ -1962,6 +2068,76 @@ static void cops_cb(struct hfp_context *context, void *user_data)
 		hfp->callbacks->update_operator(name, hfp->callbacks_data);
 }
 
+static void clcc_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	unsigned int id, status, mpty, type;
+	char number[255];
+	struct hf_call *call;
+
+	DBG(hfp, "");
+
+	if (!hfp_context_get_number(context, &id))
+		return;
+
+	/* Skip direction */
+	hfp_context_skip_field(context);
+
+	if (!hfp_context_get_number(context, &status))
+		return;
+
+	/* Skip mode */
+	hfp_context_skip_field(context);
+
+	if (!hfp_context_get_number(context, &mpty))
+		return;
+
+	if (!hfp_context_get_string(context, number, sizeof(number))) {
+		DBG(hfp, "hf: Could not get string");
+		return;
+	}
+
+	if (!hfp_context_get_number(context, &type))
+		return;
+
+	queue_push_tail(hfp->updated_calls, UINT_TO_PTR(id));
+
+	call = queue_find(hfp->calls, call_id_match, UINT_TO_PTR(id));
+	if (!call) {
+		call_new(hfp, id, status, number, type, !!mpty);
+		return;
+	}
+
+	if (call->status != status) {
+		call->status = status;
+		if (hfp->callbacks && hfp->callbacks->call_status_updated)
+			hfp->callbacks->call_status_updated(call->id,
+					call->status, hfp->callbacks_data);
+	}
+
+	if (call->mpty != mpty) {
+		call->mpty = mpty;
+		if (hfp->callbacks && hfp->callbacks->call_mpty_updated)
+			hfp->callbacks->call_mpty_updated(call->id,
+					call->mpty, hfp->callbacks_data);
+	}
+
+	if (call->line_id && strcmp(call->line_id, number) == 0 &&
+		call->type == type)
+		return;
+
+	if (call->line_id)
+		free(call->line_id);
+	call->line_id = strdup(number);
+	call->type = type;
+
+	if (hfp->callbacks && hfp->callbacks->call_line_id_updated)
+		hfp->callbacks->call_line_id_updated(call->id,
+						call->line_id,
+						call->type,
+						hfp->callbacks_data);
+}
+
 static void clip_cb(struct hfp_context *context, void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -2012,10 +2188,18 @@ static void nrec_resp(enum hfp_result result, enum hfp_error cme_err,
 		goto failed;
 	}
 
+	hfp->session = true;
 	if (hfp->callbacks->session_ready)
 		hfp->callbacks->session_ready(HFP_RESULT_OK, 0,
 						hfp->callbacks_data);
 
+	if (hfp->features & HFP_AG_FEAT_ENHANCED_CALL_STATUS) {
+		if (!send_clcc(hfp)) {
+			result = HFP_RESULT_ERROR;
+			goto failed;
+		}
+	}
+
 	return;
 
 failed:
@@ -2168,6 +2352,7 @@ static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
 	if (hfp->features & HFP_AG_FEAT_IN_BAND_RING_TONE)
 		hfp_hf_register(hfp, bsir_cb, "+BSIR", hfp, NULL);
 	hfp_hf_register(hfp, ciev_cb, "+CIEV", hfp, NULL);
+	hfp_hf_register(hfp, clcc_cb, "+CLCC", hfp, NULL);
 	hfp_hf_register(hfp, clip_cb, "+CLIP", hfp, NULL);
 	hfp_hf_register(hfp, cops_cb, "+COPS", hfp, NULL);
 
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 27315bfa0..6e3d4c213 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -210,6 +210,7 @@ struct hfp_hf_callbacks {
 							void *user_data);
 	void (*call_line_id_updated)(uint id, const char *number, uint type,
 							void *user_data);
+	void (*call_mpty_updated)(uint id, bool mpty, void *user_data);
 };
 
 struct hfp_hf *hfp_hf_new(int fd);
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index c3f9ac4d0..b25b67379 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -937,11 +937,7 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 
 	if (g_str_equal(test_name, "/HFP/HF/CIT/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/CLI/BV-01-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-02-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-07-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICR/BV-01-C") ||
@@ -949,6 +945,19 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
 		g_assert_cmpint(id, ==, 1);
 		g_assert_cmpint(status, ==, CALL_STATUS_INCOMING);
+	} else if (g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-02-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full")) {
+		bool ret;
+
+		g_assert_cmpint(id, ==, 1);
+		g_assert_cmpint(status, ==, CALL_STATUS_INCOMING);
+		if (tester_use_debug())
+			tester_debug("call %d: answering call", id);
+		ret = hfp_hf_call_answer(context->hfp_hf, id, hf_cmd_complete,
+								context);
+		g_assert(ret);
 	} else if (g_str_equal(test_name, "/HFP/HF/OCL/BV-01-C")) {
 		const char *number;
 
@@ -1002,11 +1011,7 @@ static void hf_call_line_id_updated(uint id, const char *number,
 	g_assert_cmpstr(number, ==, str);
 
 	if (g_str_equal(test_name, "/HFP/HF/ENO/BV-01-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-02-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-07-C") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
@@ -1376,6 +1381,7 @@ int main(int argc, char *argv[])
 	define_hf_test("/HFP/HF/ENO/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
 			FULL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '1', '\r', '\n'),
 			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
@@ -1387,16 +1393,23 @@ int main(int argc, char *argv[])
 				'2', ',', '1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			data_end());
 
 	/* Incoming call, in-band ring - HF */
 	define_hf_test("/HFP/HF/ICA/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
 			FULL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
 				'1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '4', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9',  '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
 				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
@@ -1406,18 +1419,30 @@ int main(int argc, char *argv[])
 				'2', ',', '1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9',  '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'2', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			data_end());
 
 	/* Answer incoming call and accept in-band setting change - HF */
 	define_hf_test("/HFP/HF/ICA/BV-02-C", test_hf_session,
 			NULL, test_hf_session_done,
 			FULL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
 				'0', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '4', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9',  '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
 				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
@@ -1427,13 +1452,24 @@ int main(int argc, char *argv[])
 				'2', ',', '1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9',  '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'2', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
 				'1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '4', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9',  '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
 				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
@@ -1443,20 +1479,32 @@ int main(int argc, char *argv[])
 				'2', ',', '1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9',  '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'2', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			data_end());
 
 	/* Answer incoming call on HF with ring muting - HF */
 	define_hf_test("/HFP/HF/ICA/BV-03-C", test_hf_session,
 			NULL, test_hf_session_done,
 			FULL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
 				'0', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
 				'1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '4', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9',  '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
 				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
@@ -1466,8 +1514,14 @@ int main(int argc, char *argv[])
 				'2', ',', '1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9',  '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'2', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			data_end());
 
 	/* Answer Incoming call on HF, no in-band ring - HF */
@@ -1496,10 +1550,16 @@ int main(int argc, char *argv[])
 	define_hf_test("/HFP/HF/ICA/BV-04-C-full", test_hf_session,
 			NULL, test_hf_session_done,
 			FULL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
 				'0', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '4', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9',  '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
 				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
@@ -1509,8 +1569,14 @@ int main(int argc, char *argv[])
 				'2', ',', '1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9',  '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
 				'2', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
 			data_end());
 
 	/* Answer Incoming call on AG, no in-band ring - HF */
-- 
2.43.0

