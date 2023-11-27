Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNUwdQQl"
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A337C1AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 13:58:04 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1f9e0e44fecso2352291fac.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 13:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701122283; x=1701727083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SnJoMYhuAyjqvMMq10kjIp56Ax6kSyhP5HMlHYzp+0E=;
        b=YNUwdQQlO3hdq9S0caEoeSF0iTqTrnMvfD1W2Zg46iZGSIFVBm4wyXAE224jGav94j
         H+AbrdcJJj97KEKlvumuOSv4cnnvhrTFznG7piDliUK+HWfooVlWhjQ4V2cEzrOOUhJp
         BfCOp8EKVOOfmP88RuvrxukNDulMcBYnb231or4qZOThyQRTw+T7wMUhEbCdceeKDp0p
         TIfC+JePW6Z8sBgYzA7SwhMWtw1/QDedFM5RGRcfCGAp2jxTv3I+zm50bvhk0OmtqG0K
         tsm7uNt20HkxoTZ1ElGGQF4OWbzpydzdJwoqTEy0sTffZ9Bw34fE6JQfCwOypAmdvFbR
         gyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122283; x=1701727083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnJoMYhuAyjqvMMq10kjIp56Ax6kSyhP5HMlHYzp+0E=;
        b=W8wSnvVnNjY+ZP0LV5vh2Dd4UgfTrQ6MnsdkWEBr3hbvHCqQJS54rGNDI7y+gN4d82
         shyO9w0+lKVMdICDSlKAN8ckim7aDbwLoCuAg1RzULDuTnE82SAxlx8wum4biDlHZWHJ
         2cwerpGaWKxeZRu7E9LDwFiHebMYWys56KxVd7HjHUvxh9YTAK0LzvVlGPiDCay1dogW
         HpKSZn4UgqHKxm25+qO+bQPnKdFw4lbkusSiy4+O+Rlw3i7AtHymGV7qk+I3G8q3d4Vt
         Pjaj7fdrnkPVHvmfSUCrzBWfQhUpx8d1ozvt1/CDxyBXljRYoW+4WN+5nZacFDowRs+X
         X0iQ==
X-Gm-Message-State: AOJu0YyjfRXbPVCvE0jNtbjQhl4YyHdTgje2K/pNW0PHe7tkVsgJy3UT
	9B9HUlADWOiCgthfGWlQYc0S/qyuISo/+w==
X-Google-Smtp-Source: AGHT+IH4XfZpSJ3R21FwAdTqVEOnI8ceL7IdQZVd38MyDETAFtSVF8hm54pstJCABJDcH9OaC8AzkA==
X-Received: by 2002:a05:6870:1601:b0:1e9:ddc5:99a3 with SMTP id b1-20020a056870160100b001e9ddc599a3mr16795546oae.16.1701122283256;
        Mon, 27 Nov 2023 13:58:03 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id z12-20020ac87cac000000b00423c802e1dasm995541qtv.23.2023.11.27.13.58.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:58:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] iso-tester: Add tests for GMAP broadcast QoS presets
Date: Mon, 27 Nov 2023 16:58:01 -0500
Message-ID: <20231127215801.1531286-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
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
 tools/iso-tester.c | 134 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 119 insertions(+), 15 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 4d47373e3290..bbc906b613e8 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -307,22 +307,82 @@
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
+	0x10, \
+	0x02, 0x01, _freq, \
+	0x02, 0x02, _dur, \
+	0x05, 0x03, 0x01, 0x00, 0x00, 0x00, \
+	0x03, 0x04, _len, _len >> 8
+
+/* 48 KHZ - 7.5 ms - Front Left - Frame Length 75 bytes */
+#define LC3_CONFIG_48_1_G \
+	LC3_CONFIG_G(0x08, 0x00, 75)
+
+static const uint8_t base_lc3_48_1_g[] =
+	LC3_BASE(10000, 1, 1, LC3_CONFIG_48_1_G, CTXT_CONVERSIONAL,
+		0x01, /* BIS */
+		0x00  /* Codec Specific Configuration */);
+
+/* 48 KHZ - 10 ms - Front Left - Frame Length 100 bytes */
+#define LC3_CONFIG_48_2_G \
+	LC3_CONFIG_G(0x08, 0x01, 100)
+
+static const uint8_t base_lc3_48_2_g[] =
+	LC3_BASE(10000, 1, 1, LC3_CONFIG_48_2_G, CTXT_CONVERSIONAL,
+		0x01, /* BIS */
+		0x00  /* Codec Specific Configuration */);
+
+/* 48 KHZ - 7.5 ms - Front Left - Frame Length 90 bytes */
+#define LC3_CONFIG_48_3_G \
+	LC3_CONFIG_G(0x08, 0x00, 90)
+
+static const uint8_t base_lc3_48_3_g[] =
+	LC3_BASE(10000, 1, 1, LC3_CONFIG_48_3_G, CTXT_CONVERSIONAL,
+		0x01, /* BIS */
+		0x00  /* Codec Specific Configuration */);
+
+/* 48 KHZ - 7.5 ms - Front Left - Frame Length 90 bytes */
+#define LC3_CONFIG_48_4_G \
+	LC3_CONFIG_G(0x08, 0x00, 120)
+
+static const uint8_t base_lc3_48_4_g[] =
+	LC3_BASE(10000, 1, 1, LC3_CONFIG_48_3_G, CTXT_CONVERSIONAL,
+		0x01, /* BIS */
+		0x00  /* Codec Specific Configuration */);
 
 /* Single Audio Channel. One BIS. */
 #define BCAST_AC_12 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
@@ -1166,6 +1226,38 @@ static const struct iso_client_data connect_ac_1_2_cig_1_2 = {
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
@@ -3054,6 +3146,18 @@ int main(int argc, char *argv[])
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
2.42.0

