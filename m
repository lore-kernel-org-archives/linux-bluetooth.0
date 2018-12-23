Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314EEC43444
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F2421783
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWr4fJaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeLWKkz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:40:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54413 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbeLWKkz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 05:40:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so9090316wmh.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 02:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=l8Ps3C0NpcPo8qaesnANsUQZhGyF0BHNZUsc/9FGrGA=;
        b=YWr4fJaJUUz8nxeR6wk0SO2I3M6f7SzRzyiLwNcUyyJAwXwIcq6E97PTVoU10oqLkb
         5ljchQmb1FAWeQeF1SPR3F1nHjNJsOqgmq0jNHLpzg6x6oigjbo6sfGUZQYZN+gsymtg
         HbqJeBiBTlIW5A75HRXF5T/JUdZszJIyE5o5LpmhxdoL3ljz83STep2Z4QAU4CpHGV8R
         t/mlxxNa4OuueNhX3kCNLuTH/MjdQbs6RBwdAC/NedN2yAF3PriTm1qFcd2oCQq5Eyk4
         gF3TgDQW5xITqN5GbRVSvkEb4hxe02FQ2YlxAGOiTRvJpC7wc5sGwrIZxQiPCJgKrk/B
         ukKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=l8Ps3C0NpcPo8qaesnANsUQZhGyF0BHNZUsc/9FGrGA=;
        b=WYx/YSrIFjF4emUoz+6inuOzZrDUmPZ85VoGiwayuSJenUt6DXzaBYlmkxW2NLK8nt
         ZoYAUvFvGCWmXOH+V8VDdV7jUYmd8ugPYOUUvCHT5EiVlTc2DaVKcn04GcUaoBHvxaSN
         aKRBrHMCwIWNWYzGAFRnkVUrTf4QbtfEZzBjil/B6EhQ9JVTGLCKwna1N5zAYOqSs2Ew
         hMGg7g8xwsauwbUsk3lRRWSNpDhedBWu78rt5MYIV0YsvjyNwaKolxJQNGuoKiZ3kg3l
         sfg2PV+RZ7RVmJhnRfiNaUmrSHzDixWIM87cb4cZalh66w8yEmgKpqsC+dj8J79XLI1A
         3XhA==
X-Gm-Message-State: AA+aEWbx1DXqsTJcQP8JIfZD0ZK4/W84HEkf1iGfntxXE3DLRz0BEFCl
        VDc/x171F7WQ4qkg/stNM1pas5Mu/fE=
X-Google-Smtp-Source: AFSGD/UNpa23iKDasYAXXjluOfLihSV1/WiVLo91w6yXuFc7FWKtiTunIxSTGVCxUmumhZSk9PB4fg==
X-Received: by 2002:a1c:70b:: with SMTP id 11mr9361865wmh.74.1545561651254;
        Sun, 23 Dec 2018 02:40:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id d4sm12168616wmb.25.2018.12.23.02.40.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 02:40:50 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/10] a2dp-codecs: Define a2dp_vendor_codec_t struct in endian neutral way
Date:   Sun, 23 Dec 2018 11:40:17 +0100
Message-Id: <20181223104021.18620-7-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181223104021.18620-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
 <20181223104021.18620-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

And define new macros A2DP_GET_VENDOR_ID(), A2DP_GET_CODEC_ID() and
A2DP_SET_VENDOR_ID_CODEC_ID() for easily filling a2dp_vendor_codec_t
struct.
---
 android/a2dp.c               |  8 ++++----
 android/avdtp.c              |  6 ++++--
 android/hal-audio-aptx.c     | 18 ++++++------------
 profiles/audio/a2dp-codecs.h | 24 ++++++++++++++++++++++--
 profiles/audio/a2dp.c        |  9 +++++----
 tools/avinfo.c               |  4 ++--
 6 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index f21904208..8bcdfd20f 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -417,8 +417,8 @@ static int check_capabilities(struct a2dp_preset *preset,
 								preset->len);
 	case A2DP_CODEC_VENDOR:
 		vndcodec = (void *) codec->data;
-		if (btohl(vndcodec->vendor_id) == APTX_VENDOR_ID &&
-				btohs(vndcodec->codec_id) == APTX_CODEC_ID)
+		if (A2DP_GET_VENDOR_ID(*vndcodec) == APTX_VENDOR_ID &&
+				A2DP_GET_CODEC_ID(*vndcodec) == APTX_CODEC_ID)
 			return aptx_check_config(codec->data, codec_len,
 						preset->data, preset->len);
 		return -EINVAL;
@@ -1344,8 +1344,8 @@ static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
 		a2dp_vendor_codec_t *vndcodec = (void *) endpoint->caps->data;
 
 		avdtp_sep_set_vendor_codec(endpoint->sep,
-						btohl(vndcodec->vendor_id),
-						btohs(vndcodec->codec_id));
+						A2DP_GET_VENDOR_ID(*vndcodec),
+						A2DP_GET_CODEC_ID(*vndcodec));
 	}
 
 	endpoints = g_slist_append(endpoints, endpoint);
diff --git a/android/avdtp.c b/android/avdtp.c
index 34caf3db5..7fb8cb731 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -1103,10 +1103,12 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 			a2dp_vendor_codec_t *vndcodec =
 						(void *) codec_data->data;
 
-			if (btohl(vndcodec->vendor_id) != lsep->vndcodec_vendor)
+			if (A2DP_GET_VENDOR_ID(*vndcodec) !=
+					lsep->vndcodec_vendor)
 				continue;
 
