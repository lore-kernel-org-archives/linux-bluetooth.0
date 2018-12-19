Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2811FC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1188217D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueHUo62+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeLSQvq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:51:46 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:40490 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSQvq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:51:46 -0500
Received: by mail-wm1-f54.google.com with SMTP id f188so6478937wmf.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=EbhBESq3lpA2BbBrYNnyuPauZNe1jkwGZd7e+eQzdH8=;
        b=ueHUo62+ux943PU12t+yTqWr0yps1RWWxn0pB/3WQQpPrLs9jSueOH+4QcAMK6CqCP
         yoCAShUmTynHbkXjhhB6Xl3TyXnR+dEmAku60nLtDassyPrx7PCW9/fLIYBZCdaEALkT
         cUn6911s2XH6fVBvXhBV9jZTbosG3RTbWSksm+ea/qEIxpadsXkGxUXYxH5HYfkmKfkI
         b9jvjCPoJ+cVj2V9PsqBoEzPyrZBVl7tmXOG1zoGxzqiHu7lif4+0I/CVH+bIQKkJnk9
         /yJqpe/YYmPNvcmYT5jAMdkosZFHiDrGkNXh5Jc+1BZQ2wiT+VzDRazuh65kZXYklZE2
         CNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=EbhBESq3lpA2BbBrYNnyuPauZNe1jkwGZd7e+eQzdH8=;
        b=aNW9v9E4gadWgoMWZM3Gfo/bPr15PWvx1fwgw6KlrvKUfP2aq1dtzUtMXXkGGdqvC1
         2w8OWzod5xPrAVOCz3s/DylxK1YHV9lOywN/LYVJB7mfsYgB/EHlSRgBCFbS5VvL/M/s
         04uOo/H+VsXj2nXGbA5g7kEy6pxQPmLZNTz6sY6Qx3bHTqpko7bTVvuwZJKosriwzfjP
         QGhnmWw12zjSwUn06V5NuRBnwI46cSWcIzcv8ujjZSz7N/V9ddTn90PlgjyWVJTGKyn/
         ePwaHCj1qTbivJRRm8DxjHTCYYHQj/CdO+NJzl/hqTz50uVb9gkB+FqN9SzgBme9tUKh
         gXkg==
X-Gm-Message-State: AA+aEWZT750FwqOaGo9gYNFlBUxDepXyDyKmOf2zD6yoXD8bDzsgqaP2
        wwl8i08ZYiCxjJqyzO9a68zxNdMJJ6M=
X-Google-Smtp-Source: AFSGD/XAUPkS9LUOMzdB7tSRK058OKoda89AXrKpndqM12YtaIRINnfQ4ZvOnCIfv77VJ4rMEFSDlw==
X-Received: by 2002:a1c:7ec4:: with SMTP id z187mr7740257wmc.43.1545238303938;
        Wed, 19 Dec 2018 08:51:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.51.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:51:42 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10] avinfo: Fix buffer overflow when parsing broken/malicious data
Date:   Wed, 19 Dec 2018 17:51:00 +0100
Message-Id: <20181219165109.29088-2-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/avinfo.c | 89 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 20 deletions(-)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index 31c4e106e..a7a61b881 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -167,10 +167,15 @@ struct avdtp_content_protection_capability {
 	uint8_t data[0];
 } __attribute__ ((packed));
 
-static void print_aptx(a2dp_aptx_t *aptx)
+static void print_aptx(a2dp_aptx_t *aptx, uint8_t size)
 {
 	printf("\t\tVendor Specific Value (aptX)");
 
+	if (size < sizeof(*aptx)) {
+		printf(" (broken)\n");
+		return;
+	}
+
 	printf("\n\t\t\tFrequencies: ");
 	if (aptx->frequency & APTX_SAMPLING_FREQ_16000)
 		printf("16kHz ");
@@ -190,20 +195,34 @@ static void print_aptx(a2dp_aptx_t *aptx)
 	printf("\n");
 }
 
-static void print_ldac(a2dp_ldac_t *ldac)
+static void print_ldac(a2dp_ldac_t *ldac, uint8_t size)
 {
 	printf("\t\tVendor Specific Value (LDAC)");
 
+	if (size < sizeof(*ldac)) {
+		printf(" (broken)\n");
+		return;
+	}
+
 	printf("\n\t\t\tUnknown: %02x %02x", ldac->unknown[0],
 							ldac->unknown[1]);
 
 	printf("\n");
 }
 
-static void print_vendor(a2dp_vendor_codec_t *vendor)
+static void print_vendor(a2dp_vendor_codec_t *vendor, uint8_t size)
 {
-	uint32_t vendor_id = btohl(vendor->vendor_id);
-	uint16_t codec_id = btohs(vendor->codec_id);
+	uint32_t vendor_id;
+	uint16_t codec_id;
+	uint8_t i;
+
+	if (size < sizeof(*vendor)) {
+		printf("\tMedia Codec: Vendor Specific A2DP Codec (broken)");
+		return;
+	}
+
+	vendor_id = btohl(vendor->vendor_id);
+	codec_id = btohs(vendor->codec_id);
 
 	printf("\tMedia Codec: Vendor Specific A2DP Codec");
 
@@ -212,15 +231,22 @@ static void print_vendor(a2dp_vendor_codec_t *vendor)
 	printf("\n\t\tVendor Specific Codec ID 0x%04x\n", codec_id);
 
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
-		print_aptx((void *) vendor);
+		print_aptx((void *) vendor, size);
 	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
-		print_ldac((void *) vendor);
+		print_ldac((void *) vendor, size);
 }
 
