Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AFDC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11634217D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpA4YNgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeLSQv5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:51:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37231 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbeLSQv5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:51:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so7164132wmd.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=oKkAQE48/U0MOEZHo8nbJNRsmtcWzyIw5JJZC1tdPek=;
        b=kpA4YNgXUyyVb2wF3Yb/oklp5M4qB+IryZ4ywNqtv8C0Z8+uwytKsF0vyGyoVlw2wx
         lI91n5BwcRIOZpZUS2eOaRbCd1sYeJm/gTd/aYfv9n38IeXrGsoAsbpordCG79VJEstk
         Ywux8BjrB08L1f+zNcZONW6L+fLKPfA44tbtwbHWuE/u3BLkA7oPmZEd2lp4GNwpitkp
         OMBkxiy+ANv0w/+Mh960SNGhlTLm2bIRU0YM/18dicaXns+YnP4RmKLP91SL4CGWOimD
         C4yJkr0K1rOtwyUAuo5qfmWb5rU/MmTjLGtwZbsZDevOFW7UxXBNbEwZgW3uruuUzx5y
         tnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=oKkAQE48/U0MOEZHo8nbJNRsmtcWzyIw5JJZC1tdPek=;
        b=Ip8OEwBisao9oi8rHqwXR5KwzKyiTld28ZPz3S/ffB+bRumoPFs+y8v8ZPxCwGTSGT
         0iIcu9f5A1q0+6DcuZuJoXaQKvfxtRfbgFmj/4WJOjYdME4aTYXcyadwsGz0cYIghYYT
         MGzUho0GbAOcOE4flPlgNSjFTKDQQbP6zNjWdgxz8Jhwbk9HIdRHRJ1ZclEOTan+fzQU
         xP8dFb6wcZtUM+prx0c5kaSs9sTkFL+x7KV15BN9TqByS/S/7B/vYo0VDXpgsrCd+kj4
         XEeZ100hLmz2kWBDG8W+pPNpwruwV8UgyopjhIFCtJ+rHZl8AmtGyriaGpxEIHM175NS
         36oQ==
X-Gm-Message-State: AA+aEWbAPw0G2sqGJpKfAD7d57TfQZg6YOnTj/E2WVbyA9N4HHMhkSXj
        TL+s/8ayhlDpbyP3r7Klczt487Ok3DI=
X-Google-Smtp-Source: AFSGD/U5DYDkkHQr3hu3WrDiHMs9m+j5I7uvw8oqLlEU+U2fvFwJqkHpbay+IBN3X2dPw9frhnAeew==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr8439858wmf.144.1545238314437;
        Wed, 19 Dec 2018 08:51:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.51.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:51:53 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] a2dp-codecs: Define a2dp_vendor_codec_t struct in endian neutral way
Date:   Wed, 19 Dec 2018 17:51:05 +0100
Message-Id: <20181219165109.29088-7-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

And define new macros A2DP_GET_VENDOR_ID(), A2DP_GET_CODEC_ID() and
A2DP_SET_VENDOR_ID_CODEC_ID() for easily filling a2dp_vendor_codec_t
struct.
---
 android/a2dp.c               |  8 ++++----
 android/avdtp.c              |  4 ++--
 android/hal-audio-aptx.c     | 15 +++------------
 profiles/audio/a2dp-codecs.h | 19 +++++++++++++++++--
 profiles/audio/a2dp.c        |  8 ++++----
 tools/avinfo.c               |  4 ++--
 6 files changed, 32 insertions(+), 26 deletions(-)

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
index 34caf3db5..88fbef85a 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -1103,10 +1103,10 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 			a2dp_vendor_codec_t *vndcodec =
 						(void *) codec_data->data;
 
-			if (btohl(vndcodec->vendor_id) != lsep->vndcodec_vendor)
+			if (A2DP_GET_VENDOR_ID(*vndcodec) != lsep->vndcodec_vendor)
 				continue;
 
-			if (btohs(vndcodec->codec_id) != lsep->vndcodec_codec)
+			if (A2DP_GET_CODEC_ID(*vndcodec) != lsep->vndcodec_codec)
 				continue;
 		}
 
diff --git a/android/hal-audio-aptx.c b/android/hal-audio-aptx.c
index bff2331a9..3453b49a4 100644
--- a/android/hal-audio-aptx.c
+++ b/android/hal-audio-aptx.c
@@ -37,27 +37,18 @@ struct aptx_data {
 
 static const a2dp_aptx_t aptx_presets[] = {
 	{
-		.info = {
-			.vendor_id = APTX_VENDOR_ID,
-			.codec_id = APTX_CODEC_ID,
-		},
+		.info = A2DP_SET_VENDOR_ID_CODEC_ID(APTX_VENDOR_ID, APTX_CODEC_ID),
 		.frequency = APTX_SAMPLING_FREQ_44100 |
 						APTX_SAMPLING_FREQ_48000,
 		.channel_mode = APTX_CHANNEL_MODE_STEREO,
 	},
 	{
-		.info = {
-			.vendor_id = APTX_VENDOR_ID,
-			.codec_id = APTX_CODEC_ID,
-		},
+		.info = A2DP_SET_VENDOR_ID_CODEC_ID(APTX_VENDOR_ID, APTX_CODEC_ID),
 		.frequency = APTX_SAMPLING_FREQ_48000,
 		.channel_mode = APTX_CHANNEL_MODE_STEREO,
 	},
 	{
-		.info = {
-			.vendor_id = APTX_VENDOR_ID,
-			.codec_id = APTX_CODEC_ID,
-		},
+		.info = A2DP_SET_VENDOR_ID_CODEC_ID(APTX_VENDOR_ID, APTX_CODEC_ID),
 		.frequency = APTX_SAMPLING_FREQ_44100,
 		.channel_mode = APTX_CHANNEL_MODE_STEREO,
 	},
diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 64a09796d..43a5eef97 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -194,10 +194,25 @@
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
 
+#define A2DP_GET_VENDOR_ID(a) ((a).vendor_id4 | (((uint32_t)(a).vendor_id3) << 8) | (((uint32_t)(a).vendor_id2) << 16) | (((uint32_t)(a).vendor_id1) << 24))
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
index fc98bb264..5bf596a2b 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -523,14 +523,14 @@ static gboolean endpoint_match_codec_ind(struct avdtp *session,
 	local_codec = (a2dp_vendor_codec_t *) capabilities;
 	remote_codec = (a2dp_vendor_codec_t *) codec->data;
 
-	if (remote_codec->vendor_id != local_codec->vendor_id)
+	if (A2DP_GET_VENDOR_ID(*remote_codec) != A2DP_GET_VENDOR_ID(*local_codec))
 		return FALSE;
 
-	if (remote_codec->codec_id != local_codec->codec_id)
+	if (A2DP_GET_CODEC_ID(*remote_codec) != A2DP_GET_CODEC_ID(*local_codec))
 		return FALSE;
 
-	DBG("vendor 0x%08x codec 0x%04x", btohl(remote_codec->vendor_id),
-						btohs(remote_codec->codec_id));
+	DBG("vendor 0x%08x codec 0x%04x", A2DP_GET_VENDOR_ID(*remote_codec),
+						A2DP_GET_CODEC_ID(*remote_codec));
 	return TRUE;
 }
 
diff --git a/tools/avinfo.c b/tools/avinfo.c
index ca0f12067..f09085c93 100644
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

