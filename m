Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A474595B
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342440; cv=none; b=MDZ30rQ+oL0xKbbl1UNK4/dvyIhKhYQqkAUrb+60eiXB3R53B/Pv1mtV3vJzievL1gTbH99TIwo5XJ5Y8pKZ5eNilEOqkQn+A7jepgbFSv5+q9Lc9L4Nx+2cWYbxnxJWyfxew6wvYM3iifun8zEFa7VBNMXPgHqQYSVpARoM24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342440; c=relaxed/simple;
	bh=j710wOZNf7KTzExFslKWSqoTk4lqWboYfZoTrcgyVgI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcLn/o/dN3vRtCe0JyjhadupYzfHHVIwaXoGzcikx0lnn222FRzgcSqDqU/wl368XeSUZSxTI934adQR2PYQ8KfnR28MD6+5LCWePe3OaKopZ85urNiCOdqj50cDNwp9vm8l5P1QaRpQ0Wmi67VrhdM0NsiedZzDHnvD3YNd0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flydXdgQ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flydXdgQ"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22181888b88so5465607fac.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710342436; x=1710947236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWt7gHL/JGzoqW2iuwH4qx4vSGfHkpJ9BsKj6XmOeRk=;
        b=flydXdgQBQ0RzgjMylPdYUF5C3fz0RW4y561XrPyr+VqI7SIiNDjl5F9ZJNBaQwLKG
         HAhssSO7lsioOenguCcAxD0sDPXNDPBqv+o1bmABaXPOB4p2ILzIE62RVuXDZrOfpJTv
         6Xn5r6/sNWygcZaiDYB/0OFGNPbZD/qnUS801fOYCRv4dAO5fT91b4qn8sX2NA2mnDx3
         24UoIIsvTBhw1RH0eJBjGO/XMzpTlsu4F+v9/pZTyJBt/RkSrRjjWWol/5Bsxx3V6wmJ
         EaKqnnDiOai6qqlf9+Y04kRNjk0j5NBzmcjfiHq1e/LkleOekPaARL/HUzT1r5H+xhsr
         B2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342436; x=1710947236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWt7gHL/JGzoqW2iuwH4qx4vSGfHkpJ9BsKj6XmOeRk=;
        b=dUgyc9tNnTIuqRAM8cJS2woJI8/2thC07RNo5jCadPkPJmf//xT9MuLogur4w7jEFM
         TMPYqbIEbVsLiooUuxoVWrTxFodBGxcVjzAVMQ2OJgl0KP0PTWI2b0yZI9+V+2DPhWHS
         kAf7XSH288N4wdODtdPDaMszXCccbZeGdcYZu9EWCMjpWVP2/fpQk9/pm5tvtWLezIz1
         R3Cphb1+dYghh0YNfSxHK8TCMIkOwZ8xgZHVzjYtfr9c0pLXZmU6Yw6h1yIQHk9Ec1G2
         W9Xtj4/ANFzXkMkZ+qsLGN26Pu9veAZgWDYc3OK/cUYVTkZfpPfwjukds3rjFqLCv7he
         qqjA==
X-Gm-Message-State: AOJu0Yy2/gryWLcgcXtViSJbNb8+xM3UBTikOK+kQxgIwR7owHVoL0n3
	7Uo69WYLvoZRexXWbLNbYbGS7dZ482DZQDh8cl6kFtLSCRmnZltm7ESpPuaZ
X-Google-Smtp-Source: AGHT+IEC08RbKwf9eczVuxAnkNH5QdEzNTIawehVFvCNir2azHrlQidaHJSzpYV6zgj1s8YARe0e+A==
X-Received: by 2002:a05:6870:1590:b0:21f:a11a:e251 with SMTP id j16-20020a056870159000b0021fa11ae251mr5665311oab.5.1710342435913;
        Wed, 13 Mar 2024 08:07:15 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id bi47-20020a05612218af00b004cd29aaccd6sm1205610vkb.2.2024.03.13.08.07.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:07:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] client/player: Use QOS macros from lc3.h to define presets
Date: Wed, 13 Mar 2024 11:07:06 -0400
Message-ID: <20240313150706.1279036-4-luiz.dentz@gmail.com>
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

This makes use of QOS macros for for lc3.h to define preset
configuration and remove existing macros since they were just
duplicates.
---
 client/player.c | 424 +++++++++++++++++++-----------------------------
 1 file changed, 169 insertions(+), 255 deletions(-)

diff --git a/client/player.c b/client/player.c
index ab8cb7434cdc..381c5d568103 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1232,20 +1232,10 @@ static const struct capabilities {
 				UTIL_IOV_INIT()),
 };
 
-struct codec_qos {
-	uint32_t interval;
-	uint8_t  framing;
-	uint8_t  phy;
-	uint16_t sdu;
-	uint8_t  rtn;
-	uint16_t latency;
-	uint32_t delay;
-};
-
 struct codec_preset {
 	char *name;
 	const struct iovec data;
-	const struct codec_qos qos;
+	struct bt_bap_qos qos;
 	uint8_t target_latency;
 };
 
@@ -1296,47 +1286,6 @@ static struct codec_preset sbc_presets[] = {
 	SBC_PRESET("UQ_STEREO_48", UTIL_IOV_INIT(0x11, 0x15, 2, 58)),
 };
 
