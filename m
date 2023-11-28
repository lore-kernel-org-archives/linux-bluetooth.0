Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwzB/1kk"
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA1CD1
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 07:28:37 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d80245b6easo2991605a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 07:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701185315; x=1701790115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YuZucRIo3c+d//e7GkzsXFLJR0Rgxs24p9QsrDyqCbg=;
        b=hwzB/1kkMOFzueFyYumllz6bStnftGT4MVSX8EJx7HeWWgElogmzzQOLQRvAz2Pbr7
         OvDYPAx2rhD5kiJi+z6KhYAXebflRBmZuHohXTG9TfAA5Mdz5xaGVYsSCMIhOt7WJMEn
         jha7aTURuARFmDZd/tK5wL+EMAQc5v+rWNYDNwsi6F8T6m3yruAI3QSfRVIS+BIkw1OY
         6mQE2kTz5tQ7Fb5vImZ4KmDucvUxzuWv8mUDVrGCxHSrCgdLGkIRdDOCzOQmqug+OeVQ
         JnNstb+bk+xydcGTBFQ77gsfli9xI+JZZzH238TlIOSY+30OV+9c8NInb2Sh6czfWKBU
         nw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701185315; x=1701790115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuZucRIo3c+d//e7GkzsXFLJR0Rgxs24p9QsrDyqCbg=;
        b=Vv4YY/tkmVk0qqkUKs62lDt+mWW8SupeS2Cg0VY21ufsr66MdGYNZD48QzRBfb+g60
         sIla+6LY76MbYq1PZVkOz3l6n/OK8akVd8gTfZLlwlxHcHL1QFAr6z0EkUdK4ur4DZQm
         FQJTVir/LmKXE+9c7G8MN7GXVZbmCRgHWsBRjdh4vGc1yuIpX5CHN9LR1FpBZ64yVw+a
         ZN1e3z6CJ20FL+SU9x3im09i9tkbTVqz3vTgaScqmsC/5pEXhe06+6r+MH4LfyOBHg0Y
         uY0JGcvkP7znUt1kKr2CZbTb+lK0qMRHcjbedUgByVF8euTSOVInja/16epg3HVeTdnG
         rJeg==
X-Gm-Message-State: AOJu0YyWODgkuunXRGGD7SxpyOaH1Pa8ywwhlnGeS5BL/2HBqzA9W4T3
	p7qM1MJiS1a3+YhejtFmeh3oaRcVZLDMjA==
X-Google-Smtp-Source: AGHT+IG+6+uDrkpW3yiMGZkIhj/nP+RUUhUvxWsKk7WPIbjGw3KvvEZZTN0nNUA6r7687fkhRVBgSA==
X-Received: by 2002:a05:6358:3107:b0:16b:c53b:4eec with SMTP id c7-20020a056358310700b0016bc53b4eecmr16507714rwe.25.1701185315320;
        Tue, 28 Nov 2023 07:28:35 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bf9-20020a056130054900b0079a1018d185sm1660644uab.31.2023.11.28.07.28.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:28:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] iso-tester: Add tests for GMAP broadcast QoS presets
Date: Tue, 28 Nov 2023 10:28:30 -0500
Message-ID: <20231128152832.1730901-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following tests:

ISO QoS 48_1_g - Success
ISO QoS 48_2_g - Success
ISO QoS 48_3_g - Success
ISO QoS 48_4_g - Success
---
 tools/iso-tester.c | 133 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 118 insertions(+), 15 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 4d47373e3290..d1f0be180c33 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -307,22 +307,81 @@
 #define QOS_OUT_1_1_16_2_1 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
 #define QOS_IN_16_2_1 BCAST_QOS_IN(10000, 10, 40, 0x02, 2)
 #define QOS_IN_ENC_16_2_1 BCAST_QOS_IN_ENC(10000, 10, 40, 0x02, 2)
+#define QOS_OUT_48_1_g BCAST_QOS_OUT(7500, 8, 75, 0x02, 1)
+#define QOS_OUT_48_2_g BCAST_QOS_OUT(10000, 10, 100, 0x02, 1)
+#define QOS_OUT_48_3_g BCAST_QOS_OUT(7500, 8, 90, 0x02, 1)
+#define QOS_OUT_48_4_g BCAST_QOS_OUT(10000, 10, 120, 0x02, 1)
 
