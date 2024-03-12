Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB225F4FA
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256666; cv=none; b=KT43OyYeVh8lCE1RjYw5Ni3O4XXdcccp5lzAaYJrS+JiCqJPi6CVZPsWrSK4mba3ROn5S1yCXa/wOzxc0ehzEGPznbm70291HI+X4gmfnnan5ZK3DKfI93aVJEoWY61bYA2jlznng8e1sMVrZOQlkWtbN6sMCBNLYSTVxBXh/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256666; c=relaxed/simple;
	bh=e4+PHqDauya9n2dspmku/9IFy3579jWCY4iOuSZnHjA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aCOtcMHkS+3qRgepd1tOhZqDjPx1AL3fiYpIUzIpOAMPJ4ZvBhdwuAKRss9Ik0Rbua4gligFdiGVgKwK/DzU62zbz5b9BUEuAQfujnA7nCVsVeW8b94olM0mjTf6CZO75K+KMWNnFxF5jQ8El7dudTvh6TZzFe+3FM8pLtX3Sa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mgp4DSTR; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgp4DSTR"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e53893c559so637180a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710256662; x=1710861462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCfHqTTsLIjf6PahHwoSB6au2rlpK/wHDjPqDhpqcc4=;
        b=Mgp4DSTRQQwKW9xIwmOHIUu6wauMBMDYNncRlOQnyEug1/cAb+SFhOp3YygaTeD7uJ
         wDMctq/WOImUbQrsLmekkQ8guclPjeVFN5jYPr92Py+nCceIJISNRxAas+QdVG45dAM2
         bdC2zF9apBUKoQMsLMUunHaucJ06Sg3deod7FMVBUCPJa4P2NBNUVol7WZvH3y0K468F
         7EuPYjR8IkhGRrt+LexB1xAh3fGn8/zFCkeyvyrIL2ujGMCROeb1sNgyjIMxLgPi4jMq
         CsV15sFy0J/ohHO92c+9Frs362KjWKm/+2XCXExv/LUK6K9grxqaz1ZG93KCLnv5dObO
         28Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710256662; x=1710861462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCfHqTTsLIjf6PahHwoSB6au2rlpK/wHDjPqDhpqcc4=;
        b=o3fXIUcZMux1FtepjnIWJ/ABIsr+iZ7zoiGxeyFNQAx4obe0Ts8sbM+kJAtwF5625N
         1zNdjEizkrBZ/RpSdQxTw6KQiG8sRg30xdCf0rzihsK5nByPF0UR3G5y0e63RThP7aHO
         8lmvECerCNB0MbGGDaJfMDfmvJcZOgfT3VN3uNVuAcv4nuY7sfSxqrWaH0KQ8zvysiYx
         YSdXsH8x6E2K86jp15TqZDcKrabVgDiDxWfWektdEfPlWKD77gUDk8X7KZwdw9H9r3oM
         b2GNwGR4KeaTs6iz3sWROAtZMi8hItyfQYx2winYIaX+2ZvSfgO+jcVIpGG64Y/e2kGR
         qn0w==
X-Gm-Message-State: AOJu0YzDjAOWYB9SdRcB9cCCm7OEgwxSyLy/e/4woobEj4w08QP67zOF
	UWb7YLMihx3DQS/BMEM/8R2QrzhWW7xTKX0TryH2UU4ClDqDGkS/Wc/CWF99
X-Google-Smtp-Source: AGHT+IFv7vO4LRgQRHLwzAXjDWa/FgbYshc/irREQHRgnunpBu3phVX34/fu/hkep6Du6e66c+6adA==
X-Received: by 2002:a9d:7581:0:b0:6e5:2435:37cf with SMTP id s1-20020a9d7581000000b006e5243537cfmr7294814otk.37.1710256662362;
        Tue, 12 Mar 2024 08:17:42 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id i4-20020ac5cd84000000b004d339781311sm896646vka.56.2024.03.12.08.17.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:17:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/player: Split unicast and broadcast presets
Date: Tue, 12 Mar 2024 11:17:40 -0400
Message-ID: <20240312151740.1105289-1-luiz.dentz@gmail.com>
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

