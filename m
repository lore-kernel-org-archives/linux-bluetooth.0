Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42925CC5E
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760039938; cv=none; b=eR/oZWYi4qLFY2aQzX5dZxMgCNagqPkEKALiLmss2C6dx1FcLBbQT+MaRwtbTiDqTXcwHAAgman9ZkjkNRXWp5LOi6k823HhOW3OeJ7JnErmjNK5snujp4o2ch9GcTpENocm74Q/ayL2TKXvgMqVWGHsBUDAimYYGwOvoUi58Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760039938; c=relaxed/simple;
	bh=MPBKvB/2rtkPNHOiFv10fYiPIfrC48oXDh1+ZrN/DJ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqBngcn+TjzKJoBKewg/rJWdg/+foDCAKS2WTTfQnLqz1H2/Y5nzGiBU2C9g2i3gJoLzMHFhMv9k5kxmsSEQSdJlasfR9Tf1BomGcF3ynamjKF107Eykht5jt7J+B4bU7oGoNuV5aQ+Eq1qsMyjx8XlpsLK8Gg0BDSOMsU+aEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pPfT5Oq9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pPfT5Oq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760039928;
	bh=MPBKvB/2rtkPNHOiFv10fYiPIfrC48oXDh1+ZrN/DJ0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pPfT5Oq98zyOmL5JA6jFrddoyP8dHYA9sJXDPzginj6Q/vmvDGftlfZhEJ1XJHTUW
	 Z0mMgyjDoYIY8NvTAZ3AbnIZGLPWLBwnsNP2CDnkuK0w+2xmcy/ANABy0FZO4ICVXT
	 ZQWW2K4CxMQlrt8c4Ryb0XZO+bix6EOzGkFAW4yZwsrmDhiUR4WX5pN08bSaDItgvd
	 EvvGfrmTefX8T7YX6UWSc0c9bd528lzUpYT7CQKPGdlqgvDgB4fQm/Zgx47DVFxpaT
	 p2QRlZknYNxncEugTg5eT/8ZuxFH/L3nnvlUMdf+g/uib4u/WC4JZrpOhbiUKD5vzU
	 7ufoOgtNLaqiA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-aB6e-1eE8-0e0E-15d0.rev.sfr.net [IPv6:2a02:8428:af44:1001:ab6e:1ee8:e0e:15d0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B9C5417E12DF
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:58:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/6] shared/hfp: Add in-band ring tone setting support
Date: Thu,  9 Oct 2025 21:58:39 +0200
Message-ID: <20251009195842.776231-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009195842.776231-1-frederic.danis@collabora.com>
References: <20251009195842.776231-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 src/shared/hfp.c | 16 ++++++++++++++++
 src/shared/hfp.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index a6f9645d8..bc81a07ee 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -1752,6 +1752,20 @@ static bool call_active_match(const void *data, const void *match_data)
 	return (call->status == CALL_STATUS_ACTIVE);
 }
 
+static void bsir_cb(struct hfp_context *context, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	unsigned int val;
+
+	DBG(hfp, "");
+
+	if (!hfp_context_get_number(context, &val))
+		return;
+
+	if (hfp->callbacks && hfp->callbacks->update_inband_ring)
+		hfp->callbacks->update_inband_ring(!!val, hfp->callbacks_data);
+}
+
 static void ciev_callsetup_cb(uint8_t val, void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
@@ -2083,6 +2097,8 @@ static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
 	}
 
 	/* Register unsolicited results handlers */
+	if (hfp->features & HFP_AG_FEAT_IN_BAND_RING_TONE)
+		hfp_hf_register(hfp, bsir_cb, "+BSIR", hfp, NULL);
 	hfp_hf_register(hfp, ciev_cb, "+CIEV", hfp, NULL);
 	hfp_hf_register(hfp, clip_cb, "+CLIP", hfp, NULL);
 	hfp_hf_register(hfp, cops_cb, "+COPS", hfp, NULL);
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 21214eee4..27315bfa0 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -201,6 +201,7 @@ struct hfp_hf_callbacks {
 	void (*update_indicator)(enum hfp_indicator indicator, uint32_t val,
 							void *user_data);
 	void (*update_operator)(const char *operator_name, void *user_data);
+	void (*update_inband_ring)(bool enabled, void *user_data);
 
 	void (*call_added)(uint id, enum hfp_call_status status,
 							void *user_data);
-- 
2.43.0

