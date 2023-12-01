Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcn+A2cr"
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D2BAD
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Dec 2023 14:39:05 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-464403cde83so920978137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Dec 2023 14:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701470343; x=1702075143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4h6ikY50jNdfv+t4SGoqzVG8MtRln2TReTJFy2w9zG8=;
        b=jcn+A2cr0XmenQ9C8nfdjXyoGDT3om1VZUFuoKuAz+M5wm9QO/sbdfHzID+aO3rWIS
         gySkHGqkHPQfxrwnu5S/+itY2463yYWJYVBauygitvOu4v/dIs6rJNPy6NjQZd+/lkrv
         zecf2OEUbcxn6X2TjB/WUaeDkutOeqFTZzpBhOf3oQu6QwBTimw9Va7Ly+hN9taO0QIx
         jxEuvDj9M6A4ARNTugHrpdLuX5LGfhd6lC84hrCIUfOd36tiikjZCjKw7eHSg4TjYLLa
         Iuf2mwDIYpOIe2MoWFltTWAzEvQN+QLES96vM0kbjCRrjOVWNWGoxuBLlhmzyZaUUsnd
         a9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470343; x=1702075143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4h6ikY50jNdfv+t4SGoqzVG8MtRln2TReTJFy2w9zG8=;
        b=Z5JaYxHTKvT/5aoE/76hoPkTe0gaS1P87L9EYGWai2b6yAf/7wN+zxNAAa7HXnRePR
         SldD3GcdYb+vazyPtl4mxyosKtNPe0Uocm10lA9fmC5jcrx862FKONU+HeS7K4VN3yxj
         8/Xyk2JERrjySpXBMzma5K4v427v3L7EUqjVALvfzJ8WkRrAVpLibrD656EEr5+HwUTB
         68fIjz7m63B6saZRpreNfDqXhEW7YNjUoHVS+3JSYOHXl0TESy+IUGft3McUdVYkgBY3
         opU0x7kYTDFRFPRREv3rdd2I+BPH4QG7pqIu3q9tKGsW6zAdWSnXcRFKvzwTmRLZmCE/
         9Ryg==
X-Gm-Message-State: AOJu0Yz7VkVwwv1wieFmMYDhpl2oaAfVNuUeR0ROy7RPse1zEmo1Lza4
	WMKpf5L5+EiDae9ywKfBTgd1d195ZmKWYA==
X-Google-Smtp-Source: AGHT+IErs4W5QMHp0v1EUqySI6feVhRGtv7Js6Q+MLNQ0mjQJgV8Tn6o6jajHzMyeWV14eMIp8TDlg==
X-Received: by 2002:a67:ce06:0:b0:464:41b9:f800 with SMTP id s6-20020a67ce06000000b0046441b9f800mr240393vsl.34.1701470343046;
        Fri, 01 Dec 2023 14:39:03 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id b18-20020a0c9b12000000b0065b13180892sm1915411qve.16.2023.12.01.14.39.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:39:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/7] shared/lc3: Add QoS definitions
Date: Fri,  1 Dec 2023 17:38:54 -0500
Message-ID: <20231201223900.2498565-1-luiz.dentz@gmail.com>
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

