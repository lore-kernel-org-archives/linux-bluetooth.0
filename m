Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB90C282CD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 23:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FF22171F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 23:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIOg6VaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfA1XKl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:10:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51495 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1XKk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 18:10:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so15875011wmj.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jan 2019 15:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=fHBZZC1rFxA/imv1oe3XF8GYogRn/t/C+PtgDs5Nx5I=;
        b=gIOg6VaXdM/3jCN8WcTg3D+lnT3x1m7VgKvRq91BUWiLq9vNnUrrtn0dW4JavyeO9z
         emOgP5dfIEyFcvHHLSOLdTX53eRAhyfJUTr683QOUfa/Ss4fghn4JPz8nUjIhDbveYzO
         cT6aDF3UzRxTgTGaOjbkD2CwVbDllstpzfJLJs/AysdhY/G+X5qxloJoM+ZsUVH+phLA
         bxSnWn/mHUwekqa6xEBrfdVixwD9o4tz9ZWZuMXPyOV1g55NaHOp4tzpvg84scEX3gvM
         lGSHqX8RQDcXtk4BE/q/x8SbGCxTs2XNRn0T3mOhoxOd0dKKOlLzUnwrrWIry/H52mKe
         FK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=fHBZZC1rFxA/imv1oe3XF8GYogRn/t/C+PtgDs5Nx5I=;
        b=solKdieJ2OuPbXCmfy1JLKSnu/xrwp6tpfrmYdJeg2DCC4I5AoIGcVM8I8eM2DHfPC
         djLJttCmHTzyHL8B2w26ZpKsC1t2Ued+RnWj+J7gcrqa9xtuMBDUU9/VfNGNr7pp5Lf+
         H16lfyP04nv1dyZxcYnQJLwiu1wibjgSyI4l2/dfESRw1mBud4P6UgY972FVMLwb3Snp
         4qHGdBWbngq89eeoQij9uHWdaHeBpBgO39xKytZ7zZoqq3N3/tPGDdLVdCvbaCP0xQl9
         OyMx7k1V2HmYPNe7nHKPmGM9pKArRclvE4BCEzpzVmYQmLycQHrpusxVxUetUdfpwS+j
         Uqqw==
X-Gm-Message-State: AJcUukd9ARHUpYinF8jX4Kx/78zasE1w2tC4Lmzl3Vhnv2gKBIlOIBwp
        y/pwAvg3kSeBWi77u+CZG603KnIa
X-Google-Smtp-Source: ALg8bN6rsC46wGXi8Pql/5d6AAeNj/Cd/NxsVC0GUOR9I5kfQ79AGVr+TC0TA+aWeLQyXqpygAdJ9g==
X-Received: by 2002:a1c:c303:: with SMTP id t3mr17631689wmf.94.1548717038410;
        Mon, 28 Jan 2019 15:10:38 -0800 (PST)
Received: from Pali-Latitude.lan ([2001:718:1e03:a01::1ca])
        by smtp.gmail.com with ESMTPSA id p10sm56038125wrt.25.2019.01.28.15.10.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 15:10:37 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] a2dp-codecs: Fix SBC_MAX_BITPOOL and add SBC quality modes
Date:   Tue, 29 Jan 2019 00:10:21 +0100
Message-Id: <20190128231021.22363-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190126104539.26421-1-pali.rohar@gmail.com>
References: <20190126104539.26421-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to A2DP specification; section SBC; Codec Specific Information
Elements; Minimum / Maximum Bitpool Value, range for Bitpool value is from
2 to 250.

A2DP specification also defines bitpool values for two SBC modes: Middle
Quality and High Quality. They depends on channel mode and frequency. So
add definitions for them into a2dp-codecs file too.

File android/hal-audio-sbc.c was updated to use High Quality mode for
chosen frequency.
---
 android/hal-audio-sbc.c      |  6 +++---
 profiles/audio/a2dp-codecs.h | 12 +++++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
index 80e271ed6..f11f40108 100644
--- a/android/hal-audio-sbc.c
+++ b/android/hal-audio-sbc.c
@@ -92,7 +92,7 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.block_length = SBC_BLOCK_LENGTH_4 | SBC_BLOCK_LENGTH_8 |
 				SBC_BLOCK_LENGTH_12 | SBC_BLOCK_LENGTH_16,
 		.min_bitpool = SBC_MIN_BITPOOL,
-		.max_bitpool = SBC_MAX_BITPOOL
+		.max_bitpool = SBC_BITPOOL_HIGH_QUALITY_JOINT_STEREO_44100,
 	},
 	{
 		.frequency = SBC_SAMPLING_FREQ_44100,
@@ -101,7 +101,7 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.allocation_method = SBC_ALLOCATION_LOUDNESS,
 		.block_length = SBC_BLOCK_LENGTH_16,
 		.min_bitpool = SBC_MIN_BITPOOL,
-		.max_bitpool = SBC_MAX_BITPOOL
+		.max_bitpool = SBC_BITPOOL_HIGH_QUALITY_JOINT_STEREO_44100,
 	},
 	{
 		.frequency = SBC_SAMPLING_FREQ_48000,
@@ -110,7 +110,7 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.allocation_method = SBC_ALLOCATION_LOUDNESS,
 		.block_length = SBC_BLOCK_LENGTH_16,
 		.min_bitpool = SBC_MIN_BITPOOL,
-		.max_bitpool = SBC_MAX_BITPOOL
+		.max_bitpool = SBC_BITPOOL_HIGH_QUALITY_JOINT_STEREO_48000,
 	},
 };
 
diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 16088dc26..9bdd0f0b8 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -53,8 +53,18 @@
 #define SBC_ALLOCATION_SNR		(1 << 1)
 #define SBC_ALLOCATION_LOUDNESS		1
 
-#define SBC_MAX_BITPOOL			64
 #define SBC_MIN_BITPOOL			2
+#define SBC_MAX_BITPOOL			250
+
+/* Other settings: Block length = 16, Allocation method = Loudness, Subbands = 8 */
+#define SBC_BITPOOL_MIDDLE_QUALITY_MONO_44100		19
+#define SBC_BITPOOL_MIDDLE_QUALITY_MONO_48000		18
+#define SBC_BITPOOL_MIDDLE_QUALITY_JOINT_STEREO_44100	35
+#define SBC_BITPOOL_MIDDLE_QUALITY_JOINT_STEREO_48000	33
+#define SBC_BITPOOL_HIGH_QUALITY_MONO_44100		31
+#define SBC_BITPOOL_HIGH_QUALITY_MONO_48000		29
+#define SBC_BITPOOL_HIGH_QUALITY_JOINT_STEREO_44100	53
+#define SBC_BITPOOL_HIGH_QUALITY_JOINT_STEREO_48000	51
 
 #define MPEG_CHANNEL_MODE_MONO		(1 << 3)
 #define MPEG_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
-- 
2.11.0

