Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB45DC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78485217D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln3NzBiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeLSQv4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:51:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40820 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSQvz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:51:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so20229602wrt.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=RzNyhPltgrWbSKOajcj+WQeYyOc8z1GRLS6/VImfVCw=;
        b=ln3NzBiyfPVG5N9v2llXLeTedf5xNeYS4vYJToSwQwpw9tiTjk+aoqYxSg9WNNTKDh
         au62wmAB3+hil3lhgrs47Je9MNHukn8X+fKgGxVyGQ0J7cjR+ssz+Cw4u0I1RHwUseSG
         FclFJx1XjvD07gLzZmTlF/SEej2KVmu/vKeu3ldTFeUzhNjAWQ6U7w+mdlroTuPncSsx
         F25D5PW4UaGnOrRI1kI0A6XZ0UiooTJiTs8xNOzvvOhstsKIlcKuFG7P+yqI+IBmzxZO
         mJsRCP/kM98UPZsK3NnJz63mcwMb07Nqx00vbaTOQYTC57faYQ+HTDcjlXSa1Dv3yqQb
         AXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=RzNyhPltgrWbSKOajcj+WQeYyOc8z1GRLS6/VImfVCw=;
        b=fmTYA6iuX1YlZgLrxFg4/ARhV4maGzLRJOIgg8WHhrwnzFbkhO0I1E/cq9cytNN3a1
         bwDw9GV1QN963l0a4kZ/7HfqkIE0fSNzsILaIyxICF5ZAz30CWmkgm3/7w64+cE1VboL
         OMAWY5Iyv52Gd8xLSnozaJsaVfLXXMmI4IRCXcEOplQJlajeGvqCzXLaM9/zdXUuRPo0
         I16clxAiQ696Zhhz+jU4B5suegQgSpEEK/3FBFcj2Ztwb2D9lpiMk/axwxgPvHUeHT3C
         xcjacJODXv9dx+M+ixbLkVTj7cz00COJApQiIvLy8rvzu+rDx/8FMCmrDR4c7pUR62sE
         EnKg==
X-Gm-Message-State: AA+aEWY/PTV34fTH0EHYeB/OHlxlubo6Z9lF6DrPqPio0y3PZ35DFeeM
        5YkH+EMFkoshA+wU2EfMmR6l/Mf1NUE=
X-Google-Smtp-Source: AFSGD/XXU4tl4aT3gibuBN+ykb9Gb4rB6Jc6evmNaSKEeIN5mllijXyTb/i7AY6k6oWtFhWw8fRaXw==
X-Received: by 2002:adf:f649:: with SMTP id x9mr18869739wrp.247.1545238312609;
        Wed, 19 Dec 2018 08:51:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.51.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:51:52 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] a2dp-codecs & avinfo: Fix parsing MPEG bit rate values
Date:   Wed, 19 Dec 2018 17:51:04 +0100
Message-Id: <20181219165109.29088-6-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Redefine bitrate field in a2dp_mpeg_t struct in endian neutral way and
separate vbr field according to A2DP specification. Define new macros
MPEG_GET_BITRATE() and MPEG_SET_BITRATE() for manipulating with bitrate
like for a2dp_aac_t struct.

And fix meaning of bitrate field. According to A2DP specification, it is
bitrate index, not bitrate itself. According to MPEG specification, each
MPEG layer have different bitrates for bitrate indexes. Therefore define
correctly bitrates for Layers 1, 2 and 3.

