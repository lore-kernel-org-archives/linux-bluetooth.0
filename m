Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPyCoU59"
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C1A11F
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 14:15:31 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-4649299d0a0so452118137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 14:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701728130; x=1702332930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4h6ikY50jNdfv+t4SGoqzVG8MtRln2TReTJFy2w9zG8=;
        b=ZPyCoU59VEW5jOte+AxyorIl9PMtBjZZfKd5Bh+epsWsKJ39/u4j7EHF4EEZEZ3J4J
         XUElAtJVJ7PvHtIkqxLHzU9tsVBJMf+A/HE7TzJ51+OiXxHf0kTsr95zV078z1oecPu8
         fnhDv1NhEZvVcrfpiTu8BtH5UxJMD5oUAoh/skMMQDSVs5eg0o3n3YNn4wwEOFlp3Blj
         3QvzzjIipYw5/fb+O5jI4kI4mTaYoxCcRFfDihXpyFvYAQL2nOpvw09X60b7TAo/NDIo
         Pr7ItjrzUGrcliATAfkR8hJ8TQxrC+kMKs23bfo928ckcmxJkIGUGy/i2hZkS+tnXlxR
         uGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728130; x=1702332930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4h6ikY50jNdfv+t4SGoqzVG8MtRln2TReTJFy2w9zG8=;
        b=EU15Y2G29hOPdZflAxziNl43FTumlOUWCe/HqB6pP4591nIyC088Pg6met2jGRXmwZ
         u7CLfzVzCqPQCUQxOueCrA6xKApoY5I/TsehfrVMaV5g4QT12WKCBbgTYzhQ8muO3gCi
         GHu3AKNXIH5DrLUiDYQniw8PI2Dk6r9jjYpe9xvcS4c+hVL0bjjnqUtSw6UNNF4sFRFF
         w4tUZHJhOdB4T9JfoA18e3kokru1JrrRvFgcRF31pPaEcJW+GDQWisCCGvc7wAq26SVi
         qnFHG5fuPAhZQkQnoz6f9IknucCgTWepax4vg8SwA1kYVse+zZTGeR9VgT0HOVuXpNNa
         g0PQ==
X-Gm-Message-State: AOJu0YxUwiG0z66ALsYlT68H7LRZGoRNRi4+q1BMb1Bsrpx8Wyckv/GK
	Zd+zbBhn+oGLgJIVi/SKvNY+JoBL8W4=
X-Google-Smtp-Source: AGHT+IGG8FrrOFXGqqTrEIp1WDdxwIEtN+fcfde3uBta4J+eLnUOv9FM3olngFtdVO0LkRJPHzX3Bg==
X-Received: by 2002:a05:6102:302e:b0:464:6793:7fd1 with SMTP id v14-20020a056102302e00b0046467937fd1mr2476464vsa.33.1701728129929;
        Mon, 04 Dec 2023 14:15:29 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bl13-20020a056102508d00b0044d4e63aa03sm1136612vsb.25.2023.12.04.14.15.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:15:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/8] shared/lc3: Add QoS definitions
Date: Mon,  4 Dec 2023 17:15:20 -0500
Message-ID: <20231204221527.2990674-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the QoS preset definitions as per BAP specification.
---
 src/shared/lc3.h | 153 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index ae193f9e2fa7..e6b043699bc1 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -155,3 +155,156 @@
 
 #define LC3_CONFIG_48_6 \
 	LC3_CONFIG_48(LC3_CONFIG_DURATION_10, 155u)
