Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E82F0E54
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167927; cv=none; b=SeklyPbjv9YeKhNacit1rmaTR9DiOgnExRdwjRoeq6xiGviNO18cipAMXklPATZFobDeoViNKZbddPha+5hCxMRf10t+TaPckEhUGTyi77Rj+9dXOfZjIz1+fiPbpO5FiAwTi4v5m7ldriUR1FT/foCcI0/dQW6Q+PfPgpVfcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167927; c=relaxed/simple;
	bh=7jq1glaS2G52Wp6aYGb8GLQZ/dN70OWScD0UlZBfDZs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oFlAiJzQtPM/P5JFHsW5VaImOrR+1CqF/WFkzcAbfDzkNorLA9vmm/ibB/6A6wzdWLkdXOSBx3bqw81bsn6mSaFr+cgXSsq830Wvfx24KZ5B8CNTRIE3rQCw2t/CQuEVP0kGe73pWqO0+Elsht9SYvrZhy1jZX86GK44hRgnFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GsPhHRuU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GsPhHRuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752167922;
	bh=7jq1glaS2G52Wp6aYGb8GLQZ/dN70OWScD0UlZBfDZs=;
	h=From:To:Subject:Date:From;
	b=GsPhHRuUsIMlGgQbRhqppO0yHSIv9fZpAA5ZuKUhSwbZdfkQy06J1PrzAawExafNF
	 1Pla9O7l94oZKNEza++JeuRaIneImGsEe3r/zx7IdSP8AkaSuGFIo4B7zJq3fNFulf
	 LBXt5CsF8/cmI2Up3r8EP6ufDL1EopbCb3xLcWB1zxiDw/xUSVEaWGab1bNcF8INYB
	 S4yaCkg5CdudjrrIgYrUmU0nnmB3YK+EcVdNPIhRPKCtY5I0FaRFQ7xzcqcxOK1vXo
	 tKEPr/JFwLBaedGv0dfSSKfGtiCEyvaWB+TofDOc5dwcIStl1lyCmVBei9m7FD2726
	 5zVgE1KacduoQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-Af44-1001-9be2-7429-4d2E-B935.rev.sfr.net [IPv6:2a02:8428:af44:1001:9be2:7429:4d2e:b935])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C50F417E0202
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 19:18:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/hfp: Add HF SLC connection function
Date: Thu, 10 Jul 2025 19:18:35 +0200
Message-ID: <20250710171838.949803-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This implements the minimal SLC connection exchange, i.e. AT+BRSF,
AT+CIND=?, AT+CIND? and AT+CMER=3,0,0,1 requested to complete the
Service Level Connection Establishment.
---
 src/shared/hfp.c | 508 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  69 +++++++
 2 files changed, 577 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index df6eab35d..c1bcb61cf 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -25,6 +25,12 @@
 #include "src/shared/io.h"
 #include "src/shared/hfp.h"
 
