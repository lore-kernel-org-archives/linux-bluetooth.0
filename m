Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B37AC43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE64821783
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGvgg1n7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeLWKlD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:41:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53373 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeLWKlD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 05:41:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so9077872wmb.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 02:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wWFYAlX7zN/6s0AI84e67x5aSGoq4C5sM5HFHDe0hOs=;
        b=fGvgg1n7tlTzuTJ5WYydPS2g1DgGbsaBl+BfCbVCe47gbWujkSjRuk04TSel/r94k0
         lBqrbH/tklOu2SoSzqqQ1cQ5quoSpTAPw1sqcZwfkxiuCrQg5bdyA46Ng69qEh4LOzcU
         y1f2/KEqrFF2cM3z0CzQlH6M7JPRt8bfGP/xx0jkBFAIaytl8JmhZ35tIWXHbEQFYd/U
         fU8/aQGPBLX0tW69uX5zim98NVEfdZcBks/vuvbVlO3Qqbe1v3bb5v03dZCbc+jJgP0F
         pczla7aZN0qxzs6bO9QYvK14YlSZwr/ijWXmaSNbLUwnlvGRMd4rjsl/o7pvfFXFpgnj
         quCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWFYAlX7zN/6s0AI84e67x5aSGoq4C5sM5HFHDe0hOs=;
        b=GH3OTCphW8nL0DTnoZ87ZFX/Q08bveW76FVlCh5le9WwEKkdvw2srh5Def4o0+vhNe
         bIN3GQFEAm/eKe8c3o3UOIC/r9lVA4uJ+IUIRpgKcx3OzYu1u/sxYtPQTXlqdsOCPDiv
         aQnxPG5QMj0Ndj9Gph3gK6zRGCebWVILBNRRlzpOMyjN6+useh8fjMg6tdlO6AJ6e+T7
         7cCHSvV/LM6/AXkcL582WqbDUEAgm4Lt0G7WU1wpxfB/GwxbOGbmY3gOsCOuhy7v1/pt
         jCvNMIK57IbKSnqU53DDLIFvS4U6ZAOx4C6SaPl8MqsEAVXddvR6Kz8/Mf7OThgzpMOe
         Jcwg==
X-Gm-Message-State: AA+aEWbtfJ675LQzQlHkxGc3hXIiS1oTKYsaqfL1y/CbtWDA8JkgyK0/
        JCh0fg31pcYQr9xxAosRps7iBw47SlI=
X-Google-Smtp-Source: ALg8bN7oQITgPDMMInyXoy/JORS/ZqBHxc9qCbXmKAytOC03cELj3ZHSJ6Uv1V72ro3VMEsVHw8tiw==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr8884012wmd.110.1545561656199;
        Sun, 23 Dec 2018 02:40:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id d4sm12168616wmb.25.2018.12.23.02.40.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 02:40:55 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/10] a2dp-codecs: Add macros and structures for new codecs
Date:   Sun, 23 Dec 2018 11:40:20 +0100
Message-Id: <20181223104021.18620-10-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181223104021.18620-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
 <20181223104021.18620-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add additional codecs: FastStream, aptX Low Latency and aptX HD codecs.
---
 profiles/audio/a2dp-codecs.h | 120 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 6f667d3aa..0bdd29110 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2018       Pali Rohár <pali.rohar@gmail.com>
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -197,6 +198,59 @@
 #define APTX_SAMPLING_FREQ_44100	0x02
 #define APTX_SAMPLING_FREQ_48000	0x01
 
