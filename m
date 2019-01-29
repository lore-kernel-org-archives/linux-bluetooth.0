Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EF6C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 17:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8263A20869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 17:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRUH7HBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfA2RMT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:12:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36942 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfA2RMS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 12:12:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so18635017wmd.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 09:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ha9CQ49poUkbrsOI1s9FN1lEdsC6TkqV0zNDm4V2wzs=;
        b=RRUH7HBgO8rMTE08otzC0MFA4HLT9aCMR3ZJBRNDgj89mjdIJJNa+LTqQCTjJbBfN+
         MiI+rob6BPMJRO485gN5Wed7qG8+kYnsS+UuKijtz7kAB99W0LS4E4Xnka79QlSLBkNw
         6DdiCQNFLIAbdtyxWJPsV01TzqBYwb65Y8rZJ97ppvQakb3tWUFCUrmki2UAaTz8kw3V
         RRFZ0AgO7ZUWN4x4GSEfO5nObu5wXE1gzh14/0MJ0QKb48/Epb9I4dgI0QEpv08Wl0qA
         eDog7rgfJhRQyHzQsf+UATVeNZB17l/w5jOYLvIvcIhWrJwQOVgxQnssk8XvtSabr5GQ
         HAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ha9CQ49poUkbrsOI1s9FN1lEdsC6TkqV0zNDm4V2wzs=;
        b=MWG1FkOazKqYY7JcoLaD9vh6pklNvcbOwhiIvrmqOd76MVeigdroYICL2HXKZwtV0A
         yHEHEuV4R/GuL48iIqGUmP1qgYZeNkTTEglIPcA2oDk98GyT4L06KHR8rDGxSohlZaC5
         GjxuB9VdHTSJwPhgvd1UTA7xOHTvptDj1rmx5T9g/BxRGmT/dofyHK/bs9pY37jtf/sZ
         N2ULnxqOHAET8vV2vBlVXZ4Yc2Q+Ad/p1guURykeSCq4VQsooidO93d4sCsvxXQm4x5n
         qShbzCKPLxDIzNt5Ni8qYR6Qmfj9NbmWjDg0Nri/cE6vdByA3ooMO/v1K2FaHCgwDy2A
         CCDQ==
X-Gm-Message-State: AJcUukefK8L/TF1opbI6EKCOD6B+i/SmkEMF6qWRjcVhV1JakCIDVXe5
        TSL68R5rB05E3nLRWzNByld23jwv
X-Google-Smtp-Source: ALg8bN7D32SJnCByVEcm5k6jOzJG4WAN669x6yl+6tXrvBDHeHIFIQDgYpIap+LWW68HVtYW7cLv+g==
X-Received: by 2002:a1c:8d53:: with SMTP id p80mr23082949wmd.68.1548781936711;
        Tue, 29 Jan 2019 09:12:16 -0800 (PST)
Received: from Pali-Latitude.lan ([2001:718:1e03:a01::1ca])
        by smtp.gmail.com with ESMTPSA id a8sm5718499wme.23.2019.01.29.09.12.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 09:12:14 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] a2dp-codecs: Fix SBC_MAX_BITPOOL and add SBC quality modes
Date:   Tue, 29 Jan 2019 18:12:07 +0100
Message-Id: <20190129171207.8976-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CABBYNZJCKhfX8jdYPqQvXDrtGQvMVT-htqE8WoyGYPLh1E78zA@mail.gmail.com>
References: <CABBYNZJCKhfX8jdYPqQvXDrtGQvMVT-htqE8WoyGYPLh1E78zA@mail.gmail.com>
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
index 80e271ed6..b06cafb7b 100644
--- a/android/hal-audio-sbc.c
+++ b/android/hal-audio-sbc.c
@@ -92,7 +92,7 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.block_length = SBC_BLOCK_LENGTH_4 | SBC_BLOCK_LENGTH_8 |
 				SBC_BLOCK_LENGTH_12 | SBC_BLOCK_LENGTH_16,
 		.min_bitpool = SBC_MIN_BITPOOL,
-		.max_bitpool = SBC_MAX_BITPOOL
+		.max_bitpool = SBC_BITPOOL_HQ_JOINT_STEREO_44100,
 	},
 	{
 		.frequency = SBC_SAMPLING_FREQ_44100,
@@ -101,7 +101,7 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.allocation_method = SBC_ALLOCATION_LOUDNESS,
 		.block_length = SBC_BLOCK_LENGTH_16,
 		.min_bitpool = SBC_MIN_BITPOOL,
-		.max_bitpool = SBC_MAX_BITPOOL
+		.max_bitpool = SBC_BITPOOL_HQ_JOINT_STEREO_44100,
 	},
 	{
 		.frequency = SBC_SAMPLING_FREQ_48000,
@@ -110,7 +110,7 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.allocation_method = SBC_ALLOCATION_LOUDNESS,
 		.block_length = SBC_BLOCK_LENGTH_16,
 		.min_bitpool = SBC_MIN_BITPOOL,
-		.max_bitpool = SBC_MAX_BITPOOL
+		.max_bitpool = SBC_BITPOOL_HQ_JOINT_STEREO_48000,
 	},
 };
 
diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 16088dc26..0d2cc155b 100644
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
+#define SBC_BITPOOL_MQ_MONO_44100		19
+#define SBC_BITPOOL_MQ_MONO_48000		18
+#define SBC_BITPOOL_MQ_JOINT_STEREO_44100	35
+#define SBC_BITPOOL_MQ_JOINT_STEREO_48000	33
+#define SBC_BITPOOL_HQ_MONO_44100		31
+#define SBC_BITPOOL_HQ_MONO_48000		29
+#define SBC_BITPOOL_HQ_JOINT_STEREO_44100	53
+#define SBC_BITPOOL_HQ_JOINT_STEREO_48000	51
 
 #define MPEG_CHANNEL_MODE_MONO		(1 << 3)
 #define MPEG_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
-- 
2.11.0

