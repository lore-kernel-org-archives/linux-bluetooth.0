Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D17C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619A7217D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVgioj7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeLSQwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:52:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50987 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSQwE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:52:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so6784357wmd.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AFyc4oS/UBNtnuq2iaFvAs/icjd9xxVp7/r+yOpQi64=;
        b=ZVgioj7fkQ/4ImRRDsnR9Gn/fdM4btVzDWv6tiZTAiH2GtyF+L7DNvOTpwoTDldKZ0
         BvrWSFcrA8KdbUTeSCEIyDJZX4j4hX4emTyoag98ApWoHj58FgsZIQduEdWky2rzKdF4
         xvOT+jA+31Uh07u08ukzMAEMycDgz5O48tD0six9KAc9Hz5BZZYhAtDqkExH8ZtxXK2m
         RnutVCaQPcE+7W5h4iKYLvOxNnC1SPKL5FvP5/NX1TaCsq77rCiL6cH5PCjpdQuNV3Ba
         R+EcpMOP/I4IRH78ijqoD4gBrZmv7uLIC6xJ8/4r84Hg6lXYTyFIW3ArJiCMI1bxLp5M
         aKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AFyc4oS/UBNtnuq2iaFvAs/icjd9xxVp7/r+yOpQi64=;
        b=dz5BDQ/xq/prG1GeKToCQQv7XcMMDpPM63Igz4srvTLY5w92mIiowsN4S93KL2J8DG
         l2rcyF6iRhZTdAAbyC+ZkN6FcKQ8pVVEg22fbPL9Luw0ni/gcgy8zDMnmT442FNp6Fk1
         To16D3XYQx9o2GJXoTEPzZQggsiyWs56nZb98C1JaC/yhwYH22GbLFWzcJXhA9AgWY4r
         SVIHIjhNDUX6spFjNafZ62plnfeW3CdpMU5f2APsRdY6raixWTHXRyuzYaxErajDNzMz
         ckmwoJKXv6lzf0J26FYHC0pzCxywdlcMKbE7yoCSm7KwYdMtQiD2HHzqjP4DsEjU71UG
         3MXA==
X-Gm-Message-State: AA+aEWYZgWe5gZ1Y7J+TlraPVXSO3GhPwUJxmTHmbvGoJxLx96jtnyTx
        s1mjr/qR98Bc7GAfr7y4PYWdt+boUws=
X-Google-Smtp-Source: AFSGD/UjMl4VomAmdsulxDr5aZq2W8D8AmWsSkHxv9J33CP5qzDjNUsSoPgyGZFPQt1q4vjYfQYDAg==
X-Received: by 2002:a1c:2686:: with SMTP id m128mr7537015wmm.52.1545238321400;
        Wed, 19 Dec 2018 08:52:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.52.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:52:00 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] a2dp-codecs: Add macros and structures for FastStream, aptX Low Latency and aptX HD codecs
Date:   Wed, 19 Dec 2018 17:51:08 +0100
Message-Id: <20181219165109.29088-10-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/audio/a2dp-codecs.h | 120 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 9f47755cb..d4a393668 100644
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
@@ -193,6 +194,59 @@
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
 
@@ -228,6 +282,18 @@ typedef struct {
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
@@ -275,6 +341,33 @@ typedef struct {
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
 #elif defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && __BYTE_ORDER == __BIG_ENDIAN
 
 typedef struct {
@@ -317,6 +410,33 @@ typedef struct {
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

