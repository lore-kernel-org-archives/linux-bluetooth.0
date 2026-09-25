Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13FB48B37E
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342762; cv=none; b=I4DDRH5kcHbNLoTexZTLkXxr3dJcAOy/aAqFLZQuyq9hrpEqOZWgdBBgkbN95FSXveuoNj7sRnL4ZlKhZsVZ1i4QVFiPHFJiXrRtS9+Tuxa4Du1UIQDDIqceTs8zdETASD74x0vCGSJCASYHZDLzX0SyenMon2kNQ0Lb9qyAMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342762; c=relaxed/simple;
	bh=0Y5DblTUxZg5wLZPH2mclOUzvP4yRxQhUGhm0cp+FOA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxSgbRbqWWDtzzSEp72DH94RiOQ1Hj8fCMPzbo4GUO40znzCy3oBEvBl3akUx00fPfTQoReBzEvZGO0wzjeZmRHTW0Gb+HEAVw4nRxAR+ray0qwQ/52RAda/aS1ALOZez1E4o564fMCDe5NC1HTi6fjhSon6rMvpMle4MFjX9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QkS8MbVg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QkS8MbVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790342739;
	bh=0Y5DblTUxZg5wLZPH2mclOUzvP4yRxQhUGhm0cp+FOA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QkS8MbVgA0lsRhMajtZKCLOOPjthyrnwv/sWjNo7SaltzxncUASU48toddwsM2aeX
	 V5AXpVpxTmBy1LbGsyVDlMhoPhoYekkOzcXcQoigRPslMYMb3vImtSzBjQyiOMBaJk
	 c9GYBasz3sw5tU79TTVr0/X/rVp0QpW4ksfY4XkaNLvSak1X1scpgv1F5dkotvq4Tp
	 mQf1cleULwYVisB3BKwa1hjjq1acOGLDeHMxxT9Cx07vslmFJ80z43WYD9OMYN4Vq3
	 kEWsqFtQ17kXG2VHM0ZjqAhSHnMkLlpAGA13GUCktb9AavPfOlh9TTPfuNqOLzpZks
	 nR2uHhhFKLf1g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F13B117E1168
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:25:38 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/12] shared/hfp: Add codecs support
Date: Fri, 25 Sep 2026 15:25:27 +0200
Message-ID: <20260925132528.3361517-12-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925132528.3361517-1-frederic.danis@collabora.com>
References: <20260925132528.3361517-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

This send the AT+BAC command with the supported codec list during
SLC connection.

On reception of +BCS event to select a codec to use it replies with
the same codec if it is available, or re-send the AT+BAC to re-trigger
codec selection.
---
 src/shared/hfp.c | 164 +++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/hfp.h |   7 ++
 2 files changed, 166 insertions(+), 5 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index dffad6fee..cf12f0637 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -100,6 +100,7 @@ struct hfp_hf {
 	struct hfp_hf_callbacks *callbacks;
 	void *callbacks_data;
 
+	uint32_t hf_features;
 	uint32_t features;
 	struct indicator ag_ind[HFP_INDICATOR_LAST];
 	bool service;
@@ -2235,6 +2236,101 @@ static void clip_cb(struct hfp_context *context, void *user_data)
 							hfp->callbacks_data);
 }
 
+static bool available_codecs_update(struct hfp_hf *hfp,
+						hfp_response_func_t resp_cb,
+						void *user_data)
+{
+	uint8_t codecs[UINT8_MAX];
+	uint8_t len;
+	uint32_t codecs_str_len;
+	char *codecs_str, *ptr;
+
+	len = hfp->callbacks->get_codecs(codecs, UINT8_MAX,
+							hfp->callbacks_data);
+	if (!len) {
+		DBG(hfp, "hf: Failed to get supported codecs");
+		return false;
+	}
+
+	/* Each codec can be up to 3 digits + comma + null terminator */
+	codecs_str_len = len * 4 + 1;
+	codecs_str = malloc(codecs_str_len);
+	if (!codecs_str) {
+		DBG(hfp, "hf: Failed to allocate memory for codecs");
+		return false;
+	}
+
+	ptr = codecs_str;
+	for (uint8_t i = 0; i < len; i++) {
+		int ret;
+
+		ret = snprintf(ptr, codecs_str_len - (ptr - codecs_str),
+							"%u,", codecs[i]);
+		if (ret < 0 || ret >= codecs_str_len - (ptr - codecs_str)) {
+			DBG(hfp, "hf: Failed to format codecs string");
+			free(codecs_str);
+			return false;
+		}
+		ptr += ret;
+	}
+	/* Remove the trailing comma */
+	if (ptr != codecs_str) {
+		ptr--;
+		*ptr = '\0';
+	}
+
+	if (!hfp_hf_send_command(hfp, resp_cb, user_data, "AT+BAC=%s",
+								codecs_str)) {
+		DBG(hfp, "hf: Could not send AT+BAC=%s", codecs_str);
+		free(codecs_str);
+		return false;
+	}
+
+	free(codecs_str);
+
+	return true;
+}
+
+static void bac_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	if (result != HFP_RESULT_OK)
+		DBG(hfp, "hf: BAC error: %d", result);
+}
+
+static void bcs_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	if (result != HFP_RESULT_OK)
+		DBG(hfp, "hf: BCS error: %d", result);
+}
+
+static void bcs_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	unsigned int val;
+
+	if (!hfp_context_get_number(context, &val))
+		return;
+
+	if (!hfp->callbacks->select_codec(val, hfp->callbacks_data)) {
+		DBG(hfp, "hf: Codec selection failed: %d", val);
+
+		if (!available_codecs_update(hfp, bac_resp, hfp)) {
+			DBG(hfp, "hf: Could not re-trigger codec update");
+			return;
+		}
+	}
+
+	if (!hfp_hf_send_command(hfp, bcs_resp, hfp, "AT+BCS=%u", val)) {
+		DBG(hfp, "hf: Could not send AT+BCS=%u", val);
+	}
+}
+
 static void nrec_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