+#define FASTSTREAM_VENDOR_ID		0x0000000a
+#define FASTSTREAM_CODEC_ID		0x0001
+
+#define FASTSTREAM_DIRECTION_SINK	0x1
+#define FASTSTREAM_DIRECTION_SOURCE	0x2
+
+#define FASTSTREAM_SINK_SAMPLING_FREQ_44100	0x2
+#define FASTSTREAM_SINK_SAMPLING_FREQ_48000	0x1
+
+#define FASTSTREAM_SOURCE_SAMPLING_FREQ_16000	0x2
+
+#define APTX_LL_VENDOR_ID		0x0000000a
+#define APTX_LL_CODEC_ID		0x0002
+
+#define APTX_LL_CHANNEL_MODE_MONO	0x01
+#define APTX_LL_CHANNEL_MODE_STEREO	0x02
+
+#define APTX_LL_SAMPLING_FREQ_16000	0x08
+#define APTX_LL_SAMPLING_FREQ_32000	0x04
+#define APTX_LL_SAMPLING_FREQ_44100	0x02
+#define APTX_LL_SAMPLING_FREQ_48000	0x01
+
+/* Default parameters for aptX Low Latency encoder */
+
+/* Target codec buffer level = 180 */
+#define APTX_LL_TARGET_LEVEL2	0xb4
+#define APTX_LL_TARGET_LEVEL1	0x00
+
+/* Initial codec buffer level = 360 */
+#define APTX_LL_INITIAL_LEVEL2	0x68
+#define APTX_LL_INITIAL_LEVEL1	0x01
+
+/* SRA max rate 0.005 * 10000 = 50 */
+#define APTX_LL_SRA_MAX_RATE		0x32
+
+/* SRA averaging time = 1s */
+#define APTX_LL_SRA_AVG_TIME		0x01
+
+/* Good working codec buffer level = 180 */
+#define APTX_LL_GOOD_WORKING_LEVEL2	0xB4
+#define APTX_LL_GOOD_WORKING_LEVEL1	0x00
+
+#define APTX_HD_VENDOR_ID		0x000000D7
+#define APTX_HD_CODEC_ID		0x0024
+
+#define APTX_HD_CHANNEL_MODE_MONO	0x1
+#define APTX_HD_CHANNEL_MODE_STEREO	0x2
+
+#define APTX_HD_SAMPLING_FREQ_16000	0x8
+#define APTX_HD_SAMPLING_FREQ_32000	0x4
+#define APTX_HD_SAMPLING_FREQ_44100	0x2
+#define APTX_HD_SAMPLING_FREQ_48000	0x1
+
 #define LDAC_VENDOR_ID			0x0000012d
 #define LDAC_CODEC_ID			0x00aa
 
@@ -237,6 +291,18 @@ typedef struct {
 	})
 
 typedef struct {
+	uint8_t reserved;
+	uint8_t target_level2;
+	uint8_t target_level1;
+	uint8_t initial_level2;
+	uint8_t initial_level1;
+	uint8_t sra_max_rate;
+	uint8_t sra_avg_time;
+	uint8_t good_working_level2;
+	uint8_t good_working_level1;
+} __attribute__ ((packed)) a2dp_aptx_ll_new_caps_t;
+
+typedef struct {
 	a2dp_vendor_codec_t info;
 	uint8_t frequency;
 	uint8_t channel_mode;
@@ -285,6 +351,33 @@ typedef struct {
 	uint8_t frequency:4;
 } __attribute__ ((packed)) a2dp_aptx_t;
 
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t direction;
+	uint8_t sink_frequency:4;
+	uint8_t source_frequency:4;
+} __attribute__ ((packed)) a2dp_faststream_t;
+
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t channel_mode:4;
+	uint8_t frequency:4;
+	uint8_t bidirect_link:1;
+	uint8_t has_new_caps:1;
+	uint8_t reserved:6;
+	a2dp_aptx_ll_new_caps_t new_caps[0];
+} __attribute__ ((packed)) a2dp_aptx_ll_t;
+
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t channel_mode:4;
+	uint8_t frequency:4;
+	uint8_t reserved0;
+	uint8_t reserved1;
+	uint8_t reserved2;
+	uint8_t reserved3;
+} __attribute__ ((packed)) a2dp_aptx_hd_t;
+
 #elif defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && \
 	__BYTE_ORDER == __BIG_ENDIAN
 
@@ -328,6 +421,33 @@ typedef struct {
 	uint8_t channel_mode:4;
 } __attribute__ ((packed)) a2dp_aptx_t;
 
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t direction;
+	uint8_t source_frequency:4;
+	uint8_t sink_frequency:4;
+} __attribute__ ((packed)) a2dp_faststream_t;
+
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t frequency:4;
+	uint8_t channel_mode:4;
+	uint8_t reserved:6;
+	uint8_t has_new_caps:1;
+	uint8_t bidirect_link:1;
+	a2dp_aptx_ll_new_caps_t new_caps[0];
+} __attribute__ ((packed)) a2dp_aptx_ll_t;
+
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t frequency:4;
+	uint8_t channel_mode:4;
+	uint8_t reserved0;
+	uint8_t reserved1;
+	uint8_t reserved2;
+	uint8_t reserved3;
+} __attribute__ ((packed)) a2dp_aptx_hd_t;
+
 #else
 #error "Unknown byte order"
 #endif
-- 
2.11.0

