Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232AA43AC8
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342431; cv=none; b=LewG4u3OIHCqcm7IliA2llkE7wN0y7tziO9gqvzrOU875lx19DfVf69OxSeCpnI27EC5kF0WnrZUgFSOEr/O2FOtpA6hTHbVPIy3bBViATaAvyaWEzVtVNPcnCNiTUQ4AfiMxj3XZoMsMsQE/K0ebLKhAZ40TA+uDduoRXPTTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342431; c=relaxed/simple;
	bh=e4+PHqDauya9n2dspmku/9IFy3579jWCY4iOuSZnHjA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DgkGwLk8REDc8TdycrTpZl+OOJtsg3G6o+EEqdE2+6xFaAzgHlGc3OWTjV1JCYx95Q9vjA64jE5HkWdX4rQxzeHUZJFFwnXdplEaBWxneNMJwHcvBxgkv+zoo3oLtbpTrjQ9rVfnnVa6tF/7OtY7DM7z2vQJ2H71dwPbUWtcuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grLc/znx; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grLc/znx"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42f2009e559so8745721cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710342428; x=1710947228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCfHqTTsLIjf6PahHwoSB6au2rlpK/wHDjPqDhpqcc4=;
        b=grLc/znxAi/g0/pw+36vNdvEFn2DGU7kv7hXS0XZ/ugNKp279FyXMgPwYNGEbSE0X1
         5ZvOq4oRuUprJLBxj8cxPjWXiZogEX0fIHve0Ppvjt0ZoqTS1aLR+/hXrRc30ey86Eos
         yHfK7dXVu7/BMPM8x/nOOQEX9iZC950OjjtyoSgdNtyVziwkC1SxSMmmtOBPx0Xo9zKi
         +Iyub0vzV0KliefZUNkucsF9r1v9/vv4RxqAAFvvlmyZTxcUHEmeCSEQezqTtVWlmhfa
         Uv0JV8I3PQd/8DuczjGAGnuhxSu7L2l5OnXBWF7noK5vB8GP16QfdZqwEVdMZ46XeVo7
         SOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342428; x=1710947228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCfHqTTsLIjf6PahHwoSB6au2rlpK/wHDjPqDhpqcc4=;
        b=jB3NAoIPs3/UPCv7YkUhOCdUrgrIJhZXA81aXJ1OY1Nzx32y5x8X1fYtaAUTFzVc4W
         wI3oAXsYBOfMM2w/PBw+6eoIx1YD15mUI+aLDo15FoCgn8mgjqLMmWKi6jaMpexJMoX0
         uCDWzxguDDQqGQ1gNBI5ZNiPs7OzEK1ImeIj5/oor60Os4BABLde2bHbZIdz95AAmjj0
         6k+Eo58DnK35nP5SVIE1bGKWEiVS6rOfL+Wv8rxpzj/jxOF0OxKDFCnClxXBNWEXkaIH
         Xb2RB2+ojdkgjEvFQL3HocQpl4AGy4LdtcimGfWhSlITY/qKuoMYA6D8Y/GT3ji4JTyy
         dV0w==
X-Gm-Message-State: AOJu0YwnzGXWsZott1R3/VC/iGFNpPXI7aeKRe3QCo16Z/9v6xoGv1jY
	cIgGyV2WD2WOqVF7JHzRv24JRdGtUQaEintqc1Lp3YNxCru3iR9Rw1v6+g5k
X-Google-Smtp-Source: AGHT+IGh2d7MdnJYdxNLeVMl8E4WCd45z7Qrb5JaEpcHtYJNKE/M84WzOv2fq0vC2gicAFafd9nPhg==
X-Received: by 2002:a05:6214:2b0a:b0:68f:f859:ee06 with SMTP id jx10-20020a0562142b0a00b0068ff859ee06mr175651qvb.12.1710342428432;
        Wed, 13 Mar 2024 08:07:08 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id bi47-20020a05612218af00b004cd29aaccd6sm1205610vkb.2.2024.03.13.08.07.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:07:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] client/player: Split unicast and broadcast presets
Date: Wed, 13 Mar 2024 11:07:03 -0400
Message-ID: <20240313150706.1279036-1-luiz.dentz@gmail.com>
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

