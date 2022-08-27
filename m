Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE8C0502A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345132AbiH0AF7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344716AbiH0AF4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:05:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A53E68D9
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f12so2721825plb.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=wxssbqhgwnyyI4qNQteNJ+xFtAj5pt6svn+tuRUJqHc=;
        b=VcKMJZtw7i2DlkphGsb2DgtL4K2Tp2h6c6rmnCn7RGeM3BOTlGhQ0dD5pQ5F6V+fBx
         1255kSmJt4MBdTzQFOPMDGoOd077qkK2oY4rV/XvQC7tc5Xarlsb/SjVK55pCcOJlT6K
         /NMaM+2C3CcbJrihlW+v07wl8wFy+gFVVMbjeVoGD4iaHucCiYkQove0qI2BYOluXMqN
         QfQJXABWTiLGuHOONN2aruECxz2LUpuf89jUu9lCHWiCznNBdLYgTWFuL9M7feUWUfd5
         s5apaOzpY4cVfN1e3FvX05WQd+dr9plE35zUGYA3KJTcVwdZpS3+Pcg4hw9cchEqs3IK
         vtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=wxssbqhgwnyyI4qNQteNJ+xFtAj5pt6svn+tuRUJqHc=;
        b=keJmJy/Hb1dPc4F7zoIOS93jRAw5HY115qi377zQxm1Fvu3//aoInRGKTzzP/ILCX9
         KF3q5DKBUowcWOGZzELL9DNrMqHNYLMlgEiuFRbi09lfNLFFe5Vr+ueD2GRuJiH7o9Xj
         EX5KNHhT+osNP3Yb/JwG4uRIBE4DlmeXyQMqNq84TwoYSZWFi8ENhr2y5ojjXJ1uyQ3i
         Cm23vz6m0O9htq6NbnlzWC+ici09li730WmJlJGfQL/1CU3JDxwOKYnVYAUDqZ5v2G6G
         XhKUfSyS8TFxdHq8uZTiumfBWBkhUy/SCaGI9HGanVVl/Ro/m0vm5OsT7Rs/dJn52iSf
         fgxw==
X-Gm-Message-State: ACgBeo1Bif+1VuNaJqEBczQtbKzR+h1R6bR+nMZ9CVzswByHKttQ2iJO
        Y6GFHx+r8x7MYMMVtLz3f6It1YPC7Yg=
X-Google-Smtp-Source: AA6agR5V7Jzjt2DuNta9k2aQzygQ+65xnsfbFGB+CFYDzENp+f9oYI371PNYC++lD1HY+UV9NmljVA==
X-Received: by 2002:a17:90b:19d8:b0:1fb:c116:a1e8 with SMTP id nm24-20020a17090b19d800b001fbc116a1e8mr6785252pjb.109.1661558753325;
        Fri, 26 Aug 2022 17:05:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm2249487pja.7.2022.08.26.17.05.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:05:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 08/11] client/player: Add support for PACS endpoints
Date:   Fri, 26 Aug 2022 17:05:37 -0700
Message-Id: <20220827000540.113414-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827000540.113414-1-luiz.dentz@gmail.com>
References: <20220827000540.113414-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for PAC_SINK and PAC_SOURCE endpoints as well as LC3
presets.
---
 client/player.c          | 619 +++++++++++++++++++++++++++++++++------
 tools/bluetooth-player.c |   2 +-
 2 files changed, 532 insertions(+), 89 deletions(-)

diff --git a/client/player.c b/client/player.c
index 0c59db648ff1..4ba1a72ecfd5 100644
--- a/client/player.c
+++ b/client/player.c
@@ -33,6 +33,7 @@
 #include "lib/uuid.h"
 
 #include "profiles/audio/a2dp-codecs.h"
+#include "src/shared/lc3.h"
 
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
@@ -64,6 +65,8 @@ struct endpoint {
 	uint8_t codec;
 	struct iovec *caps;
 	bool auto_accept;
+	uint8_t cig;
+	uint8_t cis;
 	char *transport;
 	DBusMessage *msg;
 };
