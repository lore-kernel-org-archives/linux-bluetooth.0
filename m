Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA826A0E0
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422788; cv=none; b=fRlyhxp8KixOFbQgiqqMJheOydwdZXBV4EJ0w+qsyENL5IKefjGKapRPt8jLGDAiuslL84T7XpmPpU+fdZ2x3laABPjXz7PHC1JyFqIg5nU7tjGscWApvgiNpfQ0kS2yHoB0N9YpKMy3w/0V3XGE4gSh08/WT93DZJPBGGqJ4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422788; c=relaxed/simple;
	bh=UqmFz/1gRs/5ETuF6br72EnGCYobu9fxefjr6s8IPIU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7nDhsQ8WetVDMztuX0z4fwtvYew32rTtOceAQpWSZ/WwaIZIYlArXb2OR4SB/t+tAP+D5q2lpfKBrkaiffRGM9v9vrBoq/1DsKe9tGRHen0RAH/c13OTbh4ZFXdDlLSlItGdEx1o7gmWjlyawRmLjRfSVNQttt2H1+vb0NL/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O1QR+OOX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O1QR+OOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748422778;
	bh=UqmFz/1gRs/5ETuF6br72EnGCYobu9fxefjr6s8IPIU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O1QR+OOX5BV2TV0cPYUFvub6jpGRynqX5luYM2iQTTCDLQS7QFopqQs+gjm9sHlcv
	 H2k9sJVUwuuNcr2zUn9A+UuJnam54p9oCk0iBHdgnY+ESAOZSDKN/SyafOyk9Hb66F
	 +EwgwwQm5n8tjbUuP6eImEkLEaeuPRPfVpsq3/uUDyfBsuhfodyjTF8uRjO5CY6k1F
	 MXbI3bobkhyYxU8u4itM2Q/kag8obip7bWGL750kcJSAIzKJ55+yRRPAnyFJwiAS2D
	 t8hqrsIudOk+0XNEv22+88U1oEkOKJ1qRaUT4LvO35CIKZSactTKyt23g3t5z7uRwI
	 iVZzzgbiEthhw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-AF44-1001-C79a-7427-1C18-f6a9.rev.sfr.net [IPv6:2a02:8428:af44:1001:c79a:7427:1c18:f6a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CCC9D17E378F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 10:59:37 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 04/10] audio/hfp-hf: Add HFP SLC connection and event support
Date: Wed, 28 May 2025 10:59:24 +0200
Message-ID: <20250528085930.227816-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528085930.227816-1-frederic.danis@collabora.com>
References: <20250528085930.227816-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 profiles/audio/hfp-hf.c | 904 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 904 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index aa74cd515..5068fff01 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -40,19 +40,114 @@
 #include "src/plugin.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/shared/hfp.h"
 
 #include "telephony.h"
 
