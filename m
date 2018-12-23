Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889AAC43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4244A21903
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC8dB1XT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeLWKkw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:40:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53013 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbeLWKkw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 05:40:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so9104393wml.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 02:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=6YZKGdx0pnZR57G6IbJ9hFMjYeg5tzadBBWrQoJCM0g=;
        b=WC8dB1XT7K2Ncg+Z5sJDsth2k36m6YhW13DVta+huXP90TBmijzqTvBdfSyK7qg2uC
         FbmwbuK1FWdk/WwSoP/HoiCxXF04c+cw5uyKmOhUjGL7Sfzxxmp93vxBtlOxyL2x0wGa
         4+pePJwzssy+4yBVQo5rzFFWnBRouJytACk2ukfWMPypwXV3EHx5En+iYSMRzv2mjvy9
         XEFp5oz0er1aUfzLQSfPHJtHwPKJ7iL+eQdlOVvDxVP/xlL7NGvv/QuTpD0JDMy7byjY
         jmbVcfibJ9mqe/jl+xIhkh6hJHaXSQ1EWEhP86HcjQWidrhVNs3jBIr215J4qrk/PXfN
         hN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=6YZKGdx0pnZR57G6IbJ9hFMjYeg5tzadBBWrQoJCM0g=;
        b=PWCFntKl+w7EYTupQyrBw1jmw5e6sHh+aKzxJMrGruT2pKS98p8nKucfeGL59eW5Dx
         1a9IITJHEI1s2KDPlbM57wwbGQFtTDLxSjkbshs7aFlwKqgZIP+yEWHHq2sQ3Y0s+aD0
         m7fWAWDsKMRvP2196NsNopNY2h5OzGPBJ9EMYsA5Fwn2671pKcxu1bGYNj7wpu+sxJ0F
         8D1LfxrFnNXLRQBidGoOh+stESz9jFbsbmJDFvoiqLhMwcULkz3t29082wVUYpwbi88m
         ShrF6fdVTSgFK8r7AbfOSRRxP+ynC9YWFLvXnLU3mwTfuzO+8wqjBzNTwfcrS8EW2Rrn
         PPPA==
X-Gm-Message-State: AA+aEWb1Q+z5Cl/eDqxnOBk3+j3V2xljMTUM7TNbjXV6Kacw+Uu/yiWO
        7ACMk1xbxk632ouWSKh7v6WsQfvO/cw=
X-Google-Smtp-Source: ALg8bN5ag0FjmJCMjC/YdEWgVPg9liV24SkJUK8E/cwiIpRkaXcownWFwzzyUhf6jUMymxOTZrLDrQ==
X-Received: by 2002:a1c:58ce:: with SMTP id m197mr9361224wmb.31.1545561649572;
        Sun, 23 Dec 2018 02:40:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id d4sm12168616wmb.25.2018.12.23.02.40.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 02:40:48 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/10] a2dp-codecs & avinfo: Fix parsing MPEG bit rate values
Date:   Sun, 23 Dec 2018 11:40:16 +0100
Message-Id: <20181223104021.18620-6-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181223104021.18620-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
 <20181223104021.18620-1-pali.rohar@gmail.com>
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
 profiles/audio/a2dp-codecs.h |  93 +++++++++++++++++++++++------
 tools/avinfo.c               | 135 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 176 insertions(+), 52 deletions(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 25959902c..47030bcc1 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -68,22 +68,75 @@
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
+#define MPEG_SET_BITRATE(a, b) \
+	do { \
+		(a).bitrate1 = ((b) >> 8) & 0x7f; \
+		(a).bitrate2 = (b) & 0xff; \
+	} while (0)
 
 #define AAC_OBJECT_TYPE_MPEG2_AAC_LC	0x80
 #define AAC_OBJECT_TYPE_MPEG4_AAC_LC	0x40
@@ -168,7 +221,9 @@ typedef struct {
 	uint8_t frequency:6;
 	uint8_t mpf:1;
 	uint8_t rfa:1;
-	uint16_t bitrate;
+	uint8_t bitrate1:7;
+	uint8_t vbr:1;
+	uint8_t bitrate2;
 } __attribute__ ((packed)) a2dp_mpeg_t;
 
 typedef struct {
@@ -213,7 +268,9 @@ typedef struct {
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
index b79446825..bb80cf583 100644
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