@@ -1148,7 +1151,7 @@ struct codec_capabilities {
 
 #define data(args...) ((const unsigned char[]) { args })
 
-#define SBC_DATA(args...) \
+#define CODEC_DATA(args...) \
 	{ \
 		.iov_base = (void *)data(args), \
 		.iov_len = sizeof(data(args)), \
@@ -1161,6 +1164,13 @@ struct codec_capabilities {
 		.data = _data, \
 	}
 
+#define LC3_DATA(_freq, _duration, _chan_count, _len_min, _len_max) \
+	CODEC_DATA(0x03, LC3_FREQ, _freq, _freq >> 8, \
+		   0x02, LC3_DURATION, _duration, \
+		   0x02, LC3_CHAN_COUNT, _chan_count, \
+		   0x05, LC3_FRAME_LEN, _len_min, _len_min >> 8, _len_max, \
+		   _len_max >> 8)
+
 static const struct capabilities {
 	const char *uuid;
 	uint8_t codec_id;
@@ -1175,7 +1185,7 @@ static const struct capabilities {
 	 * Bitpool Range: 2-64
 	 */
 	CODEC_CAPABILITIES(A2DP_SOURCE_UUID, A2DP_CODEC_SBC,
-					SBC_DATA(0xff, 0xff, 2, 64)),
+					CODEC_DATA(0xff, 0xff, 2, 64)),
 	/* A2DP SBC Sink:
 	 *
 	 * Channel Modes: Mono DualChannel Stereo JointStereo
@@ -1185,13 +1195,45 @@ static const struct capabilities {
 	 * Bitpool Range: 2-64
 	 */
 	CODEC_CAPABILITIES(A2DP_SINK_UUID, A2DP_CODEC_SBC,
-					SBC_DATA(0xff, 0xff, 2, 64)),
+					CODEC_DATA(0xff, 0xff, 2, 64)),
+	/* PAC LC3 Sink:
+	 *
+	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
+	 * Duration: 7.5 ms 10 ms
+	 * Channel count: 3
+	 * Frame length: 30-240
+	 */
+	CODEC_CAPABILITIES(PAC_SINK_UUID, LC3_ID,
+					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
+						3u, 30, 240)),
+	/* PAC LC3 Source:
+	 *
+	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
+	 * Duration: 7.5 ms 10 ms
+	 * Channel count: 3
+	 * Frame length: 30-240
+	 */
+	CODEC_CAPABILITIES(PAC_SOURCE_UUID, LC3_ID,
+					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
+						3u, 30, 240)),
+};
+
+struct codec_qos {
+	uint32_t interval;
+	uint8_t  framing;
+	char *phy;
+	uint16_t sdu;
+	uint8_t  rtn;
+	uint16_t latency;
+	uint32_t delay;
 };
 
 struct codec_preset {
 	const char *name;
 	const struct iovec data;
+	const struct codec_qos qos;
 	bool is_default;
+	uint8_t latency;
 };
 
 #define SBC_PRESET(_name, _data) \
@@ -1216,32 +1258,212 @@ static struct codec_preset sbc_presets[] = {
 	 * mono, and 512kb/s for two-channel modes.
 	 */
 	SBC_PRESET("MQ_MONO_44_1",
-		SBC_DATA(0x28, 0x15, 2, SBC_BITPOOL_MQ_MONO_44100)),
+		CODEC_DATA(0x28, 0x15, 2, SBC_BITPOOL_MQ_MONO_44100)),
 	SBC_PRESET("MQ_MONO_48",
-		SBC_DATA(0x18, 0x15, 2, SBC_BITPOOL_MQ_MONO_48000)),
+		CODEC_DATA(0x18, 0x15, 2, SBC_BITPOOL_MQ_MONO_48000)),
 	SBC_PRESET("MQ_STEREO_44_1",
-		SBC_DATA(0x21, 0x15, 2, SBC_BITPOOL_MQ_JOINT_STEREO_44100)),
+		CODEC_DATA(0x21, 0x15, 2, SBC_BITPOOL_MQ_JOINT_STEREO_44100)),
 	SBC_PRESET("MQ_STEREO_48",
-		SBC_DATA(0x11, 0x15, 2, SBC_BITPOOL_MQ_JOINT_STEREO_48000)),
+		CODEC_DATA(0x11, 0x15, 2, SBC_BITPOOL_MQ_JOINT_STEREO_48000)),
 	SBC_PRESET("HQ_MONO_44_1",
-		SBC_DATA(0x28, 0x15, 2, SBC_BITPOOL_HQ_MONO_44100)),
+		CODEC_DATA(0x28, 0x15, 2, SBC_BITPOOL_HQ_MONO_44100)),
 	SBC_PRESET("HQ_MONO_48",
-		SBC_DATA(0x18, 0x15, 2, SBC_BITPOOL_HQ_MONO_48000)),
+		CODEC_DATA(0x18, 0x15, 2, SBC_BITPOOL_HQ_MONO_48000)),
 	SBC_DEFAULT_PRESET("HQ_STEREO_44_1",
-		SBC_DATA(0x21, 0x15, 2, SBC_BITPOOL_HQ_JOINT_STEREO_44100)),
+		CODEC_DATA(0x21, 0x15, 2, SBC_BITPOOL_HQ_JOINT_STEREO_44100)),
 	SBC_PRESET("HQ_STEREO_48",
-		SBC_DATA(0x11, 0x15, 2, SBC_BITPOOL_HQ_JOINT_STEREO_48000)),
+		CODEC_DATA(0x11, 0x15, 2, SBC_BITPOOL_HQ_JOINT_STEREO_48000)),
 	/* Higher bitrates not recommended by A2DP spec, it dual channel to
 	 * avoid going above 53 bitpool:
 	 *
 	 * https://habr.com/en/post/456476/
 	 * https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1092
 	 */
