Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958D367F3C
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918188; cv=none; b=TGLJixNg+mx91dqW32DIDITu7fFp9pTheE4W8TkWgiyQl+7Lcj0aSgXzkTqZd7ay5BOCsCPrmSt2LKSWSyuNEmyMJs71wEWP7mBMDtmzLrXyXimj/LN+VwyDjnAns77CgT5eMkMTmhXiPvACeAjHnQkryr50rGhXnuPNowFcMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918188; c=relaxed/simple;
	bh=dryxTo8ALXhwomX/Ur0kTV11hdFex4r7aO1q++RnPOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGyaq3cXSX5gpB4g/hkHay+50M0xN/gt9VZHyE+tTl3S/hOL8tr7eqDNRIC0CYclsyPx7v2yGS6qlm5p7zO4qpWURQZAnCThsC2XuVWdO4Ja8vHmXq+/g27N9og40R2Z92pmWxzZTV4TTTmj+WQa3cc6skNra+eFXJqveg9szDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=e5LlQWa8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="e5LlQWa8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cdae130cso5415605e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780918180; x=1781522980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pe+2IX7HlDO8xi1RZGDl/u/KOQzDZP/H7YTk37mxFRk=;
        b=e5LlQWa8Wg2J5L0P5lMzuPPjjDjAf6d3MB6MzbXcD54i3GOZxX+g2tPZel6N40t31p
         NqDfQcKrzCM123kU4Rupea2kAN47oQA2jxj5IootgIBA6296r9FsLhijQ8qU39CJj2Uy
         fqyXftp4qyNebZmujMc/QX+adBN4zYPmQFams=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780918180; x=1781522980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe+2IX7HlDO8xi1RZGDl/u/KOQzDZP/H7YTk37mxFRk=;
        b=iXNKXCOtbMNvv5m9ZyC9/j8rWaYiOwRRgktBwOCg1mEVAjc0SAlsTOw4WiDWh69CbX
         dYLTCBkEA3dPdb20lsFk0MLLZyGAFx1k5UFqTeNi33IyqhIDA6j6V3W12jzWPJ+yVH4P
         yeWo9YOpWY17FbOetS/ZEcw2nP+qgXjDFeRa0YXmWQgxXPXz/PAMS2ypDYN0MCRnArTm
         bO8uy0SROM7zwdFTeSJ5XiKthFVvj8VkOdc3qELTIW10ViAkwC2MNe8Q3pZ3KX/AC55N
         c7oQuXomoCj1/zUGMG1nztA0q+Xrb+2wqG2PefZYC6Z8KTW/QS/CBe6JBAdIehcQe3qj
         baoA==
X-Gm-Message-State: AOJu0YzBrGLkmpJw93+CEgjWpDooydZ/pTKlVOdbcsJy1gw/2Sbepzqc
	AHout4NhFgB1rRuuWIsw5gQv6vSptj9CgTu42zRUjypkyAIbBZdGEE9OQfscqYrBRKxlF3cgvO3
	kyIYi
X-Gm-Gg: Acq92OEiSpPYjkMlB8ZkNxfotcFFpiw0glb3vMTxWUr4MIuxAAwOSUVnLGQWA0ytDM9
	n9pTaH1Hx1iACf0GlpLteLgHE1CuXTjCz+TFmMZjJnJIVSrI+W80YS8iHZE4pDZrY0d5ZHQM8ko
	j9x5FjHIm0QCrc9b8E91anmG5GzVW1gUMRcV2xIhkb8tWm6EtGqYOjf3uZJ52DM/uLKc+IA/Mxq
	pGofKqqVankfkW7AvcZv/h62X1Qr/YWw7gr3gvljQ07s0N7SuZU+mlvCM/8JvuXfrv5a8J/MrUy
	lGVVxhY8e2z56Rv5zDiaSrP/dOxcz22iNa+l1OLyA8Xqnx5leLn1FTHo5pYMT3sXLboz3dYKpDt
	GKicoMbrM+X3I7jr0EF78TqfBiVugaAPEuzGT9w9gVAecIXEn0ZSbwCZZGOmuYo/PRYWc8I+9XT
	YFK+nfI0kwuG05MmazFiWptOZ+dhM9XeBsqOMdiVCMZR7HnujBGFGLW5nEBv0QSdEu
X-Received: by 2002:a05:600c:8b0d:b0:490:b9ce:a73c with SMTP id 5b1f17b1804b1-490c55662b1mr231978845e9.31.1780918180203;
        Mon, 08 Jun 2026 04:29:40 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d30eeasm248446035e9.1.2026.06.08.04.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:29:39 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] avdtp: Fix GET_CONFIGURATION cmd
Date: Mon,  8 Jun 2026 13:29:22 +0200
Message-ID: <20260608112923.3722754-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes AVDTP/SNK/ACP/SIG/SMG/BV-12-C
---
 profiles/audio/avdtp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index d475a545e..7cfc9a80d 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1641,7 +1641,6 @@ static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t transaction,
 					struct seid_req *req, int size)
 {
 	GSList *l;
-	struct avdtp_local_sep *sep = NULL;
 	struct avdtp_stream *stream;
 	int rsp_size;
 	uint8_t err;
@@ -1656,7 +1655,7 @@ static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t transaction,
 	memset(buf, 0, sizeof(buf));
 
 	stream = find_stream_by_lseid(session, req->acp_seid);
-	if (!sep) {
+	if (!stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
 	}
-- 
2.43.0

