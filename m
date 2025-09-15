Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D0202C46
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954077; cv=none; b=pMYlK3veGF0sGD/O2LcVxDcrfrDfMMZr1qOahAbPkHjtXUqNGUku+oySLCDMACiJs4FFXKXUI8IrYxCV8GOmjHFKR0Ed+dDU00Ikj2cYPUpBy9/nIO1SZTfE8L1rUTZlLYGFH4098pAdhZGrBQlO4Az0O8g4o9sdXVKFN47QjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954077; c=relaxed/simple;
	bh=cAv+gp5NdDZzUkkE4QZXp7JPnJnXW0kEiUCjS5zCShs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MJzDTsn3SeyvUHK4q5AFrBGnGmJxd8Ft8VciRO/GJDj4o0Ijgwh1kdtVIioK/fZsB6Kr7N6tuaH/SCmFSaGEKUxY6H1wTWKWVcIFIM4ketidcmBDP92N5NaA5ZfccvBj2glRQMVs1ZwGXR2yD8Tn/aO9doGJ6MrQktvvw0XHuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gVkZPp8O; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gVkZPp8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757954073;
	bh=cAv+gp5NdDZzUkkE4QZXp7JPnJnXW0kEiUCjS5zCShs=;
	h=From:To:Subject:Date:From;
	b=gVkZPp8OglnJ/vP0kyq9rItGkVxzUnqSpU4aK6WFZmYC/rjylwGSOxXkVRp+p/f2j
	 u5ZMrexHU1Ut2XdIGvo25DgGCLVkKI67zLvMz1mGkvNR5lbhroke4LW+NFlHDYO4L8
	 gbt16RglZ2eWWBnn19S1TrTkTgSb2xfFlUXLQs07ThhYl0pa26OQqfQ+08nh51+OiT
	 KNPbEMWotfajZp4sLBIzeCQMOkD8U42cCHPjHSS4t1fcRKKHzgtJZWK2vbG9I+Xfl4
	 MaJF7pgcOs/dZKYvXit+56ApgcJwuc3kPDIpAi7IMXmgr7bXVkh2c2y8cxwXM0M7kk
	 +vy3XOZ3hEf4g==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-ed13-78a5-a1e8-7185.rev.sfr.net [IPv6:2a02:8428:af44:1001:ed13:78a5:a1e8:7185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1670617E0A49
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 18:34:33 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] shared/hfp: Add Operator name support
Date: Mon, 15 Sep 2025 18:34:24 +0200
Message-ID: <20250915163427.3589748-1-frederic.danis@collabora.com>
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
v1->v2 : Move changes from patch 2 to fix unit/test-hfp

 src/shared/hfp.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/hfp.h |  1 +
 unit/test-hfp.c  |  7 +++-
 3 files changed, 89 insertions(+), 3 deletions(-)

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
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 371415a68..2a85ec575 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -725,7 +725,12 @@ static void test_hf_robustness(gconstpointer data)
 	frg_pdu('0', ',', '0', ',', '0', ',', '0', ',', '5'), \
 	frg_pdu(',', '0', ',', '5', '\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
-	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', '+', 'C', 'O', 'P', 'S', ':', ' '), \
+	frg_pdu('0', ',', '0', ',', '\"', 'T', 'E', 'S', 'T'), \
+	frg_pdu('\"', '\r', '\n'), \
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n')
 
 static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
-- 
2.43.0