+#define DBG(_hfp, fmt, arg...) \
+	hfp_debug(_hfp->debug_callback, _hfp->debug_data, "%s:%s() " fmt, \
+						__FILE__, __func__, ## arg)
+
+#define HFP_HF_FEATURES	(HFP_HF_FEAT_ESCO_S4_T2)
+
 struct hfp_gw {
 	int ref_count;
 	int fd;
@@ -50,6 +56,16 @@ struct hfp_gw {
 	bool destroyed;
 };
 
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
 struct hfp_hf {
 	int ref_count;
 	int fd;
@@ -73,6 +89,17 @@ struct hfp_hf {
 
 	bool in_disconnect;
 	bool destroyed;
+
+	struct hfp_hf_callbacks *callbacks;
+	void *callbacks_data;
+
+	uint32_t features;
+	struct indicator ag_ind[HFP_INDICATOR_LAST];
+	bool service;
+	uint8_t signal;
+	bool roaming;
+	uint8_t battchg;
+
 };
 
 struct cmd_handler {
@@ -101,6 +128,19 @@ struct event_handler {
 	hfp_hf_result_func_t callback;
 };
 
+static void hfp_debug(hfp_debug_func_t debug_func, void *debug_data,
+						const char *format, ...)
+{
+	va_list ap;
+
+	if (!debug_func || !format)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(debug_func, debug_data, format, ap);
+	va_end(ap);
+}
+
 static void destroy_cmd_handler(void *data)
 {
 	struct cmd_handler *handler = data;
@@ -1527,3 +1567,471 @@ bool hfp_hf_disconnect(struct hfp_hf *hfp)
 
 	return io_shutdown(hfp->io);
 }
+
+static void ciev_service_cb(uint8_t val, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "%u", val);
+
+	if (val < hfp->ag_ind[HFP_INDICATOR_SERVICE].min ||
+			val > hfp->ag_ind[HFP_INDICATOR_SERVICE].max) {
+		DBG(hfp, "hf: Incorrect state %u:", val);
+		return;
+	}
+
+	hfp->service = val;
+	if (hfp->callbacks && hfp->callbacks->update_indicator)
+		hfp->callbacks->update_indicator(HFP_INDICATOR_SERVICE, val,
+							hfp->callbacks_data);
+}
+
+static void ciev_call_cb(uint8_t val, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "%u", val);
+
+	if (val < hfp->ag_ind[HFP_INDICATOR_CALL].min ||
+			val > hfp->ag_ind[HFP_INDICATOR_CALL].max) {
+		DBG(hfp, "hf: Incorrect call state %u:", val);
+		return;
+	}
+}
+
+static void ciev_callsetup_cb(uint8_t val, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "%u", val);
+
+	if (val < hfp->ag_ind[HFP_INDICATOR_CALLSETUP].min ||
+			val > hfp->ag_ind[HFP_INDICATOR_CALLSETUP].max) {
+		DBG(hfp, "hf: Incorrect call setup state %u:", val);
+		return;
+	}
+}
+
+static void ciev_callheld_cb(uint8_t val, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "%u", val);
+
+	if (val < hfp->ag_ind[HFP_INDICATOR_CALLHELD].min ||
+			val > hfp->ag_ind[HFP_INDICATOR_CALLHELD].max) {
+		DBG(hfp, "hf: Incorrect call held state %u:", val);
+		return;
+	}
+}
+
+static void ciev_signal_cb(uint8_t val, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "%u", val);
+
+	if (val < hfp->ag_ind[HFP_INDICATOR_SIGNAL].min ||
+			val > hfp->ag_ind[HFP_INDICATOR_SIGNAL].max) {
+		DBG(hfp, "hf: Incorrect signal value %u:", val);
+		return;
+	}
+
+	hfp->signal = val;
+	if (hfp->callbacks && hfp->callbacks->update_indicator)
+		hfp->callbacks->update_indicator(HFP_INDICATOR_SIGNAL, val,
+							hfp->callbacks_data);
+}
+
+static void ciev_roam_cb(uint8_t val, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "%u", val);
+
+	if (val < hfp->ag_ind[HFP_INDICATOR_ROAM].min ||
+			val > hfp->ag_ind[HFP_INDICATOR_ROAM].max) {
+		DBG(hfp, "hf: Incorrect roaming state %u:", val);
+		return;
+	}
+
+	hfp->roaming = val;
+	if (hfp->callbacks && hfp->callbacks->update_indicator)
+		hfp->callbacks->update_indicator(HFP_INDICATOR_ROAM, val,
+							hfp->callbacks_data);
+}
+
+static void ciev_battchg_cb(uint8_t val, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "%u", val);
+
+	if (val < hfp->ag_ind[HFP_INDICATOR_BATTCHG].min ||
+			val > hfp->ag_ind[HFP_INDICATOR_BATTCHG].max) {
+		DBG(hfp, "hf: Incorrect battery charge value %u:", val);
+		return;
+	}
+
+	hfp->battchg = val;
+	if (hfp->callbacks && hfp->callbacks->update_indicator)
+		hfp->callbacks->update_indicator(HFP_INDICATOR_BATTCHG, val,
+							hfp->callbacks_data);
+}
+
+static void set_indicator_value(uint8_t index, unsigned int val,
+	struct indicator *ag_ind, struct hfp_hf *hfp)
+{
+	int i;
+
+	for (i = 0; i < HFP_INDICATOR_LAST; i++) {
+		if (index != ag_ind[i].index)
+			continue;
+
+		ag_ind[i].val = val;
+		ag_ind[i].cb(val, hfp);
+		return;
+	}
+}
+
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
+	if (hfp->callbacks->session_ready)
+		hfp->callbacks->session_ready(HFP_RESULT_OK, 0,
+						hfp->callbacks_data);
+	return;
+
+failed:
+	if (hfp->callbacks->session_ready)
+		hfp->callbacks->session_ready(result, cme_err,
+						hfp->callbacks_data);
+}
+
+static void slc_cind_status_cb(struct hfp_context *context,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	uint8_t index = 1;
+
+	while (hfp_context_has_next(context)) {
+		uint32_t val;
+
+		if (!hfp_context_get_number(context, &val)) {
+			DBG(hfp, "hf: Error on CIND status response");
+			return;
+		}
+
+		set_indicator_value(index++, val, hfp->ag_ind, hfp);
+	}
+}
+
+static void slc_cind_status_resp(enum hfp_result result,
+	enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "");
+
+	hfp_hf_unregister(hfp, "+CIND");
+
+	if (result != HFP_RESULT_OK) {
+		DBG(hfp, "hf: CIND error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (!hfp_hf_send_command(hfp, slc_cmer_resp, hfp,
+		"AT+CMER=3,0,0,1")) {
+		DBG(hfp, "hf: Could not send AT+CMER");
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
+static void set_indicator_parameters(struct hfp_hf *hfp, uint8_t index,
+	const char *indicator,
+	unsigned int min,
+	unsigned int max)
+{
+	struct indicator *ag_ind = hfp->ag_ind;
+
+	DBG(hfp, "%s, %i", indicator, index);
+
+	if (strcmp("service", indicator) == 0) {
+		if (min != 0 || max != 1) {
+			DBG(hfp, "hf: Invalid min/max values for service,"
+				" expected (0,1) got (%u,%u)", min, max);
+			return;
+		}
+		ag_ind[HFP_INDICATOR_SERVICE].index = index;
+		ag_ind[HFP_INDICATOR_SERVICE].min = min;
+		ag_ind[HFP_INDICATOR_SERVICE].max = max;
+		ag_ind[HFP_INDICATOR_SERVICE].cb = ciev_service_cb;
+		return;
+	}
+
+	if (strcmp("call", indicator) == 0) {
+		if (min != 0 || max != 1) {
+			DBG(hfp, "hf: Invalid min/max values for call,"
+				" expected (0,1) got (%u,%u)", min, max);
+			return;
+		}
+		ag_ind[HFP_INDICATOR_CALL].index = index;
+		ag_ind[HFP_INDICATOR_CALL].min = min;
+		ag_ind[HFP_INDICATOR_CALL].max = max;
+		ag_ind[HFP_INDICATOR_CALL].cb = ciev_call_cb;
+		return;
+	}
+
+	if (strcmp("callsetup", indicator) == 0) {
+		if (min != 0 || max != 3) {
+			DBG(hfp, "hf: Invalid min/max values for callsetup,"
+				" expected (0,3) got (%u,%u)", min, max);
+			return;
+		}
+		ag_ind[HFP_INDICATOR_CALLSETUP].index = index;
+		ag_ind[HFP_INDICATOR_CALLSETUP].min = min;
+		ag_ind[HFP_INDICATOR_CALLSETUP].max = max;
+		ag_ind[HFP_INDICATOR_CALLSETUP].cb = ciev_callsetup_cb;
+		return;
+	}
+
+	if (strcmp("callheld", indicator) == 0) {
+		if (min != 0 || max != 2) {
+			DBG(hfp, "hf: Invalid min/max values for callheld,"
+				" expected (0,2) got (%u,%u)", min, max);
+			return;
+		}
+		ag_ind[HFP_INDICATOR_CALLHELD].index = index;
+		ag_ind[HFP_INDICATOR_CALLHELD].min = min;
+		ag_ind[HFP_INDICATOR_CALLHELD].max = max;
+		ag_ind[HFP_INDICATOR_CALLHELD].cb = ciev_callheld_cb;
+		return;
+	}
+
+	if (strcmp("signal", indicator) == 0) {
+		if (min != 0 || max != 5) {
+			DBG(hfp, "hf: Invalid min/max values for signal,"
+				" expected (0,5) got (%u,%u)", min, max);
+			return;
+		}
+		ag_ind[HFP_INDICATOR_SIGNAL].index = index;
+		ag_ind[HFP_INDICATOR_SIGNAL].min = min;
+		ag_ind[HFP_INDICATOR_SIGNAL].max = max;
+		ag_ind[HFP_INDICATOR_SIGNAL].cb = ciev_signal_cb;
+		return;
+	}
+
+	if (strcmp("roam", indicator) == 0) {
+		if (min != 0 || max != 1) {
+			DBG(hfp, "hf: Invalid min/max values for roam,"
+				" expected (0,1) got (%u,%u)", min, max);
+			return;
+		}
+		ag_ind[HFP_INDICATOR_ROAM].index = index;
+		ag_ind[HFP_INDICATOR_ROAM].min = min;
+		ag_ind[HFP_INDICATOR_ROAM].max = max;
+		ag_ind[HFP_INDICATOR_ROAM].cb = ciev_roam_cb;
+		return;
+	}
+
+	if (strcmp("battchg", indicator) == 0) {
+		if (min != 0 || max != 5) {
+			DBG(hfp, "hf: Invalid min/max values for battchg,"
+				" expected (0,5) got (%u,%u)", min, max);
+			return;
+		}
+		ag_ind[HFP_INDICATOR_BATTCHG].index = index;
+		ag_ind[HFP_INDICATOR_BATTCHG].min = min;
+		ag_ind[HFP_INDICATOR_BATTCHG].max = max;
+		ag_ind[HFP_INDICATOR_BATTCHG].cb = ciev_battchg_cb;
+		return;
+	}
+
+	DBG(hfp, "hf: Unknown indicator: %s", indicator);
+}
+
+static void slc_cind_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	int index = 1;
+
+	DBG(hfp, "");
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
+			DBG(hfp, "hf: Could not get string");
+			goto failed;
+		}
+
+		if (!hfp_context_open_container(context)) {
+			DBG(hfp, "hf: Could not open container");
+			goto failed;
+		}
+
+		if (!hfp_context_get_range(context, &min, &max)) {
+			if (!hfp_context_get_number(context, &min)) {
+				DBG(hfp, "hf: Could not get number");
+				goto failed;
+			}
+
+			if (!hfp_context_get_number(context, &max)) {
+				DBG(hfp, "hf: Could not get number");
+				goto failed;
+			}
+		}
+
+		if (!hfp_context_close_container(context)) {
+			DBG(hfp, "hf: Could not close container");
+			goto failed;
+		}
+
+		if (!hfp_context_close_container(context)) {
+			DBG(hfp, "hf: Could not close container");
+			goto failed;
+		}
+
+		set_indicator_parameters(hfp, index, name, min, max);
+		index++;
+	}
+
+	return;
+
+failed:
+	DBG(hfp, "hf: Error on CIND response");
+}
+
+static void slc_cind_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "");
+
+	hfp_hf_unregister(hfp, "+CIND");
+
+	if (result != HFP_RESULT_OK) {
+		DBG(hfp, "hf: CIND error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (!hfp_hf_register(hfp, slc_cind_status_cb, "+CIND", hfp,
+			NULL)) {
+		DBG(hfp, "hf: Could not register +CIND");
+		result = HFP_RESULT_ERROR;
+		goto failed;
+	}
+
+	if (!hfp_hf_send_command(hfp, slc_cind_status_resp, hfp,
+			"AT+CIND?")) {
+		DBG(hfp, "hf: Could not send AT+CIND?");
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
+static void slc_brsf_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	unsigned int feat;
+
+	DBG(hfp, "");
+
+	if (hfp_context_get_number(context, &feat))
+		hfp->features = feat;
+}
+
+static void slc_brsf_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "");
+
+	hfp_hf_unregister(hfp, "+BRSF");
+
+	if (result != HFP_RESULT_OK) {
+		DBG(hfp, "BRSF error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (!hfp_hf_register(hfp, slc_cind_cb, "+CIND", hfp, NULL)) {
+		DBG(hfp, "hf: Could not register for +CIND");
+		result = HFP_RESULT_ERROR;
+		goto failed;
+	}
+
+	if (!hfp_hf_send_command(hfp, slc_cind_resp, hfp, "AT+CIND=?")) {
+		DBG(hfp, "hf: Could not send AT+CIND command");
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
+bool hfp_hf_session_register(struct hfp_hf *hfp,
+				struct hfp_hf_callbacks *callbacks,
+				void *callbacks_data)
+{
+	if (!hfp)
+		return false;
+
+	hfp->callbacks = callbacks;
+	hfp->callbacks_data = callbacks_data;
+
+	return true;
+}
+
+bool hfp_hf_session(struct hfp_hf *hfp)
+{
+	DBG(hfp, "");
+
+	if (!hfp)
+		return false;
+
+	if (!hfp_hf_register(hfp, slc_brsf_cb, "+BRSF", hfp, NULL))
+		return false;
+
+	return hfp_hf_send_command(hfp, slc_brsf_resp, hfp,
+					"AT+BRSF=%u", HFP_HF_FEATURES);
+}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 600d084a7..f54b86a92 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -10,6 +10,34 @@
 
 #include <stdbool.h>
 
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
 enum hfp_result {
 	HFP_RESULT_OK		= 0,
 	HFP_RESULT_CONNECT	= 1,
@@ -57,6 +85,35 @@ enum hfp_gw_cmd_type {
 	HFP_GW_CMD_TYPE_COMMAND
 };
 
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
+enum hfp_call {
+	CIND_CALL_NONE = 0,
+	CIND_CALL_IN_PROGRESS
+};
+
+enum hfp_call_setup {
+	CIND_CALLSETUP_NONE = 0,
+	CIND_CALLSETUP_INCOMING,
+	CIND_CALLSETUP_DIALING,
+	CIND_CALLSETUP_ALERTING
+};
+
+enum hfp_call_held {
+	CIND_CALLHELD_NONE = 0,
+	CIND_CALLHELD_HOLD_AND_ACTIVE,
+	CIND_CALLHELD_HOLD
+};
+
 struct hfp_context;
 
 typedef void (*hfp_result_func_t)(struct hfp_context *context,
@@ -128,6 +185,13 @@ typedef void (*hfp_response_func_t)(enum hfp_result result,
 
 struct hfp_hf;
 
+struct hfp_hf_callbacks {
+	void (*session_ready)(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data);
+	void (*update_indicator)(enum hfp_indicator indicator, uint32_t val,
+							void *user_data);
+};
+
 struct hfp_hf *hfp_hf_new(int fd);
 
 struct hfp_hf *hfp_hf_ref(struct hfp_hf *hfp);
@@ -146,3 +210,8 @@ bool hfp_hf_register(struct hfp_hf *hfp, hfp_hf_result_func_t callback,
 bool hfp_hf_unregister(struct hfp_hf *hfp, const char *prefix);
 bool hfp_hf_send_command(struct hfp_hf *hfp, hfp_response_func_t resp_cb,
 				void *user_data, const char *format, ...);
+
+bool hfp_hf_session_register(struct hfp_hf *hfp,
+				struct hfp_hf_callbacks *callbacks,
+				void *callbacks_data);
+bool hfp_hf_session(struct hfp_hf *hfp);
-- 
2.43.0