-	SBC_PRESET("XQ_DUAL_44_1", SBC_DATA(0x24, 0x15, 2, 43)),
-	SBC_PRESET("XQ_DUAL_48", SBC_DATA(0x14, 0x15, 2, 39)),
+	SBC_PRESET("XQ_DUAL_44_1", CODEC_DATA(0x24, 0x15, 2, 43)),
+	SBC_PRESET("XQ_DUAL_48", CODEC_DATA(0x14, 0x15, 2, 39)),
 	/* Ultra high bitpool that fits in 512 kbps mandatory bitrate */
-	SBC_PRESET("UQ_STEREO_44_1", SBC_DATA(0x21, 0x15, 2, 64)),
-	SBC_PRESET("UQ_STEREO_48", SBC_DATA(0x11, 0x15, 2, 58)),
+	SBC_PRESET("UQ_STEREO_44_1", CODEC_DATA(0x21, 0x15, 2, 64)),
+	SBC_PRESET("UQ_STEREO_48", CODEC_DATA(0x11, 0x15, 2, 58)),
+};
+
+#define QOS_CONFIG(_interval, _framing, _phy, _sdu, _rtn, _latency, _delay) \
+	{ \
+		.interval = _interval, \
+		.framing = _framing, \
+		.phy = _phy, \
+		.sdu = _sdu, \
+		.rtn = _rtn, \
+		.latency = _latency, \
+		.delay = _delay, \
+	}
+
+#define QOS_UNFRAMED(_interval, _phy, _sdu, _rtn, _latency, _delay) \
+	QOS_CONFIG(_interval, 0x00, _phy, _sdu, _rtn, _latency, _delay)
+
+#define QOS_FRAMED(_interval, _phy, _sdu, _rtn, _latency, _delay) \
+	QOS_CONFIG(_interval, 0x01, _phy, _sdu, _rtn, _latency, _delay)
+
+#define QOS_UNFRAMED_1M(_interval, _sdu, _rtn, _latency, _delay) \
+	QOS_UNFRAMED(_interval, "1M", _sdu, _rtn, _latency, _delay) \
+
+#define QOS_FRAMED_1M(_interval, _sdu, _rtn, _latency, _delay) \
+	QOS_FRAMED(_interval, "1M", _sdu, _rtn, _latency, _delay) \
+
+#define QOS_UNFRAMED_2M(_interval, _sdu, _rtn, _latency, _delay) \
+	QOS_UNFRAMED(_interval, "2M", _sdu, _rtn, _latency, _delay) \
+
+#define QOS_FRAMED_2M(_interval, _sdu, _rtn, _latency, _delay) \
+	QOS_FRAMED(_interval, "2M", _sdu, _rtn, _latency, _delay) \
+
+#define LC3_7_5_UNFRAMED(_sdu, _rtn, _latency, _delay) \
+	QOS_UNFRAMED(7500u, "2M", _sdu, _rtn, _latency, _delay)
+
+#define LC3_7_5_FRAMED(_sdu, _rtn, _latency, _delay) \
+	QOS_FRAMED(7500u, "2M", _sdu, _rtn, _latency, _delay)
+
+#define LC3_10_UNFRAMED(_sdu, _rtn, _latency, _delay) \
+	QOS_UNFRAMED_2M(10000u, _sdu, _rtn, _latency, _delay)
+
+#define LC3_10_FRAMED(_sdu, _rtn, _latency, _delay) \
+	QOS_FRAMED_2M(10000u, _sdu, _rtn, _latency, _delay)
+
+#define LC3_PRESET_DATA(_freq, _duration, _len) \
+	CODEC_DATA(0x02, LC3_CONFIG_FREQ, _freq, \
+		   0x02, LC3_CONFIG_DURATION, _duration, \
+		   0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
+
+#define LC3_PRESET_8KHZ(_duration, _len) \
+	LC3_PRESET_DATA(LC3_CONFIG_FREQ_8KHZ, _duration, _len)
+
+#define LC3_PRESET_11KHZ(_duration, _len) \
+	LC3_PRESET_DATA(LC3_CONFIG_FREQ_11KHZ, _duration, _len)
+
+#define LC3_PRESET_16KHZ(_duration, _len) \
+	LC3_PRESET_DATA(LC3_CONFIG_FREQ_16KHZ, _duration, _len)
+
+#define LC3_PRESET_22KHZ(_duration, _len) \
+	LC3_PRESET_DATA(LC3_CONFIG_FREQ_22KHZ, _duration, _len)
+
+#define LC3_PRESET_24KHZ(_duration, _len) \
+	LC3_PRESET_DATA(LC3_CONFIG_FREQ_24KHZ, _duration, _len)
+
+#define LC3_PRESET_32KHZ(_duration, _len) \
+	LC3_PRESET_DATA(LC3_CONFIG_FREQ_32KHZ, _duration, _len)
+
+#define LC3_PRESET_44KHZ(_duration, _len) \
+	LC3_PRESET_DATA(LC3_CONFIG_FREQ_44KHZ, _duration, _len)
+
+#define LC3_PRESET_48KHZ(_duration, _len) \
+	LC3_PRESET_DATA(LC3_CONFIG_FREQ_48KHZ, _duration, _len)
+
+#define LC3_PRESET_LL(_name, _data, _qos) \
+	{ \
+		.name = _name, \
+		.data = _data, \
+		.qos = _qos, \
+		.latency = 0x01, \
+	}
+
+#define LC3_PRESET(_name, _data, _qos) \
+	{ \
+		.name = _name, \
+		.data = _data, \
+		.qos = _qos, \
+		.latency = 0x02, \
+	}
+
+#define LC3_PRESET_HR(_name, _data, _qos) \
+	{ \
+		.name = _name, \
+		.data = _data, \
+		.qos = _qos, \
+		.latency = 0x03, \
+	}
+
+#define LC3_DEFAULT_PRESET(_name, _data, _qos) \
+	{ \
+		.name = _name, \
+		.data = _data, \
+		.is_default = true, \
+		.qos = _qos, \
+		.latency = 0x02, \
+	}
+
+static struct codec_preset lc3_presets[] = {
+	/* Table 4.43: QoS configuration support setting requirements */
+	LC3_PRESET("8_1_1",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+			LC3_7_5_UNFRAMED(26u, 2u, 8u, 40000u)),
+	LC3_PRESET("8_2_1",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+			LC3_10_UNFRAMED(30u, 2u, 10u, 40000u)),
+	LC3_PRESET("16_1_1",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+			LC3_7_5_UNFRAMED(30u, 2u, 8u, 40000u)),
+	LC3_DEFAULT_PRESET("16_2_1",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+			LC3_10_UNFRAMED(40u, 2u, 10u, 40000u)),
+	LC3_PRESET("24_1_1",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_7_5, 45u),
+			LC3_7_5_UNFRAMED(45u, 2u, 8u, 40000u)),
+	LC3_PRESET("24_2_1",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_10, 60u),
+			LC3_10_UNFRAMED(60u, 2u, 10u, 40000u)),
+	LC3_PRESET("32_1_1",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+			LC3_7_5_UNFRAMED(60u, 2u, 8u, 40000u)),
+	LC3_PRESET("32_2_1",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+			LC3_10_UNFRAMED(80u, 2u, 10u, 40000u)),
+	LC3_PRESET("44_1_1",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
+			QOS_FRAMED_2M(8163u, 98u, 5u, 24u, 40000u)),
+	LC3_PRESET("44_2_1",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
+			QOS_FRAMED_2M(10884u, 130u, 5u, 31u, 40000u)),
+	LC3_PRESET("48_1_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+			LC3_7_5_UNFRAMED(75u, 5u, 15u, 40000u)),
+	LC3_PRESET("48_2_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+			LC3_10_UNFRAMED(100u, 5u, 20u, 40000u)),
+	LC3_PRESET("48_3_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+			LC3_7_5_UNFRAMED(90u, 5u, 15u, 40000u)),
+	LC3_PRESET("48_4_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+			LC3_10_UNFRAMED(120u, 5u, 20u, 40000u)),
+	LC3_PRESET("48_5_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
+			LC3_7_5_UNFRAMED(117u, 5u, 15u, 40000u)),
+	LC3_PRESET("48_6_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
+			LC3_10_UNFRAMED(155u, 5u, 20u, 40000u)),
+	/* QoS Configuration settings for high reliability audio data */
+	LC3_PRESET_HR("44_1_2",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
+			QOS_FRAMED_2M(8163u, 98u, 23u, 54u, 40000u)),
+	LC3_PRESET_HR("44_2_2",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
+			QOS_FRAMED_2M(10884u, 130u, 23u, 71u, 40000u)),
+	LC3_PRESET_HR("48_1_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+			LC3_7_5_UNFRAMED(75u, 23u, 45u, 40000u)),
+	LC3_PRESET_HR("48_2_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+			LC3_10_UNFRAMED(100u, 23u, 60u, 40000u)),
+	LC3_PRESET_HR("48_3_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+			LC3_7_5_UNFRAMED(90u, 23u, 45u, 40000u)),
+	LC3_PRESET_HR("48_4_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+			LC3_10_UNFRAMED(120u, 23u, 60u, 40000u)),
+	LC3_PRESET_HR("48_5_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
+			LC3_7_5_UNFRAMED(117u, 23u, 45u, 40000u)),
+	LC3_PRESET_HR("48_6_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
+			LC3_10_UNFRAMED(155u, 23u, 60u, 40000u)),
 };
 
 #define PRESET(_uuid, _presets) \
@@ -1258,6 +1480,8 @@ static const struct preset {
 } presets[] = {
 	PRESET(A2DP_SOURCE_UUID, sbc_presets),
 	PRESET(A2DP_SINK_UUID, sbc_presets),
+	PRESET(PAC_SINK_UUID, lc3_presets),
+	PRESET(PAC_SOURCE_UUID, lc3_presets),
 };
 
 static struct codec_preset *find_preset(const char *uuid, const char *name)
@@ -1400,10 +1624,7 @@ static DBusMessage *endpoint_select_configuration(DBusConnection *conn,
 	}
 
 	p = find_preset(ep->uuid, NULL);
-	if (!p)
-		NULL;
-
-	if (p->data.iov_base) {
+	if (!p) {
 		reply = g_dbus_create_error(msg, "org.bluez.Error.Rejected",
 								NULL);
 		return reply;
@@ -1419,6 +1640,190 @@ static DBusMessage *endpoint_select_configuration(DBusConnection *conn,
 	return reply;
 }
 
+struct endpoint_config {
+	GDBusProxy *proxy;
+	struct endpoint *ep;
+	struct iovec *caps;
+	uint8_t target_latency;
+	const struct codec_qos *qos;
+};
+
+static void append_properties(DBusMessageIter *iter,
+						struct endpoint_config *cfg)
+{
+	DBusMessageIter dict;
+	struct codec_qos *qos = (void *)cfg->qos;
+	const char *key = "Capabilities";
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	bt_shell_printf("Capabilities: ");
+	bt_shell_hexdump(cfg->caps->iov_base, cfg->caps->iov_len);
+
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
+					DBUS_TYPE_BYTE, &cfg->caps->iov_base,
+					cfg->caps->iov_len);
+
+	if (!qos)
+		goto done;
+
+	if (cfg->target_latency) {
+		bt_shell_printf("TargetLatency 0x%02x\n", qos->interval);
+		g_dbus_dict_append_entry(&dict, "TargetLatency",
+					DBUS_TYPE_BYTE, &cfg->target_latency);
+	}
+
+	if (cfg->ep->cig != BT_ISO_QOS_CIG_UNSET) {
+		bt_shell_printf("CIG 0x%2.2x\n", cfg->ep->cig);
+		g_dbus_dict_append_entry(&dict, "CIG", DBUS_TYPE_BYTE,
+							&cfg->ep->cig);
+	}
+
+	if (cfg->ep->cis != BT_ISO_QOS_CIS_UNSET) {
+		bt_shell_printf("CIS 0x%2.2x\n", cfg->ep->cis);
+		g_dbus_dict_append_entry(&dict, "CIS", DBUS_TYPE_BYTE,
+							&cfg->ep->cis);
+	}
+
+	bt_shell_printf("Interval %u\n", qos->interval);
+
+	g_dbus_dict_append_entry(&dict, "Interval", DBUS_TYPE_UINT32,
+						&qos->interval);
+
+	bt_shell_printf("Framing %s\n", qos->framing ? "true" : "false");
+
+	g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
+						&qos->framing);
+
+	bt_shell_printf("PHY %s\n", qos->phy);
+
+	g_dbus_dict_append_entry(&dict, "PHY", DBUS_TYPE_STRING, &qos->phy);
+
+	bt_shell_printf("SDU %u\n", cfg->qos->sdu);
+
+	g_dbus_dict_append_entry(&dict, "SDU", DBUS_TYPE_UINT16, &qos->sdu);
+
+	bt_shell_printf("Retransmissions %u\n", qos->rtn);
+
+	g_dbus_dict_append_entry(&dict, "Retransmissions", DBUS_TYPE_BYTE,
+						&qos->rtn);
+
+	bt_shell_printf("Latency %u\n", qos->latency);
+
+	g_dbus_dict_append_entry(&dict, "Latency", DBUS_TYPE_UINT16,
+						&qos->latency);
+
+	bt_shell_printf("Delay %u\n", qos->delay);
+
+	g_dbus_dict_append_entry(&dict, "Delay", DBUS_TYPE_UINT32,
+						&qos->delay);
+
+done:
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static struct iovec *iov_append(struct iovec **iov, const void *data,
+							size_t len)
+{
+	if (!*iov) {
+		*iov = new0(struct iovec, 1);
+		(*iov)->iov_base = new0(uint8_t, UINT8_MAX);
+	}
+
+	if (data && len) {
+		memcpy((*iov)->iov_base + (*iov)->iov_len, data, len);
+		(*iov)->iov_len += len;
+	}
+
+	return *iov;
+}
+
+static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
+						DBusMessage *msg,
+						struct codec_preset *preset)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	struct endpoint_config *cfg;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	cfg = new0(struct endpoint_config, 1);
+	cfg->ep = ep;
+
+	/* Copy capabilities */
+	iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
+	cfg->target_latency = preset->latency;
+
+	if (preset->qos.phy)
+		/* Set QoS parameters */
+		cfg->qos = &preset->qos;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	append_properties(&iter, cfg);
+
+	free(cfg);
+
+	return reply;
+}
+
+static void select_properties_response(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	struct codec_preset *p;
+	DBusMessage *reply;
+
+	p = find_preset(ep->uuid, input);
+	if (p) {
+		reply = endpoint_select_properties_reply(ep, ep->msg, p);
+		goto done;
+	}
+
+	bt_shell_printf("Preset %s not found\n", input);
+	reply = g_dbus_create_error(ep->msg, "org.bluez.Error.Rejected", NULL);
+
+done:
+	g_dbus_send_message(dbus_conn, reply);
+	dbus_message_unref(ep->msg);
+	ep->msg = NULL;
+}
+
+static DBusMessage *endpoint_select_properties(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	struct codec_preset *p;
+	DBusMessageIter args;
+	DBusMessage *reply;
+
+	dbus_message_iter_init(msg, &args);
+
+	bt_shell_printf("Endpoint: SelectProperties\n");
+	print_iter("\t", "Properties", &args);
+
+	if (!ep->auto_accept) {
+		ep->msg = dbus_message_ref(msg);
+		bt_shell_prompt_input("Endpoint", "Enter preset/configuration:",
+					select_properties_response, ep);
+		return NULL;
+	}
+
+	p = find_preset(ep->uuid, NULL);
+	if (!p)
+		NULL;
+
+	reply = endpoint_select_properties_reply(ep, msg, p);
+	if (!reply)
+		return NULL;
+
+	bt_shell_printf("Auto Accepting using %s...\n", p->name);
+
+	return reply;
+}
+
 static DBusMessage *endpoint_clear_configuration(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -1478,7 +1883,12 @@ static const GDBusMethodTable endpoint_methods[] = {
 					NULL, endpoint_set_configuration) },
 	{ GDBUS_ASYNC_METHOD("SelectConfiguration",
 					GDBUS_ARGS({ "caps", "ay" } ),
-					NULL, endpoint_select_configuration) },
+					GDBUS_ARGS({ "cfg", "ay" } ),
+					endpoint_select_configuration) },
+	{ GDBUS_ASYNC_METHOD("SelectProperties",
+					GDBUS_ARGS({ "properties", "a{sv}" } ),
+					GDBUS_ARGS({ "properties", "a{sv}" } ),
+					endpoint_select_properties) },
 	{ GDBUS_ASYNC_METHOD("ClearConfiguration",
 					GDBUS_ARGS({ "transport", "o" } ),
 					NULL, endpoint_clear_configuration) },
@@ -1625,18 +2035,64 @@ fail:
 
 }
 
+static void endpoint_cis(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	char *endptr = NULL;
+	int value;
+
+	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
+		ep->cis = BT_ISO_QOS_CIS_UNSET;
+	} else {
+		value = strtol(input, &endptr, 0);
+
+		if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		ep->cis = value;
+	}
+
+	endpoint_register(ep);
+}
+
+static void endpoint_cig(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	char *endptr = NULL;
+	int value;
+
+	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
+		ep->cig = BT_ISO_QOS_CIG_UNSET;
+	} else {
+		value = strtol(input, &endptr, 0);
+
+		if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		ep->cig = value;
+	}
+
+	bt_shell_prompt_input(ep->path, "CIS (auto/value):", endpoint_cis, ep);
+}
+
 static void endpoint_auto_accept(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
-	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes"))
+	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
 		ep->auto_accept = true;
-	else if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
+	} else if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
 		ep->auto_accept = false;
-	else
+	} else {
 		bt_shell_printf("Invalid input for Auto Accept\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 
-	endpoint_register(ep);
+	bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
 }
 
 static void endpoint_set_capabilities(const char *input, void *user_data)
@@ -1694,22 +2150,6 @@ static const struct capabilities *find_capabilities(const char *uuid,
 	return NULL;
 }
 
-static struct iovec *iov_append(struct iovec **iov, const void *data,
-							size_t len)
-{
-	if (!*iov) {
-		*iov = new0(struct iovec, 1);
-		(*iov)->iov_base = new0(uint8_t, UINT8_MAX);
-	}
-
-	if (data && len) {
-		memcpy((*iov)->iov_base + (*iov)->iov_len, data, len);
-		(*iov)->iov_len += len;
-	}
-
-	return *iov;
-}
-
 static void cmd_register_endpoint(int argc, char *argv[])
 {
 	struct endpoint *ep;
@@ -1799,31 +2239,14 @@ static void cmd_unregister_endpoint(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-struct endpoint_config {
-	GDBusProxy *proxy;
-	struct endpoint *ep;
-	struct iovec *caps;
-};
-
 static void config_endpoint_setup(DBusMessageIter *iter, void *user_data)
 {
 	struct endpoint_config *cfg = user_data;
-	DBusMessageIter dict;
-	const char *key = "Capabilities";
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
 					&cfg->ep->path);
 
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
-
-	bt_shell_printf("Capabilities: ");
-	bt_shell_hexdump(cfg->caps->iov_base, cfg->caps->iov_len);
-
-	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
-					DBUS_TYPE_BYTE, &cfg->caps->iov_base,
-					cfg->caps->iov_len);
-
-	dbus_message_iter_close_container(iter, &dict);
+	append_properties(iter, cfg);
 }
 
 static void config_endpoint_reply(DBusMessage *message, void *user_data)
@@ -1906,6 +2329,9 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		iov_append(&cfg->caps, preset->data.iov_base,
 						preset->data.iov_len);
 
+		/* Set QoS parameters */
+		cfg->qos = &preset->qos;
+
 		endpoint_set_config(cfg);
 		return;
 	}
