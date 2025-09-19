Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C042ECD15
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270252; cv=none; b=TIUu5gCJqI74RYGri4V5jrhIQbCRat9sfMnn+vLM85vuce6HW0gOCllrVRpCMz+a99Zog4hgU6qxIaw5vdqLp1r2XyjsEmknV+xYat6TDhs17i74FMh1lDqc9wG+pKN713/z70LR10r1Cp3Ntj37ZrvXRmEKBxzo/ygGZn6LvZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270252; c=relaxed/simple;
	bh=XLcnXAfjObqeuIAUA2+60qsGQEZ8StQJJqa9cy/hqAo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFgQBUmEE28xhXN5y2kTg9CkNtZSZustM+D9qbE5XmtcWwnGiPAPoWtTq+v84HH+sexQp3LbzZBBltVgPcxRp3J37V1cskaQF52YOPtRPPL64+aWOZFWUXAtXDsPE09l6VJSprrnGiiirmT2Ux9smE8nEAfmk2EDQNMxyGOFCqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pyY/cKKQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pyY/cKKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758270249;
	bh=XLcnXAfjObqeuIAUA2+60qsGQEZ8StQJJqa9cy/hqAo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pyY/cKKQBS1VNXcVR2Tf4EdlKbiqZ6HKQzUbEjhV8rc/2O9OaNCoDhH0yYH6cmVtb
	 t6YsTVie5y8SDghyewOQf9Uo/52ARh6G/bZ+5tYmCSyS9IRs5u2bZbmDsI/tcA6Ahe
	 igDOz+eSyA/av7F9Khy4H29anx85kK92WmBy8ZZS+LlzI8Xg847AN3j99tDVR7bZHf
	 StmJTyRcpn7JfH6WFerc44PbannJ7+zXmOTnsQSlLzz8rx3G5TE9naetRUtEYWnfJ2
	 wfqsycFeCrMpoCxPYIjwlxY49PkaMlrui7FBro6cUERUPvUhKw/vEB3VStlI/WqU21
	 xjqrvbLH9SMbw==
Received: from fdanis-ThinkPad-X1.. (unknown [IPv6:2a02:8428:af44:1001:17f0:5da3:acf8:a3c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EEE5817E12BB
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 10:24:08 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] shared/hfp: Add Call hangup support
Date: Fri, 19 Sep 2025 10:23:32 +0200
Message-ID: <20250919082334.1443310-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919082334.1443310-1-frederic.danis@collabora.com>
References: <20250919082334.1443310-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 src/shared/hfp.c | 25 +++++++++++++++++++++++++
 src/shared/hfp.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 7e35f239a..133bff248 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -2446,3 +2446,28 @@ bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 
 	return hfp_hf_send_command(hfp, resp_cb, user_data, "ATA");
 }
+
+bool hfp_hf_call_hangup(struct hfp_hf *hfp, uint id,
+				hfp_response_func_t resp_cb,
+				void *user_data)
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
+	if (call_setup_match(call, NULL) || call_active_match(call, NULL)) {
+		return hfp_hf_send_command(hfp, resp_cb, user_data,
+								"AT+CHUP");
+	}
+
+	return false;
+}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index c623e48e6..4b171ad88 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -240,3 +240,6 @@ const char *hfp_hf_call_get_number(struct hfp_hf *hfp, uint id);
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data);
+bool hfp_hf_call_hangup(struct hfp_hf *hfp, uint id,
+				hfp_response_func_t resp_cb,
+				void *user_data);
-- 
2.43.0

