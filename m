Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93846426
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359046; cv=none; b=QnmrKvF85V7t57xsCgQ/WHAGu3wdJHZ+z88hQA4FzkC4OGRs/nWu3wtpcDPJM5D4jpdKObI+Xu11acrJuh018gJWwn1eRvqSA5xlyDN4pVfLyp986j6nXE4l1ld40a4DfY/Ln2iYc8qCmhzHubbGWHcJ1tRR9e8zvbsg9EJ+oRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359046; c=relaxed/simple;
	bh=e4+PHqDauya9n2dspmku/9IFy3579jWCY4iOuSZnHjA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WLKvy+1jY3aSaLu1Mvhd1HSVVUn/4sa9Ie6FnemY0uesgEAtKiSufN/wrPpvNWmMA3361Yf976pj68hglwg13xHPEkbvv5peYBhwVyylDEzo/HscHZFcc5qwEPwL3t6PiovX28cXd9S/eX3jucAOY+l4Mq7zWVSSkkDrzH1ucU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwCRHC3p; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwCRHC3p"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7de0f584da9so80002241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710359042; x=1710963842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCfHqTTsLIjf6PahHwoSB6au2rlpK/wHDjPqDhpqcc4=;
        b=CwCRHC3p3xqD+sxS80XqWZhVPLydXoCxP6RdCaG2f9iRj+bjBDH+PjsLXnmYZwQs/Q
         b0NE1iJPa/KuDAL2iYSWBVJVUUD7tcesCu4pqhMecn8OcYZ3G5G4ZXTQ2xTgrwxdoE3S
         w1+hC7jkU5f08DZZa1F8uWWslVgLZyox+KUodRUT7xg6nGeM/TN6tWa6ubrYAbWEzNcd
         lloLod8C+nmFttZcACFiVaS31qBziG57FsIyfNq8fRQO+ckCaMaD9fnnpzanIKTJx5Qu
         nDEoi6cieEVRw2pvelnSwBIuXrA6Jq/lQ0Vo30HwhePJBGovrniSu8/+lY3mPoFvKeMx
         Sqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359042; x=1710963842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCfHqTTsLIjf6PahHwoSB6au2rlpK/wHDjPqDhpqcc4=;
        b=sALRZjNTaUpKNr8+OA+Qcurq6EJZgvE2A3Frjlt+PtzGJfDwdMIiMZLrj9eurgbnmY
         2tSeVP16lifVadYiFwq/7MpVvM8nqL8A8ezRitZdJet0KU6VYt2b+sT5b/1sjA9wGMcD
         BytzAkihiOyDO3j5JaFUzxPUdas77DJNkmW8k604vKnHuevRUAHBskvcSqf/LGatSgYa
         EqsGQUrpoM9i1wBkFQwc9qobNemfKNNroML6OsXG5C8L0OWWccV7W6ZG0Fm1TX1uGXTw
         ISg4nMmCnTXDwOVkvn5LV4tuwFdoPMxnrO/CbR9tCe80vQXzPFDtH8KTTs4GZO4sxovS
         A68g==
X-Gm-Message-State: AOJu0Yx98Yt9ncIrgZXCLC+AxRYhbQZrM4lUXd0hl+VKORJo/jlOLWc+
	Tcdw2G3+6ZFOp9ZGrnfZ2vJjRVWjxrPunUoVIB3QOXtr+/f3IWhqPxR6BsWJ
X-Google-Smtp-Source: AGHT+IHvorvA3rwf+gSE15zDGGIiDN06JW/S9WbtgGZF1eKZDfMYx9RVZRcPzx75eWpujHmzMVJfeA==
X-Received: by 2002:a05:6102:408:b0:475:fd25:3c6 with SMTP id d8-20020a056102040800b00475fd2503c6mr799678vsq.35.1710359042005;
        Wed, 13 Mar 2024 12:44:02 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id gd6-20020a056102624600b004730db4e873sm1800259vsb.10.2024.03.13.12.44.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:44:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/6] client/player: Split unicast and broadcast presets
Date: Wed, 13 Mar 2024 15:43:55 -0400
Message-ID: <20240313194400.1397477-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Although their name matches unicast and broadcast are not actually the
same when it comes to RTN and Max Latency, so this splits their settings
into 2 presets tables and fix the values for broadcast.
---
 client/player.c | 115 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 5 deletions(-)

diff --git a/client/player.c b/client/player.c
index a40bf66e3967..cb771447bf4b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1403,7 +1403,7 @@ static struct codec_preset sbc_presets[] = {
 		.target_latency = 0x03, \
 	}
 
