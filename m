Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F62157E87
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563243; cv=none; b=dZsawOEPDcvHuDfQ8NSS5F+p8z/HiJfgDwZBma21P4PZO352aJWpWgLbr+N1aZf74x8ycBcaBdi2/2pcH/2Dc+9ejF2DVsddc3E0ejUNxfHc0sowfeRDUN4aaBTtWCyxJRIIkvA9xx3aVCdavqEY3dq2hlrZVSVp+/gqSrXlbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563243; c=relaxed/simple;
	bh=HScspj2KBEM4z2LFd52QvW2BWvmC2lfzDO8Pg9gmxXQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw/PUlkX8RNEWW7YA2UnMX2ThaSDcBUulzm8MtO7Mm+hdA6fyQh6ePMou5Ju4h4kEm91o07Ur3YBsQia6S6cuWYvKAYepcyWca/NcmvfZrZsBO/LlQjpXGEfkwKCXRv7dq83Coq0rZE2HDpyK/I3xSsYh4N7W5QtTdGLeL05otk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSxRqP5V; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSxRqP5V"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-603e7d19725so10015387b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 13:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706563240; x=1707168040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkqRF+mC8DuzEovf7kGj9+XXGT1P8SVx4xHS/zSUU2U=;
        b=TSxRqP5VL38eSYrxaneql9qXU6Zxe318IGnbxj5xp5GBfEqso0JN+Bba5vzOlpjPWp
         ziXqCGr8Rn5y7KgkXpepJ46V5jkqAPmUv0dq3mQBCzcfJHeT0zaN14xi3jmsmRyEL4Ni
         w/t/8i4L6O24W8Ga0/zFGeeYKhClTU5w/j4bFhstrHSKpXvJhHg/bc5UgECmfZA2YKHe
         zdq7ksNZ2EWBtObgeBw318U64CpLANZ7KTTUl1c3jvcD5qpR1fMzslP9ByTvrup4MeEv
         XS6K3DS/Q6ytrfMOEkWPQa9WzUcEhzJFSZ4cmiYwym9EFCaY+YfqRiStcfVMfwn9Epmj
         SdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706563240; x=1707168040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkqRF+mC8DuzEovf7kGj9+XXGT1P8SVx4xHS/zSUU2U=;
        b=dIpfeLJWHEWlqULM6e5YnFZEU8Nvi/a6iXndpV8XJujtAYJ4QA7WAqJZ9KLnW2BfYI
         IIN2G5fXFD5SauD/0xJ6ojcQyu44n5kCutBxJbOzJfTjT215QJL37Qz619/bgRbm9SFf
         O+JO7kNIrUkvKcGFRKZSmSlthRXbJvAigWJESxdn6iFXtfB2yL+2iG6ud5oVOld2+IDr
         Vq0tHhkWzvxFtGfp8DGtAbDKioj9e+TF6nZkGjRqYSCx+mAKT+smQmBsRIXbgViXMkL1
         CLxttSyd1osRZ9xsWJDgEVeO7S28tb7Pk8CuCYMZPakKIlZU0dLfvKM410H9jNb+8H67
         +V8g==
X-Gm-Message-State: AOJu0YyRLRTe0ZeI5l/nlCTtX5+5iKlAfPCkk0EcfjQm3J2QHAYlRSw8
	NsLgWWoIXfHGgq5R7IP8LGTQpokOIHY00buzWKMBcciy1b0Nbgxf5EKLwyR3
X-Google-Smtp-Source: AGHT+IFoDwEL0zm65HoBAwpDAYHezlA2E6FnhjevNE/BfivkddsSSNS5whdL1K4mzo2yGU4mGSglVQ==
X-Received: by 2002:a05:690c:3508:b0:5ff:cbab:2625 with SMTP id fq8-20020a05690c350800b005ffcbab2625mr7690499ywb.36.1706563239913;
        Mon, 29 Jan 2024 13:20:39 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l198-20020a0de2cf000000b005fff75780f3sm2704904ywe.66.2024.01.29.13.20.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:20:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] client/player: Add metadata support to struct capabilities
Date: Mon, 29 Jan 2024 16:20:34 -0500
Message-ID: <20240129212036.163298-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129212036.163298-1-luiz.dentz@gmail.com>
References: <20240129212036.163298-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables defining metadata as part of the struct capabilities.
---
 client/player.c | 92 ++++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/client/player.c b/client/player.c
index 623519209001..f6b2278d5a8f 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1130,21 +1130,7 @@ static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 	return NULL;
 }
 