-static const uint8_t base_lc3_16_2_1[] = {
-	0x28, 0x00, 0x00, /* Presentation Delay */
-	0x01, /* Number of Subgroups */
-	0x01, /* Number of BIS */
-	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
-	0x11, /* Codec Specific Configuration */
-	0x02, 0x01, 0x03, /* 16 KHZ */
-	0x02, 0x02, 0x01, /* 10 ms */
-	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
-	0x03, 0x04, 0x28, 0x00, /* Frame Length 40 bytes */
-	0x04, /* Metadata */
-	0x03, 0x02, 0x02, 0x00, /* Audio Context: Convertional */
-	0x01, /* BIS */
-	0x00, /* Codec Specific Configuration */
-};
+#define BASE(_pd, _sgrp, _nbis, _cfg...) \
+{ \
+	_pd & 0xff, _pd >> 8, _pd >> 16, \
+	_sgrp, \
+	_nbis, \
+	_cfg \
+}
+
+#define LC3_BASE(_pd, _sgrp, _nbis, _cc...) \
+	BASE(_pd, _sgrp, _nbis, 0x06, 0x00, 0x00, 0x00, 0x00, _cc)
+
+/* 16 KHZ - 10 ms - Front Left - Frame Length 40 bytes */
+#define LC3_CONFIG_16_2_1 \
+	0x10, \
+	0x02, 0x01, 0x03, \
+	0x02, 0x02, 0x01, \
+	0x05, 0x03, 0x01, 0x00, 0x00, 0x00, \
+	0x03, 0x04, 0x28, 0x00
+
+/* Audio Context: Convertional */
+#define CTXT_CONVERSIONAL \
+	0x04, \
+	0x03, 0x02, 0x02, 0x00
+
+static const uint8_t base_lc3_16_2_1[] =
+	LC3_BASE(40000, 1, 1, LC3_CONFIG_16_2_1, CTXT_CONVERSIONAL,
+		0x01, /* BIS */
+		0x00  /* Codec Specific Configuration */);
+
+#define LC3_CONFIG_G(_freq, _dur, _len) \
+	0x0a, \
+	0x02, 0x01, _freq, \
+	0x02, 0x02, _dur, \
+	0x03, 0x04, _len, _len >> 8
+
+#define LC3_CONFIG_FRONT_LEFT \
+	0x06, \
+	0x05, 0x03, 0x01, 0x00, 0x00, 0x00
+
+/* 48 KHZ - 7.5 ms - Frame Length 75 bytes */
+#define LC3_CONFIG_48_1_G \
+	LC3_CONFIG_G(0x08, 0x00, 75)
+
+static const uint8_t base_lc3_48_1_g[] =
+	LC3_BASE(10000, 1, 1, LC3_CONFIG_48_1_G, CTXT_CONVERSIONAL,
+			0x01, LC3_CONFIG_FRONT_LEFT);
+
+/* 48 KHZ - 10 ms Frame Length 100 bytes */
+#define LC3_CONFIG_48_2_G \
+	LC3_CONFIG_G(0x08, 0x01, 100)
+
+static const uint8_t base_lc3_48_2_g[] =
+	LC3_BASE(10000, 1, 1, LC3_CONFIG_48_2_G, CTXT_CONVERSIONAL,
+			0x01, LC3_CONFIG_FRONT_LEFT);
+
+/* 48 KHZ - 7.5 ms Frame Length 90 bytes */
+#define LC3_CONFIG_48_3_G \
+	LC3_CONFIG_G(0x08, 0x00, 90)
+
+static const uint8_t base_lc3_48_3_g[] =
+	LC3_BASE(10000, 1, 1, LC3_CONFIG_48_3_G, CTXT_CONVERSIONAL,
+			0x01, LC3_CONFIG_FRONT_LEFT);
+
+/* 48 KHZ - 7.5 ms Frame Length 90 bytes */
+#define LC3_CONFIG_48_4_G \
+	LC3_CONFIG_G(0x08, 0x00, 120)
+
+static const uint8_t base_lc3_48_4_g[] =
+	LC3_BASE(10000, 1, 1, LC3_CONFIG_48_3_G, CTXT_CONVERSIONAL,
+			0x01, LC3_CONFIG_FRONT_LEFT);
 
 /* Single Audio Channel. One BIS. */
 #define BCAST_AC_12 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
@@ -1166,6 +1225,38 @@ static const struct iso_client_data connect_ac_1_2_cig_1_2 = {
 	.mconn = true,
 };
 
+static const struct iso_client_data bcast_48_1_g = {
+	.qos = QOS_OUT_48_1_g,
+	.expect_err = 0,
+	.bcast = true,
+	.base = base_lc3_48_1_g,
+	.base_len = sizeof(base_lc3_48_1_g),
+};
+
+static const struct iso_client_data bcast_48_2_g = {
+	.qos = QOS_OUT_48_2_g,
+	.expect_err = 0,
+	.bcast = true,
+	.base = base_lc3_48_2_g,
+	.base_len = sizeof(base_lc3_48_2_g),
+};
+
+static const struct iso_client_data bcast_48_3_g = {
+	.qos = QOS_OUT_48_3_g,
+	.expect_err = 0,
+	.bcast = true,
+	.base = base_lc3_48_3_g,
+	.base_len = sizeof(base_lc3_48_3_g),
+};
+
+static const struct iso_client_data bcast_48_4_g = {
+	.qos = QOS_OUT_48_4_g,
+	.expect_err = 0,
+	.bcast = true,
+	.base = base_lc3_48_4_g,
+	.base_len = sizeof(base_lc3_48_4_g),
+};
+
 static const struct iso_client_data bcast_16_2_1_send = {
 	.qos = QOS_OUT_16_2_1,
 	.expect_err = 0,
@@ -3054,6 +3145,18 @@ int main(int argc, char *argv[])
 	test_iso("ISO QoS 48_4_gr - Success", &connect_48_4_gr, setup_powered,
 							test_connect);
 
+	test_iso("ISO QoS 48_1_g - Success", &bcast_48_1_g,
+						setup_powered, test_bcast);
+
+	test_iso("ISO QoS 48_2_g - Success", &bcast_48_2_g,
+						setup_powered, test_bcast);
+
+	test_iso("ISO QoS 48_3_g - Success", &bcast_48_3_g,
+						setup_powered, test_bcast);
+
+	test_iso("ISO QoS 48_4_g - Success", &bcast_48_4_g,
+						setup_powered, test_bcast);
+
 	test_iso("ISO QoS - Invalid", &connect_invalid, setup_powered,
 							test_connect);
 
-- 
2.43.0