-static void print_mpeg24(a2dp_aac_t *aac)
+static void print_mpeg24(a2dp_aac_t *aac, uint8_t size)
 {
-	unsigned freq = AAC_GET_FREQUENCY(*aac);
-	unsigned bitrate = AAC_GET_BITRATE(*aac);
+	unsigned freq, bitrate;
+
+	if (size < sizeof(*aac)) {
+		printf("\tMedia Codec: MPEG24 (broken)\n");
+		return;
+	}
+
+	freq = AAC_GET_FREQUENCY(*aac);
+	bitrate = AAC_GET_BITRATE(*aac);
 
 	printf("\tMedia Codec: MPEG24\n\t\tObject Types: ");
 
@@ -270,8 +296,13 @@ static void print_mpeg24(a2dp_aac_t *aac)
 	printf("\n\t\tVBR: %s", aac->vbr ? "Yes\n" : "No\n");
 }
 
-static void print_mpeg12(a2dp_mpeg_t *mpeg)
+static void print_mpeg12(a2dp_mpeg_t *mpeg, uint8_t size)
 {
+	if (size < sizeof(*mpeg)) {
+		printf("\tMedia Codec: MPEG12 (broken)\n");
+		return;
+	}
+
 	printf("\tMedia Codec: MPEG12\n\t\tChannel Modes: ");
 
 	if (mpeg->channel_mode & MPEG_CHANNEL_MODE_MONO)
@@ -351,8 +382,13 @@ static void print_mpeg12(a2dp_mpeg_t *mpeg)
 		printf("RFC-2250\n");
 }
 
-static void print_sbc(a2dp_sbc_t *sbc)
+static void print_sbc(a2dp_sbc_t *sbc, uint8_t size)
 {
+	if (size < sizeof(*sbc)) {
+		printf("\tMedia Codec: SBC (broken)\n");
+		return;
+	}
+
 	printf("\tMedia Codec: SBC\n\t\tChannel Modes: ");
 
 	if (sbc->channel_mode & SBC_CHANNEL_MODE_MONO)
@@ -394,20 +430,25 @@ static void print_sbc(a2dp_sbc_t *sbc)
 				sbc->min_bitpool, sbc->max_bitpool);
 }
 
-static void print_media_codec(struct avdtp_media_codec_capability *cap)
+static void print_media_codec(struct avdtp_media_codec_capability *cap, uint8_t size)
 {
+	if (size < sizeof(*cap)) {
+		printf("\tMedia Codec: Unknown (broken)\n");
+		return;
+	}
+
 	switch (cap->media_codec_type) {
 	case A2DP_CODEC_SBC:
-		print_sbc((void *) cap->data);
+		print_sbc((void *) cap->data, size - 2);
 		break;
 	case A2DP_CODEC_MPEG12:
-		print_mpeg12((void *) cap->data);
+		print_mpeg12((void *) cap->data, size - 2);
 		break;
 	case A2DP_CODEC_MPEG24:
-		print_mpeg24((void *) cap->data);
+		print_mpeg24((void *) cap->data, size - 2);
 		break;
 	case A2DP_CODEC_VENDOR:
-		print_vendor((void *) cap->data);
+		print_vendor((void *) cap->data, size - 2);
 		break;
 	default:
 		printf("\tMedia Codec: Unknown\n");
@@ -415,10 +456,16 @@ static void print_media_codec(struct avdtp_media_codec_capability *cap)
 }
 
 static void print_content_protection(
-				struct avdtp_content_protection_capability *cap)
+				struct avdtp_content_protection_capability *cap,
+				uint8_t size)
 {
 	printf("\tContent Protection: ");
 
+	if (size < sizeof(*cap)) {
+		printf("Unknown (broken)\n");
+		return;
+	}
+
 	switch (btohs(cap->content_protection_type)) {
 	case AVDTP_CONTENT_PROTECTION_TYPE_DTCP:
 		printf("DTCP");
@@ -452,13 +499,15 @@ static void print_caps(void *data, int size)
 		case AVDTP_REPORTING:
 		case AVDTP_RECOVERY:
 		case AVDTP_MULTIPLEXING:
+		default:
 			/* FIXME: Add proper functions */
+			printf("\tUnknown category: %d\n", cap->category);
 			break;
 		case AVDTP_MEDIA_CODEC:
-			print_media_codec((void *) cap->data);
+			print_media_codec((void *) cap->data, cap->length);
 			break;
 		case AVDTP_CONTENT_PROTECTION:
-			print_content_protection((void *) cap->data);
+			print_content_protection((void *) cap->data, cap->length);
 			break;
 		}
 
-- 
2.11.0

