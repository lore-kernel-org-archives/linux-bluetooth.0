Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B6C43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC6821903
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liWP0dr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeLWKkt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:40:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbeLWKks (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 05:40:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so9077622wmb.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7meiL+ScL+Yq1nR82pvjiXdVMpI0uHu6kuF2ctvRJdk=;
        b=liWP0dr3YnOCNIDctlpTaAF1nzHAn9IJkzvgxlYQEZDILJQEGYrbSlzo81LqRz9YgF
         gCn7bx4CTo1xmHaXrxtRJQ2GRCynmFrD9ujCpGw2LJqFK97LobTYzOKaiToDPnBGwvM6
         lPkcG0BPo20l/q8XSqzS1HJgG0zY4kZBwefltQHsTpffMilw+6JX0ll82CYg3VnnSi3A
         KgMD6r7atjmMaUBNwiFSVM3h4k1OZSmq/m93f5pypOcHGPpV2cXKTD8UQxtx7kg1Ir0R
         SlkdMEYfLPT0/B+YBFvy6XaKmiBIoBL+bnZvs5W7e1iROJdFhaYFh/g3fNFV/qA0HU3Y
         kA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=7meiL+ScL+Yq1nR82pvjiXdVMpI0uHu6kuF2ctvRJdk=;
        b=gB3EcV0hLDxjfa1Egjv4wVPUeZUEvtZwmAKXf00+iJsOijHv6QE77YVZ3YpbZD1sgC
         sY/h0IYvW3TZGwoSjwSdF23DprY0f+e2FbJiz1UXg5KlJHL3KHEqvrZfbaUoYZxt0nxj
         lC/XI3/LuO9xfe3t8G8q7gM7HXYWqxhE0YzPLoNspzJ8FytVnpSVgFK3V3enXXuXPHVZ
         9YSm6epdReOTI7QUfpXK7LdrP9wSNY942nXO6rOFjs8cn3ZecFWAI1NbLtxGIj0+cKpK
         lHYp4je2EHBYhHc0S4vB5+fcnqrnp2fGnOZVr46dNUHsSWKo6Fv80+tjA38Ufh5nbeHR
         /9Og==
X-Gm-Message-State: AJcUukcjsgOXu3yfEvoyKD/JKk0eKHfjusHdpA5KMkvyURVQKg1QmeB7
        LD2YmwWcBbMTRxg6g2Y/9QWnxBYvfgw=
X-Google-Smtp-Source: ALg8bN77ftavTDOm8Iulkc8So6J668BLbPIBU50GErzb4YbouHGWQYmN7OUmNw/oAHHpb3uJCNiB/w==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr8560744wml.49.1545561646213;
        Sun, 23 Dec 2018 02:40:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id d4sm12168616wmb.25.2018.12.23.02.40.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 02:40:45 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/10] a2dp-codecs: Add SBC prefix for MIN/MAX_BITPOOL constants
Date:   Sun, 23 Dec 2018 11:40:14 +0100
Message-Id: <20181223104021.18620-4-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181223104021.18620-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
 <20181223104021.18620-1-pali.rohar@gmail.com>
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