-static struct codec_preset lc3_presets[] = {
+static struct codec_preset lc3_ucast_presets[] = {
 	/* Table 4.43: QoS configuration support setting requirements */
 	LC3_PRESET("8_1_1",
 			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
@@ -1565,6 +1565,111 @@ static struct codec_preset lc3_presets[] = {
 			LC3_10_UNFRAMED(2 * 120u, 1u, 20u, 10000u)),
 };
 
+static struct codec_preset lc3_bcast_presets[] = {
+	/* Table 6.4: Broadcast Audio Stream configuration support requirements
+	 * for the Broadcast Source and Broadcast Sink
+	 */
+	LC3_PRESET("8_1_1",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+			LC3_7_5_UNFRAMED(26u, 2u, 8u, 40000u)),
+	LC3_PRESET("8_2_1",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+			LC3_10_UNFRAMED(30u, 2u, 10u, 40000u)),
+	LC3_PRESET("16_1_1",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+			LC3_7_5_UNFRAMED(30u, 2u, 8u, 40000u)),
+	LC3_PRESET("16_2_1",
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
+			QOS_FRAMED_2M(8163u, 98u, 4u, 24u, 40000u)),
+	LC3_PRESET("44_2_1",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
+			QOS_FRAMED_2M(10884u, 130u, 4u, 31u, 40000u)),
+	LC3_PRESET("48_1_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+			LC3_7_5_UNFRAMED(75u, 4u, 15u, 40000u)),
+	LC3_PRESET("48_2_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+			LC3_10_UNFRAMED(100u, 4u, 20u, 40000u)),
+	LC3_PRESET("48_3_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+			LC3_7_5_UNFRAMED(90u, 4u, 15u, 40000u)),
+	LC3_PRESET("48_4_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+			LC3_10_UNFRAMED(120u, 4u, 20u, 40000u)),
+	LC3_PRESET("48_5_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
+			LC3_7_5_UNFRAMED(117u, 4u, 15u, 40000u)),
+	LC3_PRESET("48_6_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
+			LC3_10_UNFRAMED(155u, 4u, 20u, 40000u)),
+	/* Broadcast Audio Stream configuration settings for high-reliability
+	 * audio data.
+	 */
+	LC3_PRESET_HR("8_1_2",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+			LC3_7_5_UNFRAMED(26u, 4u, 45u, 40000u)),
+	LC3_PRESET_HR("8_2_2",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+			LC3_10_UNFRAMED(30u, 4u, 60u, 40000u)),
+	LC3_PRESET_HR("16_1_2",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+			LC3_7_5_UNFRAMED(30u, 4u, 45u, 40000u)),
+	LC3_PRESET_HR("16_2_2",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+			LC3_10_UNFRAMED(40u, 4u, 60u, 40000u)),
+	LC3_PRESET_HR("24_1_2",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_7_5, 45u),
+			LC3_7_5_UNFRAMED(45u, 4u, 45u, 40000u)),
+	LC3_PRESET_HR("24_2_2",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_10, 60u),
+			LC3_10_UNFRAMED(60u, 4u, 60u, 40000u)),
+	LC3_PRESET_HR("32_1_2",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+			LC3_7_5_UNFRAMED(60u, 4u, 45u, 40000u)),
+	LC3_PRESET_HR("32_2_2",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+			LC3_10_UNFRAMED(80u, 4u, 60u, 40000u)),
+	LC3_PRESET_HR("44_1_2",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
+			QOS_FRAMED_2M(8163u, 4u, 13u, 54u, 40000u)),
+	LC3_PRESET_HR("44_2_2",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
+			QOS_FRAMED_2M(10884u, 130u, 4u, 60u, 40000u)),
+	LC3_PRESET_HR("48_1_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+			LC3_7_5_UNFRAMED(75u, 4u, 50u, 40000u)),
+	LC3_PRESET_HR("48_2_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+			LC3_10_UNFRAMED(100u, 4u, 65u, 40000u)),
+	LC3_PRESET_HR("48_3_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+			LC3_7_5_UNFRAMED(90u, 4u, 50u, 40000u)),
+	LC3_PRESET_HR("48_4_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+			LC3_10_UNFRAMED(120u, 4u, 65u, 40000u)),
+	LC3_PRESET_HR("48_5_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
+			LC3_7_5_UNFRAMED(117u, 4u, 50u, 40000u)),
+	LC3_PRESET_HR("48_6_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
+			LC3_10_UNFRAMED(155u, 4u, 65u, 40000u)),
+};
+
 static void print_ltv(const char *str, void *user_data)
 {
 	const char *label = user_data;
@@ -1615,10 +1720,10 @@ static struct preset {
 } presets[] = {
 	PRESET(A2DP_SOURCE_UUID, A2DP_CODEC_SBC, sbc_presets, 6),
 	PRESET(A2DP_SINK_UUID, A2DP_CODEC_SBC, sbc_presets, 6),
-	PRESET(PAC_SINK_UUID, LC3_ID, lc3_presets, 3),
-	PRESET(PAC_SOURCE_UUID, LC3_ID, lc3_presets, 3),
-	PRESET(BCAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
-	PRESET(BAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
+	PRESET(PAC_SINK_UUID, LC3_ID, lc3_ucast_presets, 3),
+	PRESET(PAC_SOURCE_UUID, LC3_ID, lc3_ucast_presets, 3),
+	PRESET(BCAA_SERVICE_UUID,  LC3_ID, lc3_bcast_presets, 3),
+	PRESET(BAA_SERVICE_UUID,  LC3_ID, lc3_bcast_presets, 3),
 };
 
 static void parse_vendor_codec(const char *codec, uint16_t *vid, uint16_t *cid)
-- 
2.43.0

