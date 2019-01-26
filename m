Return-Path: <SRS0=qwpb=QC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDC4C282C7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 10:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B2921872
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 10:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6ZKevoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfAZKqW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:46:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51020 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZKqW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jan 2019 05:46:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so9087106wmd.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jan 2019 02:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=V07GtudTSRg41GHhmCBFEJfgRNeLIqmecUDTxWTOp90=;
        b=q6ZKevoKVWy19XQGIur8eXjdhz/XqZwCni6IIvS0dcMo9etlNViyac5j8WHE6CPkC3
         WU6bciAWsNkzn7aXa1vy/+jODU+Xo9PjAXUC/G1olPsVpW65HHOpIFYwIgcXMiTOD93f
         h+IuSQoIC2FpGMB+gaSAY1Rby0pWMWN1WkE26pU6aV0GGj8z4t9uUGtTqmMaR696Nbwc
         4JTbwhKkJFb8Vq2gSQG3l+tmG6n3QJ0zVCHJiEQ+Q0oBmgVIQJhkXsKGtTzKdPlSx9OB
         tlChNU/hBEROk++7Fq077ExP9oL0Mghu1S+1DOV07mnAOEotgLZC3gxSuExSqGCdQPOZ
         qzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=V07GtudTSRg41GHhmCBFEJfgRNeLIqmecUDTxWTOp90=;
        b=tHjcXiq00/QnSuGpKEDAI8x8kGxtD8TQDn07B3UIFvgBylyk6nWQ95Xrz3diRivuL2
         On25UFRAGmW7yq0PN1DnpTTqnhBD3wHAxXcmckPiPGYcqd3j07+qQz3AkeiRYF1qy9IR
         pj0Tj7hJc/4y6NWLXsnO8s+oat15Ce+RvzTvQ2TOYHF9BKgifnk40PP1bVcJzteHTCBm
         +Kc4pmvS1Wm8ST8XM0k6ufAOTjfnJG4Psm+p059ys5cIq/QAUgQYp+xvwVDRNWXZgI3m
         1OMuRfv0tRkPgvkLsDMctoP7fRW44xEjNt7MqQJVYKDUmnATMUiVUZG9jQXmROkJYTkS
         caoQ==
X-Gm-Message-State: AJcUukdkrgxuA030o/PC/L2B78eUNzutWtWybZzmfLRpZV+WN/p8UQ7b
        KPwWMwRrzuTGImiFy9J87BnP/5JA
X-Google-Smtp-Source: ALg8bN6S64BJd4zxEldiH0wygHYltt4Vu4qHFKVOv7aOdL9oWaK+EZHoaM0KKU93EnXbrqP8Z+Jbyg==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr10396133wmd.67.1548499578775;
        Sat, 26 Jan 2019 02:46:18 -0800 (PST)
Received: from Pali-Latitude.lan ([2001:718:1e03:a01::1ca])
        by smtp.gmail.com with ESMTPSA id t66sm34596305wme.15.2019.01.26.02.46.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 02:46:18 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] a2dp-codecs & avinfo: Simplify defintions and parsing of aptX family
