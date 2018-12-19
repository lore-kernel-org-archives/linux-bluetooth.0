Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8636C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97F2217D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgognHG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeLSQwA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:52:00 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39702 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSQwA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:52:00 -0500
Received: by mail-wm1-f49.google.com with SMTP id f81so7166455wmd.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=PxWiA3i0KggH74Mp4g+hpgwPAMnJugxxMogdTGy3YwU=;
        b=LgognHG8EwMveXqtfMXYR5JKsleP8ovl17Y2Xrftj0sVmjvT9/sYRsGmONnhWtZDzI
         09rTneUSiQReIZbaUA8SAuF9fGACdtmO2eoVvFsPZeQnLaCz0yXmxO3zySL1LCaUINi3
         R0CZvw5KvqYqPnu+dTX2JPSQE4gn81j7gzTrdu2vuIfNG4PIgN456qAJWtwTqG3+X1wV
         hDwsVCAK7fJSRLRwszKpmlDNjSuG79quhXqElXLJL98AlPl719dfBg8GRAbSgUJgbGCO
         dx2pkOJ/NEU1BVjWPqEIKFXUQlw9o/NneTBe909IMrEcA3EbgKd62tTwreEa0WfD7icj
         oXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=PxWiA3i0KggH74Mp4g+hpgwPAMnJugxxMogdTGy3YwU=;
        b=jERGBOxbp7O/Kn6sAr5G0P2qLuj58+Xp1KFEn8ZD+aPGyleC6fPyxizbcVaAgcryzD
         /vbcVj2CMejjlZvg8DG+vNF7q1+RJZUpDRfNc5haheVlhnW5BGeLy5bBLtrMzeycnGt5
         8jid4gFqAsNIGqhXu5HV1gNgwXxiItZR5u4hsrrx5FOFZ81Oqyrx6HbGA9Zkx5rHVthC
         fSdirmUgMCdFaBJpShVUJtukckDAW7GUdQPGF1qMp0R7R/7Yj+3UIsIzEiY41RE4/FbT
         l9tLcpzEC1pFbdMicEO0rdbkytDjuzfOX4vhq9eUy/kFXlzVo1x0V9YCoU4T1poqBxHi
         rL9g==
X-Gm-Message-State: AA+aEWbDmOQvSdE2fXKjrshLUuluh2SImzkz0FdeeT/JQ5oiPSVRDbyl
        2TYTCsc5/dpx+KnVqf8M4NjzQmSaFjU=
X-Google-Smtp-Source: AFSGD/U/GcCaa2jRmGI/vim6wBEw0Lbrnjw/eUTfw/A132pm1joIS/MoCJkPQcBUCHyPUbBJO4mnRw==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr8130144wmh.18.1545238318141;
        Wed, 19 Dec 2018 08:51:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.51.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:51:57 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] a2dp-codecs: Properly define macros and struct for LDAC codec
Date:   Wed, 19 Dec 2018 17:51:07 +0100
Message-Id: <20181219165109.29088-9-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/audio/a2dp-codecs.h | 27 +++++++++++++++++----------
 tools/avinfo.c               |  3 +--
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 327901eac..9f47755cb 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -196,6 +196,17 @@
 #define LDAC_VENDOR_ID			0x0000012d
 #define LDAC_CODEC_ID			0x00aa
 
+#define LDAC_SAMPLING_FREQ_44100	0x20
+#define LDAC_SAMPLING_FREQ_48000	0x10
+#define LDAC_SAMPLING_FREQ_88200	0x08
+#define LDAC_SAMPLING_FREQ_96000	0x04
+#define LDAC_SAMPLING_FREQ_176400	0x02
+#define LDAC_SAMPLING_FREQ_192000	0x01
+
+#define LDAC_CHANNEL_MODE_MONO		0x04
+#define LDAC_CHANNEL_MODE_DUAL		0x02
+#define LDAC_CHANNEL_MODE_STEREO	0x01
+
 typedef struct {
 	uint8_t vendor_id4;
 	uint8_t vendor_id3;
@@ -216,6 +227,12 @@ typedef struct {
 		.codec_id1 = (((c) >> 8) & 0xff), \
 	})
 
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t frequency;
+	uint8_t channel_mode;
+} __attribute__ ((packed)) a2dp_ldac_t;
+
 #if defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && __BYTE_ORDER == __LITTLE_ENDIAN
 
 typedef struct {
@@ -258,11 +275,6 @@ typedef struct {
 	uint8_t frequency:4;
 } __attribute__ ((packed)) a2dp_aptx_t;
 
-typedef struct {
-	a2dp_vendor_codec_t info;
-	uint8_t unknown[2];
-} __attribute__ ((packed)) a2dp_ldac_t;
-
 #elif defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && __BYTE_ORDER == __BIG_ENDIAN
 
 typedef struct {
@@ -305,11 +317,6 @@ typedef struct {
 	uint8_t channel_mode:4;
 } __attribute__ ((packed)) a2dp_aptx_t;
 
-typedef struct {
-	a2dp_vendor_codec_t info;
-	uint8_t unknown[2];
-} __attribute__ ((packed)) a2dp_ldac_t;
-
 #else
 #error "Unknown byte order"
 #endif
diff --git a/tools/avinfo.c b/tools/avinfo.c
index f09085c93..78da0d5d2 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -204,8 +204,7 @@ static void print_ldac(a2dp_ldac_t *ldac, uint8_t size)
 		return;
 	}
 
-	printf("\n\t\t\tUnknown: %02x %02x", ldac->unknown[0],
-							ldac->unknown[1]);
+	printf("\n\t\t\tUnknown: %02x %02x", ldac->frequency, ldac->channel_mode);
 
 	printf("\n");
 }
-- 
2.11.0

