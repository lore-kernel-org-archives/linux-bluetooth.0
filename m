Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C6943AC8
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342434; cv=none; b=e+8wHrH1qUdWWJ8yS2FHJxyDbGh8aQKxzfS4GTmjHcuhBh/jRYE0x3G8tL1Da5OZOo9WpaNu2wdHJ0Cp+WmlitWdC8clhvnAj5dnKQxfV+MbNjs6Z5Rms+AjuejsU9dsA25UmY5ykKSKYCecc07rHF0wQVCTH8dVbicjLaiUHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342434; c=relaxed/simple;
	bh=cfNY3BBkfwla0T7BeuhyZ1NNOs+VAaGvidP52JFYiQw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5i3NkfJZpTj+HVaOw72SJMAth/6e1s/qNZQMKd1Exo6GMFz/jgIzehnTgKzAJuclKpEr0XR8ECNSuxKKqNmXRMY8x40Q0Qs93sGONZZJLeG+kUw5qb09zXH47biC+RfSn32BZG8DKZ/L1gi5uEA3gJ1GDy/uh7XM9CnQL+ne2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJANZ2Qq; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJANZ2Qq"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e4f7975121so1619417a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710342430; x=1710947230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MZuY6HijLPSzb+nauMJkoEggmbfDWPgO2STK/0p2VQ=;
        b=BJANZ2QqQadLPpjgTr7hPssgFV+aQdhj51d+8IcnHbdJAY4Rc95tHNsQsOk68YBFlz
         rehsf7f4lu5Jgqds3Nnh/AEIFcd2B4Mz1nVM3lhF9aGVRi6hIhJ7w1JL/nvULH8ww9+R
         5Xl0MVfY2E/f4Kcqp45p6L8p2D6VcQRPXG5J78q7+jmkdlr9FcDoSktgBnTaLllgudhO
         hnyBGGJtUnvGjl6ER8c+fbWhWbjzPzujvn8DZFFt+NmCmlpY+q3m6HcokoE2Ha/40WTO
         W0eeb5eNrqwi9PaLfLRhA3fsDh+fWzKexthAtCOy8uboaoFrioAZ73nDztn6I+/SIhTG
         URug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342430; x=1710947230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MZuY6HijLPSzb+nauMJkoEggmbfDWPgO2STK/0p2VQ=;
        b=DG+pVZhpIG5YWCiWsuoTBMDDLLthJXqvkfnKt8KmfySPxjtIfIodTA7B3jkP3l7qhw
         uKDl5/LSzCVTvdsGykdDJunM2p+SFYC0hC2UmLkh1szdKcC4DX7HTnpdno5OdCJd9eLp
         lGTUOULvPTTh5oOTwxuas9MQNi5mYYrExHSU2IMxnqMEHY6YWlZJ0is1c2OSgxNS2KpV
         v3whMRaKinmTNOSo4SVnwKQCHKE47MIfa4NfeKGhwXRx33L+ncbj1YL227p9XH07jluT
         MTR9bZUq6XnV4yv9psJHib/Jpsrt//WRrxriPnSH4mAdZ8qMOXCDWHBPAumfMaZ171Mb
         n2Vg==
X-Gm-Message-State: AOJu0Ywz8A8giVLxB9OCfbRa4u/t1n+WUzzxxGWwP+rdKMGrsHWmGarR
	gB8XEEbA54UUrFYxOQS251oZrVxoS1ChnxjJGn0+lYDAZpYyNlhfxf1yp45w
X-Google-Smtp-Source: AGHT+IHkD4lyBgI9tsQxAzgRu/9k7xFhCQT7ClUjhejIgM4gGWbt3oADrE6KXUTNw2uHFJWEemFy/g==
X-Received: by 2002:a05:6830:1549:b0:6e5:3103:a948 with SMTP id l9-20020a056830154900b006e53103a948mr137126otp.27.1710342430157;
        Wed, 13 Mar 2024 08:07:10 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id bi47-20020a05612218af00b004cd29aaccd6sm1205610vkb.2.2024.03.13.08.07.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:07:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] client/player: Use macros from lc3.h to define presets