Date:   Sat, 26 Jan 2019 11:46:06 +0100
Message-Id: <20190126104606.26486-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reuse whole a2dp_aptx_t structure and defines as they are same for aptX Low
Latency and aptX HD.
---
 profiles/audio/a2dp-codecs.h | 46 ++++++--------------------------------
 tools/avinfo.c               | 53 +++++++++++++-------------------------------
 2 files changed, 22 insertions(+), 77 deletions(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index f31f3a311..4789e27ed 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -213,14 +213,6 @@
 #define APTX_LL_VENDOR_ID		0x0000000a
 #define APTX_LL_CODEC_ID		0x0002
 
-#define APTX_LL_CHANNEL_MODE_MONO	0x01
-#define APTX_LL_CHANNEL_MODE_STEREO	0x02
-
-#define APTX_LL_SAMPLING_FREQ_16000	0x08
-#define APTX_LL_SAMPLING_FREQ_32000	0x04
-#define APTX_LL_SAMPLING_FREQ_44100	0x02
-#define APTX_LL_SAMPLING_FREQ_48000	0x01
-
 /* Default parameters for aptX Low Latency encoder */
 
 /* Target codec buffer level = 180 */
@@ -244,14 +236,6 @@
 #define APTX_HD_VENDOR_ID		0x000000D7
 #define APTX_HD_CODEC_ID		0x0024
 
-#define APTX_HD_CHANNEL_MODE_MONO	0x1
-#define APTX_HD_CHANNEL_MODE_STEREO	0x2
-
-#define APTX_HD_SAMPLING_FREQ_16000	0x8
-#define APTX_HD_SAMPLING_FREQ_32000	0x4
-#define APTX_HD_SAMPLING_FREQ_44100	0x2
-#define APTX_HD_SAMPLING_FREQ_48000	0x1
-
 #define LDAC_VENDOR_ID			0x0000012d
 #define LDAC_CODEC_ID			0x00aa
 
@@ -360,25 +344,13 @@ typedef struct {
 } __attribute__ ((packed)) a2dp_faststream_t;
 
 typedef struct {
-	a2dp_vendor_codec_t info;
-	uint8_t channel_mode:4;
-	uint8_t frequency:4;
+	a2dp_aptx_t aptx;
 	uint8_t bidirect_link:1;
 	uint8_t has_new_caps:1;
 	uint8_t reserved:6;
 	a2dp_aptx_ll_new_caps_t new_caps[0];
 } __attribute__ ((packed)) a2dp_aptx_ll_t;
 
-typedef struct {
-	a2dp_vendor_codec_t info;
-	uint8_t channel_mode:4;
-	uint8_t frequency:4;
-	uint8_t reserved0;
-	uint8_t reserved1;
-	uint8_t reserved2;
-	uint8_t reserved3;
-} __attribute__ ((packed)) a2dp_aptx_hd_t;
-
 #elif defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && \
 	__BYTE_ORDER == __BIG_ENDIAN
 
@@ -430,25 +402,21 @@ typedef struct {
 } __attribute__ ((packed)) a2dp_faststream_t;
 
 typedef struct {
-	a2dp_vendor_codec_t info;
-	uint8_t frequency:4;
-	uint8_t channel_mode:4;
+	a2dp_aptx_t aptx;
 	uint8_t reserved:6;
 	uint8_t has_new_caps:1;
 	uint8_t bidirect_link:1;
 	a2dp_aptx_ll_new_caps_t new_caps[0];
 } __attribute__ ((packed)) a2dp_aptx_ll_t;
 
+#else
+#error "Unknown byte order"
+#endif
+
 typedef struct {
-	a2dp_vendor_codec_t info;
-	uint8_t frequency:4;
-	uint8_t channel_mode:4;
+	a2dp_aptx_t aptx;
 	uint8_t reserved0;
 	uint8_t reserved1;
 	uint8_t reserved2;
 	uint8_t reserved3;
 } __attribute__ ((packed)) a2dp_aptx_hd_t;
-
-#else
-#error "Unknown byte order"
-#endif
diff --git a/tools/avinfo.c b/tools/avinfo.c
index 42f539f43..852d7b67e 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -168,15 +168,8 @@ struct avdtp_content_protection_capability {
 	uint8_t data[0];
 } __attribute__ ((packed));
 
-static void print_aptx(a2dp_aptx_t *aptx, uint8_t size)
+static void print_aptx_common(a2dp_aptx_t *aptx)
 {
-	printf("\t\tVendor Specific Value (aptX)");
-
-	if (size < sizeof(*aptx)) {
-		printf(" (broken)\n");
-		return;
-	}
-
 	printf("\n\t\t\tFrequencies: ");
 	if (aptx->frequency & APTX_SAMPLING_FREQ_16000)
 		printf("16kHz ");
@@ -192,6 +185,18 @@ static void print_aptx(a2dp_aptx_t *aptx, uint8_t size)
 		printf("Mono ");
 	if (aptx->channel_mode & APTX_CHANNEL_MODE_STEREO)
 		printf("Stereo ");
+}
+
+static void print_aptx(a2dp_aptx_t *aptx, uint8_t size)
+{
+	printf("\t\tVendor Specific Value (aptX)");
+
+	if (size < sizeof(*aptx)) {
+		printf(" (broken)\n");
+		return;
+	}
+
+	print_aptx_common(aptx);
 
 	printf("\n");
 }
@@ -242,21 +247,7 @@ static void print_aptx_ll(a2dp_aptx_ll_t *aptx_ll, uint8_t size)
 		return;
 	}
 
-	printf("\n\t\t\tFrequencies: ");
-	if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_16000)
-		printf("16kHz ");
-	if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_32000)
-		printf("32kHz ");
-	if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_44100)
-		printf("44.1kHz ");
-	if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_48000)
-		printf("48kHz ");
-
-	printf("\n\t\t\tChannel modes: ");
-	if (aptx_ll->channel_mode & APTX_LL_CHANNEL_MODE_MONO)
-		printf("Mono ");
-	if (aptx_ll->channel_mode & APTX_LL_CHANNEL_MODE_STEREO)
-		printf("Stereo ");
+	print_aptx_common(&aptx_ll->aptx);
 
 	printf("\n\t\tBidirectional link: %s",
 			aptx_ll->bidirect_link ? "Yes" : "No");
@@ -292,21 +283,7 @@ static void print_aptx_hd(a2dp_aptx_hd_t *aptx_hd, uint8_t size)
 		return;
 	}
 
-	printf("\n\t\t\tFrequencies: ");
-	if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_16000)
-		printf("16kHz ");
-	if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_32000)
-		printf("32kHz ");
-	if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_44100)
-		printf("44.1kHz ");
-	if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_48000)
-		printf("48kHz ");
-
-	printf("\n\t\t\tChannel modes: ");
-	if (aptx_hd->channel_mode & APTX_HD_CHANNEL_MODE_MONO)
-		printf("Mono ");
-	if (aptx_hd->channel_mode & APTX_HD_CHANNEL_MODE_STEREO)
-		printf("Stereo ");
+	print_aptx_common(&aptx_hd->aptx);
 
 	printf("\n");
 }
-- 
2.11.0