-			if (btohs(vndcodec->codec_id) != lsep->vndcodec_codec)
+			if (A2DP_GET_CODEC_ID(*vndcodec) !=
+					lsep->vndcodec_codec)
 				continue;
 		}
 
diff --git a/android/hal-audio-aptx.c b/android/hal-audio-aptx.c
index bff2331a9..4e364fc65 100644
--- a/android/hal-audio-aptx.c
+++ b/android/hal-audio-aptx.c
@@ -37,27 +37,21 @@ struct aptx_data {
 
 static const a2dp_aptx_t aptx_presets[] = {
 	{
-		.info = {
-			.vendor_id = APTX_VENDOR_ID,
-			.codec_id = APTX_CODEC_ID,
-		},
+		.info =
+		    A2DP_SET_VENDOR_ID_CODEC_ID(APTX_VENDOR_ID, APTX_CODEC_ID),
 		.frequency = APTX_SAMPLING_FREQ_44100 |
 						APTX_SAMPLING_FREQ_48000,
 		.channel_mode = APTX_CHANNEL_MODE_STEREO,
 	},
 	{
-		.info = {
-			.vendor_id = APTX_VENDOR_ID,
-			.codec_id = APTX_CODEC_ID,
-		},
+		.info =
+		    A2DP_SET_VENDOR_ID_CODEC_ID(APTX_VENDOR_ID, APTX_CODEC_ID),
 		.frequency = APTX_SAMPLING_FREQ_48000,
 		.channel_mode = APTX_CHANNEL_MODE_STEREO,
 	},
 	{
-		.info = {
-			.vendor_id = APTX_VENDOR_ID,
-			.codec_id = APTX_CODEC_ID,
-		},
+		.info =
+		    A2DP_SET_VENDOR_ID_CODEC_ID(APTX_VENDOR_ID, APTX_CODEC_ID),
 		.frequency = APTX_SAMPLING_FREQ_44100,
 		.channel_mode = APTX_CHANNEL_MODE_STEREO,
 	},
diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 47030bcc1..a310efe49 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -198,10 +198,30 @@
 #define LDAC_CODEC_ID			0x00aa
 
 typedef struct {
-	uint32_t vendor_id;
-	uint16_t codec_id;
+	uint8_t vendor_id4;
+	uint8_t vendor_id3;
+	uint8_t vendor_id2;
+	uint8_t vendor_id1;
+	uint8_t codec_id2;
+	uint8_t codec_id1;
 } __attribute__ ((packed)) a2dp_vendor_codec_t;
 
+#define A2DP_GET_VENDOR_ID(a) ( \
+		(((uint32_t)(a).vendor_id4) <<  0) | \
+		(((uint32_t)(a).vendor_id3) <<  8) | \
+		(((uint32_t)(a).vendor_id2) << 16) | \
+		(((uint32_t)(a).vendor_id1) << 24) \
+	)
+#define A2DP_GET_CODEC_ID(a) ((a).codec_id2 | (((uint16_t)(a).codec_id1) << 8))
+#define A2DP_SET_VENDOR_ID_CODEC_ID(v, c) ((a2dp_vendor_codec_t){ \
+		.vendor_id4 = (((v) >>  0) & 0xff), \
+		.vendor_id3 = (((v) >>  8) & 0xff), \
+		.vendor_id2 = (((v) >> 16) & 0xff), \
+		.vendor_id1 = (((v) >> 24) & 0xff), \
+		.codec_id2 = (((c) >> 0) & 0xff), \
+		.codec_id1 = (((c) >> 8) & 0xff), \
+	})
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 typedef struct {
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index fc98bb264..344459332 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -523,14 +523,15 @@ static gboolean endpoint_match_codec_ind(struct avdtp *session,
 	local_codec = (a2dp_vendor_codec_t *) capabilities;
 	remote_codec = (a2dp_vendor_codec_t *) codec->data;
 
-	if (remote_codec->vendor_id != local_codec->vendor_id)
+	if (A2DP_GET_VENDOR_ID(*remote_codec) !=
+			A2DP_GET_VENDOR_ID(*local_codec))
 		return FALSE;
 
-	if (remote_codec->codec_id != local_codec->codec_id)
+	if (A2DP_GET_CODEC_ID(*remote_codec) != A2DP_GET_CODEC_ID(*local_codec))
 		return FALSE;
 
-	DBG("vendor 0x%08x codec 0x%04x", btohl(remote_codec->vendor_id),
-						btohs(remote_codec->codec_id));
+	DBG("vendor 0x%08x codec 0x%04x", A2DP_GET_VENDOR_ID(*remote_codec),
+					A2DP_GET_CODEC_ID(*remote_codec));
 	return TRUE;
 }
 
diff --git a/tools/avinfo.c b/tools/avinfo.c
index bb80cf583..9a07e675d 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -221,8 +221,8 @@ static void print_vendor(a2dp_vendor_codec_t *vendor, uint8_t size)
 		return;
 	}
 
-	vendor_id = btohl(vendor->vendor_id);
-	codec_id = btohs(vendor->codec_id);
+	vendor_id = A2DP_GET_VENDOR_ID(*vendor);
+	codec_id = A2DP_GET_CODEC_ID(*vendor);
 
 	printf("\tMedia Codec: Vendor Specific A2DP Codec");
 
-- 
2.11.0