-struct codec_capabilities {
-	uint8_t len;
-	uint8_t type;
-	uint8_t data[UINT8_MAX];
-};
-
-#define data(args...) ((const unsigned char[]) { args })
-
-#define CODEC_DATA(args...) \
-	{ \
-		.iov_base = (void *)data(args), \
-		.iov_len = sizeof(data(args)), \
-	}
-
-#define CODEC_CAPABILITIES(_uuid, _codec_id, _data) \
+#define CODEC_CAPABILITIES(_uuid, _codec_id, _data, _meta) \
 	{ \
 		.uuid = _uuid, \
 		.codec_id = _codec_id, \
@@ -1152,16 +1138,17 @@ struct codec_capabilities {
 	}
 
 #define LC3_DATA(_freq, _duration, _chan_count, _len_min, _len_max) \
-	CODEC_DATA(0x03, LC3_FREQ, _freq, _freq >> 8, \
-		   0x02, LC3_DURATION, _duration, \
-		   0x02, LC3_CHAN_COUNT, _chan_count, \
-		   0x05, LC3_FRAME_LEN, _len_min, _len_min >> 8, _len_max, \
-		   _len_max >> 8)
+	UTIL_IOV_INIT(0x03, LC3_FREQ, _freq, _freq >> 8, \
+			0x02, LC3_DURATION, _duration, \
+			0x02, LC3_CHAN_COUNT, _chan_count, \
+			0x05, LC3_FRAME_LEN, _len_min, _len_min >> 8, \
+			_len_max, _len_max >> 8)
 
 static const struct capabilities {
 	const char *uuid;
 	uint8_t codec_id;
 	struct iovec data;
+	struct iovec meta;
 } caps[] = {
 	/* A2DP SBC Source:
 	 *
@@ -1172,7 +1159,8 @@ static const struct capabilities {
 	 * Bitpool Range: 2-64
 	 */
 	CODEC_CAPABILITIES(A2DP_SOURCE_UUID, A2DP_CODEC_SBC,
-					CODEC_DATA(0xff, 0xff, 2, 64)),
+					UTIL_IOV_INIT(0xff, 0xff, 2, 64),
+					UTIL_IOV_INIT()),
 	/* A2DP SBC Sink:
 	 *
 	 * Channel Modes: Mono DualChannel Stereo JointStereo
@@ -1182,7 +1170,9 @@ static const struct capabilities {
 	 * Bitpool Range: 2-64
 	 */
 	CODEC_CAPABILITIES(A2DP_SINK_UUID, A2DP_CODEC_SBC,
-					CODEC_DATA(0xff, 0xff, 2, 64)),
+					UTIL_IOV_INIT(0xff, 0xff, 2, 64),
+					UTIL_IOV_INIT()),
+
 	/* PAC LC3 Sink:
 	 *
 	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
@@ -1192,7 +1182,9 @@ static const struct capabilities {
 	 */
 	CODEC_CAPABILITIES(PAC_SINK_UUID, LC3_ID,
 					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
-						3u, 30, 240)),
+						3u, 30, 240),
+					UTIL_IOV_INIT()),
+
 	/* PAC LC3 Source:
 	 *
 	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
@@ -1202,7 +1194,9 @@ static const struct capabilities {
 	 */
 	CODEC_CAPABILITIES(PAC_SOURCE_UUID, LC3_ID,
 					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
-						3u, 30, 240)),
+						3u, 30, 240),
+					UTIL_IOV_INIT()),
+
 	/* Broadcast LC3 Source:
 	 *
 	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
@@ -1212,7 +1206,8 @@ static const struct capabilities {
 	 */
 	CODEC_CAPABILITIES(BCAA_SERVICE_UUID, LC3_ID,
 					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
-						3u, 30, 240)),
+						3u, 30, 240),
+					UTIL_IOV_INIT()),
 
 	/* Broadcast LC3 Sink:
 	 *
@@ -1223,7 +1218,8 @@ static const struct capabilities {
 	 */
 	CODEC_CAPABILITIES(BAA_SERVICE_UUID, LC3_ID,
 					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
-						3u, 30, 240)),
+						3u, 30, 240),
+					UTIL_IOV_INIT()),
 };
 
 struct codec_qos {
@@ -1258,32 +1254,36 @@ static struct codec_preset sbc_presets[] = {
 	 * mono, and 512kb/s for two-channel modes.
 	 */
 	SBC_PRESET("MQ_MONO_44_1",
-		CODEC_DATA(0x28, 0x15, 2, SBC_BITPOOL_MQ_MONO_44100)),
+		UTIL_IOV_INIT(0x28, 0x15, 2, SBC_BITPOOL_MQ_MONO_44100)),
 	SBC_PRESET("MQ_MONO_48",
-		CODEC_DATA(0x18, 0x15, 2, SBC_BITPOOL_MQ_MONO_48000)),
+		UTIL_IOV_INIT(0x18, 0x15, 2, SBC_BITPOOL_MQ_MONO_48000)),
 	SBC_PRESET("MQ_STEREO_44_1",
-		CODEC_DATA(0x21, 0x15, 2, SBC_BITPOOL_MQ_JOINT_STEREO_44100)),
+		UTIL_IOV_INIT(0x21, 0x15, 2,
+				SBC_BITPOOL_MQ_JOINT_STEREO_44100)),
 	SBC_PRESET("MQ_STEREO_48",
-		CODEC_DATA(0x11, 0x15, 2, SBC_BITPOOL_MQ_JOINT_STEREO_48000)),
+		UTIL_IOV_INIT(0x11, 0x15, 2,
+				SBC_BITPOOL_MQ_JOINT_STEREO_48000)),
 	SBC_PRESET("HQ_MONO_44_1",
-		CODEC_DATA(0x28, 0x15, 2, SBC_BITPOOL_HQ_MONO_44100)),
+		UTIL_IOV_INIT(0x28, 0x15, 2, SBC_BITPOOL_HQ_MONO_44100)),
 	SBC_PRESET("HQ_MONO_48",
-		CODEC_DATA(0x18, 0x15, 2, SBC_BITPOOL_HQ_MONO_48000)),
+		UTIL_IOV_INIT(0x18, 0x15, 2, SBC_BITPOOL_HQ_MONO_48000)),
 	SBC_PRESET("HQ_STEREO_44_1",
-		CODEC_DATA(0x21, 0x15, 2, SBC_BITPOOL_HQ_JOINT_STEREO_44100)),
+		UTIL_IOV_INIT(0x21, 0x15, 2,
+				SBC_BITPOOL_HQ_JOINT_STEREO_44100)),
 	SBC_PRESET("HQ_STEREO_48",
-		CODEC_DATA(0x11, 0x15, 2, SBC_BITPOOL_HQ_JOINT_STEREO_48000)),
+		UTIL_IOV_INIT(0x11, 0x15, 2,
+			      SBC_BITPOOL_HQ_JOINT_STEREO_48000)),
 	/* Higher bitrates not recommended by A2DP spec, it dual channel to
 	 * avoid going above 53 bitpool:
 	 *
 	 * https://habr.com/en/post/456476/
 	 * https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1092
 	 */
