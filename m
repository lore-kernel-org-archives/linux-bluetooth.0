Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616681C6BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943391; cv=none; b=DO0H1FnXZiRxfR9RvNsgfnz5VUJqIUJOcpjsH6nqkJWYYz5vv7YJUzclUECzRx17/5V1dpzf0dPQaPnRYx4oZOoRr+E23AGlWrFSc5CsFChl+sWHibJ9MO3sChIXweAnp86xoFfR1FX/pUwvKukZVyFRVweoMYCLsQnXh02Zolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943391; c=relaxed/simple;
	bh=7GRCKYgoXagAflSyyDQsc2HgTuleIPQw1HHl4LRElIE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ejgaey0UY9/5TJECZIzQSXmSjoDm27wVr5GbC10DEk3ygdPsdydjI8RwPH2HHuL2ewcdO/HU6Pfu1PAVFP8Cn8++b5quMo5BYCt9ED+ENfB2EOALhjudPceHtR3QnqUn40Tmfeo71qhzPWCLSfAZikSgiux54S7TBR507qZPzU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Icuxfgaz; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icuxfgaz"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4929540f38dso457779137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721943388; x=1722548188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mAiYFKSRsQ/2TruribD2xPO+KLN4jbBOflIDN2+g6yQ=;
        b=IcuxfgazSFPAOx06THGCQV5TBZ/+QN6XN7yEDJA3MkZo7+0lboHZpUKzmeKw+6t3dt
         kj9snM310xlouRYZAb+n83EzC7riAtBYFHNeFVe5/MlPkZdElJYr+X4cowDauE/GoUoZ
         L+KZQkzLQqqohA81RcHHx2hGLMpFELruHPfnmLDk8IfwBMNu81WvqARgMSZApMwvv+au
         kHAbXWvujx440O2l0yPj4PbKdZFbYHR2hDFvbFpCHodzMEwPJ9AD7DiXvNqePBpvxBiS
         GSNEmqXxwyPpm0QWOTkvJAexuZ3ddE7lPXTYbb2lXU7lc7/8x3R2tQB/HmNTqGNZid0x
         4U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721943388; x=1722548188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAiYFKSRsQ/2TruribD2xPO+KLN4jbBOflIDN2+g6yQ=;
        b=VuhMkFTshmpDwpDPLtF2lnJSVNrTp4dAUsfeYi1lE+SpclRQmCOcJomCvcmHKLaWFG
         yAcP56d/A/VxTJtPujBQO9XCrgrd72+ollJ9eD9zWGgOnkrZDEYW3ERTvgvJWXCBP/zB
         DhKVc/AlwI94rH3wcLPlcaP8uPAaBCRkF9O5P4wBX6F3s/i/sKHa1fVTirXsSnmC3pYm
         /w08NnSUMTlJ+feFIDNQ3+VwmbhJBdoJP09XmFWh6LUctoFTfWCJuBDfRmUmxLQzz+sk
         GEgooI1yPMg6mI3FGKlI9U6MLWZUi2Qe7Sb86BRpWros2LM4P5RpISM+wUKvmCR9kpPD
         iA1g==
X-Gm-Message-State: AOJu0Yx20zVUrllRkLm/uoV/MJFoJw2pHX0IC6aEIOczPSS6zMPzpRul
	jOiaFIfyDZOvyvhp1fnHl39k6L1iTJPm2PIwVJHlxVCh4YQx8DC/4csvbg==
X-Google-Smtp-Source: AGHT+IFFBYjuOnd+0gdWYkzot3q/euuyFD2Oucsn5vo0XVmgaIOWFlWGPDkmVPWMms2BQ0nFpFS+nA==
X-Received: by 2002:a05:6102:151b:b0:491:f22:3a8 with SMTP id ada2fe7eead31-493d650da91mr6367547137.29.1721943388437;
        Thu, 25 Jul 2024 14:36:28 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-493d95f313csm377007137.7.2024.07.25.14.36.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:36:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/3] client/player: Set number of channels based on locations
Date: Thu, 25 Jul 2024 17:36:24 -0400
Message-ID: <20240725213626.3183962-1-luiz.dentz@gmail.com>
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

