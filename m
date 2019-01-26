Return-Path: <SRS0=qwpb=QC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294D5C282C7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 10:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB5021872
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 10:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHAeIbbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAZKps (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:45:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZKps (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jan 2019 05:45:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so9071424wmb.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jan 2019 02:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=rBdrGHGewe/Hq4tO2WHzO+GhoR9VRH8xnSovsttGqP0=;
        b=VHAeIbbTjY2NKP2wPcYqI97BhLumKsU7OjvCxLz4hdDrfxlHPQSiXNfVmR43gUEY4W
         Kx6NHUl6WukEHodXannqSC00nD3YOty/QFKKHFnM5thM4WP/I9e/5wqklrMRJzPYx2nd
         h9/wdvHkH+hKNO1XueuoGDdJpP+7Q3u9IlD597Ze5t29TEs7jeMDK8R7fLt1cu8QWT3w
         /AE65p/knFy22HKR5wO3NvrcmvrGBZYQunClys7Xq64vAncv5dWVIM+EKrIgqk0CMdzB
         rd+n+g8MiyyaKHvhnDBw1c6hZrZvaPJb8a1L/rBzuPl2XHCRYKWjJKLmX9x4gCgZbhdi
         kfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=rBdrGHGewe/Hq4tO2WHzO+GhoR9VRH8xnSovsttGqP0=;
        b=h8wkSKhnEKlQ9Im9aEI9YFtS66KgWMxX5q2XqYIATlb0DmVJdwsSusm2mu9n2sEcua
         JVP24FysWWgjFK5cWUsMX/vngO95PIePaeouUy1OjfDpeGh69ZqRJz3WE4tcDMnwMLSt
         u4Vur82zKqh57ru2yL5/Xg5aPaBdHZmj4Fqq4wzA3KEkyODTKy6TIpGIIy+6NbB+EkEF
         DEUpecFo7K3+rB+MSzr0bG5aM76h06HPzNfjuhx7qG1EwVgzBrowvPbKrHBiAtnH0UuW
         W/u2MQdy5WOdAGGVuFzvPnvxYnXGOJFGFrypHJAwu7dL2rUHzOse9vvsr8420C6wh9fE
         Lu2g==
X-Gm-Message-State: AJcUukcJX8ISzMOyT0CWR0U6jObQKtjhErQcUBJbjVazVrpV9B0zpjr6
        JL5C7gUaAaY4EaUhlHbjInF6u6Vk
X-Google-Smtp-Source: ALg8bN5i2LQ36V8rtKnnYyKOtPL/Q6L/QZnq43ppe1PGwleGddoLB/LSZhuaFoggz+7YDLH6QaUWDw==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr10326646wme.73.1548499545828;
        Sat, 26 Jan 2019 02:45:45 -0800 (PST)
Received: from Pali-Latitude.lan ([2001:718:1e03:a01::1ca])
        by smtp.gmail.com with ESMTPSA id v12sm137984360wmd.27.2019.01.26.02.45.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 02:45:44 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] a2dp-codecs: Remove wrong definition of SBC_MAX_BITPOOL
Date:   Sat, 26 Jan 2019 11:45:39 +0100
Message-Id: <20190126104539.26421-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to A2DP specification; section SBC; Codec Specific Information
Elements; Minimum / Maximum Bitpool Value, range for Bitpool value is from
2 to 250. Decoder shell support 2 as Minimum Bitpool Value and High Quality
Bitpool value as the Maximum Bitpool Value at a minimum. A2DP defines
maximal High Quality Bitpool value as 53.

Therefore instead of SBC_MAX_BITPOOL macro, defines two macros, one for
minimal value of "Maximum Bitpool Value" and maximal value of "Maximum
Bitpool Value".

I have no idea what is origin of value 64 as it does not match minimum nor
maximum bitpool value. Lot of headsets declares maximum value to 53, so use
this value also in android/hal-audio-sbc.c
---
 android/hal-audio-sbc.c      | 6 +++---
 profiles/audio/a2dp-codecs.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
index 80e271ed6..541b2d6a7 100644
--- a/android/hal-audio-sbc.c
+++ b/android/hal-audio-sbc.c
@@ -92,7 +92,7 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.block_length = SBC_BLOCK_LENGTH_4 | SBC_BLOCK_LENGTH_8 |
 				SBC_BLOCK_LENGTH_12 | SBC_BLOCK_LENGTH_16,
 		.min_bitpool = SBC_MIN_BITPOOL,
-		.max_bitpool = SBC_MAX_BITPOOL
+		.max_bitpool = SBC_MAX_BITPOOL_MIN,
 	},
 	{
 		.frequency = SBC_SAMPLING_FREQ_44100,
@@ -101,7 +101,7 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.allocation_method = SBC_ALLOCATION_LOUDNESS,
 		.block_length = SBC_BLOCK_LENGTH_16,
 		.min_bitpool = SBC_MIN_BITPOOL,
-		.max_bitpool = SBC_MAX_BITPOOL
+		.max_bitpool = SBC_MAX_BITPOOL_MIN,
 	},
 	{
 		.frequency = SBC_SAMPLING_FREQ_48000,
@@ -110,7 +110,7 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.allocation_method = SBC_ALLOCATION_LOUDNESS,
 		.block_length = SBC_BLOCK_LENGTH_16,
 		.min_bitpool = SBC_MIN_BITPOOL,
-		.max_bitpool = SBC_MAX_BITPOOL
+		.max_bitpool = SBC_MAX_BITPOOL_MIN,
 	},
 };
 
diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 0bdd29110..f31f3a311 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -53,8 +53,9 @@
 #define SBC_ALLOCATION_SNR		(1 << 1)
 #define SBC_ALLOCATION_LOUDNESS		1
 
-#define SBC_MAX_BITPOOL			64
 #define SBC_MIN_BITPOOL			2
+#define SBC_MAX_BITPOOL_MIN		53
+#define SBC_MAX_BITPOOL_MAX		250
 
 #define MPEG_CHANNEL_MODE_MONO		(1 << 3)
 #define MPEG_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
-- 
2.11.0