+
+#define LC3_QOS_UNFRAMED	0x00
+#define LC3_QOS_FRAMED		0x01
+
+#define LC3_QOS_UCAST(_frame, _pd, _t_lat, _interval, _lat, _sdu, _rtn) \
+{ \
+	.ucast.cig_id = 0x00, \
+	.ucast.cis_id = 0x00, \
+	.ucast.delay = _pd, \
+	.ucast.target_latency = _t_lat, \
+	.ucast.io_qos.interval = _interval, \
+	.ucast.io_qos.latency = _lat, \
+	.ucast.io_qos.sdu = _sdu, \
+	.ucast.io_qos.phy = BT_BAP_CONFIG_PHY_2M, \
+	.ucast.io_qos.rtn = _rtn, \
+}
+
+#define LC3_QOS_UCAST_7_5_UNFRAMED(_pd, _t_lat, _lat, _sdu, _rtn) \
+	LC3_QOS_UCAST(LC3_QOS_UNFRAMED, _pd, _t_lat, 7500u, _lat, _sdu, _rtn)
+
+#define LC3_QOS_UCAST_10_UNFRAMED(_pd, _t_lat, _lat, _sdu, _rtn) \
+	LC3_QOS_UCAST(LC3_QOS_UNFRAMED, _pd, _t_lat, 10000u, _lat, _sdu, _rtn)
+
+#define LC3_QOS_UCAST_FRAMED(_pd, _t_lat, _interval, _lat, _sdu, _rtn) \
+	LC3_QOS_UCAST(LC3_QOS_FRAMED, _pd, _t_lat, _interval, _lat, _sdu, _rtn)
+
+#define LC3_QOS_8_1_1 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					8u, 26u, 2u)
+
+#define LC3_QOS_8_1_2 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					75u, 26u, 13u)
+
+#define LC3_QOS_8_2_1 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					10u, 30u, 2u)
+
+#define LC3_QOS_8_2_2 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					95u, 30u, 13u)
+
+#define LC3_QOS_16_1_1 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					8u, 30u, 2u)
+
+#define LC3_QOS_16_1_2 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					75u, 30u, 13u)
+
+#define LC3_QOS_16_2_1 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					10u, 40u, 2u)
+
+#define LC3_QOS_16_2_2 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					95u, 40u, 13u)
+
+#define LC3_QOS_24_1_1 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					8u, 45u, 2u)
+
+#define LC3_QOS_24_1_2 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					75u, 45u, 13u)
+
+#define LC3_QOS_24_2_1 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					10u, 60u, 2u)
+
+#define LC3_QOS_24_2_2 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					95u, 60u, 13u)
+
+#define LC3_QOS_32_1_1 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					8u, 60u, 2u)
+
+#define LC3_QOS_32_1_2 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					75u, 60u, 13u)
+
+#define LC3_QOS_32_2_1 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					10u, 80u, 2u)
+
+#define LC3_QOS_32_2_2 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					95u, 80u, 13u)
+
+#define LC3_QOS_44_1_1 \
+	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					8163u, 24u, 98u, 5u)
+
+#define LC3_QOS_44_1_2 \
+	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					8163u, 80u, 98u, 13u)
+
+#define LC3_QOS_44_2_1 \
+	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					10884u, 31u, 130u, 5u)
+
+#define LC3_QOS_44_2_2 \
+	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					10884u, 85u, 130u, 13u)
+
+#define LC3_QOS_48_1_1 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					15u, 75u, 5u)
+
+#define LC3_QOS_48_1_2 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					75u, 75u, 13u)
+
+#define LC3_QOS_48_2_1 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					20u, 100u, 5u)
+
+#define LC3_QOS_48_2_2 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					95u, 100u, 13u)
+
+#define LC3_QOS_48_3_1 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					15u, 90u, 5u)
+
+#define LC3_QOS_48_3_2 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					75u, 90u, 13u)
+
+#define LC3_QOS_48_4_1 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					20u, 120u, 5u)
+
+#define LC3_QOS_48_4_2 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					100u, 120u, 13u)
+
+#define LC3_QOS_48_5_1 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					15u, 117u, 5u)
+
+#define LC3_QOS_48_5_2 \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					75u, 117u, 13u)
+
+#define LC3_QOS_48_6_1 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					20u, 155u, 5u)
+
+#define LC3_QOS_48_6_2 \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					100u, 155u, 13u)
-- 
2.43.0

