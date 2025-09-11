Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51B31076D
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586647; cv=none; b=BsPINJ7bXgZAzQrIZozOlceuTrHXhLxfrJIsDNtMFLr5AMDIjXTIaF0KQAInDLQBZMxWlUTkZYbqEX6yea9iNN+GtQ/GpO0jqr4TSYMPv7piEp6cKaWYbj32pTxCuIoN8WsmUaAODbsgGwGrPrEZrhYyKRveqo24Dl4Wi1VxeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586647; c=relaxed/simple;
	bh=l0eWj3MNpXmAB6GHAr87ETKE5OyDBwd4QcEAB7qOyG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keiryio9XYhz5P2gpCrM6XNOR+6GA/0xdLom4Wb71bFo+AAWkH78S8MmGO4x1MhZOXPyOQkJPV2TChg3LvzNZ6FBdz9A/fk7WHgrHUkGh7/YEiml5QocoFIxm7s7uj9cRrEj9g5xsRzAIiWlQgY9XZTpy/YFuixVqWn9aJD+4+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O+slmdMU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O+slmdMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757586642;
	bh=l0eWj3MNpXmAB6GHAr87ETKE5OyDBwd4QcEAB7qOyG0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O+slmdMU8T7Ay/0/5Ui9DiERnJkZCjbfrRLOv9D7UQDConwPG/24J+qGfZfiyhHG7
	 CsTKyxJ5t338wIaejWPILbKm15Qq1wJKkE6fqbOVALxwvWVfKfxnj/PKz7slRF/ruc
	 OYPyryKbxHtNIZ3OYQ8J+WiFK9/8v4Fk4hlMylqrl0PiR1RqVxA4UFY/Q5/EYxBxEc
	 8V7q6bX/Fi4Dv8Mm4tMeUTlI1C6Bvh7mU1BI9CdemsoOu1A6cfKOD9oOqTCv1se5lt
	 b/1AA6BtOmWQ5xy1tztIDrlEV/vevhNz40L5oniKvBlW3Kqr9Z4aH5AQauE8Hpzi7s
	 puUmN5VHxoB4w==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-E0e2-6802-CeeF-9413.rev.sfr.net [IPv6:2a02:8428:af44:1001:e0e2:6802:ceef:9413])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A490517E07EE
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 12:30:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/hfp: Add Call Line Identification support
Date: Thu, 11 Sep 2025 12:28:39 +0200
Message-ID: <20250911102840.2090361-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911102840.2090361-1-frederic.danis@collabora.com>
References: <20250911102840.2090361-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Send AT+CLIP=1 at the end of the SLC creation to enable CLIP event.
Register +CLIP handler to call the update_call_line_id callback on event.

During incoming call notifications, i.e. after +CIEV:<callsetup>,1
event which creates a new call object, the reception of +CLIP event
will update the line_id and type of the call object.
---
 src/shared/hfp.c | 238 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/hfp.h |  20 ++++
 2 files changed, 255 insertions(+), 3 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index f94df90f1..29b467ae3 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <stdarg.h>
 #include <ctype.h>
+#include <limits.h>
 
 #include "src/shared/util.h"
 #include "src/shared/ringbuf.h"
