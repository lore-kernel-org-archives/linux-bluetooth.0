Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg6TZbGA"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE610E2
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 11:16:16 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77d708e4916so62269785a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701371775; x=1701976575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4h6ikY50jNdfv+t4SGoqzVG8MtRln2TReTJFy2w9zG8=;
        b=Mg6TZbGAQa9AOahKnDgfb+QLgUySRei/zhughMHGntRLNIxa7gkhUuCZdWs7wr3Dk5
         4/SYwH4F1LQdVVJExI3Ald2O6O6ANL6qw1dAW45NI9qPWJ73VEc4UblNtSM3SrNJc20K
         emgN3JAFEhr9GE9iibpUqKc5nX5s+LKrK5MBxidUFIXWtmlPD7nWX5rtRhyUtj7baXwY
         fax/Qi/3iTKsmU4fqE/kOBcm9fRj0owmGieRJwl/6LLkN1Ig07WpThi4ae1oXbOStBAQ
         xslgfiUr0WDcQnAtwJbF2ZFEUKbCHi8/l0Auh/KJFCja5a57LZT+LnAaAvS5fnJwaj5N
         YrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371775; x=1701976575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4h6ikY50jNdfv+t4SGoqzVG8MtRln2TReTJFy2w9zG8=;
        b=gQfPreGV8uO+RTa6mhqTIOSAXHiwZoiKfROP1OdTne7Q1lLifNZx7XzK5pSCUw2Kjw
         u2XKVco7WSJfQgacvhqtCJEPG1CmcW+1OJiC0gg90YZzTJx07pE9OA8YPdHiu9tVEu2k
         iCy/55vIqdFwQGKIF4ITuqWwgjIZQ6qiodwjqz5iF7uqgomTmVyyH5BYHZq7pUgyLVrK
         zvjcDrWguwrGc+x8WC6YUmfqyszYWwzOsDYqD3JFetSHpUX1fW1/roOwV3F6N8fKI7oj
         WZx0GVV8algrZQ4wUICZiQ8xwhHmq0Yfw6lOusrAVvQOCugTojehlqvwrJ7ouH83xzrm
         v2Vw==
X-Gm-Message-State: AOJu0YzcohQFVs+lavUenHcRUB4NCMgQIrh+6mMWRYX5m9UBrWiigHZd
	BGmHZU5yD6ZfjkClZtE0f/7H5Qg6+Pn8bw==
X-Google-Smtp-Source: AGHT+IFRjZTjC+heT4NolKKD80jV7S1GIbYmTBwsdQ3V3c5NK0XisCa27CQ7oZeAuUkIYUwsJr/04w==
X-Received: by 2002:a05:620a:24cf:b0:77d:ab2c:3e5d with SMTP id m15-20020a05620a24cf00b0077dab2c3e5dmr17136442qkn.41.1701371774618;
        Thu, 30 Nov 2023 11:16:14 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id c20-20020a05620a0cf400b0077d9aa74e40sm754552qkj.68.2023.11.30.11.16.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:16:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/lc3: Add QoS definitions
Date: Thu, 30 Nov 2023 14:16:11 -0500
Message-ID: <20231130191612.2295021-1-luiz.dentz@gmail.com>
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

