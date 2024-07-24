Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9AA33991
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837173; cv=none; b=mYAbX6AcPREJNr79HnEFQI+oXrYHwm4zeGlp9KaLMo1RfUuM1bWg+e2uSSo/352y8eY286+waQmCLj5zFBj+ccnwrIQkDbAalwg/x1+RnBQz6pDSD7i32fbu0xgMHikB2/ihP3yRqXYRlYlkvWYlLlMxSUcvEHs1FGAklRl8vtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837173; c=relaxed/simple;
	bh=7GRCKYgoXagAflSyyDQsc2HgTuleIPQw1HHl4LRElIE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WatjL2UncFfr00wi+WXq/hU0Wym0DMSvSeTKsPC3qzOgb74jwrL7a7RYEf5++Elgr+5cM+YIfFkL9fAMPkejvW+GH9qqKVOyNcLPxvKpl+1yunviaWaQIW+rkraz4I6AJ0D8SGiB6u9vJ11FHM4g8RXEQR3f4InfstXPz9JwN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2GT5v9R; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2GT5v9R"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70446231242so3451349a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721837171; x=1722441971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mAiYFKSRsQ/2TruribD2xPO+KLN4jbBOflIDN2+g6yQ=;
        b=G2GT5v9RPa4LQOAD8gNv+n+iHlOWjcnLAx6goW96q51wjVWSgBPPFFQFQbQfeCsWLE
         PDkIYeQlk/Zl8+Lt5beO9ZU6U9Oyi7VL9Vi7SESLMD/hHMmipjeOkoFQaZ9G13wTp2+s
         TwPfzLrt+v5aO6vf03Y8b2jVeHBXP3bAJpb/Qcxs7n/c31sYt/TBBgCT7KVYNj6sva4V
         5Rb0YEb7EXFlltjcJISCUFkBhpawA4qKwehxT7+pVYFptFkIluN+I79Hrr44IZ0zVXFr
         2TLVhmS2W4AVPQHxQcrvYIzP0JUaOn4CO5i/+JYl3YmExYHCpSluebpd855owkOmiuEq
         /yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837171; x=1722441971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAiYFKSRsQ/2TruribD2xPO+KLN4jbBOflIDN2+g6yQ=;
        b=R++Uklz2cykm0P4Vj7sdHj6n+qD0BuZyFQEX4MjFgZZG+6hpzhkv9TvSWY+5uaT4Gi
         vT4VP2kMvpWwRX3hZcB5kehk9GTrRKGIp98gqUwoKQwtwZFmKZ9t0BI+mnnpSQcraMuS
         d6gr0eqD6d5t3bTaGkNmBIW9+e3T6OKiFG/5LgOSIuz5uF5bAYO5Zx9ECKXZKAVjbTPH
         17SFokMgAGjPRVsseywLKOmj+OkGoAx8UaN4KRnyUwS3pgp6qGNDvNafduS+cBvevxKI
         ep8NQ1I9QWjgC86MM4f6aUW3AI3LoqJFOzuMz7Lcp2k6NNYahYg2PMrMbKTDE0Lr5e7d
         CNrA==
X-Gm-Message-State: AOJu0YyYBEMSLd2PMKb3T3PJ66hPghb+9tcA8SAHhnxbSnslB0TY43yp
	m4LUMNbrM/4X3QtS86tYuiqLKQEHzuoT8+gp9IwiWdT+LPconkxZh/3pUg==
X-Google-Smtp-Source: AGHT+IFF7310Ll+0jSogNIXZ/pp7uHG0HC2ZbRpdsb/XReiB0NS8FFy86SnezMsiixYd7SEGbNNmkQ==
X-Received: by 2002:a05:6830:6819:b0:708:b2c9:1a9e with SMTP id 46e09a7af769-7092e6d3120mr250216a34.12.1721837170549;
        Wed, 24 Jul 2024 09:06:10 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-826dcefcc28sm2445485241.10.2024.07.24.09.06.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:06:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/3] client/player: Set number of channels based on locations
Date: Wed, 24 Jul 2024 12:06:06 -0400
Message-ID: <20240724160608.2779282-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets the number of channels based on the locations set rather than
always hardcoding it to 3 which in certain case is incorrect and can
lead for the same location to be configured multiple times.
---
 client/player.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index 5b0b918fb8d7..9334a053d34d 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1140,10 +1140,9 @@ static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 		.meta = _meta, \
 	}
 
-#define LC3_DATA(_freq, _duration, _chan_count, _len_min, _len_max) \
+#define LC3_DATA(_freq, _duration, _len_min, _len_max) \
 	UTIL_IOV_INIT(0x03, LC3_FREQ, _freq, _freq >> 8, \
 			0x02, LC3_DURATION, _duration, \
-			0x02, LC3_CHAN_COUNT, _chan_count, \
 			0x05, LC3_FRAME_LEN, _len_min, _len_min >> 8, \
 			_len_max, _len_max >> 8)
 
@@ -1182,11 +1181,10 @@ static const struct capabilities {
 	 *
 	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
 	 * Duration: 7.5 ms 10 ms
-	 * Channel count: 3
 	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("pac_snk/lc3", PAC_SINK_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 26,
 					240),
 				UTIL_IOV_INIT()),
 
@@ -1198,7 +1196,7 @@ static const struct capabilities {
 	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("pac_src/lc3", PAC_SOURCE_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 26,
 					240),
 				UTIL_IOV_INIT()),
 
@@ -1210,7 +1208,7 @@ static const struct capabilities {
 	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("bcaa/lc3", BCAA_SERVICE_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 26,
 					240),
 				UTIL_IOV_INIT()),
 
@@ -1222,7 +1220,7 @@ static const struct capabilities {
 	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("baa/lc3", BAA_SERVICE_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 26,
 					240),
 				UTIL_IOV_INIT()),
 };
@@ -3220,6 +3218,7 @@ static void endpoint_locations(const char *input, void *user_data)
 	struct endpoint *ep = user_data;
 	char *endptr = NULL;
 	int value;
+	uint8_t channels;
 
 	value = strtol(input, &endptr, 0);
 
@@ -3230,6 +3229,12 @@ static void endpoint_locations(const char *input, void *user_data)
 
 	ep->locations = value;
 
+	channels = __builtin_popcount(value);
+	/* Automatically set LC3_CHAN_COUNT if only 1 location is supported */
+	if (channels == 1)
+		util_ltv_push(ep->caps, sizeof(channels), LC3_CHAN_COUNT,
+				&channels);
+
 	bt_shell_prompt_input(ep->path, "Supported Context (value):",
 				endpoint_supported_context, ep);
 }
-- 
2.45.2