Date: Wed, 13 Mar 2024 11:07:04 -0400
Message-ID: <20240313150706.1279036-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313150706.1279036-1-luiz.dentz@gmail.com>
References: <20240313150706.1279036-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of macros for for lc3.h to define preset configuration
and remove existing macros since they were just duplicates.
---
 client/player.c | 294 ++++++++++++++----------------------------------
 1 file changed, 82 insertions(+), 212 deletions(-)

diff --git a/client/player.c b/client/player.c
index cb771447bf4b..ab8cb7434cdc 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1337,48 +1337,6 @@ static struct codec_preset sbc_presets[] = {
 #define LC3_10_FRAMED(_sdu, _rtn, _latency, _delay) \
 	QOS_FRAMED_2M(10000u, _sdu, _rtn, _latency, _delay)
 
-#define LC3_PRESET_DATA(_freq, _duration, _len) \
-	UTIL_IOV_INIT(0x02, LC3_CONFIG_FREQ, _freq, \
-			0x02, LC3_CONFIG_DURATION, _duration, \
-			0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
-
-#define LC3_PRESET_DATA_ALL(_freq, _duration, _alloc, _len) \
-	UTIL_IOV_INIT(0x02, LC3_CONFIG_FREQ, _freq, \
-			0x02, LC3_CONFIG_DURATION, _duration, \
-			0x05, LC3_CONFIG_CHAN_ALLOC, _alloc, _alloc >> 8, \
-			_alloc >> 16, _alloc >> 24, \
-			0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
-
-#define LC3_PRESET_8KHZ(_duration, _len) \
-	LC3_PRESET_DATA(LC3_CONFIG_FREQ_8KHZ, _duration, _len)
-
-#define LC3_PRESET_11KHZ(_duration, _len) \
-	LC3_PRESET_DATA(LC3_CONFIG_FREQ_11KHZ, _duration, _len)
-
-#define LC3_PRESET_16KHZ(_duration, _len) \
-	LC3_PRESET_DATA(LC3_CONFIG_FREQ_16KHZ, _duration, _len)
-
-#define LC3_PRESET_22KHZ(_duration, _len) \
-	LC3_PRESET_DATA(LC3_CONFIG_FREQ_22KHZ, _duration, _len)
-
-#define LC3_PRESET_24KHZ(_duration, _len) \
-	LC3_PRESET_DATA(LC3_CONFIG_FREQ_24KHZ, _duration, _len)
-
-#define LC3_PRESET_32KHZ(_duration, _len) \
-	LC3_PRESET_DATA(LC3_CONFIG_FREQ_32KHZ, _duration, _len)
-
-#define LC3_PRESET_32KHZ_ALL(_duration, _len, _alloc) \
-	LC3_PRESET_DATA_ALL(LC3_CONFIG_FREQ_48KHZ, _duration, _alloc, _len)
-
-#define LC3_PRESET_44KHZ(_duration, _len) \
-	LC3_PRESET_DATA(LC3_CONFIG_FREQ_44KHZ, _duration, _len)
-
-#define LC3_PRESET_48KHZ(_duration, _len) \
-	LC3_PRESET_DATA(LC3_CONFIG_FREQ_48KHZ, _duration, _len)
-
-#define LC3_PRESET_48KHZ_ALL(_duration, _len, _alloc) \
-	LC3_PRESET_DATA_ALL(LC3_CONFIG_FREQ_48KHZ, _duration, _alloc, _len)
-
 #define LC3_PRESET_LL(_name, _data, _qos) \
 	{ \
 		.name = _name, \
@@ -1405,163 +1363,107 @@ static struct codec_preset sbc_presets[] = {
 
 static struct codec_preset lc3_ucast_presets[] = {
 	/* Table 4.43: QoS configuration support setting requirements */
-	LC3_PRESET("8_1_1",
-			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+	LC3_PRESET("8_1_1", LC3_CONFIG_8_1,
 			LC3_7_5_UNFRAMED(26u, 2u, 8u, 40000u)),
-	LC3_PRESET("8_2_1",
-			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+	LC3_PRESET("8_2_1", LC3_CONFIG_8_2,
 			LC3_10_UNFRAMED(30u, 2u, 10u, 40000u)),
-	LC3_PRESET("16_1_1",
-			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+	LC3_PRESET("16_1_1", LC3_CONFIG_16_1,
 			LC3_7_5_UNFRAMED(30u, 2u, 8u, 40000u)),
-	LC3_PRESET("16_2_1",
-			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+	LC3_PRESET("16_2_1", LC3_CONFIG_16_2,
 			LC3_10_UNFRAMED(40u, 2u, 10u, 40000u)),
-	LC3_PRESET("24_1_1",
-			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_7_5, 45u),
+	LC3_PRESET("24_1_1", LC3_CONFIG_24_1,
 			LC3_7_5_UNFRAMED(45u, 2u, 8u, 40000u)),
-	LC3_PRESET("24_2_1",
-			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_10, 60u),
+	LC3_PRESET("24_2_1", LC3_CONFIG_24_2,
 			LC3_10_UNFRAMED(60u, 2u, 10u, 40000u)),
-	LC3_PRESET("32_1_1",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+	LC3_PRESET("32_1_1", LC3_CONFIG_32_1,
 			LC3_7_5_UNFRAMED(60u, 2u, 8u, 40000u)),
-	LC3_PRESET("32_2_1",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+	LC3_PRESET("32_2_1", LC3_CONFIG_32_2,
 			LC3_10_UNFRAMED(80u, 2u, 10u, 40000u)),
-	LC3_PRESET("44_1_1",
-			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
+	LC3_PRESET("44_1_1", LC3_CONFIG_44_1,
 			QOS_FRAMED_2M(8163u, 98u, 5u, 24u, 40000u)),
-	LC3_PRESET("44_2_1",
-			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
+	LC3_PRESET("44_2_1", LC3_CONFIG_44_2,
 			QOS_FRAMED_2M(10884u, 130u, 5u, 31u, 40000u)),
-	LC3_PRESET("48_1_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+	LC3_PRESET("48_1_1", LC3_CONFIG_48_1,
 			LC3_7_5_UNFRAMED(75u, 5u, 15u, 40000u)),
-	LC3_PRESET("48_2_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+	LC3_PRESET("48_2_1", LC3_CONFIG_48_2,
 			LC3_10_UNFRAMED(100u, 5u, 20u, 40000u)),
-	LC3_PRESET("48_3_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+	LC3_PRESET("48_3_1", LC3_CONFIG_48_3,
 			LC3_7_5_UNFRAMED(90u, 5u, 15u, 40000u)),
-	LC3_PRESET("48_4_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+	LC3_PRESET("48_4_1", LC3_CONFIG_48_4,
 			LC3_10_UNFRAMED(120u, 5u, 20u, 40000u)),
-	LC3_PRESET("48_5_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
+	LC3_PRESET("48_5_1", LC3_CONFIG_48_5,
 			LC3_7_5_UNFRAMED(117u, 5u, 15u, 40000u)),
-	LC3_PRESET("48_6_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
+	LC3_PRESET("48_6_1", LC3_CONFIG_48_6,
 			LC3_10_UNFRAMED(155u, 5u, 20u, 40000u)),
 	/* QoS Configuration settings for high reliability audio data */
-	LC3_PRESET_HR("8_1_2",
-			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+	LC3_PRESET_HR("8_1_2", LC3_CONFIG_8_1,
 			LC3_7_5_UNFRAMED(26u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("8_2_2",
-			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+	LC3_PRESET_HR("8_2_2", LC3_CONFIG_8_2,
 			LC3_10_UNFRAMED(30u, 13u, 95u, 40000u)),
-	LC3_PRESET_HR("16_1_2",
-			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+	LC3_PRESET_HR("16_1_2", LC3_CONFIG_16_1,
 			LC3_7_5_UNFRAMED(30u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("16_2_2",
-			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+	LC3_PRESET_HR("16_2_2", LC3_CONFIG_16_2,
 			LC3_10_UNFRAMED(40u, 13u, 95u, 40000u)),
-	LC3_PRESET_HR("24_1_2",
-			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_7_5, 45u),
+	LC3_PRESET_HR("24_1_2", LC3_CONFIG_24_1,
 			LC3_7_5_UNFRAMED(45u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("24_2_2",
-			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_10, 60u),
+	LC3_PRESET_HR("24_2_2", LC3_CONFIG_24_2,
 			LC3_10_UNFRAMED(60u, 13u, 95u, 40000u)),
-	LC3_PRESET_HR("32_1_2",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+	LC3_PRESET_HR("32_1_2", LC3_CONFIG_32_1,
 			LC3_7_5_UNFRAMED(60u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("32_2_2",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+	LC3_PRESET_HR("32_2_2", LC3_CONFIG_32_2,
 			LC3_10_UNFRAMED(80u, 13u, 95u, 40000u)),
-	LC3_PRESET_HR("44_1_2",
-			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
+	LC3_PRESET_HR("44_1_2", LC3_CONFIG_44_1,
 			QOS_FRAMED_2M(8163u, 98u, 13u, 80u, 40000u)),
-	LC3_PRESET_HR("44_2_2",
-			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
+	LC3_PRESET_HR("44_2_2", LC3_CONFIG_44_2,
 			QOS_FRAMED_2M(10884u, 130u, 13u, 85u, 40000u)),
-	LC3_PRESET_HR("48_1_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+	LC3_PRESET_HR("48_1_2", LC3_CONFIG_48_1,
 			LC3_7_5_UNFRAMED(75u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("48_2_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+	LC3_PRESET_HR("48_2_2", LC3_CONFIG_48_2,
 			LC3_10_UNFRAMED(100u, 13u, 95u, 40000u)),
-	LC3_PRESET_HR("48_3_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+	LC3_PRESET_HR("48_3_2", LC3_CONFIG_48_3,
 			LC3_7_5_UNFRAMED(90u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("48_4_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+	LC3_PRESET_HR("48_4_2", LC3_CONFIG_48_4,
 			LC3_10_UNFRAMED(120u, 13u, 100u, 40000u)),
-	LC3_PRESET_HR("48_5_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
+	LC3_PRESET_HR("48_5_2", LC3_CONFIG_48_5,
 			LC3_7_5_UNFRAMED(117u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("48_6_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
+	LC3_PRESET_HR("48_6_2", LC3_CONFIG_48_6,
 			LC3_10_UNFRAMED(155u, 13u, 100u, 40000u)),
 	/* QoS configuration support setting requirements for the UGG and UGT */
-	LC3_PRESET_LL("16_1_gs",
-			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+	LC3_PRESET_LL("16_1_gs", LC3_CONFIG_16_1,
 			LC3_7_5_UNFRAMED(30u, 1u, 15u, 60000u)),
-	LC3_PRESET_LL("16_2_gs",
-			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+	LC3_PRESET_LL("16_2_gs", LC3_CONFIG_16_2,
 			LC3_10_UNFRAMED(40u, 1u, 20u, 60000u)),
-	LC3_PRESET_LL("32_1_gs",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+	LC3_PRESET_LL("32_1_gs", LC3_CONFIG_32_1,
 			LC3_7_5_UNFRAMED(60u, 1u, 15u, 60000u)),
-	LC3_PRESET_LL("32_2_gs",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+	LC3_PRESET_LL("32_2_gs", LC3_CONFIG_32_2,
 			LC3_10_UNFRAMED(80u, 1u, 20u, 60000u)),
-	LC3_PRESET_LL("48_1_gs",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+	LC3_PRESET_LL("48_1_gs", LC3_CONFIG_48_1,
 			LC3_7_5_UNFRAMED(75u, 1u, 15u, 60000u)),
-	LC3_PRESET_LL("48_2_gs",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+	LC3_PRESET_LL("48_2_gs", LC3_CONFIG_48_2,
 			LC3_10_UNFRAMED(100u, 1u, 20u, 60000u)),
-	LC3_PRESET_LL("32_1_gr",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+	LC3_PRESET_LL("32_1_gr", LC3_CONFIG_32_1,
 			LC3_7_5_UNFRAMED(60u, 1u, 15u, 10000u)),
-	LC3_PRESET_LL("32_2_gr",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+	LC3_PRESET_LL("32_2_gr", LC3_CONFIG_32_2,
 			LC3_10_UNFRAMED(80u, 1u, 20u, 10000u)),
-	LC3_PRESET_LL("48_1_gr",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+	LC3_PRESET_LL("48_1_gr", LC3_CONFIG_48_1,
 			LC3_7_5_UNFRAMED(75u, 1u, 15u, 10000u)),
-	LC3_PRESET_LL("48_2_gr",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+	LC3_PRESET_LL("48_2_gr", LC3_CONFIG_48_2,
 			LC3_10_UNFRAMED(100u, 1u, 20u, 10000u)),
-	LC3_PRESET_LL("48_3_gr",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+	LC3_PRESET_LL("48_3_gr", LC3_CONFIG_48_3,
 			LC3_7_5_UNFRAMED(90u, 1u, 15u, 10000u)),
-	LC3_PRESET_LL("48_4_gr",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+	LC3_PRESET_LL("48_4_gr", LC3_CONFIG_48_4,
 			LC3_10_UNFRAMED(120u, 1u, 20u, 10000u)),
-	LC3_PRESET_LL("32_1_gr_l+r",
-			LC3_PRESET_32KHZ_ALL(LC3_CONFIG_DURATION_7_5, 60u,
-						0x00000003),
+	LC3_PRESET_LL("32_1_gr_l+r", LC3_CONFIG_32_1_AC(2),
 			LC3_7_5_UNFRAMED(2 * 60u, 1u, 15u, 10000u)),
-	LC3_PRESET_LL("32_2_gr_l+r",
-			LC3_PRESET_32KHZ_ALL(LC3_CONFIG_DURATION_10, 80u,
-						0x00000003),
+	LC3_PRESET_LL("32_2_gr_l+r", LC3_CONFIG_32_2_AC(2),
 			LC3_10_UNFRAMED(2 * 80u, 1u, 20u, 10000u)),
-	LC3_PRESET_LL("48_1_gr_l+r",
-			LC3_PRESET_48KHZ_ALL(LC3_CONFIG_DURATION_7_5, 75u,
-						0x00000003),
+	LC3_PRESET_LL("48_1_gr_l+r", LC3_CONFIG_48_1_AC(2),
 			LC3_7_5_UNFRAMED(2 * 75u, 1u, 15u, 10000u)),
-	LC3_PRESET_LL("48_2_gr_l+r",
-			LC3_PRESET_48KHZ_ALL(LC3_CONFIG_DURATION_10, 100u,
-						0x00000003),
+	LC3_PRESET_LL("48_2_gr_l+r", LC3_CONFIG_48_2_AC(2),
 			LC3_10_UNFRAMED(2 * 100u, 1u, 20u, 10000u)),
-	LC3_PRESET_LL("48_3_gr_l+r",
-			LC3_PRESET_48KHZ_ALL(LC3_CONFIG_DURATION_7_5, 90u,
-						0x00000003),
+	LC3_PRESET_LL("48_3_gr_l+r", LC3_CONFIG_48_3_AC(2),
 			LC3_7_5_UNFRAMED(2 * 90u, 1u, 15u, 10000u)),
-	LC3_PRESET_LL("48_4_gr_l+r",
-			LC3_PRESET_48KHZ_ALL(LC3_CONFIG_DURATION_10, 120u,
-						0x00000003),
+	LC3_PRESET_LL("48_4_gr_l+r", LC3_CONFIG_48_4_AC(2),
 			LC3_10_UNFRAMED(2 * 120u, 1u, 20u, 10000u)),
 };
 
@@ -1569,104 +1471,72 @@ static struct codec_preset lc3_bcast_presets[] = {
 	/* Table 6.4: Broadcast Audio Stream configuration support requirements
 	 * for the Broadcast Source and Broadcast Sink
 	 */
-	LC3_PRESET("8_1_1",
-			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+	LC3_PRESET("8_1_1", LC3_CONFIG_8_1,
 			LC3_7_5_UNFRAMED(26u, 2u, 8u, 40000u)),
-	LC3_PRESET("8_2_1",
-			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+	LC3_PRESET("8_2_1", LC3_CONFIG_8_2,
 			LC3_10_UNFRAMED(30u, 2u, 10u, 40000u)),
-	LC3_PRESET("16_1_1",
-			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+	LC3_PRESET("16_1_1", LC3_CONFIG_16_1,
 			LC3_7_5_UNFRAMED(30u, 2u, 8u, 40000u)),
-	LC3_PRESET("16_2_1",
-			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+	LC3_PRESET("16_2_1", LC3_CONFIG_16_2,
 			LC3_10_UNFRAMED(40u, 2u, 10u, 40000u)),
-	LC3_PRESET("24_1_1",
-			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_7_5, 45u),
+	LC3_PRESET("24_1_1", LC3_CONFIG_24_1,
 			LC3_7_5_UNFRAMED(45u, 2u, 8u, 40000u)),
-	LC3_PRESET("24_2_1",
-			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_10, 60u),
+	LC3_PRESET("24_2_1", LC3_CONFIG_24_2,
 			LC3_10_UNFRAMED(60u, 2u, 10u, 40000u)),
-	LC3_PRESET("32_1_1",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+	LC3_PRESET("32_1_1", LC3_CONFIG_32_1,
 			LC3_7_5_UNFRAMED(60u, 2u, 8u, 40000u)),
-	LC3_PRESET("32_2_1",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+	LC3_PRESET("32_2_1", LC3_CONFIG_32_2,
 			LC3_10_UNFRAMED(80u, 2u, 10u, 40000u)),
-	LC3_PRESET("44_1_1",
-			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
+	LC3_PRESET("44_1_1", LC3_CONFIG_44_1,
 			QOS_FRAMED_2M(8163u, 98u, 4u, 24u, 40000u)),
-	LC3_PRESET("44_2_1",
-			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
+	LC3_PRESET("44_2_1", LC3_CONFIG_44_2,
 			QOS_FRAMED_2M(10884u, 130u, 4u, 31u, 40000u)),
-	LC3_PRESET("48_1_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+	LC3_PRESET("48_1_1", LC3_CONFIG_48_1,
 			LC3_7_5_UNFRAMED(75u, 4u, 15u, 40000u)),
-	LC3_PRESET("48_2_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+	LC3_PRESET("48_2_1", LC3_CONFIG_48_2,
 			LC3_10_UNFRAMED(100u, 4u, 20u, 40000u)),
-	LC3_PRESET("48_3_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+	LC3_PRESET("48_3_1", LC3_CONFIG_48_3,
 			LC3_7_5_UNFRAMED(90u, 4u, 15u, 40000u)),
-	LC3_PRESET("48_4_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+	LC3_PRESET("48_4_1", LC3_CONFIG_48_4,
 			LC3_10_UNFRAMED(120u, 4u, 20u, 40000u)),
-	LC3_PRESET("48_5_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
+	LC3_PRESET("48_5_1", LC3_CONFIG_48_5,
 			LC3_7_5_UNFRAMED(117u, 4u, 15u, 40000u)),
-	LC3_PRESET("48_6_1",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
+	LC3_PRESET("48_6_1", LC3_CONFIG_48_6,
 			LC3_10_UNFRAMED(155u, 4u, 20u, 40000u)),
 	/* Broadcast Audio Stream configuration settings for high-reliability
 	 * audio data.
 	 */
-	LC3_PRESET_HR("8_1_2",
-			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+	LC3_PRESET_HR("8_1_2", LC3_CONFIG_8_1,
 			LC3_7_5_UNFRAMED(26u, 4u, 45u, 40000u)),
-	LC3_PRESET_HR("8_2_2",
-			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+	LC3_PRESET_HR("8_2_2", LC3_CONFIG_8_2,
 			LC3_10_UNFRAMED(30u, 4u, 60u, 40000u)),
-	LC3_PRESET_HR("16_1_2",
-			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+	LC3_PRESET_HR("16_1_2", LC3_CONFIG_16_1,
 			LC3_7_5_UNFRAMED(30u, 4u, 45u, 40000u)),
-	LC3_PRESET_HR("16_2_2",
-			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+	LC3_PRESET_HR("16_2_2", LC3_CONFIG_16_2,
 			LC3_10_UNFRAMED(40u, 4u, 60u, 40000u)),
-	LC3_PRESET_HR("24_1_2",
-			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_7_5, 45u),
+	LC3_PRESET_HR("24_1_2", LC3_CONFIG_24_1,
 			LC3_7_5_UNFRAMED(45u, 4u, 45u, 40000u)),
-	LC3_PRESET_HR("24_2_2",
-			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_10, 60u),
+	LC3_PRESET_HR("24_2_2", LC3_CONFIG_24_2,
 			LC3_10_UNFRAMED(60u, 4u, 60u, 40000u)),
-	LC3_PRESET_HR("32_1_2",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+	LC3_PRESET_HR("32_1_2", LC3_CONFIG_32_1,
 			LC3_7_5_UNFRAMED(60u, 4u, 45u, 40000u)),
-	LC3_PRESET_HR("32_2_2",
-			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+	LC3_PRESET_HR("32_2_2", LC3_CONFIG_32_2,
 			LC3_10_UNFRAMED(80u, 4u, 60u, 40000u)),
-	LC3_PRESET_HR("44_1_2",
-			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
+	LC3_PRESET_HR("44_1_2", LC3_CONFIG_44_1,
 			QOS_FRAMED_2M(8163u, 4u, 13u, 54u, 40000u)),
-	LC3_PRESET_HR("44_2_2",
-			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
+	LC3_PRESET_HR("44_2_2", LC3_CONFIG_44_2,
 			QOS_FRAMED_2M(10884u, 130u, 4u, 60u, 40000u)),
-	LC3_PRESET_HR("48_1_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+	LC3_PRESET_HR("48_1_2", LC3_CONFIG_48_1,
 			LC3_7_5_UNFRAMED(75u, 4u, 50u, 40000u)),
-	LC3_PRESET_HR("48_2_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+	LC3_PRESET_HR("48_2_2", LC3_CONFIG_48_2,
 			LC3_10_UNFRAMED(100u, 4u, 65u, 40000u)),
-	LC3_PRESET_HR("48_3_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+	LC3_PRESET_HR("48_3_2", LC3_CONFIG_48_3,
 			LC3_7_5_UNFRAMED(90u, 4u, 50u, 40000u)),
-	LC3_PRESET_HR("48_4_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+	LC3_PRESET_HR("48_4_2", LC3_CONFIG_48_4,
 			LC3_10_UNFRAMED(120u, 4u, 65u, 40000u)),
-	LC3_PRESET_HR("48_5_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
+	LC3_PRESET_HR("48_5_2", LC3_CONFIG_48_5,
 			LC3_7_5_UNFRAMED(117u, 4u, 50u, 40000u)),
-	LC3_PRESET_HR("48_6_2",
-			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
+	LC3_PRESET_HR("48_6_2", LC3_CONFIG_48_6,
 			LC3_10_UNFRAMED(155u, 4u, 65u, 40000u)),
 };
 
-- 
2.43.0