@@ -2794,17 +2890,15 @@ static void slc_brsf_cb(struct hfp_context *context, void *user_data)
 		hfp->features = feat;
 }
 
-static void slc_brsf_resp(enum hfp_result result, enum hfp_error cme_err,
+static void slc_bac_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
 
 	DBG(hfp, "");
 
-	hfp_hf_unregister(hfp, "+BRSF");
-
 	if (result != HFP_RESULT_OK) {
-		DBG(hfp, "BRSF error: %d", result);
+		DBG(hfp, "hf: BAC error: %d", result);
 		goto failed;
 	}
 
@@ -2829,6 +2923,46 @@ failed:
 						hfp->callbacks_data);
 }
 
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
+	if (!(hfp->hf_features & HFP_HF_FEAT_CODEC_NEGOTIATION) ||
+			!(hfp->features & HFP_AG_FEAT_CODEC_NEGOTIATION)) {
+		/* Jump to next setup state */
+		slc_bac_resp(HFP_RESULT_OK, cme_err, user_data);
+		return;
+	}
+
+	if (!hfp_hf_register(hfp, bcs_cb, "+BCS", hfp, NULL)) {
+		DBG(hfp, "hf: Could not register for +BCS");
+		result = HFP_RESULT_ERROR;
+		goto failed;
+	}
+
+	if (!available_codecs_update(hfp, slc_bac_resp, hfp)) {
+		DBG(hfp, "hf: Could not send AT+BAC");
+		result = HFP_RESULT_ERROR;
+		goto failed;
+	}
+
+failed:
+	if (hfp->callbacks->session_ready)
+		hfp->callbacks->session_ready(result, cme_err,
+						hfp->callbacks_data);
+}
+
 bool hfp_hf_session_register(struct hfp_hf *hfp,
 				struct hfp_hf_callbacks *callbacks,
 				void *callbacks_data)
@@ -2849,11 +2983,15 @@ bool hfp_hf_session(struct hfp_hf *hfp)
 
 	DBG(hfp, "");
 
+	hfp->hf_features = HFP_HF_FEATURES;
+	if (hfp->callbacks->get_codecs && hfp->callbacks->select_codec)
+		hfp->hf_features |= HFP_HF_FEAT_CODEC_NEGOTIATION;
+
 	if (!hfp_hf_register(hfp, slc_brsf_cb, "+BRSF", hfp, NULL))
 		return false;
 
 	return hfp_hf_send_command(hfp, slc_brsf_resp, hfp,
-					"AT+BRSF=%u", HFP_HF_FEATURES);
+					"AT+BRSF=%u", hfp->hf_features);
 }
 
 const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id)
@@ -3090,3 +3228,19 @@ bool hfp_hf_call_hangup(struct hfp_hf *hfp, uint id,
 
 	return false;
 }
+
+bool hfp_hf_request_codec_connection(struct hfp_hf *hfp,
+				hfp_response_func_t resp_cb,
+				void *user_data)
+{
+	if (!hfp)
+		return false;
+
+	if (!(hfp->hf_features & HFP_HF_FEAT_CODEC_NEGOTIATION) ||
+			!(hfp->features & HFP_AG_FEAT_CODEC_NEGOTIATION)) {
+		DBG(hfp, "hf: Codec negotiation not supported");
+		return false;
+	}
+
+	return hfp_hf_send_command(hfp, resp_cb, user_data, "AT+BCC");
+}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 11610018e..a3b956cf5 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -220,6 +220,9 @@ struct hfp_hf_callbacks {
 	void (*call_line_id_updated)(uint id, const char *number, uint type,
 							void *user_data);
 	void (*call_mpty_updated)(uint id, bool mpty, void *user_data);
+	uint8_t (*get_codecs)(uint8_t *codecs, uint8_t max_codecs,
+							void *user_data);
+	bool (*select_codec)(uint8_t codec, void *user_data);
 };
 
 struct hfp_hf *hfp_hf_new(int fd);
@@ -270,3 +273,7 @@ bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 bool hfp_hf_call_hangup(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data);
+
+bool hfp_hf_request_codec_connection(struct hfp_hf *hfp,
+				hfp_response_func_t resp_cb,
+				void *user_data);
-- 
2.43.0

