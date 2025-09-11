Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC9321423
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586646; cv=none; b=dgfNekzaYc+AI1nxrAHJC6RuetG+J+wLEhSHga8Gy6EeN+3vge86gwE9m4enaI2nd3oHnUltMs8nOMuxba3Sst5TcbtT5mFshLsAaYRgHW5/8VKzJUpnQKpeFw9g9t8HQToROI+23Fz1OppEmrv57NTYqNKADlqGxU4DphivKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586646; c=relaxed/simple;
	bh=f7dAUauJOhGAUeD/vQaAF/NOdilz5RVEXSG8m8he4Yo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tb3dU4ob0i5CqsV1ymDfiAtcN/10mX6uebX1rMdhB/YYa3yqTyXN/Pr8/qhgzCIzEZ+89NeO0QVybhpHma8cG+QCXGeAthIXRHWi2c0dLrAQO6zxPW9OrjC2tolixHJnVyMSDMLeE97K0WlmVvbe4AhOTTm4ORUw9r0UKjnG+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VqIcOWZU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VqIcOWZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757586642;
	bh=f7dAUauJOhGAUeD/vQaAF/NOdilz5RVEXSG8m8he4Yo=;
	h=From:To:Subject:Date:From;
	b=VqIcOWZUGcgJCew/O046qo68Y0wjERUAr6oB4NcVzN9BKQpyAsElnmWFcxsoDnNgv
	 Tr4PE8d+aK7je3YCo7XLc+dF6RymVomyLpg8EtTAK+Arx8u/4wUnVpmn2Frz8lb1ki
	 xLcmk6mFei6uvl5yjClrVB/6B4F4nrTqwevn2UpILtbDRcFBAPGCqIeBgRtTyxtpaP
	 G/Lei0uzUaQlGbPWzKQZBUdkKvz9yu8cOgN1obetOoIzRO6QHg7dBH8gXDN4tl+GjM
	 F9AjKZdC6/4Zt1ayhVB/hlO2ZogS0conZSOHZ/oMLpNPgvp4y9MraCPZqPoHkQLXgC
	 kVXPV7wzOwrYA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-E0e2-6802-CeeF-9413.rev.sfr.net [IPv6:2a02:8428:af44:1001:e0e2:6802:ceef:9413])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0CC3117E0100
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 12:30:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/hfp: Add Operator name support
Date: Thu, 11 Sep 2025 12:28:37 +0200
Message-ID: <20250911102840.2090361-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Send AT+COPS=3,0 at the end of the SLC creation to set the format of
the operator selection to long alphanumeric, then query the currently
selected operator name from the AG.

Register +COPS handler to call the update_operator callback on event.
---
 src/shared/hfp.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/hfp.h |  1 +
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index d01915ab1..f94df90f1 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -1710,7 +1710,30 @@ static void ciev_cb(struct hfp_context *context, void *user_data)
 	set_indicator_value(index, val, hfp->ag_ind, hfp);
 }
 
-static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
+static void cops_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	unsigned int mode, val;
+	char name[255];
+
+	DBG(hfp, "");
+
+	if (!hfp_context_get_number(context, &mode))
+		return;
+
+	if (!hfp_context_get_number(context, &val))
+		return;
+
+	if (!hfp_context_get_string(context, name, sizeof(name))) {
+		DBG(hfp, "hf: Could not get string");
+		return;
+	}
+
+	if (hfp->callbacks && hfp->callbacks->update_operator)
+		hfp->callbacks->update_operator(name, hfp->callbacks_data);
+}
+
+static void cops_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -1718,7 +1741,7 @@ static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
 	DBG(hfp, "");
 
 	if (result != HFP_RESULT_OK) {
-		DBG(hfp, "hf: CMER error: %d", result);
+		DBG(hfp, "hf: COPS? error: %d", result);
 		goto failed;
 	}
 
@@ -1726,8 +1749,65 @@ static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
 		hfp->callbacks->session_ready(HFP_RESULT_OK, 0,
 						hfp->callbacks_data);
 
+	return;
+
+failed:
+	if (hfp->callbacks->session_ready)
+		hfp->callbacks->session_ready(result, cme_err,
+						hfp->callbacks_data);
+}
+
+static void cops_conf_resp(enum hfp_result result, enum hfp_error cme_err,
+	void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	DBG(hfp, "");
+
+	if (result != HFP_RESULT_OK) {
+		DBG(hfp, "hf: COPS= error: %d", result);
+		goto failed;
+	}
+
+	/* SLC creation done, continue with default setup */
+	if (!hfp_hf_send_command(hfp, cops_resp, hfp,
+		"AT+COPS?")) {
+		DBG(hfp, "hf: Could not send AT+COPS?");
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
+	/* SLC creation done, continue with default setup */
+	if (!hfp_hf_send_command(hfp, cops_conf_resp, hfp,
+		"AT+COPS=3,0")) {
+		DBG(hfp, "hf: Could not send AT+COPS=3,0");
+		result = HFP_RESULT_ERROR;
+		goto failed;
+	}
+
 	/* Register unsolicited results handlers */
 	hfp_hf_register(hfp, ciev_cb, "+CIEV", hfp, NULL);
+	hfp_hf_register(hfp, cops_cb, "+COPS", hfp, NULL);
 
 	return;
 
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index e6f7bbbb6..27f6d2d7c 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -190,6 +190,7 @@ struct hfp_hf_callbacks {
 							void *user_data);
 	void (*update_indicator)(enum hfp_indicator indicator, uint32_t val,
 							void *user_data);
+	void (*update_operator)(const char *operator_name, void *user_data);
 };
 
 struct hfp_hf *hfp_hf_new(int fd);
-- 
2.43.0

