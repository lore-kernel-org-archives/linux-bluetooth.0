Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F929E0E6
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248504; cv=none; b=sDXjMbHUEO0FdR5Bufj5QqdwiBiXb73n1T1pOCWtEzZ0A486ErobmP4VSzOX3IxR4OOVxTDZ2ZRkCBksIjQw442v/uoJWHSYcSHxclMgvHNmlwIC+cCvnpQNu55UmQjnv9r7WxJ1Hnif5Tb89K5cwaNXhMM/lbOI0Q2iAloeGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248504; c=relaxed/simple;
	bh=wDrXXOA9qT3YWzKRXXkpJR6TKIuZsDOhfIEV3PfnXOs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K7c7GYuMVM4GfSB963oPBjObZt91k1XaKP+4QpsVtdGoj3Uu+3ZfJtSW3S3o4Mm83WQ22NROi680c6UVms0fwIpS40TuDTuw10KRqa+aq5f3zFJK8d/C19tz+aiFzZKM6pxM7TKfbxtpiEQ3oxkDDAuLxuMmC87p7bCIs7ynIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gxMH6GbB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gxMH6GbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762248493;
	bh=wDrXXOA9qT3YWzKRXXkpJR6TKIuZsDOhfIEV3PfnXOs=;
	h=From:To:Subject:Date:From;
	b=gxMH6GbBgvupmmvnOK+2LERZxjN+5yib8/HR4/1tGwt1HThbGk8OtMj5AYmisdg7b
	 8tK8A8dPDkP37iuBxLlTVQSHoIhtmCOgljgUC5NA9ZwTPFsQi7fUGxy+rC7hRuFkrL
	 YopsEJPvjBq3Gzg3doZLIHhhW/YIlJJPBH9uW6NPMvBp3lzqKIXcu81w/AoWcTjyz5
	 zMCe6xX5zWCcbN34agpyXUVC2rXBZyGCSYwgn8O+2r0ImKBTiWU1NBmxYusaFjSigB
	 IzIUMfJ0AfyZ+FubU7h+C9XfBQV7McQt15amdM8MgkR7ORUtaHaqFTtrBYEp+17ZVJ
	 rkbVJZUA8fq9Q==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-AF44-1001-2EF7-962e-01c6-D201.rev.sfr.net [IPv6:2a02:8428:af44:1001:2ef7:962e:1c6:d201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B098817E1389
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 10:28:13 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] shared/hfp: Add extended response code enabling command
Date: Tue,  4 Nov 2025 10:28:06 +0100
Message-ID: <20251104092808.128726-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 src/shared/hfp.c | 36 ++++++++++++++++++++++++++++++++++--
 unit/test-hfp.c  |  1 +
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index bc81a07ee..2342c24df 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -1996,7 +1996,7 @@ static void clip_cb(struct hfp_context *context, void *user_data)
 							hfp->callbacks_data);
 }
 
-static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
+static void cmee_resp(enum hfp_result result, enum hfp_error cme_err,
 	void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -2004,7 +2004,7 @@ static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
 	DBG(hfp, "");
 
 	if (result != HFP_RESULT_OK) {
-		DBG(hfp, "hf: CLIP error: %d", result);
+		DBG(hfp, "hf: CMEE error: %d", result);
 		goto failed;
 	}
 
@@ -2020,6 +2020,38 @@ failed:
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
+	if (!(hfp->features & HFP_AG_FEAT_EXTENDED_RES_CODE)) {
+		/* Jump to next setup state */
+		cmee_resp(HFP_RESULT_OK, cme_err, user_data);
+		return;
+	}
+
+	if (!hfp_hf_send_command(hfp, cmee_resp, hfp, "AT+CMEE=1")) {
+		DBG(hfp, "hf: Could not send AT+CMEE=1");
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
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 3973df5cf..fc9fb1865 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -762,6 +762,7 @@ static void test_hf_robustness(gconstpointer data)
 	raw_pdu('\r', '\n', '+', 'C', 'O', 'P', 'S', ':', ' ', '0', ',', \
 		'0', ',', '\"', 'T', 'E', 'S', 'T', '\"', '\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
 
 static void hf_cmd_complete(enum hfp_result res, enum hfp_error cme_err,
-- 
2.43.0