This fixes problems with parsing bitrate field in a2dp_mpeg_t struct as it
was broken due to endianity and it was broken for Layer 1 and 2 as bitrate
definitions was for Layer 3.
---
 profiles/audio/a2dp-codecs.h |  89 ++++++++++++++++++++++------
 tools/avinfo.c               | 135 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 172 insertions(+), 52 deletions(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 25959902c..64a09796d 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -68,22 +68,71 @@
 #define MPEG_SAMPLING_FREQ_44100	(1 << 1)
 #define MPEG_SAMPLING_FREQ_48000	1
 
-#define MPEG_BIT_RATE_VBR		0x8000
-#define MPEG_BIT_RATE_320000		0x4000
-#define MPEG_BIT_RATE_256000		0x2000
-#define MPEG_BIT_RATE_224000		0x1000
-#define MPEG_BIT_RATE_192000		0x0800
-#define MPEG_BIT_RATE_160000		0x0400
-#define MPEG_BIT_RATE_128000		0x0200
-#define MPEG_BIT_RATE_112000		0x0100
-#define MPEG_BIT_RATE_96000		0x0080
-#define MPEG_BIT_RATE_80000		0x0040
-#define MPEG_BIT_RATE_64000		0x0020
-#define MPEG_BIT_RATE_56000		0x0010
-#define MPEG_BIT_RATE_48000		0x0008
-#define MPEG_BIT_RATE_40000		0x0004
-#define MPEG_BIT_RATE_32000		0x0002
-#define MPEG_BIT_RATE_FREE		0x0001
+#define MPEG_BIT_RATE_INDEX_0		(1 << 0)
+#define MPEG_BIT_RATE_INDEX_1		(1 << 1)
+#define MPEG_BIT_RATE_INDEX_2		(1 << 2)
+#define MPEG_BIT_RATE_INDEX_3		(1 << 3)
+#define MPEG_BIT_RATE_INDEX_4		(1 << 4)
+#define MPEG_BIT_RATE_INDEX_5		(1 << 5)
+#define MPEG_BIT_RATE_INDEX_6		(1 << 6)
+#define MPEG_BIT_RATE_INDEX_7		(1 << 7)
+#define MPEG_BIT_RATE_INDEX_8		(1 << 8)
+#define MPEG_BIT_RATE_INDEX_9		(1 << 9)
+#define MPEG_BIT_RATE_INDEX_10		(1 << 10)
+#define MPEG_BIT_RATE_INDEX_11		(1 << 11)
+#define MPEG_BIT_RATE_INDEX_12		(1 << 12)
+#define MPEG_BIT_RATE_INDEX_13		(1 << 13)
+#define MPEG_BIT_RATE_INDEX_14		(1 << 14)
+
+#define MPEG_MP1_BIT_RATE_32000		MPEG_BIT_RATE_INDEX_1
+#define MPEG_MP1_BIT_RATE_64000		MPEG_BIT_RATE_INDEX_2
+#define MPEG_MP1_BIT_RATE_96000		MPEG_BIT_RATE_INDEX_3
+#define MPEG_MP1_BIT_RATE_128000	MPEG_BIT_RATE_INDEX_4
+#define MPEG_MP1_BIT_RATE_160000	MPEG_BIT_RATE_INDEX_5
+#define MPEG_MP1_BIT_RATE_192000	MPEG_BIT_RATE_INDEX_6
+#define MPEG_MP1_BIT_RATE_224000	MPEG_BIT_RATE_INDEX_7
+#define MPEG_MP1_BIT_RATE_256000	MPEG_BIT_RATE_INDEX_8
+#define MPEG_MP1_BIT_RATE_288000	MPEG_BIT_RATE_INDEX_9
+#define MPEG_MP1_BIT_RATE_320000	MPEG_BIT_RATE_INDEX_10
+#define MPEG_MP1_BIT_RATE_352000	MPEG_BIT_RATE_INDEX_11
+#define MPEG_MP1_BIT_RATE_384000	MPEG_BIT_RATE_INDEX_12
+#define MPEG_MP1_BIT_RATE_416000	MPEG_BIT_RATE_INDEX_13
+#define MPEG_MP1_BIT_RATE_448000	MPEG_BIT_RATE_INDEX_14
+
+#define MPEG_MP2_BIT_RATE_32000		MPEG_BIT_RATE_INDEX_1
+#define MPEG_MP2_BIT_RATE_48000		MPEG_BIT_RATE_INDEX_2
+#define MPEG_MP2_BIT_RATE_56000		MPEG_BIT_RATE_INDEX_3
+#define MPEG_MP2_BIT_RATE_64000		MPEG_BIT_RATE_INDEX_4
+#define MPEG_MP2_BIT_RATE_80000		MPEG_BIT_RATE_INDEX_5
+#define MPEG_MP2_BIT_RATE_96000		MPEG_BIT_RATE_INDEX_6
+#define MPEG_MP2_BIT_RATE_112000	MPEG_BIT_RATE_INDEX_7
+#define MPEG_MP2_BIT_RATE_128000	MPEG_BIT_RATE_INDEX_8
+#define MPEG_MP2_BIT_RATE_160000	MPEG_BIT_RATE_INDEX_9
+#define MPEG_MP2_BIT_RATE_192000	MPEG_BIT_RATE_INDEX_10
+#define MPEG_MP2_BIT_RATE_224000	MPEG_BIT_RATE_INDEX_11
+#define MPEG_MP2_BIT_RATE_256000	MPEG_BIT_RATE_INDEX_12
+#define MPEG_MP2_BIT_RATE_320000	MPEG_BIT_RATE_INDEX_13
+#define MPEG_MP2_BIT_RATE_384000	MPEG_BIT_RATE_INDEX_14
+
+#define MPEG_MP3_BIT_RATE_32000		MPEG_BIT_RATE_INDEX_1
+#define MPEG_MP3_BIT_RATE_40000		MPEG_BIT_RATE_INDEX_2
+#define MPEG_MP3_BIT_RATE_48000		MPEG_BIT_RATE_INDEX_3
+#define MPEG_MP3_BIT_RATE_56000		MPEG_BIT_RATE_INDEX_4
+#define MPEG_MP3_BIT_RATE_64000		MPEG_BIT_RATE_INDEX_5
+#define MPEG_MP3_BIT_RATE_80000		MPEG_BIT_RATE_INDEX_6
+#define MPEG_MP3_BIT_RATE_96000		MPEG_BIT_RATE_INDEX_7
+#define MPEG_MP3_BIT_RATE_112000	MPEG_BIT_RATE_INDEX_8
+#define MPEG_MP3_BIT_RATE_128000	MPEG_BIT_RATE_INDEX_9
+#define MPEG_MP3_BIT_RATE_160000	MPEG_BIT_RATE_INDEX_10
+#define MPEG_MP3_BIT_RATE_192000	MPEG_BIT_RATE_INDEX_11
+#define MPEG_MP3_BIT_RATE_224000	MPEG_BIT_RATE_INDEX_12
+#define MPEG_MP3_BIT_RATE_256000	MPEG_BIT_RATE_INDEX_13
+#define MPEG_MP3_BIT_RATE_320000	MPEG_BIT_RATE_INDEX_14
+
+#define MPEG_BIT_RATE_FREE		MPEG_BIT_RATE_INDEX_0
+
+#define MPEG_GET_BITRATE(a) ((uint16_t)(a).bitrate1 << 8 | (a).bitrate2)
+#define MPEG_SET_BITRATE(a, b) do { (a).bitrate1 = ((b) >> 8) & 0x7f; (a).bitrate2 = (b) & 0xff; } while (0)
 
 #define AAC_OBJECT_TYPE_MPEG2_AAC_LC	0x80
 #define AAC_OBJECT_TYPE_MPEG4_AAC_LC	0x40
@@ -168,7 +217,9 @@ typedef struct {
 	uint8_t frequency:6;
 	uint8_t mpf:1;
 	uint8_t rfa:1;
-	uint16_t bitrate;
+	uint8_t bitrate1:7;
+	uint8_t vbr:1;
+	uint8_t bitrate2;
 } __attribute__ ((packed)) a2dp_mpeg_t;
 
 typedef struct {
@@ -213,7 +264,9 @@ typedef struct {
 	uint8_t rfa:1;
 	uint8_t mpf:1;
 	uint8_t frequency:6;
-	uint16_t bitrate;
+	uint8_t vbr:1;
+	uint8_t bitrate1:7;
+	uint8_t bitrate2;
 } __attribute__ ((packed)) a2dp_mpeg_t;
 
 typedef struct {
diff --git a/tools/avinfo.c b/tools/avinfo.c
index 1f7c68d4b..ca0f12067 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -303,11 +303,15 @@ static void print_mpeg24(a2dp_aac_t *aac, uint8_t size)
 
 static void print_mpeg12(a2dp_mpeg_t *mpeg, uint8_t size)
 {
+	uint16_t bitrate;
+
 	if (size < sizeof(*mpeg)) {
 		printf("\tMedia Codec: MPEG12 (broken)\n");
 		return;
 	}
 
+	bitrate = MPEG_GET_BITRATE(*mpeg);
+
 	printf("\tMedia Codec: MPEG12\n\t\tChannel Modes: ");
 
 	if (mpeg->channel_mode & MPEG_CHANNEL_MODE_MONO)
@@ -343,42 +347,105 @@ static void print_mpeg12(a2dp_mpeg_t *mpeg, uint8_t size)
 	if (mpeg->layer & MPEG_LAYER_MP3)
 		printf("3 ");
 
-	printf("\n\t\tBit Rate: ");
-	if (mpeg->bitrate & MPEG_BIT_RATE_FREE)
-		printf("Free format");
-	else {
-		if (mpeg->bitrate & MPEG_BIT_RATE_32000)
-			printf("32kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_40000)
-			printf("40kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_48000)
-			printf("48kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_56000)
-			printf("56kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_64000)
-			printf("64kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_80000)
-			printf("80kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_96000)
-			printf("96kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_112000)
-			printf("112kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_128000)
-			printf("128kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_160000)
-			printf("160kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_192000)
-			printf("192kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_224000)
-			printf("224kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_256000)
-			printf("256kbps ");
-		if (mpeg->bitrate & MPEG_BIT_RATE_320000)
-			printf("320kbps ");
+	if (bitrate & MPEG_BIT_RATE_FREE) {
+		printf("\n\t\tBit Rate: Free format");
+	} else {
+		if (mpeg->layer & MPEG_LAYER_MP1) {
+			printf("\n\t\tLayer 1 Bit Rate: ");
+			if (bitrate & MPEG_MP1_BIT_RATE_32000)
+				printf("32kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_64000)
+				printf("64kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_96000)
+				printf("96kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_128000)
+				printf("128kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_160000)
+				printf("160kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_192000)
+				printf("192kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_224000)
+				printf("224kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_256000)
+				printf("256kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_320000)
+				printf("320kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_352000)
+				printf("352kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_384000)
+				printf("384kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_416000)
+				printf("416kbps ");
+			if (bitrate & MPEG_MP1_BIT_RATE_448000)
+				printf("448kbps ");
+		}
+
+		if (mpeg->layer & MPEG_LAYER_MP2) {
+			printf("\n\t\tLayer 2 Bit Rate: ");
+			if (bitrate & MPEG_MP2_BIT_RATE_32000)
+				printf("32kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_48000)
+				printf("48kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_56000)
+				printf("56kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_64000)
+				printf("64kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_80000)
+				printf("80kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_96000)
+				printf("96kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_112000)
+				printf("112kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_128000)
+				printf("128kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_160000)
+				printf("160kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_192000)
+				printf("192kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_224000)
+				printf("224kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_256000)
+				printf("256kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_320000)
+				printf("320kbps ");
+			if (bitrate & MPEG_MP2_BIT_RATE_384000)
+				printf("384kbps ");
+		}
+
+		if (mpeg->layer & MPEG_LAYER_MP3) {
+			printf("\n\t\tLayer 3 Bit Rate: ");
+			if (bitrate & MPEG_MP3_BIT_RATE_32000)
+				printf("32kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_40000)
+				printf("40kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_48000)
+				printf("48kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_56000)
+				printf("56kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_64000)
+				printf("64kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_80000)
+				printf("80kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_96000)
+				printf("96kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_112000)
+				printf("112kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_128000)
+				printf("128kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_160000)
+				printf("160kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_192000)
+				printf("192kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_224000)
+				printf("224kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_256000)
+				printf("256kbps ");
+			if (bitrate & MPEG_MP3_BIT_RATE_320000)
+				printf("320kbps ");
+		}
 	}
 
-	printf("\n\t\tVBR: %s", mpeg->bitrate & MPEG_BIT_RATE_VBR ? "Yes" :
-		"No");
+	printf("\n\t\tVBR: %s", mpeg->vbr ? "Yes" : "No");
 
 	printf("\n\t\tPayload Format: ");
 	if (mpeg->mpf)
-- 
2.11.0