@@ -29,7 +30,7 @@
 	hfp_debug(_hfp->debug_callback, _hfp->debug_data, "%s:%s() " fmt, \
 						__FILE__, __func__, ## arg)
 
-#define HFP_HF_FEATURES	(HFP_HF_FEAT_ESCO_S4_T2)
+#define HFP_HF_FEATURES	(HFP_HF_FEAT_CLIP | HFP_HF_FEAT_ESCO_S4_T2)
 
 struct hfp_gw {
 	int ref_count;
@@ -100,6 +101,7 @@ struct hfp_hf {
 	bool roaming;
 	uint8_t battchg;
 
+	struct queue *calls;
 };
 
 struct cmd_handler {
@@ -128,6 +130,15 @@ struct event_handler {
 	hfp_hf_result_func_t callback;
 };
 
+struct hf_call {
+	uint id;
+	enum hfp_call_status status;
+	char *line_id;
+	uint type;
+
+	struct hfp_hf *hfp;
+};
+
 static void hfp_debug(hfp_debug_func_t debug_func, void *debug_data,
 						const char *format, ...)
 {
@@ -1303,6 +1314,7 @@ struct hfp_hf *hfp_hf_new(int fd)
 
 	hfp->event_handlers = queue_new();
 	hfp->cmd_queue = queue_new();
+	hfp->calls = queue_new();
 	hfp->writer_active = false;
 
 	if (!io_set_read_handler(hfp->io, hf_can_read_data, hfp,
@@ -1329,6 +1341,18 @@ struct hfp_hf *hfp_hf_ref(struct hfp_hf *hfp)
 	return hfp;
 }
 
+static void remove_call_cb(void *user_data)
+{
+	struct hf_call *call = user_data;
+	struct hfp_hf *hfp = call->hfp;
+
+	if (hfp->callbacks && hfp->callbacks->call_removed)
+		hfp->callbacks->call_removed(call->id, hfp->callbacks_data);
+
+	free(call->line_id);
+	free(call);
+}
+
 void hfp_hf_unref(struct hfp_hf *hfp)
 {
 	if (!hfp)
@@ -1361,6 +1385,9 @@ void hfp_hf_unref(struct hfp_hf *hfp)
 	queue_destroy(hfp->cmd_queue, free);
 	hfp->cmd_queue = NULL;
 
+	queue_destroy(hfp->calls, remove_call_cb);
+	hfp->calls = NULL;
+
 	if (!hfp->in_disconnect) {
 		free(hfp);
 		return;
@@ -1568,6 +1595,44 @@ bool hfp_hf_disconnect(struct hfp_hf *hfp)
 	return io_shutdown(hfp->io);
 }
 
+static bool call_id_match(const void *data, const void *match_data)
+{
+	const struct hf_call *call = data;
+	uint id = PTR_TO_UINT(match_data);
+
+	return (call->id == id);
+}
+
+static uint next_call_index(struct hfp_hf *hfp)
+{
+	for (uint i = 1; i < UINT_MAX; i++) {
+		if (!queue_find(hfp->calls, call_id_match, UINT_TO_PTR(i)))
+			return i;
+	}
+
+	return 0;
+}
+
+static struct hf_call *call_new(struct hfp_hf *hfp, unsigned int id,
+						enum hfp_call_status status,
+						char *number)
+{
+	struct hf_call *call;
+
+	call = new0(struct hf_call, 1);
+	call->id = id;
+	call->status = status;
+	call->line_id = number;
+	call->hfp = hfp;
+	queue_push_tail(hfp->calls, call);
+
+	if (hfp->callbacks && hfp->callbacks->call_added)
+		hfp->callbacks->call_added(call->id, call->status,
+						hfp->callbacks_data);
+
+	return call;
+}
+
 static void ciev_service_cb(uint8_t val, void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -1599,9 +1664,40 @@ static void ciev_call_cb(uint8_t val, void *user_data)
 	}
 }
 
+static bool call_outgoing_match(const void *data, const void *match_data)
+{
+	const struct hf_call *call = data;
+
+	return (call->status == CALL_STATUS_DIALING ||
+				    call->status == CALL_STATUS_ALERTING);
+}
+
+static bool call_incoming_match(const void *data, const void *match_data)
+{
+	const struct hf_call *call = data;
+
+	return (call->status == CALL_STATUS_INCOMING);
+}
+
+static bool call_setup_match(const void *data, const void *match_data)
+{
+	return (call_outgoing_match(data, match_data) ||
+				    call_incoming_match(data, match_data));
+}
+
+static bool call_active_match(const void *data, const void *match_data)
+{
+	const struct hf_call *call = data;
+
+	return (call->status == CALL_STATUS_ACTIVE);
+}
+
 static void ciev_callsetup_cb(uint8_t val, void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
+	struct hf_call *call;
+	uint id;
+	enum hfp_call_status status;
 
 	DBG(hfp, "%u", val);
 
@@ -1610,6 +1706,57 @@ static void ciev_callsetup_cb(uint8_t val, void *user_data)
 		DBG(hfp, "hf: Incorrect call setup state: %u", val);
 		return;
 	}
+
+	switch (val) {
+	case CIND_CALLSETUP_NONE:
+		/* remove call in setup phase */
+		queue_remove_all(hfp->calls, call_setup_match, hfp,
+							remove_call_cb);
+		break;
+	case CIND_CALLSETUP_INCOMING:
+		if (queue_length(hfp->calls) != 0) {
+			DBG(hfp, "hf: Call already exists");
+			return;
+		}
+
+		id = next_call_index(hfp);
+		if (id == 0) {
+			DBG(hfp, "hf: No new call index available");
+			return;
+		}
+		call_new(hfp, id, CALL_STATUS_INCOMING, NULL);
+		break;
+	case CIND_CALLSETUP_DIALING:
+	case CIND_CALLSETUP_ALERTING:
+		if (val == CIND_CALLSETUP_DIALING)
+			status = CALL_STATUS_DIALING;
+		else
+			status = CALL_STATUS_ALERTING;
+
+		if (queue_find(hfp->calls, call_active_match, NULL)) {
+			DBG(hfp, "hf: Error: active call");
+			return;
+		}
+
+		call = queue_find(hfp->calls, call_outgoing_match, NULL);
+		if (call && call->status != status) {
+			call->status = status;
+			if (hfp->callbacks &&
+				hfp->callbacks->call_status_updated)
+				hfp->callbacks->call_status_updated(call->id,
+							call->status,
+							hfp->callbacks_data);
+			return;
+		}
+
+		id = next_call_index(hfp);
+		if (id == 0) {
+			DBG(hfp, "hf: No new call index available");
+			return;
+		}
+		call_new(hfp, id, status, NULL);
+		break;
+	}
 }
 
 static void ciev_callheld_cb(uint8_t val, void *user_data)
@@ -1733,7 +1880,45 @@ static void cops_cb(struct hfp_context *context, void *user_data)
 		hfp->callbacks->update_operator(name, hfp->callbacks_data);
 }
 
-static void cops_resp(enum hfp_result result, enum hfp_error cme_err,
+static void clip_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	char number[255];
+	unsigned int type;
+	struct hf_call *call;
+
+	DBG(hfp, "");
+
+	if (!hfp_context_get_string(context, number, sizeof(number))) {
+		DBG(hfp, "hf: Could not get string");
+		return;
+	}
+
+	if (!hfp_context_get_number(context, &type))
+		return;
+
+	call = queue_find(hfp->calls, call_incoming_match, NULL);
+	if (!call) {
+		DBG(hfp, "hf: no incoming call");
+		return;
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
+		hfp->callbacks->call_line_id_updated(call->id, call->line_id,
+							call->type,
+							hfp->callbacks_data);
+}
+
+static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -1741,7 +1926,7 @@ static void cops_resp(enum hfp_result result, enum hfp_error cme_err,
 	DBG(hfp, "");
 
 	if (result != HFP_RESULT_OK) {
-		DBG(hfp, "hf: COPS? error: %d", result);
+		DBG(hfp, "hf: CLIP error: %d", result);
 		goto failed;
 	}
 
@@ -1757,6 +1942,34 @@ failed:
 						hfp->callbacks_data);
 }
 
+static void cops_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "");
+
+	if (result != HFP_RESULT_OK) {
+		DBG(hfp, "hf: COPS? error: %d", result);
+		goto failed;
+	}
+
+	/* SLC creation done, continue with default setup */
+	if (!hfp_hf_send_command(hfp, clip_resp, hfp,
+		"AT+CLIP=1")) {
+		DBG(hfp, "hf: Could not send AT+CLIP=1");
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
 static void cops_conf_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
@@ -1807,6 +2020,7 @@ static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
 
 	/* Register unsolicited results handlers */
 	hfp_hf_register(hfp, ciev_cb, "+CIEV", hfp, NULL);
+	hfp_hf_register(hfp, clip_cb, "+CLIP", hfp, NULL);
 	hfp_hf_register(hfp, cops_cb, "+COPS", hfp, NULL);
 
 	return;
@@ -2135,3 +2349,21 @@ bool hfp_hf_session(struct hfp_hf *hfp)
 	return hfp_hf_send_command(hfp, slc_brsf_resp, hfp,
 					"AT+BRSF=%u", HFP_HF_FEATURES);
 }
+
+const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id)
+{
+	struct hf_call *call;
+
+	DBG(hfp, "");
+
+	if (!hfp)
+		return false;
+
+	call = queue_find(hfp->calls, call_id_match, UINT_TO_PTR(id));
+	if (!call) {
+		DBG(hfp, "hf: no call with id: %u", id);
+		return false;
+	}
+
+	return call->line_id;
+}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 27f6d2d7c..fec63c150 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -114,6 +114,16 @@ enum hfp_call_held {
 	CIND_CALLHELD_HOLD
 };
 
+enum hfp_call_status {
+	CALL_STATUS_ACTIVE = 0,
+	CALL_STATUS_HELD,
+	CALL_STATUS_DIALING,
+	CALL_STATUS_ALERTING,
+	CALL_STATUS_INCOMING,
+	CALL_STATUS_WAITING,
+	CALL_STATUS_RESPONSE_AND_HOLD
+};
+
 struct hfp_context;
 
 typedef void (*hfp_result_func_t)(struct hfp_context *context,
@@ -191,6 +201,14 @@ struct hfp_hf_callbacks {
 	void (*update_indicator)(enum hfp_indicator indicator, uint32_t val,
 							void *user_data);
 	void (*update_operator)(const char *operator_name, void *user_data);
+
+	void (*call_added)(uint id, enum hfp_call_status status,
+							void *user_data);
+	void (*call_removed)(uint id, void *user_data);
+	void (*call_status_updated)(uint id, enum hfp_call_status status,
+							void *user_data);
+	void (*call_line_id_updated)(uint id, const char *number, uint type,
+							void *user_data);
 };
 
 struct hfp_hf *hfp_hf_new(int fd);
@@ -216,3 +234,5 @@ bool hfp_hf_session_register(struct hfp_hf *hfp,
 				struct hfp_hf_callbacks *callbacks,
 				void *callbacks_data);
 bool hfp_hf_session(struct hfp_hf *hfp);
+
+const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id);
-- 
2.43.0