+#define CALL_IND_NO_CALL_IN_PROGRESS	0x00
+#define CALL_IND_CALL_IN_PROGRESS	0x01
+
+#define CHLD_FEAT_REL		0x00000001
+#define CHLD_FEAT_REL_ACC	0x00000002
+#define CHLD_FEAT_REL_X		0x00000004
+#define CHLD_FEAT_HOLD_ACC	0x00000008
+#define CHLD_FEAT_PRIV_X	0x00000010
+#define CHLD_FEAT_MERGE		0x00000020
+#define CHLD_FEAT_MERGE_DETACH	0x00000040
+
+#define HFP_HF_FEAT_ECNR				0x00000001
+#define HFP_HF_FEAT_3WAY				0x00000002
+#define HFP_HF_FEAT_CLIP				0x00000004
+#define HFP_HF_FEAT_VOICE_RECOGNITION			0x00000008
+#define HFP_HF_FEAT_REMOTE_VOLUME_CONTROL		0x00000010
+#define HFP_HF_FEAT_ENHANCED_CALL_STATUS		0x00000020
+#define HFP_HF_FEAT_ENHANCED_CALL_CONTROL		0x00000040
+#define HFP_HF_FEAT_CODEC_NEGOTIATION			0x00000080
+#define HFP_HF_FEAT_HF_INDICATORS			0x00000100
+#define HFP_HF_FEAT_ESCO_S4_T2				0x00000200
+#define HFP_HF_FEAT_ENHANCED_VOICE_RECOGNITION_STATUS	0x00000400
+#define HFP_HF_FEAT_VOICE_RECOGNITION_TEXT		0x00000800
+
+#define HFP_AG_FEAT_3WAY				0x00000001
+#define HFP_AG_FEAT_ECNR				0x00000002
+#define HFP_AG_FEAT_VOICE_RECOGNITION			0x00000004
+#define HFP_AG_FEAT_IN_BAND_RING_TONE			0x00000008
+#define HFP_AG_FEAT_ATTACH_VOICE_TAG			0x00000010
+#define HFP_AG_FEAT_REJECT_CALL				0x00000020
+#define HFP_AG_FEAT_ENHANCED_CALL_STATUS		0x00000040
+#define HFP_AG_FEAT_ENHANCED_CALL_CONTROL		0x00000080
+#define HFP_AG_FEAT_EXTENDED_RES_CODE			0x00000100
+#define HFP_AG_FEAT_CODEC_NEGOTIATION			0x00000200
+#define HFP_AG_FEAT_HF_INDICATORS			0x00000400
+#define HFP_AG_FEAT_ESCO_S4_T2				0x00000800
+#define HFP_AG_FEAT_ENHANCED_VOICE_RECOGNITION_STATUS	0x00001000
+#define HFP_AG_FEAT_VOICE_RECOGNITION_TEXT		0x00001000
+
+#define HFP_HF_FEATURES (HFP_HF_FEAT_ECNR | HFP_HF_FEAT_3WAY |\
+	HFP_HF_FEAT_CLIP | HFP_HF_FEAT_REMOTE_VOLUME_CONTROL |\
+	HFP_HF_FEAT_ENHANCED_CALL_STATUS | HFP_HF_FEAT_ESCO_S4_T2)
+
+enum hfp_indicator {
+	HFP_INDICATOR_SERVICE = 0,
+	HFP_INDICATOR_CALL,
+	HFP_INDICATOR_CALLSETUP,
+	HFP_INDICATOR_CALLHELD,
+	HFP_INDICATOR_SIGNAL,
+	HFP_INDICATOR_ROAM,
+	HFP_INDICATOR_BATTCHG,
+	HFP_INDICATOR_LAST
+};
+
+enum call_setup {
+	CIND_CALLSETUP_NONE = 0,
+	CIND_CALLSETUP_INCOMING,
+	CIND_CALLSETUP_DIALING,
+	CIND_CALLSETUP_ALERTING
+};
+
+enum call_held {
+	CIND_CALLHELD_NONE = 0,
+	CIND_CALLHELD_HOLD_AND_ACTIVE,
+	CIND_CALLHELD_HOLD
+};
+
+typedef void (*ciev_func_t)(uint8_t val, void *user_data);
+
+struct indicator {
+	uint8_t index;
+	uint32_t min;
+	uint32_t max;
+	uint32_t val;
+	ciev_func_t cb;
+};
+
 struct hfp_device {
 	struct telephony	*telephony;
 	uint16_t		version;
 	GIOChannel		*io;
+	enum connection_state	state;
+	uint32_t		hfp_hf_features;
+	uint32_t		features;
+	struct hfp_hf		*hf;
+	struct indicator	ag_ind[HFP_INDICATOR_LAST];
+	uint32_t		chld_features;
+	bool			call;
+	enum call_setup		call_setup;
+	enum call_held		call_held;
+	GSList			*calls;
 };
 
 static void device_destroy(struct hfp_device *dev)
 {
 	DBG("%s", telephony_get_path(dev->telephony));
 
+	telephony_set_state(dev->telephony, DISCONNECTING);
+
+	if (dev->hf) {
+		hfp_hf_unref(dev->hf);
+		dev->hf = NULL;
+	}
+
 	if (dev->io) {
 		g_io_channel_unref(dev->io);
 		dev->io = NULL;
@@ -61,6 +156,790 @@ static void device_destroy(struct hfp_device *dev)
 	telephony_unregister_interface(dev->telephony);
 }
 
+static void slc_error(struct hfp_device *dev)
+{
+	error("Could not create SLC - dropping connection");
+	hfp_hf_disconnect(dev->hf);
+}
+
+static void set_chld_feat(struct hfp_device *dev, char *feat)
+{
+	DBG(" %s", feat);
+
+	if (strcmp(feat, "0") == 0)
+		dev->chld_features |= CHLD_FEAT_REL;
+	else if (strcmp(feat, "1") == 0)
+		dev->chld_features |= CHLD_FEAT_REL_ACC;
+	else if (strcmp(feat, "1x") == 0)
+		dev->chld_features |= CHLD_FEAT_REL_X;
+	else if (strcmp(feat, "2") == 0)
+		dev->chld_features |= CHLD_FEAT_HOLD_ACC;
+	else if (strcmp(feat, "2x") == 0)
+		dev->chld_features |= CHLD_FEAT_PRIV_X;
+	else if (strcmp(feat, "3") == 0)
+		dev->chld_features |= CHLD_FEAT_MERGE;
+	else if (strcmp(feat, "4") == 0)
+		dev->chld_features |= CHLD_FEAT_MERGE_DETACH;
+}
+
+static const char *cme_error_to_string(uint8_t cme_error)
+{
+	switch (cme_error) {
+	case 0: return "AG failure";
+	case 1: return "no connection to phone";
+	case 3: return "operation not allowed";
+	case 4: return "operation not supported";
+	case 5: return "PH-SIM PIN required";
+	case 10: return "SIM not inserted";
+	case 11: return "SIM PIN required";
+	case 12: return "SIM PUK required";
+	case 13: return "SIM failure";
+	case 14: return "SIM busy";
+	case 16: return "incorrect password";
+	case 17: return "SIM PIN2 required";
+	case 18: return "SIM PUK2 required";
+	case 20: return "memory full";
+	case 21: return "invalid index";
+	case 23: return "memory failure";
+	case 24: return "text string too long";
+	case 25: return "invalid characters in text string";
+	case 26: return "dial string too long";
+	case 27: return "invalid characters in dial string";
+	case 30: return "no network service";
+	case 31: return "network Timeout";
+	case 32: return "network not allowed - Emergency calls only";
+	default: return "Unknown CME error";
+	}
+}
+
+static void cmd_complete_cb(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	DBusMessage *msg = user_data;
+	DBusMessage *reply = NULL;
+
+	DBG("%u", result);
+
+	if (msg == NULL)
+		return;
+
+	switch (result) {
+	case HFP_RESULT_OK:
+		reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+		break;
+	case HFP_RESULT_NO_CARRIER:
+		reply = btd_error_failed(msg, "no-carrier");
+		break;
+	case HFP_RESULT_ERROR:
+		reply = btd_error_failed(msg, "unknown");
+		break;
+	case HFP_RESULT_BUSY:
+		reply = btd_error_busy(msg);
+		break;
+	case HFP_RESULT_NO_ANSWER:
+		reply = btd_error_failed(msg, "no-answer");
+		break;
+	case HFP_RESULT_DELAYED:
+		reply = btd_error_failed(msg, "delayed");
+		break;
+	case HFP_RESULT_REJECTED:
+		reply = btd_error_failed(msg, "rejected");
+		break;
+	case HFP_RESULT_CME_ERROR:
+		reply = btd_error_failed(msg, cme_error_to_string(cme_err));
+		break;
+	case HFP_RESULT_CONNECT:
+	case HFP_RESULT_RING:
+	case HFP_RESULT_NO_DIALTONE:
+	default:
+		reply = btd_error_failed(msg, "unknown");
+		error("hf-client: Unknown error code %d", result);
+		break;
+	}
+
+	if (reply) {
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+		dbus_message_unref(msg);
+	}
+}
+
+static void ciev_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	unsigned int index, val;
+	int i;
+
+	DBG("");
+
+	if (!hfp_context_get_number(context, &index))
+		return;
+
+	if (!hfp_context_get_number(context, &val))
+		return;
+
+	for (i = 0; i < HFP_INDICATOR_LAST; i++) {
+		if (dev->ag_ind[i].index != index)
+			continue;
+
+		if (dev->ag_ind[i].cb) {
+			dev->ag_ind[i].val = val;
+			dev->ag_ind[i].cb(val, dev);
+			return;
+		}
+	}
+}
+
+static void slc_completed(struct hfp_device *dev)
+{
+	int i;
+	struct indicator *ag_ind;
+
+	DBG("");
+
+	ag_ind = dev->ag_ind;
+
+	telephony_set_state(dev->telephony, CONNECTED);
+
+	/* Notify Android with indicators */
+	for (i = 0; i < HFP_INDICATOR_LAST; i++) {
+		if (!ag_ind[i].cb)
+			continue;
+
+		ag_ind[i].cb(ag_ind[i].val, dev);
+	}
+
+	/* TODO: register unsolicited results handlers */
+
+	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
+
+	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS=3,0"))
+		info("hf-client: Could not send AT+COPS=3,0");
+}
+
+static void slc_chld_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	hfp_hf_unregister(dev->hf, "+CHLD");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CHLD error: %d", result);
+		slc_error(dev);
+		return;
+	}
+
+	slc_completed(dev);
+}
+
+static void slc_chld_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	char feat[3];
+
+	if (!hfp_context_open_container(context))
+		goto failed;
+
+	while (hfp_context_get_unquoted_string(context, feat, sizeof(feat)))
+		set_chld_feat(dev, feat);
+
+	if (!hfp_context_close_container(context))
+		goto failed;
+
+	return;
+
+failed:
+	error("hf-client: Error on CHLD response");
+	slc_error(dev);
+}
+
+static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CMER error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (!(dev->features & HFP_AG_FEAT_3WAY)) {
+		slc_completed(dev);
+		return;
+	}
+
+	if (!hfp_hf_register(dev->hf, slc_chld_cb, "+CHLD", dev, NULL)) {
+		error("hf-client: Could not register +CHLD");
+		goto failed;
+	}
+
+	if (!hfp_hf_send_command(dev->hf, slc_chld_resp, dev, "AT+CHLD=?")) {
+		error("hf-client: Could not send AT+CHLD");
+		goto failed;
+	}
+
+	return;
+
+failed:
+	slc_error(dev);
+}
+
+static void slc_cind_status_resp(enum hfp_result result,
+	enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	hfp_hf_unregister(dev->hf, "+CIND");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CIND error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (!hfp_hf_send_command(dev->hf, slc_cmer_resp, dev,
+		"AT+CMER=3,0,0,1")) {
+		error("hf-client: Counld not send AT+CMER");
+		goto failed;
+	}
+
+	return;
+
+failed:
+	slc_error(dev);
+}
+
+static void set_indicator_value(uint8_t index, unsigned int val,
+	struct indicator *ag_ind, struct hfp_device *dev)
+{
+	int i;
+
+	for (i = 0; i < HFP_INDICATOR_LAST; i++) {
+		if (index != ag_ind[i].index)
+			continue;
+
+		ag_ind[i].val = val;
+		ag_ind[i].cb(val, dev);
+		return;
+	}
+}
+
+static void slc_cind_status_cb(struct hfp_context *context,
+	void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	uint8_t index = 1;
+
+	DBG("");
+
+	while (hfp_context_has_next(context)) {
+		uint32_t val;
+
+		if (!hfp_context_get_number(context, &val)) {
+			error("hf-client: Error on CIND status response");
+			return;
+		}
+
+		set_indicator_value(index++, val, dev->ag_ind, dev);
+	}
+}
+
+static void slc_cind_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	hfp_hf_unregister(dev->hf, "+CIND");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CIND error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (!hfp_hf_register(dev->hf, slc_cind_status_cb, "+CIND", dev,
+			NULL)) {
+		error("hf-client: Counld not register +CIND");
+		goto failed;
+	}
+
+	if (!hfp_hf_send_command(dev->hf, slc_cind_status_resp, dev,
+			"AT+CIND?")) {
+		error("hf-client: Counld not send AT+CIND?");
+		goto failed;
+	}
+
+	return;
+
+failed:
+	slc_error(dev);
+}
+
+static void ciev_service_cb(uint8_t val, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (val > 1) {
+		error("hf-client: Incorrect state %u:", val);
+		return;
+	}
+
+	telephony_set_network_service(dev->telephony, val);
+}
+
+static void activate_calls(gpointer data, gpointer user_data)
+{
+	struct call *call = data;
+
+	if (call->state == CALL_STATE_DIALING ||
+			call->state == CALL_STATE_ALERTING ||
+			call->state == CALL_STATE_INCOMING)
+		telephony_set_call_state(call, CALL_STATE_ACTIVE);
+}
+
+static void deactivate_active_calls(gpointer data, gpointer user_data)
+{
+	struct call *call = data;
+	struct hfp_device *dev = user_data;
+
+	if (call->state == CALL_STATE_ACTIVE) {
+		telephony_set_call_state(call, CALL_STATE_DISCONNECTED);
+		dev->calls = g_slist_remove(dev->calls, call);
+		telephony_call_unregister_interface(call);
+	}
+}
+
+static void ciev_call_cb(uint8_t val, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (val > CALL_IND_CALL_IN_PROGRESS) {
+		error("hf-client: Incorrect call state %u:", val);
+		return;
+	}
+
+	if (dev->call == val)
+		return;
+
+	dev->call = !!val;
+
+	if (dev->call == TRUE)
+		g_slist_foreach(dev->calls, activate_calls, dev);
+	else
+		g_slist_foreach(dev->calls, deactivate_active_calls, dev);
+}
+
+static void callsetup_deactivate(gpointer data, gpointer user_data)
+{
+	struct call *call = data;
+	struct hfp_device *dev = user_data;
+
+	if (call->state == CALL_STATE_DIALING ||
+			call->state == CALL_STATE_ALERTING ||
+			call->state == CALL_STATE_INCOMING ||
+			call->state == CALL_STATE_WAITING) {
+		telephony_set_call_state(call, CALL_STATE_DISCONNECTED);
+		dev->calls = g_slist_remove(dev->calls, call);
+		telephony_call_unregister_interface(call);
+	}
+}
+
+static void callsetup_alerting(gpointer data, gpointer user_data)
+{
+	struct call *call = data;
+
+	if (call->state == CALL_STATE_DIALING)
+		telephony_set_call_state(call, CALL_STATE_ALERTING);
+}
+
+static void ciev_callsetup_cb(uint8_t val, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (val > CIND_CALLSETUP_ALERTING) {
+		error("hf-client: Incorrect call setup state %u:", val);
+		return;
+	}
+
+	if (dev->call_setup == val)
+		return;
+
+	dev->call_setup = val;
+
+	if (dev->call_setup == CIND_CALLSETUP_NONE) {
+		g_slist_foreach(dev->calls, callsetup_deactivate, dev);
+	} else if (dev->call_setup == CIND_CALLSETUP_INCOMING) {
+		bool found = FALSE;
+		GSList *l;
+
+		for (l = dev->calls; l; l = l->next) {
+			struct call *call = l->data;
+
+			if (call->state == CALL_STATE_INCOMING ||
+				call->state == CALL_STATE_WAITING) {
+				DBG("incoming call already in progress (%d)",
+								 call->state);
+				found = TRUE;
+				break;
+			}
+		}
+
+		if (!found) {
+			struct call *call;
+
+			call = telephony_new_call(dev->telephony,
+							CALL_STATE_INCOMING,
+							NULL);
+			if (telephony_call_register_interface(call)) {
+				telephony_free_call(call);
+				return;
+			}
+			dev->calls = g_slist_append(dev->calls, call);
+		}
+	} else if (dev->call_setup == CIND_CALLSETUP_DIALING) {
+		bool found = FALSE;
+		GSList *l;
+
+		for (l = dev->calls; l; l = l->next) {
+			struct call *call = l->data;
+
+			if (call->state == CALL_STATE_DIALING ||
+				call->state == CALL_STATE_ALERTING) {
+				DBG("dialing call already in progress (%d)",
+								call->state);
+				found = TRUE;
+				break;
+			}
+		}
+
+		if (!found) {
+			struct call *call;
+
+			call = telephony_new_call(dev->telephony,
+							CALL_STATE_DIALING,
+							NULL);
+			if (telephony_call_register_interface(call)) {
+				telephony_free_call(call);
+				return;
+			}
+			dev->calls = g_slist_append(dev->calls, call);
+		}
+	} else if (dev->call_setup == CIND_CALLSETUP_ALERTING) {
+		g_slist_foreach(dev->calls, callsetup_alerting, dev);
+	}
+}
+
+static void ciev_callheld_cb(uint8_t val, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (val > CIND_CALLHELD_HOLD) {
+		error("hf-client: Incorrect call held state %u:", val);
+		return;
+	}
+
+	dev->call_held = val;
+
+	if (dev->call_held == CIND_CALLHELD_NONE) {
+		GSList *l;
+		bool found_waiting = FALSE;
+
+		for (l = dev->calls; l; l = l->next) {
+			struct call *call = l->data;
+
+			if (call->state != CALL_STATE_WAITING)
+				continue;
+
+			telephony_set_call_state(call,
+					CALL_STATE_DISCONNECTED);
+			found_waiting = TRUE;
+			dev->calls = g_slist_remove(dev->calls, call);
+			telephony_call_unregister_interface(call);
+		}
+
+		if (!found_waiting) {
+			for (l = dev->calls; l; l = l->next) {
+				struct call *call = l->data;
+
+				if (call->state != CALL_STATE_HELD)
+					continue;
+
+				telephony_set_call_state(call,
+						CALL_STATE_DISCONNECTED);
+				dev->calls = g_slist_remove(dev->calls, call);
+				telephony_call_unregister_interface(call);
+		}
+		}
+	} else if (dev->call_held == CIND_CALLHELD_HOLD_AND_ACTIVE) {
+		GSList *l;
+
+		for (l = dev->calls; l; l = l->next) {
+			struct call *call = l->data;
+
+			if (call->state == CALL_STATE_ACTIVE)
+				telephony_set_call_state(call,
+							CALL_STATE_HELD);
+			else if (call->state == CALL_STATE_HELD)
+				telephony_set_call_state(call,
+							CALL_STATE_ACTIVE);
+		}
+	} else if (dev->call_held == CIND_CALLHELD_HOLD) {
+		GSList *l;
+
+		for (l = dev->calls; l; l = l->next) {
+			struct call *call = l->data;
+
+			if (call->state == CALL_STATE_ACTIVE ||
+					call->state == CALL_STATE_WAITING)
+				telephony_set_call_state(call, CALL_STATE_HELD);
+		}
+	}
+}
+
+static void ciev_signal_cb(uint8_t val, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (val > 5) {
+		error("hf-client: Incorrect signal value %u:", val);
+		return;
+	}
+
+	telephony_set_signal(dev->telephony, val);
+}
+
+static void ciev_roam_cb(uint8_t val, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (val > 1) {
+		error("hf-client: Incorrect roaming state %u:", val);
+		return;
+	}
+
+	telephony_set_roaming(dev->telephony, val);
+}
+
+static void ciev_battchg_cb(uint8_t val, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (val > 5) {
+		error("hf-client: Incorrect battery charge value %u:", val);
+		return;
+	}
+
+	telephony_set_battchg(dev->telephony, val);
+}
+
+static void set_indicator_parameters(uint8_t index, const char *indicator,
+	unsigned int min,
+	unsigned int max,
+	struct indicator *ag_ind)
+{
+	DBG("%s, %i", indicator, index);
+
+	/* TODO: Verify min/max values ? */
+
+	if (strcmp("service", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_SERVICE].index = index;
+		ag_ind[HFP_INDICATOR_SERVICE].min = min;
+		ag_ind[HFP_INDICATOR_SERVICE].max = max;
+		ag_ind[HFP_INDICATOR_SERVICE].cb = ciev_service_cb;
+		return;
+	}
+
+	if (strcmp("call", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_CALL].index = index;
+		ag_ind[HFP_INDICATOR_CALL].min = min;
+		ag_ind[HFP_INDICATOR_CALL].max = max;
+		ag_ind[HFP_INDICATOR_CALL].cb = ciev_call_cb;
+		return;
+	}
+
+	if (strcmp("callsetup", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_CALLSETUP].index = index;
+		ag_ind[HFP_INDICATOR_CALLSETUP].min = min;
+		ag_ind[HFP_INDICATOR_CALLSETUP].max = max;
+		ag_ind[HFP_INDICATOR_CALLSETUP].cb = ciev_callsetup_cb;
+		return;
+	}
+
+	if (strcmp("callheld", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_CALLHELD].index = index;
+		ag_ind[HFP_INDICATOR_CALLHELD].min = min;
+		ag_ind[HFP_INDICATOR_CALLHELD].max = max;
+		ag_ind[HFP_INDICATOR_CALLHELD].cb = ciev_callheld_cb;
+		return;
+	}
+
+	if (strcmp("signal", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_SIGNAL].index = index;
+		ag_ind[HFP_INDICATOR_SIGNAL].min = min;
+		ag_ind[HFP_INDICATOR_SIGNAL].max = max;
+		ag_ind[HFP_INDICATOR_SIGNAL].cb = ciev_signal_cb;
+		return;
+	}
+
+	if (strcmp("roam", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_ROAM].index = index;
+		ag_ind[HFP_INDICATOR_ROAM].min = min;
+		ag_ind[HFP_INDICATOR_ROAM].max = max;
+		ag_ind[HFP_INDICATOR_ROAM].cb = ciev_roam_cb;
+		return;
+	}
+
+	if (strcmp("battchg", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_BATTCHG].index = index;
+		ag_ind[HFP_INDICATOR_BATTCHG].min = min;
+		ag_ind[HFP_INDICATOR_BATTCHG].max = max;
+		ag_ind[HFP_INDICATOR_BATTCHG].cb = ciev_battchg_cb;
+		return;
+	}
+
+	error("hf-client: Unknown indicator: %s", indicator);
+}
+
+static void slc_cind_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	int index = 1;
+
+	DBG("");
+
+	while (hfp_context_has_next(context)) {
+		char name[255];
+		unsigned int min, max;
+
+		/* e.g ("callsetup",(0-3)) */
+		if (!hfp_context_open_container(context))
+			break;
+
+		if (!hfp_context_get_string(context, name, sizeof(name))) {
+			error("hf-client: Could not get string");
+			goto failed;
+		}
+
+		if (!hfp_context_open_container(context)) {
+			error("hf-client: Could not open container");
+			goto failed;
+		}
+
+		if (!hfp_context_get_range(context, &min, &max)) {
+			if (!hfp_context_get_number(context, &min)) {
+				error("hf-client: Could not get number");
+				goto failed;
+			}
+
+			if (!hfp_context_get_number(context, &max)) {
+				error("hf-client: Could not get number");
+				goto failed;
+			}
+		}
+
+		if (!hfp_context_close_container(context)) {
+			error("hf-client: Could not close container");
+			goto failed;
+		}
+
+		if (!hfp_context_close_container(context)) {
+			error("hf-client: Could not close container");
+			goto failed;
+		}
+
+		set_indicator_parameters(index, name, min, max, dev->ag_ind);
+		index++;
+	}
+
+	return;
+
+failed:
+	error("hf-client: Error on CIND response");
+	slc_error(dev);
+}
+
+static void slc_brsf_cb(struct hfp_context *context, void *user_data)
+{
+	unsigned int feat;
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (hfp_context_get_number(context, &feat))
+		dev->features = feat;
+}
+
+static void slc_brsf_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	hfp_hf_unregister(dev->hf, "+BRSF");
+
+	if (result != HFP_RESULT_OK) {
+		error("BRSF error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (!hfp_hf_register(dev->hf, slc_cind_cb, "+CIND", dev, NULL)) {
+		error("hf-client: Could not register for +CIND");
+		goto failed;
+	}
+
+	if (!hfp_hf_send_command(dev->hf, slc_cind_resp, dev, "AT+CIND=?")) {
+		error("hf-client: Could not send AT+CIND command");
+		goto failed;
+	}
+
+	return;
+
+failed:
+	slc_error(dev);
+}
+
+static bool create_slc(struct hfp_device *dev)
+{
+	DBG("");
+
+	if (!hfp_hf_register(dev->hf, slc_brsf_cb, "+BRSF", dev, NULL))
+		return false;
+
+	return hfp_hf_send_command(dev->hf, slc_brsf_resp, dev, "AT+BRSF=%u",
+							dev->hfp_hf_features);
+}
+
+static void hfp_disconnect_watch(void *user_data)
+{
+	DBG("");
+
+	device_destroy(user_data);
+}
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct hfp_device *dev = user_data;
@@ -73,8 +952,25 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
+	dev->hf = hfp_hf_new(g_io_channel_unix_get_fd(chan));
+	if (!dev->hf) {
+		error("Could not create hfp io");
+		goto failed;
+	}
+
 	g_io_channel_set_close_on_unref(chan, FALSE);
 