-#define QOS_CONFIG(_interval, _framing, _phy, _sdu, _rtn, _latency, _delay) \
-	{ \
-		.interval = _interval, \
-		.framing = _framing, \
-		.phy = _phy, \
-		.sdu = _sdu, \
-		.rtn = _rtn, \
-		.latency = _latency, \
-		.delay = _delay, \
-	}
-
-#define QOS_UNFRAMED(_interval, _phy, _sdu, _rtn, _latency, _delay) \
-	QOS_CONFIG(_interval, 0x00, _phy, _sdu, _rtn, _latency, _delay)
-
-#define QOS_FRAMED(_interval, _phy, _sdu, _rtn, _latency, _delay) \
-	QOS_CONFIG(_interval, 0x01, _phy, _sdu, _rtn, _latency, _delay)
-
-#define QOS_UNFRAMED_1M(_interval, _sdu, _rtn, _latency, _delay) \
-	QOS_UNFRAMED(_interval, 0x01, _sdu, _rtn, _latency, _delay) \
-
-#define QOS_FRAMED_1M(_interval, _sdu, _rtn, _latency, _delay) \
-	QOS_FRAMED(_interval, 0x01, _sdu, _rtn, _latency, _delay) \
-
-#define QOS_UNFRAMED_2M(_interval, _sdu, _rtn, _latency, _delay) \
-	QOS_UNFRAMED(_interval, 0x02, _sdu, _rtn, _latency, _delay) \
-
-#define QOS_FRAMED_2M(_interval, _sdu, _rtn, _latency, _delay) \
-	QOS_FRAMED(_interval, 0x02, _sdu, _rtn, _latency, _delay) \
-
-#define LC3_7_5_UNFRAMED(_sdu, _rtn, _latency, _delay) \
-	QOS_UNFRAMED(7500u, 0x02, _sdu, _rtn, _latency, _delay)
-
-#define LC3_7_5_FRAMED(_sdu, _rtn, _latency, _delay) \
-	QOS_FRAMED(7500u, 0x02, _sdu, _rtn, _latency, _delay)
-
-#define LC3_10_UNFRAMED(_sdu, _rtn, _latency, _delay) \
-	QOS_UNFRAMED_2M(10000u, _sdu, _rtn, _latency, _delay)
-
-#define LC3_10_FRAMED(_sdu, _rtn, _latency, _delay) \
-	QOS_FRAMED_2M(10000u, _sdu, _rtn, _latency, _delay)
-
 #define LC3_PRESET_LL(_name, _data, _qos) \
 	{ \
 		.name = _name, \
@@ -1361,183 +1310,115 @@ static struct codec_preset sbc_presets[] = {
 		.target_latency = 0x03, \
 	}
 
+#define LC3_PRESET_B(_name, _data, _qos) \
+	{ \
+		.name = _name, \
+		.data = _data, \
+		.qos = _qos, \
+		.target_latency = 0x00, \
+	}
+
 static struct codec_preset lc3_ucast_presets[] = {
 	/* Table 4.43: QoS configuration support setting requirements */
-	LC3_PRESET("8_1_1", LC3_CONFIG_8_1,
-			LC3_7_5_UNFRAMED(26u, 2u, 8u, 40000u)),
-	LC3_PRESET("8_2_1", LC3_CONFIG_8_2,
-			LC3_10_UNFRAMED(30u, 2u, 10u, 40000u)),
-	LC3_PRESET("16_1_1", LC3_CONFIG_16_1,
-			LC3_7_5_UNFRAMED(30u, 2u, 8u, 40000u)),
-	LC3_PRESET("16_2_1", LC3_CONFIG_16_2,
-			LC3_10_UNFRAMED(40u, 2u, 10u, 40000u)),
-	LC3_PRESET("24_1_1", LC3_CONFIG_24_1,
-			LC3_7_5_UNFRAMED(45u, 2u, 8u, 40000u)),
-	LC3_PRESET("24_2_1", LC3_CONFIG_24_2,
-			LC3_10_UNFRAMED(60u, 2u, 10u, 40000u)),
-	LC3_PRESET("32_1_1", LC3_CONFIG_32_1,
-			LC3_7_5_UNFRAMED(60u, 2u, 8u, 40000u)),
-	LC3_PRESET("32_2_1", LC3_CONFIG_32_2,
-			LC3_10_UNFRAMED(80u, 2u, 10u, 40000u)),
-	LC3_PRESET("44_1_1", LC3_CONFIG_44_1,
-			QOS_FRAMED_2M(8163u, 98u, 5u, 24u, 40000u)),
-	LC3_PRESET("44_2_1", LC3_CONFIG_44_2,
-			QOS_FRAMED_2M(10884u, 130u, 5u, 31u, 40000u)),
-	LC3_PRESET("48_1_1", LC3_CONFIG_48_1,
-			LC3_7_5_UNFRAMED(75u, 5u, 15u, 40000u)),
-	LC3_PRESET("48_2_1", LC3_CONFIG_48_2,
-			LC3_10_UNFRAMED(100u, 5u, 20u, 40000u)),
-	LC3_PRESET("48_3_1", LC3_CONFIG_48_3,
-			LC3_7_5_UNFRAMED(90u, 5u, 15u, 40000u)),
-	LC3_PRESET("48_4_1", LC3_CONFIG_48_4,
-			LC3_10_UNFRAMED(120u, 5u, 20u, 40000u)),
-	LC3_PRESET("48_5_1", LC3_CONFIG_48_5,
-			LC3_7_5_UNFRAMED(117u, 5u, 15u, 40000u)),
-	LC3_PRESET("48_6_1", LC3_CONFIG_48_6,
-			LC3_10_UNFRAMED(155u, 5u, 20u, 40000u)),
+	LC3_PRESET("8_1_1", LC3_CONFIG_8_1, LC3_QOS_8_1_1),
+	LC3_PRESET("8_2_1", LC3_CONFIG_8_2, LC3_QOS_8_2_1),
+	LC3_PRESET("16_1_1", LC3_CONFIG_16_1, LC3_QOS_16_1_1),
+	LC3_PRESET("16_2_1", LC3_CONFIG_16_2, LC3_QOS_16_2_1),
+	LC3_PRESET("24_1_1", LC3_CONFIG_24_1, LC3_QOS_24_1_1),
+	LC3_PRESET("24_2_1", LC3_CONFIG_24_2, LC3_QOS_24_2_1),
+	LC3_PRESET("32_1_1", LC3_CONFIG_32_1, LC3_QOS_32_1_1),
+	LC3_PRESET("32_2_1", LC3_CONFIG_32_2, LC3_QOS_32_1_1),
+	LC3_PRESET("44_1_1", LC3_CONFIG_44_1, LC3_QOS_44_1_1),
+	LC3_PRESET("44_2_1", LC3_CONFIG_44_2, LC3_QOS_44_2_1),
+	LC3_PRESET("48_1_1", LC3_CONFIG_48_1, LC3_QOS_48_1_1),
+	LC3_PRESET("48_2_1", LC3_CONFIG_48_2, LC3_QOS_48_2_1),
+	LC3_PRESET("48_3_1", LC3_CONFIG_48_3, LC3_QOS_48_3_1),
+	LC3_PRESET("48_4_1", LC3_CONFIG_48_4, LC3_QOS_48_4_1),
+	LC3_PRESET("48_5_1", LC3_CONFIG_48_5, LC3_QOS_48_5_1),
+	LC3_PRESET("48_6_1", LC3_CONFIG_48_6, LC3_QOS_48_6_1),
 	/* QoS Configuration settings for high reliability audio data */
-	LC3_PRESET_HR("8_1_2", LC3_CONFIG_8_1,
-			LC3_7_5_UNFRAMED(26u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("8_2_2", LC3_CONFIG_8_2,
-			LC3_10_UNFRAMED(30u, 13u, 95u, 40000u)),
-	LC3_PRESET_HR("16_1_2", LC3_CONFIG_16_1,
-			LC3_7_5_UNFRAMED(30u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("16_2_2", LC3_CONFIG_16_2,
-			LC3_10_UNFRAMED(40u, 13u, 95u, 40000u)),
-	LC3_PRESET_HR("24_1_2", LC3_CONFIG_24_1,
-			LC3_7_5_UNFRAMED(45u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("24_2_2", LC3_CONFIG_24_2,
-			LC3_10_UNFRAMED(60u, 13u, 95u, 40000u)),
-	LC3_PRESET_HR("32_1_2", LC3_CONFIG_32_1,
-			LC3_7_5_UNFRAMED(60u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("32_2_2", LC3_CONFIG_32_2,
-			LC3_10_UNFRAMED(80u, 13u, 95u, 40000u)),
-	LC3_PRESET_HR("44_1_2", LC3_CONFIG_44_1,
-			QOS_FRAMED_2M(8163u, 98u, 13u, 80u, 40000u)),
-	LC3_PRESET_HR("44_2_2", LC3_CONFIG_44_2,
-			QOS_FRAMED_2M(10884u, 130u, 13u, 85u, 40000u)),
-	LC3_PRESET_HR("48_1_2", LC3_CONFIG_48_1,
-			LC3_7_5_UNFRAMED(75u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("48_2_2", LC3_CONFIG_48_2,
-			LC3_10_UNFRAMED(100u, 13u, 95u, 40000u)),
-	LC3_PRESET_HR("48_3_2", LC3_CONFIG_48_3,
-			LC3_7_5_UNFRAMED(90u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("48_4_2", LC3_CONFIG_48_4,
-			LC3_10_UNFRAMED(120u, 13u, 100u, 40000u)),
-	LC3_PRESET_HR("48_5_2", LC3_CONFIG_48_5,
-			LC3_7_5_UNFRAMED(117u, 13u, 75u, 40000u)),
-	LC3_PRESET_HR("48_6_2", LC3_CONFIG_48_6,
-			LC3_10_UNFRAMED(155u, 13u, 100u, 40000u)),
+	LC3_PRESET_HR("8_1_2", LC3_CONFIG_8_1, LC3_QOS_8_1_2),
+	LC3_PRESET_HR("8_2_2", LC3_CONFIG_8_2, LC3_QOS_8_2_2),
+	LC3_PRESET_HR("16_1_2", LC3_CONFIG_16_1, LC3_QOS_16_1_2),
+	LC3_PRESET_HR("16_2_2", LC3_CONFIG_16_2, LC3_QOS_16_2_2),
+	LC3_PRESET_HR("24_1_2", LC3_CONFIG_24_1, LC3_QOS_24_1_2),
+	LC3_PRESET_HR("24_2_2", LC3_CONFIG_24_2, LC3_QOS_24_2_2),
+	LC3_PRESET_HR("32_1_2", LC3_CONFIG_32_1, LC3_QOS_32_1_2),
+	LC3_PRESET_HR("32_2_2", LC3_CONFIG_32_2, LC3_QOS_32_2_2),
+	LC3_PRESET_HR("44_1_2", LC3_CONFIG_44_1, LC3_QOS_44_1_2),
+	LC3_PRESET_HR("44_2_2", LC3_CONFIG_44_2, LC3_QOS_44_2_2),
+	LC3_PRESET_HR("48_1_2", LC3_CONFIG_48_1, LC3_QOS_48_1_2),
+	LC3_PRESET_HR("48_2_2", LC3_CONFIG_48_2, LC3_QOS_48_2_2),
+	LC3_PRESET_HR("48_3_2", LC3_CONFIG_48_3, LC3_QOS_48_3_2),
+	LC3_PRESET_HR("48_4_2", LC3_CONFIG_48_4, LC3_QOS_48_4_2),
+	LC3_PRESET_HR("48_5_2", LC3_CONFIG_48_5, LC3_QOS_48_5_2),
+	LC3_PRESET_HR("48_6_2", LC3_CONFIG_48_6, LC3_QOS_48_6_2),
 	/* QoS configuration support setting requirements for the UGG and UGT */
-	LC3_PRESET_LL("16_1_gs", LC3_CONFIG_16_1,
-			LC3_7_5_UNFRAMED(30u, 1u, 15u, 60000u)),
-	LC3_PRESET_LL("16_2_gs", LC3_CONFIG_16_2,
-			LC3_10_UNFRAMED(40u, 1u, 20u, 60000u)),
-	LC3_PRESET_LL("32_1_gs", LC3_CONFIG_32_1,
-			LC3_7_5_UNFRAMED(60u, 1u, 15u, 60000u)),
-	LC3_PRESET_LL("32_2_gs", LC3_CONFIG_32_2,
-			LC3_10_UNFRAMED(80u, 1u, 20u, 60000u)),
-	LC3_PRESET_LL("48_1_gs", LC3_CONFIG_48_1,
-			LC3_7_5_UNFRAMED(75u, 1u, 15u, 60000u)),
-	LC3_PRESET_LL("48_2_gs", LC3_CONFIG_48_2,
-			LC3_10_UNFRAMED(100u, 1u, 20u, 60000u)),
-	LC3_PRESET_LL("32_1_gr", LC3_CONFIG_32_1,
-			LC3_7_5_UNFRAMED(60u, 1u, 15u, 10000u)),
-	LC3_PRESET_LL("32_2_gr", LC3_CONFIG_32_2,
-			LC3_10_UNFRAMED(80u, 1u, 20u, 10000u)),
-	LC3_PRESET_LL("48_1_gr", LC3_CONFIG_48_1,
-			LC3_7_5_UNFRAMED(75u, 1u, 15u, 10000u)),
-	LC3_PRESET_LL("48_2_gr", LC3_CONFIG_48_2,
-			LC3_10_UNFRAMED(100u, 1u, 20u, 10000u)),
-	LC3_PRESET_LL("48_3_gr", LC3_CONFIG_48_3,
-			LC3_7_5_UNFRAMED(90u, 1u, 15u, 10000u)),
-	LC3_PRESET_LL("48_4_gr", LC3_CONFIG_48_4,
-			LC3_10_UNFRAMED(120u, 1u, 20u, 10000u)),
+	LC3_PRESET_LL("16_1_gs", LC3_CONFIG_16_1, LC3_QOS_16_1_GS),
+	LC3_PRESET_LL("16_2_gs", LC3_CONFIG_16_2, LC3_QOS_16_2_GS),
+	LC3_PRESET_LL("32_1_gs", LC3_CONFIG_32_1, LC3_QOS_32_1_GS),
+	LC3_PRESET_LL("32_2_gs", LC3_CONFIG_32_2, LC3_QOS_32_2_GS),
+	LC3_PRESET_LL("48_1_gs", LC3_CONFIG_48_1, LC3_QOS_48_1_GS),
+	LC3_PRESET_LL("48_2_gs", LC3_CONFIG_48_2, LC3_QOS_48_2_GS),
+	LC3_PRESET_LL("32_1_gr", LC3_CONFIG_32_1, LC3_QOS_32_1_GR),
+	LC3_PRESET_LL("32_2_gr", LC3_CONFIG_32_2, LC3_QOS_32_2_GR),
+	LC3_PRESET_LL("48_1_gr", LC3_CONFIG_48_1, LC3_QOS_48_1_GR),
+	LC3_PRESET_LL("48_2_gr", LC3_CONFIG_48_2, LC3_QOS_48_2_GR),
+	LC3_PRESET_LL("48_3_gr", LC3_CONFIG_48_3, LC3_QOS_48_3_GR),
+	LC3_PRESET_LL("48_4_gr", LC3_CONFIG_48_4, LC3_QOS_48_4_GR),
 	LC3_PRESET_LL("32_1_gr_l+r", LC3_CONFIG_32_1_AC(2),
-			LC3_7_5_UNFRAMED(2 * 60u, 1u, 15u, 10000u)),
+				LC3_QOS_32_1_GR_AC(2)),
 	LC3_PRESET_LL("32_2_gr_l+r", LC3_CONFIG_32_2_AC(2),
-			LC3_10_UNFRAMED(2 * 80u, 1u, 20u, 10000u)),
+				LC3_QOS_32_2_GR_AC(2)),
 	LC3_PRESET_LL("48_1_gr_l+r", LC3_CONFIG_48_1_AC(2),
-			LC3_7_5_UNFRAMED(2 * 75u, 1u, 15u, 10000u)),
+				LC3_QOS_48_1_GR_AC(2)),
 	LC3_PRESET_LL("48_2_gr_l+r", LC3_CONFIG_48_2_AC(2),
-			LC3_10_UNFRAMED(2 * 100u, 1u, 20u, 10000u)),
+				LC3_QOS_48_2_GR_AC(2)),
 	LC3_PRESET_LL("48_3_gr_l+r", LC3_CONFIG_48_3_AC(2),
-			LC3_7_5_UNFRAMED(2 * 90u, 1u, 15u, 10000u)),
+				LC3_QOS_48_3_GR_AC(2)),
 	LC3_PRESET_LL("48_4_gr_l+r", LC3_CONFIG_48_4_AC(2),
-			LC3_10_UNFRAMED(2 * 120u, 1u, 20u, 10000u)),
+				LC3_QOS_48_4_GR_AC(2)),
 };
 
 static struct codec_preset lc3_bcast_presets[] = {
 	/* Table 6.4: Broadcast Audio Stream configuration support requirements
 	 * for the Broadcast Source and Broadcast Sink
 	 */
-	LC3_PRESET("8_1_1", LC3_CONFIG_8_1,
-			LC3_7_5_UNFRAMED(26u, 2u, 8u, 40000u)),
-	LC3_PRESET("8_2_1", LC3_CONFIG_8_2,
-			LC3_10_UNFRAMED(30u, 2u, 10u, 40000u)),
-	LC3_PRESET("16_1_1", LC3_CONFIG_16_1,
-			LC3_7_5_UNFRAMED(30u, 2u, 8u, 40000u)),
-	LC3_PRESET("16_2_1", LC3_CONFIG_16_2,
-			LC3_10_UNFRAMED(40u, 2u, 10u, 40000u)),
-	LC3_PRESET("24_1_1", LC3_CONFIG_24_1,
-			LC3_7_5_UNFRAMED(45u, 2u, 8u, 40000u)),
-	LC3_PRESET("24_2_1", LC3_CONFIG_24_2,
-			LC3_10_UNFRAMED(60u, 2u, 10u, 40000u)),
-	LC3_PRESET("32_1_1", LC3_CONFIG_32_1,
-			LC3_7_5_UNFRAMED(60u, 2u, 8u, 40000u)),
-	LC3_PRESET("32_2_1", LC3_CONFIG_32_2,
-			LC3_10_UNFRAMED(80u, 2u, 10u, 40000u)),
-	LC3_PRESET("44_1_1", LC3_CONFIG_44_1,
-			QOS_FRAMED_2M(8163u, 98u, 4u, 24u, 40000u)),
-	LC3_PRESET("44_2_1", LC3_CONFIG_44_2,
-			QOS_FRAMED_2M(10884u, 130u, 4u, 31u, 40000u)),
-	LC3_PRESET("48_1_1", LC3_CONFIG_48_1,
-			LC3_7_5_UNFRAMED(75u, 4u, 15u, 40000u)),
-	LC3_PRESET("48_2_1", LC3_CONFIG_48_2,
-			LC3_10_UNFRAMED(100u, 4u, 20u, 40000u)),
-	LC3_PRESET("48_3_1", LC3_CONFIG_48_3,
-			LC3_7_5_UNFRAMED(90u, 4u, 15u, 40000u)),
-	LC3_PRESET("48_4_1", LC3_CONFIG_48_4,
-			LC3_10_UNFRAMED(120u, 4u, 20u, 40000u)),
-	LC3_PRESET("48_5_1", LC3_CONFIG_48_5,
-			LC3_7_5_UNFRAMED(117u, 4u, 15u, 40000u)),
-	LC3_PRESET("48_6_1", LC3_CONFIG_48_6,
-			LC3_10_UNFRAMED(155u, 4u, 20u, 40000u)),
+	LC3_PRESET_B("8_1_1", LC3_CONFIG_8_1, LC3_QOS_8_1_1_B),
+	LC3_PRESET_B("8_2_1", LC3_CONFIG_8_2, LC3_QOS_8_2_1_B),
+	LC3_PRESET_B("16_1_1", LC3_CONFIG_16_1, LC3_QOS_16_1_1_B),
+	LC3_PRESET_B("16_2_1", LC3_CONFIG_16_2, LC3_QOS_16_2_1_B),
+	LC3_PRESET_B("24_1_1", LC3_CONFIG_24_1, LC3_QOS_24_1_1_B),
+	LC3_PRESET_B("24_2_1", LC3_CONFIG_24_2, LC3_QOS_24_2_1_B),
+	LC3_PRESET_B("32_1_1", LC3_CONFIG_32_1, LC3_QOS_32_1_1_B),
+	LC3_PRESET_B("32_2_1", LC3_CONFIG_32_2, LC3_QOS_32_2_1_B),
+	LC3_PRESET_B("44_1_1", LC3_CONFIG_44_1, LC3_QOS_44_1_1_B),
+	LC3_PRESET_B("44_2_1", LC3_CONFIG_44_2, LC3_QOS_44_2_1_B),
+	LC3_PRESET_B("48_1_1", LC3_CONFIG_48_1, LC3_QOS_48_1_1_B),
+	LC3_PRESET_B("48_2_1", LC3_CONFIG_48_2, LC3_QOS_48_2_1_B),
+	LC3_PRESET_B("48_3_1", LC3_CONFIG_48_3, LC3_QOS_48_3_1_B),
+	LC3_PRESET_B("48_4_1", LC3_CONFIG_48_4, LC3_QOS_48_4_1_B),
+	LC3_PRESET_B("48_5_1", LC3_CONFIG_48_5, LC3_QOS_48_5_1_B),
+	LC3_PRESET_B("48_6_1", LC3_CONFIG_48_6, LC3_QOS_48_6_1_B),
 	/* Broadcast Audio Stream configuration settings for high-reliability
 	 * audio data.
 	 */
-	LC3_PRESET_HR("8_1_2", LC3_CONFIG_8_1,
-			LC3_7_5_UNFRAMED(26u, 4u, 45u, 40000u)),
-	LC3_PRESET_HR("8_2_2", LC3_CONFIG_8_2,
-			LC3_10_UNFRAMED(30u, 4u, 60u, 40000u)),
-	LC3_PRESET_HR("16_1_2", LC3_CONFIG_16_1,
-			LC3_7_5_UNFRAMED(30u, 4u, 45u, 40000u)),
-	LC3_PRESET_HR("16_2_2", LC3_CONFIG_16_2,
-			LC3_10_UNFRAMED(40u, 4u, 60u, 40000u)),
-	LC3_PRESET_HR("24_1_2", LC3_CONFIG_24_1,
-			LC3_7_5_UNFRAMED(45u, 4u, 45u, 40000u)),
-	LC3_PRESET_HR("24_2_2", LC3_CONFIG_24_2,
-			LC3_10_UNFRAMED(60u, 4u, 60u, 40000u)),
-	LC3_PRESET_HR("32_1_2", LC3_CONFIG_32_1,
-			LC3_7_5_UNFRAMED(60u, 4u, 45u, 40000u)),
-	LC3_PRESET_HR("32_2_2", LC3_CONFIG_32_2,
-			LC3_10_UNFRAMED(80u, 4u, 60u, 40000u)),
-	LC3_PRESET_HR("44_1_2", LC3_CONFIG_44_1,
-			QOS_FRAMED_2M(8163u, 4u, 13u, 54u, 40000u)),
-	LC3_PRESET_HR("44_2_2", LC3_CONFIG_44_2,
-			QOS_FRAMED_2M(10884u, 130u, 4u, 60u, 40000u)),
-	LC3_PRESET_HR("48_1_2", LC3_CONFIG_48_1,
-			LC3_7_5_UNFRAMED(75u, 4u, 50u, 40000u)),
-	LC3_PRESET_HR("48_2_2", LC3_CONFIG_48_2,
-			LC3_10_UNFRAMED(100u, 4u, 65u, 40000u)),
-	LC3_PRESET_HR("48_3_2", LC3_CONFIG_48_3,
-			LC3_7_5_UNFRAMED(90u, 4u, 50u, 40000u)),
-	LC3_PRESET_HR("48_4_2", LC3_CONFIG_48_4,
-			LC3_10_UNFRAMED(120u, 4u, 65u, 40000u)),
-	LC3_PRESET_HR("48_5_2", LC3_CONFIG_48_5,
-			LC3_7_5_UNFRAMED(117u, 4u, 50u, 40000u)),
-	LC3_PRESET_HR("48_6_2", LC3_CONFIG_48_6,
-			LC3_10_UNFRAMED(155u, 4u, 65u, 40000u)),
+	LC3_PRESET_B("8_1_2", LC3_CONFIG_8_1, LC3_QOS_8_1_1_B),
+	LC3_PRESET_B("8_2_2", LC3_CONFIG_8_2, LC3_QOS_8_2_2_B),
+	LC3_PRESET_B("16_1_2", LC3_CONFIG_16_1, LC3_QOS_16_1_2_B),
+	LC3_PRESET_B("16_2_2", LC3_CONFIG_16_2, LC3_QOS_16_2_2_B),
+	LC3_PRESET_B("24_1_2", LC3_CONFIG_24_1, LC3_QOS_24_1_2_B),
+	LC3_PRESET_B("24_2_2", LC3_CONFIG_24_2, LC3_QOS_24_2_2_B),
+	LC3_PRESET_B("32_1_2", LC3_CONFIG_32_1, LC3_QOS_32_1_2_B),
+	LC3_PRESET_B("32_2_2", LC3_CONFIG_32_2, LC3_QOS_32_2_2_B),
+	LC3_PRESET_B("44_1_2", LC3_CONFIG_44_1, LC3_QOS_44_1_2_B),
+	LC3_PRESET_B("44_2_2", LC3_CONFIG_44_2, LC3_QOS_44_2_2_B),
+	LC3_PRESET_B("48_1_2", LC3_CONFIG_48_1, LC3_QOS_48_1_2_B),
+	LC3_PRESET_B("48_2_2", LC3_CONFIG_48_2, LC3_QOS_48_2_2_B),
+	LC3_PRESET_B("48_3_2", LC3_CONFIG_48_3, LC3_QOS_48_3_2_B),
+	LC3_PRESET_B("48_4_2", LC3_CONFIG_48_4, LC3_QOS_48_4_2_B),
+	LC3_PRESET_B("48_5_2", LC3_CONFIG_48_5, LC3_QOS_48_5_2_B),
+	LC3_PRESET_B("48_6_2", LC3_CONFIG_48_6, LC3_QOS_48_6_2_B),
 };
 
 static void print_ltv(const char *str, void *user_data)
@@ -1863,7 +1744,7 @@ struct endpoint_config {
 	struct iovec *caps;		/* Codec Specific Configuration LTVs */
 	struct iovec *meta;		/* Metadata LTVs*/
 	uint8_t target_latency;
-	struct codec_qos qos;	/* BAP QOS configuration parameters */
+	struct bt_bap_qos qos;		/* BAP QOS configuration parameters */
 	uint8_t  sync_factor;		/* PA parameter */
 	uint8_t  options;		/* PA create sync parameter */
 	uint16_t skip;			/* PA create sync parameter */
@@ -1873,20 +1754,8 @@ struct endpoint_config {
 	uint16_t timeout;		/* BIG create sync parameter */
 };
 
-static void append_io_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
+static void append_io_qos(DBusMessageIter *iter, struct bt_bap_io_qos *qos)
 {
-	struct codec_qos *qos = &cfg->qos;
-
-	bt_shell_printf("Framing 0x%02x\n", qos->framing);
-
-	g_dbus_dict_append_entry(iter, "Framing", DBUS_TYPE_BYTE,
-							&qos->framing);
-
-	bt_shell_printf("PresentationDelay %u\n", qos->delay);
-
-	g_dbus_dict_append_entry(iter, "PresentationDelay",
-			DBUS_TYPE_UINT32, &qos->delay);
-
 	bt_shell_printf("Interval %u\n", qos->interval);
 
 	g_dbus_dict_append_entry(iter, "Interval", DBUS_TYPE_UINT32,
@@ -1902,18 +1771,18 @@ static void append_io_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 
 	bt_shell_printf("Retransmissions %u\n", qos->rtn);
 
-	g_dbus_dict_append_entry(iter, "Retransmissions",
-					DBUS_TYPE_BYTE, &qos->rtn);
+	g_dbus_dict_append_entry(iter, "Retransmissions", DBUS_TYPE_BYTE,
+						&qos->rtn);
 
 	bt_shell_printf("Latency %u\n", qos->latency);
 
-	g_dbus_dict_append_entry(iter, "Latency",
-					DBUS_TYPE_UINT16, &qos->latency);
+	g_dbus_dict_append_entry(iter, "Latency", DBUS_TYPE_UINT16,
+						&qos->latency);
 }
 
 static void append_ucast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 {
-	struct codec_qos *qos = &cfg->qos;
+	struct bt_bap_ucast_qos *qos = &cfg->qos.ucast;
 
 	if (cfg->ep->iso_group != BT_ISO_QOS_GROUP_UNSET) {
 		bt_shell_printf("CIG 0x%2.2x\n", cfg->ep->iso_group);
@@ -1930,7 +1799,7 @@ static void append_ucast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 	bt_shell_printf("Framing 0x%02x\n", qos->framing);
 
 	g_dbus_dict_append_entry(iter, "Framing", DBUS_TYPE_BYTE,
-							&qos->framing);
+					&qos->framing);
 
 	bt_shell_printf("PresentationDelay %u\n", qos->delay);
 
@@ -1938,16 +1807,18 @@ static void append_ucast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 					DBUS_TYPE_UINT32, &qos->delay);
 
 	if (cfg->target_latency) {
-		bt_shell_printf("TargetLatency 0x%02x\n", cfg->target_latency);
-		g_dbus_dict_append_entry(iter, "TargetLatency",
-					DBUS_TYPE_BYTE, &cfg->target_latency);
+		bt_shell_printf("TargetLatency 0x%02x\n", qos->target_latency);
+		g_dbus_dict_append_entry(iter, "TargetLatency", DBUS_TYPE_BYTE,
+					&qos->target_latency);
 	}
 
-	append_io_qos(iter, cfg);
+	append_io_qos(iter, &qos->io_qos);
 }
 
 static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 {
+	struct bt_bap_bcast_qos *qos = &cfg->qos.bcast;
+
 	if (cfg->ep->iso_group != BT_ISO_QOS_BIG_UNSET) {
 		bt_shell_printf("BIG 0x%2.2x\n", cfg->ep->iso_group);
 		g_dbus_dict_append_entry(iter, "BIG", DBUS_TYPE_BYTE,
@@ -2008,19 +1879,25 @@ static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 						cfg->ep->bcode->iov_len);
 	}
 
+	bt_shell_printf("Framing 0x%02x\n", qos->framing);
+
+	g_dbus_dict_append_entry(iter, "Framing", DBUS_TYPE_BYTE,
+					&qos->framing);
+
+	bt_shell_printf("PresentationDelay %u\n", qos->delay);
+
+	g_dbus_dict_append_entry(iter, "PresentationDelay",
+					DBUS_TYPE_UINT32, &qos->delay);
+
 	/* Add BAP codec QOS configuration */
-	append_io_qos(iter, cfg);
+	append_io_qos(iter, &qos->io_qos);
 }
 
 static void append_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 {
 	DBusMessageIter entry, var, dict;
-	struct codec_qos *qos = &cfg->qos;
 	const char *key = "QoS";
 
-	if (!qos)
-		return;
-
 	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY,
 						NULL, &entry);
 
@@ -2137,6 +2014,7 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	DBusMessage *reply;
 	DBusMessageIter iter, props;
 	struct endpoint_config *cfg;
+	struct bt_bap_io_qos *qos;
 	uint32_t location = 0;
 	uint8_t channels = 1;
 
@@ -2169,14 +2047,19 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	/* Copy metadata */
 	cfg->meta = util_iov_dup(ep->meta, 1);
 
-	if (preset->qos.phy) {
+	if (ep->broadcast)
+		qos = &preset->qos.bcast.io_qos;
+	else
+		qos = &preset->qos.ucast.io_qos;
+
+	if (qos->phy) {
 		/* Set QoS parameters */
 		cfg->qos = preset->qos;
 		/* Adjust the SDU size based on the number of
 		 * locations/channels that is being requested.
 		 */
 		if (channels > 1)
-			cfg->qos.sdu *= channels;
+			qos->sdu *= channels;
 	}
 
 	dbus_message_iter_init_append(reply, &iter);
@@ -3871,10 +3754,14 @@ fail:
 static void custom_delay(const char *input, void *user_data)
 {
 	struct codec_preset *p = user_data;
-	struct codec_qos *qos = (void *)&p->qos;
+	struct bt_bap_qos *qos = (void *)&p->qos;
 	char *endptr = NULL;
 
-	qos->delay = strtol(input, &endptr, 0);
+	if (!p->target_latency)
+		qos->bcast.delay = strtol(input, &endptr, 0);
+	else
+		qos->ucast.delay = strtol(input, &endptr, 0);
+
 	if (!endptr || *endptr != '\0') {
 		bt_shell_printf("Invalid argument: %s\n", input);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -3886,10 +3773,14 @@ static void custom_delay(const char *input, void *user_data)
 static void custom_latency(const char *input, void *user_data)
 {
 	struct codec_preset *p = user_data;
-	struct codec_qos *qos = (void *)&p->qos;
+	struct bt_bap_qos *qos = (void *)&p->qos;
 	char *endptr = NULL;
 
-	qos->latency = strtol(input, &endptr, 0);
+	if (!p->target_latency)
+		qos->bcast.io_qos.latency = strtol(input, &endptr, 0);
+	else
+		qos->ucast.io_qos.latency = strtol(input, &endptr, 0);
+
 	if (!endptr || *endptr != '\0') {
 		bt_shell_printf("Invalid argument: %s\n", input);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -3902,10 +3793,14 @@ static void custom_latency(const char *input, void *user_data)
 static void custom_rtn(const char *input, void *user_data)
 {
 	struct codec_preset *p = user_data;
-	struct codec_qos *qos = (void *)&p->qos;
+	struct bt_bap_qos *qos = (void *)&p->qos;
 	char *endptr = NULL;
 
-	qos->rtn = strtol(input, &endptr, 0);
+	if (!p->target_latency)
+		qos->bcast.io_qos.rtn = strtol(input, &endptr, 0);
+	else
+		qos->ucast.io_qos.rtn = strtol(input, &endptr, 0);
+
 	if (!endptr || *endptr != '\0') {
 		bt_shell_printf("Invalid argument: %s\n", input);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -3918,10 +3813,14 @@ static void custom_rtn(const char *input, void *user_data)
 static void custom_sdu(const char *input, void *user_data)
 {
 	struct codec_preset *p = user_data;
-	struct codec_qos *qos = (void *)&p->qos;
+	struct bt_bap_qos *qos = (void *)&p->qos;
 	char *endptr = NULL;
 
-	qos->sdu = strtol(input, &endptr, 0);
+	if (!p->target_latency)
+		qos->bcast.io_qos.sdu = strtol(input, &endptr, 0);
+	else
+		qos->ucast.io_qos.sdu = strtol(input, &endptr, 0);
+
 	if (!endptr || *endptr != '\0') {
 		bt_shell_printf("Invalid argument: %s\n", input);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -3933,7 +3832,12 @@ static void custom_sdu(const char *input, void *user_data)
 static void custom_phy(const char *input, void *user_data)
 {
 	struct codec_preset *p = user_data;
-	struct codec_qos *qos = (void *)&p->qos;
+	struct bt_bap_io_qos *qos;
+
+	if (!p->target_latency)
+		qos = &p->qos.bcast.io_qos;
+	else
+		qos = &p->qos.ucast.io_qos;
 
 	if (!strcmp(input, "1M"))
 		qos->phy = 0x01;
@@ -3965,16 +3869,21 @@ static void custom_phy(const char *input, void *user_data)
 static void custom_framing(const char *input, void *user_data)
 {
 	struct codec_preset *p = user_data;
-	struct codec_qos *qos = (void *)&p->qos;
+	uint8_t *framing;
+
+	if (!p->target_latency)
+		framing = &p->qos.bcast.framing;
+	else
+		framing = &p->qos.ucast.framing;
 
 	if (!strcasecmp(input, "Unframed"))
-		qos->framing = 0x00;
+		*framing = 0x00;
 	else if (!strcasecmp(input, "Framed"))
-		qos->framing = 0x01;
+		*framing = 0x01;
 	else {
 		char *endptr = NULL;
 
-		qos->framing = strtol(input, &endptr, 0);
+		*framing = strtol(input, &endptr, 0);
 		if (!endptr || *endptr != '\0') {
 			bt_shell_printf("Invalid argument: %s\n", input);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -3988,8 +3897,13 @@ static void custom_framing(const char *input, void *user_data)
 static void custom_interval(const char *input, void *user_data)
 {
 	struct codec_preset *p = user_data;
-	struct codec_qos *qos = (void *)&p->qos;
 	char *endptr = NULL;
+	struct bt_bap_io_qos *qos;
+
+	if (!p->target_latency)
+		qos = &p->qos.bcast.io_qos;
+	else
+		qos = &p->qos.ucast.io_qos;
 
 	qos->interval = strtol(input, &endptr, 0);
 	if (!endptr || *endptr != '\0') {
-- 
2.43.0

