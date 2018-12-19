Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A1BC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82CF217D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd/5UFgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeLSQvv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:51:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42630 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSQvv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:51:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so20220619wrx.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7meiL+ScL+Yq1nR82pvjiXdVMpI0uHu6kuF2ctvRJdk=;
        b=Sd/5UFgtqhPDh8SUFjIC48lGruklTK/uYVAzDLPYohRRpBxNdpALN0qgU7ozGHTO7q
         jLrGDwV1KuCNfTYWx4hDUey25wc71/PAVrZXX1h8UvyNaKFtoTrTzLV9qX1viE8JTG6R
         ocUY2R1+AxD/soWoYKUvC+/MAhI+J31WqIxZ1iCg+C6sHoBSsZCZmEa6Nt08G2ya2GXG
         uLtO4Ruzgbi115SWSYfWYu05PG8mraqzYzZfW0i/oNG51uYXG43C6E+CFp4oBS3weICR
         YWceV8gAl9K5eBIigc4i/eBJ2+iMDG0nTDxljEqtL4CEw9N3q3aSfo3iENS1AEQmvyC3
         IhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=7meiL+ScL+Yq1nR82pvjiXdVMpI0uHu6kuF2ctvRJdk=;
        b=Ukbdclbn0vvkEqBaVvAgYB/CKdObOy/Om/g0p94zZXTozO7AYaTo49x3fV7s2r/fd/
         YC4Vc9cdfaoREoWfuWf8Bhc2VqnWJx5gzmASoU1jd97m4g4vio4RviAkRHg9UXx8m/st
         AAMxEv9DaBKDnaNmEi2rdp8X63lp2suBxADhVwxrUDEU86QrKTALSNpeOCoTxv47MtJ6
         Y3JUVeV6WFuLlV92w/npK6m1urHeAODp3jBsZMZkvOu9fUDPhstw4kUkB6ByyQUYVrOu
         WQ5ZH1MXWVvqD4yt/IFX6kwqK1JNgOfvSzfh2hEclARw4NFpbaI2jH9dij8Z/RudAYBQ
         IBjw==
X-Gm-Message-State: AA+aEWYRiSeOFGDcV/ID3J7p5SW1dpWf0WU1sEEXiiD0yiH9TP2t/IYl
        PNGE9zeE5HfPqMNreCwQnb0pA8r4hrA=
X-Google-Smtp-Source: AFSGD/XN5M+hQ6rQeEAp8EPoccDy3Sx/XXZdAdx32aY4ipkSo8CrsimDxZeWY0raqgICRuDXIcGhzQ==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr13791139wro.29.1545238309082;
        Wed, 19 Dec 2018 08:51:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.51.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:51:48 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] a2dp-codecs: Add SBC prefix for MIN/MAX_BITPOOL constants
Date:   Wed, 19 Dec 2018 17:51:02 +0100
Message-Id: <20181219165109.29088-4-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Those two constants are SBC codec specific.
---
 android/hal-audio-sbc.c      | 12 ++++++------
 profiles/audio/a2dp-codecs.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
index 9da9575f5..80e271ed6 100644
--- a/android/hal-audio-sbc.c
+++ b/android/hal-audio-sbc.c
@@ -91,8 +91,8 @@ static const a2dp_sbc_t sbc_presets[] = {
 					SBC_ALLOCATION_LOUDNESS,
 		.block_length = SBC_BLOCK_LENGTH_4 | SBC_BLOCK_LENGTH_8 |
 				SBC_BLOCK_LENGTH_12 | SBC_BLOCK_LENGTH_16,
-		.min_bitpool = MIN_BITPOOL,
-		.max_bitpool = MAX_BITPOOL
+		.min_bitpool = SBC_MIN_BITPOOL,
+		.max_bitpool = SBC_MAX_BITPOOL
 	},
 	{
 		.frequency = SBC_SAMPLING_FREQ_44100,
@@ -100,8 +100,8 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.subbands = SBC_SUBBANDS_8,
 		.allocation_method = SBC_ALLOCATION_LOUDNESS,
 		.block_length = SBC_BLOCK_LENGTH_16,
-		.min_bitpool = MIN_BITPOOL,
-		.max_bitpool = MAX_BITPOOL
+		.min_bitpool = SBC_MIN_BITPOOL,
+		.max_bitpool = SBC_MAX_BITPOOL
 	},
 	{
 		.frequency = SBC_SAMPLING_FREQ_48000,
@@ -109,8 +109,8 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.subbands = SBC_SUBBANDS_8,
 		.allocation_method = SBC_ALLOCATION_LOUDNESS,
 		.block_length = SBC_BLOCK_LENGTH_16,
-		.min_bitpool = MIN_BITPOOL,
-		.max_bitpool = MAX_BITPOOL
+		.min_bitpool = SBC_MIN_BITPOOL,
+		.max_bitpool = SBC_MAX_BITPOOL
 	},
 };
 
diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 4fb5c0cc9..205491939 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -49,8 +49,8 @@
 #define SBC_ALLOCATION_SNR		(1 << 1)
 #define SBC_ALLOCATION_LOUDNESS		1
 
-#define MAX_BITPOOL 64
-#define MIN_BITPOOL 2
+#define SBC_MAX_BITPOOL			64
+#define SBC_MIN_BITPOOL			2
 
 #define MPEG_CHANNEL_MODE_MONO		(1 << 3)
 #define MPEG_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
-- 
2.11.0