+	hfp_hf_set_close_on_unref(dev->hf, true);
+	hfp_hf_set_disconnect_handler(dev->hf, hfp_disconnect_watch,
+					dev, NULL);
+
+	if (!create_slc(dev)) {
+		error("Could not start SLC creation");
+		hfp_hf_disconnect(dev->hf);
+		goto failed;
+	}
+
+	telephony_set_state(dev->telephony, SLC_CONNECTING);
 	btd_service_connecting_complete(service, 0);
 
 	return;
@@ -146,8 +1042,15 @@ static int hfp_connect(struct btd_service *service)
 
 static int hfp_disconnect(struct btd_service *service)
 {
+	struct hfp_device *dev;
+
 	DBG("");
 
+	dev = btd_service_get_user_data(service);
+
+	if (dev->hf)
+		hfp_hf_disconnect(dev->hf);
+
 	btd_service_disconnecting_complete(service, 0);
 
 	return 0;
@@ -166,6 +1069,7 @@ static int hfp_probe(struct btd_service *service)
 		return -EINVAL;
 
 	dev->telephony = telephony_new(service, dev, &hfp_callbacks);
+	dev->hfp_hf_features = HFP_HF_FEATURES;
 	btd_service_set_user_data(service, dev);
 
 	return 0;
-- 
2.43.0