@@ -2362,7 +2788,7 @@ static void transport_property_changed(GDBusProxy *proxy, const char *name,
 		return;
 
 	if (ep->auto_accept) {
-		bt_shell_printf("Auto Accepting...\n");
+		bt_shell_printf("Auto Acquiring...\n");
 		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
 						acquire_reply, proxy, NULL))
 			bt_shell_printf("Failed acquire transport\n");
@@ -2431,6 +2857,15 @@ static void cmd_show_transport(int argc, char *argv[])
 	print_property(proxy, "Volume");
 	print_property(proxy, "Endpoint");
 
+	print_property(proxy, "Interval");
+	print_property(proxy, "Framing");
+	print_property(proxy, "SDU");
+	print_property(proxy, "Retransmissions");
+	print_property(proxy, "Latency");
+	print_property(proxy, "Location");
+	print_property(proxy, "Metadata");
+	print_property(proxy, "Links");
+
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
@@ -2450,23 +2885,27 @@ static struct transport *find_transport(GDBusProxy *proxy)
 static void cmd_acquire_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
+	int i;
 
-	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+	for (i = 1; i < argc; i++) {
+		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
-	if (!proxy) {
-		bt_shell_printf("Transport %s not found\n", argv[1]);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
+		if (!proxy) {
+			bt_shell_printf("Transport %s not found\n", argv[i]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 
-	if (find_transport(proxy)) {
-		bt_shell_printf("Transport %s already acquired\n", argv[1]);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
+		if (find_transport(proxy)) {
+			bt_shell_printf("Transport %s already acquired\n",
+					argv[i]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 
-	if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
-					acquire_reply, proxy, NULL)) {
-		bt_shell_printf("Failed acquire transport\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
+						acquire_reply, proxy, NULL)) {
+			bt_shell_printf("Failed acquire transport\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -2496,25 +2935,29 @@ static void release_reply(DBusMessage *message, void *user_data)
 static void cmd_release_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
-	struct transport *transport;
+	int i;
 
-	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+	for (i = 1; i < argc; i++) {
+		struct transport *transport;
+
+		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
-	if (!proxy) {
-		bt_shell_printf("Transport %s not found\n", argv[1]);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
+		if (!proxy) {
+			bt_shell_printf("Transport %s not found\n", argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 
-	transport = find_transport(proxy);
-	if (!transport) {
-		bt_shell_printf("Transport %s not acquired\n", argv[1]);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
+		transport = find_transport(proxy);
+		if (!transport) {
+			bt_shell_printf("Transport %s not acquired\n", argv[i]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 
-	if (!g_dbus_proxy_method_call(proxy, "Release", NULL,
+		if (!g_dbus_proxy_method_call(proxy, "Release", NULL,
 					release_reply, transport, NULL)) {
-		bt_shell_printf("Failed release transport\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+			bt_shell_printf("Failed release transport\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -2707,10 +3150,10 @@ static const struct bt_shell_menu transport_menu = {
 	{ "show",        "<transport>", cmd_show_transport,
 						"Transport information",
 						transport_generator },
-	{ "acquire",     "<transport>",	cmd_acquire_transport,
+	{ "acquire",     "<transport> [transport1...]", cmd_acquire_transport,
 						"Acquire Transport",
 						transport_generator },
-	{ "release",     "<transport>",	cmd_release_transport,
+	{ "release",     "<transport> [transport1...]", cmd_release_transport,
 						"Release Transport",
 						transport_generator },
 	{ "send",        "<transport> <filename>", cmd_send_transport,
diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 497d975e9d7c..b6cdd161ee8c 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -26,7 +26,6 @@
 #include <glib.h>
 
 #include "gdbus/gdbus.h"
-
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
 
@@ -37,6 +36,7 @@
 #define PROMPT_ON	COLOR_BLUE "[bluetooth]" COLOR_OFF "# "
 #define PROMPT_OFF	"[bluetooth]# "
 
+
 static DBusConnection *dbus_conn;
 
 static void connect_handler(DBusConnection *connection, void *user_data)
-- 
2.37.2

