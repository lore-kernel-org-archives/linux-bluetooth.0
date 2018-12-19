Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5715FC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B27217D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOxKp6Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbeLSQwG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:52:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34009 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbeLSQwG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:52:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so20258640wrw.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XhsF65BQSRfMTAEMjbqKS6Uhtnu02UkSTdfBc/tR3i4=;
        b=EOxKp6Ggf7UPAUlhBXrxhi8iuuaJthMcXMH+RQ4KC0RlhUBMcQh3SEdcnV9EEkfYO9
         NJWFSGNY6s6vln1zvmCNMI+LAD2/0v/xun7XFfbhKY3+vMdyvbFp8xgSjDmYV2z8O14q
         67RWuYm5+3UL+AFav5Tmz2z6KWlA0a1M9j6P7K8wpbDqEt3RgQQwbzc4uM45G7Hd6mEr
         5lFc3Cv65fVNk9NNsy/Bl8eZQXW+TnHaGwQDSo6B6QlTFaxNeHkwVMRXYSsQC77nbyCv
         Kobv/j1fDj3/E/sc55rzNOdCwO8ZS86id3YMcYlLsiEZmgh1xNj8yaepC1lAP2D9++en
         7g3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhsF65BQSRfMTAEMjbqKS6Uhtnu02UkSTdfBc/tR3i4=;
        b=HOsXTs4usjiWsp10/EequTvn4FRebIgq2lhNo5LxMopLE1LzE9vJgYbSAZ3nnSf9Hd
         I9FWpSNBYCNNlW5iLZx/Bn1/e7TpA/IdPnnwk/5nSih3DIxKeYKUg7QLH0so27yU2YJd
         XI5DEpGXw3L+AmPSkwmt/srDnHOXvTMmKuJo6w+7inr3phgg0CkRdE+Ldj7R0gLq8pyC
         K/Dfoyq2gAEhdxwg3SoPd61zNs3DtTGB2DQ1xrjL9r7TZXuJohptqnexwEA36cv9zxXO
         4995tceRXjg6NhjSySr9DRb4akwGfjQWRM9acTL9TvmLJl+mTSQeC+zgk+zBnONjdjkx
         Wn8g==
X-Gm-Message-State: AA+aEWYGBedwgAgtxMcV+Oygg1X2ndqivMFoxYgRHGMUbSVAOLXI6XaO
        Ev7k/vFf8fhwvwllHY348tw+ISu/iY4=
X-Google-Smtp-Source: AFSGD/WVP7b1eHGcJGwHDOfu/tP+PUNZ1cQNX5qY3UTnMQ7P9tP4u+uxxmUaFP1iR80CoUmYHTmEgg==
X-Received: by 2002:a5d:628a:: with SMTP id k10mr18791142wru.254.1545238323444;
        Wed, 19 Dec 2018 08:52:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.52.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:52:02 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] avinfo: Parse information about A2DP codecs: FastStream, aptX Low Latency, aptX HD and LDAC
Date:   Wed, 19 Dec 2018 17:51:09 +0100
Message-Id: <20181219165109.29088-11-pali.rohar@gmail.com>
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
 tools/avinfo.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index 78da0d5d2..9c05eb889 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2018       Pali Rohár <pali.rohar@gmail.com>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -195,6 +196,107 @@ static void print_aptx(a2dp_aptx_t *aptx, uint8_t size)
 	printf("\n");
 }
 
