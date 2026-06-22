Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA693D1ABD
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143793; cv=none; b=i5HHEdlSvWaMAQFdXDf2f5ExiZGb+YqiAe+iYJovj3LjQinIo4gIjCkeSuISAqWgGztEO8wLkWfKBuxMlwsE47syqf+GT3SKurIzosJF2qMSMrnI1zUnYvN2zgddQFEU3wqwwOIbhc1sFSEHWx8WrxfOAKg4y6kjuivimMUbe/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143793; c=relaxed/simple;
	bh=YHF7UKFkaCtEVBpyg99ZSl5MDHu9O6SG4Rt7Q9P7Zkg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jboYhhypRv72HJtASEp2p49BMcVwyyKDXtZWgi0k1fMBSwf2cr9ww491V+oiv0ANzgrbz2WIAYx50QBOeLt/eQIqSB2Z0d444luAG1tKqQ74SI0nCM+o6Y6N0GlnXvBK7UubdPDfSP2LY/40QFjIaU/H1ZAnD0UDefgq7BNZKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiPOLL3i; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiPOLL3i"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bbe617d624so29657e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143791; x=1782748591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TJoNjs+98JPi2eONIlVves9ZMVYEPhAq5R2L7Tf9I9Q=;
        b=AiPOLL3iKJsDorDnth4Nk8/lU47Yvg+HoA84cw6qgq9oPPjJ673/XRR2J/TFkHgPVB
         f12Vj+hirHB+YzSgbDcdzlues/Mvg6axVCBWUICBWBV4NYoeAz34a0Lw+1WcFN6FNrSY
         V0iVEzeVpV/5w6SYNWWpDZSWOD7/U3lRPiqcZgkY97OZYXZSAr9kFvesiZYDDXxCc2Xa
         MXLqc45H3JcyX6sXfedmsQsErfcfNurPCG/Brxy0YMV12uYSmx1+eDCzLbNr5PoxU77R
         N+xJ7SH5HpKxRAolDs3unGcq5WnXIOB0fpzMEV/rJJM5YhsPXsQZp64QSYLPBO4Or6kY
         6pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143791; x=1782748591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJoNjs+98JPi2eONIlVves9ZMVYEPhAq5R2L7Tf9I9Q=;
        b=Ldn2eNr1aoEnmKmfGP5L6IIDXPC7wgUhhZrO8BNVtr6NHQyF2QNmDfe0S0aiTUN+1A
         LqjTLiTmSw60JnrnbYw0OiTEx1AiOegci2Vrvai3xTX6aWNaUc9LYaDSyD4ADXHLeI1r
         tTwemG7QiwnCM2M/IKlizM5Tc6JCRe6v8nC2D7i1lCSEnK0JiOm7v8cHL2+ve7FY/uwp
         FXqmgH+YwkTOv1SkyKLHN8jVDgmG/r3F/Ier9kPJFyYGSGr03ok8xx0Qbvhk/1cNHdlH
         QnVYxt/1sBbnjX9qwExkMdi5NhT9Wwz3z+us1uSP4lN9UvoQPch0+Un3R51WVbvVCT0C
         C2vg==
X-Gm-Message-State: AOJu0YwqloYhycqq6NqIP7NC5zIFun1Hiq3ykJk/YcXo85Qtcovpzs2b
	3EiN7wF+37EMQIt34UpaDv3rE0DzMtp32wX7M0mxrCVUscFI91paSrNvqw+tcD9pmxY=
X-Gm-Gg: AfdE7cksDUTII+VTTui563ycZ6jyKZfiLkxhL4UMMrOPKVUEUZV20rjFATtLDIb4WaO
	51jeNbMRIXmhFcXC9HsdJxYKrkSVQeCkBN+DdRfsqmgQV9afoCramXZvsciPSoc8Dtl5AU+uNN9
	TJkKpP0tYPcw0iD8rVG8lBQzEVX8p6xfpS01uEZUbqVITWlTlbd0wa42ZUAurjaJjIuh7UlsXaB
	zC7qmuy52SX9wQj0C/0KFKMyWyZPJ1UvmXOeqoxRT4JImxuP79j4F8HJVhlNbYipGTRoakaftgc
	rDT2GTNw8ggf1V2Oz6UfM9bn7cA23yCt38tnO7M+TEXvrKc0o8NNcmAnae/L5Pf5rXE7JsnTjg+
	RoemwTPcueEU12HnJ5f34qgkxXIZUbTDEn2yCyZKfTrQPjuwbxLnEBmZ8UUj8y2MobHgejQZDlr
	KN8Ey1D0Yp3o5FcX1YF8CdVLLCaxaDXJkYAUKiNkEMnecbZ2PRk7Ot0AQo7XYPKtCxv/tzmP0d5
	ZuQiMI=
X-Received: by 2002:a05:6122:3d11:b0:5a1:b296:78fc with SMTP id 71dfb90a1353d-5bc2ac55ffamr74130e0c.1.1782143790995;
        Mon, 22 Jun 2026 08:56:30 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfb878c91sm7082028e0c.6.2026.06.22.08.56.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:56:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] a2dp: Fix handling of codec capability storage
Date: Mon, 22 Jun 2026 11:56:21 -0400
Message-ID: <20260622155621.675255-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Codec capability is one byte long (max 255) the storage format is
02hhx which means each byte ends up as 2 characters so the buffer
needs to be doubled in order to handle capabilities of that size.

Reported-by:  p0her (_@p0her_) in TeamH4C working with TrendAI Zero Day Initiative
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 profiles/audio/a2dp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index a5e002784c02..c8adc3122563 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -971,7 +971,7 @@ static void store_remote_sep(void *data, void *user_data)
 {
 	struct a2dp_remote_sep *sep = data;
 	GKeyFile *key_file = user_data;
-	char seid[4], value[256];
+	char seid[4], value[9 + 512];
 	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
 	struct avdtp_media_codec_capability *codec;
 	unsigned int i;
@@ -2373,7 +2373,7 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 		uint8_t codec;
 		uint8_t delay_reporting;
 		GSList *l = NULL;
-		char caps[256];
+		char caps[513];
 		uint8_t data[128];
 		int i, size;
 
@@ -2386,10 +2386,10 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 			continue;
 
 		/* Try loading with delay_reporting first */
-		if (sscanf(value, "%02hhx:%02hhx:%02hhx:%s", &type, &codec,
+		if (sscanf(value, "%02hhx:%02hhx:%02hhx:%512s", &type, &codec,
 					&delay_reporting, caps) != 4) {
 			/* Try old format */
-			if (sscanf(value, "%02hhx:%02hhx:%s", &type, &codec,
+			if (sscanf(value, "%02hhx:%02hhx:%512s", &type, &codec,
 								caps) != 3) {
 				warn("Unable to load Endpoint: seid %u", rseid);
 				g_free(value);
@@ -2398,7 +2398,7 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 			delay_reporting = false;
 		}
 
-		for (i = 0, size = strlen(caps); i < size; i += 2) {
+		for (i = 0, size = strlen(caps); i < size && i >= 2; i += 2) {
 			uint8_t *tmp = data + i / 2;
 
 			if (sscanf(caps + i, "%02hhx", tmp) != 1) {
-- 
2.54.0