-	SBC_PRESET("XQ_DUAL_44_1", CODEC_DATA(0x24, 0x15, 2, 43)),
-	SBC_PRESET("XQ_DUAL_48", CODEC_DATA(0x14, 0x15, 2, 39)),
+	SBC_PRESET("XQ_DUAL_44_1", UTIL_IOV_INIT(0x24, 0x15, 2, 43)),
+	SBC_PRESET("XQ_DUAL_48", UTIL_IOV_INIT(0x14, 0x15, 2, 39)),
 	/* Ultra high bitpool that fits in 512 kbps mandatory bitrate */
-	SBC_PRESET("UQ_STEREO_44_1", CODEC_DATA(0x21, 0x15, 2, 64)),
-	SBC_PRESET("UQ_STEREO_48", CODEC_DATA(0x11, 0x15, 2, 58)),
+	SBC_PRESET("UQ_STEREO_44_1", UTIL_IOV_INIT(0x21, 0x15, 2, 64)),
+	SBC_PRESET("UQ_STEREO_48", UTIL_IOV_INIT(0x11, 0x15, 2, 58)),
 };
 
 #define QOS_CONFIG(_interval, _framing, _phy, _sdu, _rtn, _latency, _delay) \
@@ -1328,16 +1328,16 @@ static struct codec_preset sbc_presets[] = {
 	QOS_FRAMED_2M(10000u, _sdu, _rtn, _latency, _delay)
 
 #define LC3_PRESET_DATA(_freq, _duration, _len) \
-	CODEC_DATA(0x02, LC3_CONFIG_FREQ, _freq, \
-		   0x02, LC3_CONFIG_DURATION, _duration, \
-		   0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
+	UTIL_IOV_INIT(0x02, LC3_CONFIG_FREQ, _freq, \
+			0x02, LC3_CONFIG_DURATION, _duration, \
+			0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
 
 #define LC3_PRESET_DATA_ALL(_freq, _duration, _alloc, _len) \
-	CODEC_DATA(0x02, LC3_CONFIG_FREQ, _freq, \
-		   0x02, LC3_CONFIG_DURATION, _duration, \
-		   0x05, LC3_CONFIG_CHAN_ALLOC, _alloc, _alloc >> 8, \
-		   _alloc >> 16, _alloc >> 24, \
-		   0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
+	UTIL_IOV_INIT(0x02, LC3_CONFIG_FREQ, _freq, \
+			0x02, LC3_CONFIG_DURATION, _duration, \
+			0x05, LC3_CONFIG_CHAN_ALLOC, _alloc, _alloc >> 8, \
+			_alloc >> 16, _alloc >> 24, \
+			0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
 
 #define LC3_PRESET_8KHZ(_duration, _len) \
 	LC3_PRESET_DATA(LC3_CONFIG_FREQ_8KHZ, _duration, _len)
-- 
2.43.0