+static void print_faststream(a2dp_faststream_t *faststream, uint8_t size)
+{
+	printf("\t\tVendor Specific Value (FastStream)");
+
+	if (size < sizeof(*faststream)) {
+		printf(" (broken)\n");
+		return;
+	}
+
+	printf("\n\t\t\tDirections: ");
+	if (faststream->direction & FASTSTREAM_DIRECTION_SINK)
+		printf("sink ");
+	if (faststream->direction & FASTSTREAM_DIRECTION_SOURCE)
+		printf("source ");
+
+	if (faststream->direction & FASTSTREAM_DIRECTION_SINK) {
+		printf("\n\t\t\tSink Frequencies: ");
+		if (faststream->sink_frequency & FASTSTREAM_SINK_SAMPLING_FREQ_44100)
+			printf("44.1kHz ");
+		if (faststream->sink_frequency & FASTSTREAM_SINK_SAMPLING_FREQ_48000)
+			printf("48kHz ");
+	}
+
+	if (faststream->direction & FASTSTREAM_DIRECTION_SOURCE) {
+		printf("\n\t\t\tSource Frequencies: ");
+		if (faststream->source_frequency & FASTSTREAM_SOURCE_SAMPLING_FREQ_16000)
+			printf("16kHz ");
+	}
+
+	printf("\n");
+}
+
+static void print_aptx_ll(a2dp_aptx_ll_t *aptx_ll, uint8_t size)
+{
+	a2dp_aptx_ll_new_caps_t *aptx_ll_new;
+
+	printf("\t\tVendor Specific Value (aptX Low Latency)");
+
+	if (size < sizeof(*aptx_ll)) {
+		printf(" (broken)\n");
+		return;
+	}
+
+	printf("\n\t\t\tFrequencies: ");
+	if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_16000)
+		printf("16kHz ");
+	if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_32000)
+		printf("32kHz ");
+	if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_44100)
+		printf("44.1kHz ");
+	if (aptx_ll->frequency & APTX_LL_SAMPLING_FREQ_48000)
+		printf("48kHz ");
+
+	printf("\n\t\t\tChannel modes: ");
+	if (aptx_ll->channel_mode & APTX_LL_CHANNEL_MODE_MONO)
+		printf("Mono ");
+	if (aptx_ll->channel_mode & APTX_LL_CHANNEL_MODE_STEREO)
+		printf("Stereo ");
+
+	printf("\n\t\tBidirectional link: %s", aptx_ll->bidirect_link ? "Yes" : "No");
+
+	aptx_ll_new = &aptx_ll->new_caps[0];
+	if (aptx_ll->has_new_caps && size >= sizeof(*aptx_ll) + sizeof(*aptx_ll_new)) {
+		printf("\n\t\tTarget codec buffer level: %u", (unsigned)aptx_ll_new->target_level2 | ((unsigned)(aptx_ll_new->target_level1) << 8));
+		printf("\n\t\tInitial codec buffer level: %u", (unsigned)aptx_ll_new->initial_level2 | ((unsigned)(aptx_ll_new->initial_level1) << 8));
+		printf("\n\t\tSRA max rate: %g", aptx_ll_new->sra_max_rate / 10000.0);
+		printf("\n\t\tSRA averaging time: %us", (unsigned)aptx_ll_new->sra_avg_time);
+		printf("\n\t\tGood working codec buffer level: %u", (unsigned)aptx_ll_new->good_working_level2 | ((unsigned)(aptx_ll_new->good_working_level1) << 8));
+	}
+
+	printf("\n");
+}
+
+static void print_aptx_hd(a2dp_aptx_hd_t *aptx_hd, uint8_t size)
+{
+	printf("\t\tVendor Specific Value (aptX HD)");
+
+	if (size < sizeof(*aptx_hd)) {
+		printf(" (broken)\n");
+		return;
+	}
+
+	printf("\n\t\t\tFrequencies: ");
+	if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_16000)
+		printf("16kHz ");
+	if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_32000)
+		printf("32kHz ");
+	if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_44100)
+		printf("44.1kHz ");
+	if (aptx_hd->frequency & APTX_HD_SAMPLING_FREQ_48000)
+		printf("48kHz ");
+
+	printf("\n\t\t\tChannel modes: ");
+	if (aptx_hd->channel_mode & APTX_HD_CHANNEL_MODE_MONO)
+		printf("Mono ");
+	if (aptx_hd->channel_mode & APTX_HD_CHANNEL_MODE_STEREO)
+		printf("Stereo ");
+
+	printf("\n");
+}
+
 static void print_ldac(a2dp_ldac_t *ldac, uint8_t size)
 {
 	printf("\t\tVendor Specific Value (LDAC)");
@@ -204,7 +306,27 @@ static void print_ldac(a2dp_ldac_t *ldac, uint8_t size)
 		return;
 	}
 
-	printf("\n\t\t\tUnknown: %02x %02x", ldac->frequency, ldac->channel_mode);
+	printf("\n\t\t\tFrequencies: ");
+	if (ldac->frequency & LDAC_SAMPLING_FREQ_44100)
+		printf("44.1kHz ");
+	if (ldac->frequency & LDAC_SAMPLING_FREQ_48000)
+		printf("48kHz ");
+	if (ldac->frequency & LDAC_SAMPLING_FREQ_88200)
+		printf("88.2kHz ");
+	if (ldac->frequency & LDAC_SAMPLING_FREQ_96000)
+		printf("96kHz ");
+	if (ldac->frequency & LDAC_SAMPLING_FREQ_176400)
+		printf("176.4kHz ");
+	if (ldac->frequency & LDAC_SAMPLING_FREQ_192000)
+		printf("192kHz ");
+
+	printf("\n\t\t\tChannel modes: ");
+	if (ldac->channel_mode & LDAC_CHANNEL_MODE_MONO)
+		printf("Mono ");
+	if (ldac->channel_mode & LDAC_CHANNEL_MODE_DUAL)
+		printf("Dual ");
+	if (ldac->channel_mode & LDAC_CHANNEL_MODE_STEREO)
+		printf("Stereo ");
 
 	printf("\n");
 }
@@ -236,6 +358,12 @@ static void print_vendor(a2dp_vendor_codec_t *vendor, uint8_t size)
 
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		print_aptx((void *) vendor, size);
+	else if (vendor_id == FASTSTREAM_VENDOR_ID && codec_id == FASTSTREAM_CODEC_ID)
+		print_faststream((void *) vendor, size);
+	else if (vendor_id == APTX_LL_VENDOR_ID && codec_id == APTX_LL_CODEC_ID)
+		print_aptx_ll((void *) vendor, size);
+	else if (vendor_id == APTX_HD_VENDOR_ID && codec_id == APTX_HD_CODEC_ID)
+		print_aptx_hd((void *) vendor, size);
 	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
 		print_ldac((void *) vendor, size);
 }
-- 
2.11.0

