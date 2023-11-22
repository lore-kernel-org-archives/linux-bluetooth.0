Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvkvfh+m"
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF161B9
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 13:07:36 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6705379b835so1513216d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 13:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687254; x=1701292054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qi3K7VQyUWa0lVFxz42Xy5Na8CHjuAIK7BaAEzLEHTA=;
        b=dvkvfh+mODAExfyI2UNn6Bhqi98tMWL/58pohg1jqj/jejVWkJOQFfnT0lhzT4Ak27
         tByw50OnRfMmbJ6wMhyVeDEZMrLqjY/wnrsAkhGgK+7Xh/T8QlZuFhSvY8KiyUP3HMRG
         gagdO3nRTBEOah5cxBTt3rnCUiUtmg6ymq7LZ0sUJJ/QPO/AmJg0sujfBMXxxH1cZxEy
         5aT8D3LzkGNVwxKxvySY/CuMTJopwM6KDQnweu4cEDaXXhoqzJwrNFDHUfrCHstJm/ke
         9/TqDvkE5OIjdfE7SHD8mX9Uj8QHYCgcq0y4YOEniwho0oaRKEnUk5L16SorT1SOr1QH
         mebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687254; x=1701292054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi3K7VQyUWa0lVFxz42Xy5Na8CHjuAIK7BaAEzLEHTA=;
        b=Rqogd/Wj8ZSaDTy5HvDSojb3SqXGEfJaAe4WpWcKLNd+katcSCGRqGBLc4g24JYoJ7
         Zl0ArBIaTN4pEZxpccVNQgFjNS9fK2BIOF7dFDO9szsW3KwRqpqOCQ6U4XCfL/gmLd4s
         ZMOBAV0SxAsDRN0ADADxNRJVqJ6/O2/1EannE79tKNJAZmsPnZ8LmQb2MwK0rJuLR9wN
         M6Ay4DfzNeTnjTXOTfv0MdHvHQhQ3AE1EkS23A7W9h0zHWJotHFunW9jqM1wsanBbCvG
         0zyPiIxVUYCoLTFusBTMFUIbZc4TygWVkDXWrN3XjizP1Qrjh6ISsulYV1HpSd0JIjiu
         mSpA==
X-Gm-Message-State: AOJu0YzEpi0wNxOXufOvnJcFHc0d/HUQd9Zh+i4jBy0rzA7V9oVHzBxA
	2HT3WWG+KTPf9TLqo9US9KotxAjuVBUUoHCd
X-Google-Smtp-Source: AGHT+IHL2YeouxuvMfcLNpDUqVRHWgeBmqabZwYQGAqPNIaqt9iYui6DRHBZfFHT1LwFyRDByV2scQ==
X-Received: by 2002:a05:6214:628:b0:66d:36fb:474d with SMTP id a8-20020a056214062800b0066d36fb474dmr4488758qvx.1.1700687254522;
        Wed, 22 Nov 2023 13:07:34 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id w2-20020a0ca802000000b006781b67abaasm94384qva.109.2023.11.22.13.07.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:07:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/5] iso-tester: Add presets from GMAP
Date: Wed, 22 Nov 2023 16:07:25 -0500
Message-ID: <20231122210727.893872-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122210727.893872-1-luiz.dentz@gmail.com>
References: <20231122210727.893872-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following presets from GMAP:

ISO QoS 48_1_gc - Success                            Passed
ISO QoS 48_2_gc - Success                            Passed
ISO QoS 48_1_gr - Success                            Passed
ISO QoS 48_2_gr - Success                            Passed
ISO QoS 48_3_gr - Success                            Passed
ISO QoS 48_4_gr - Success                            Passed
---
 tools/iso-tester.c | 109 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 9fccbaa809e4..4d47373e3290 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -154,6 +154,19 @@
 #define QOS_48_4_2 QOS_OUT(10000, 100, 120, 0x02, 13)
 #define QOS_48_5_2 QOS_OUT(7500, 75, 117, 0x02, 13)
 #define QOS_48_6_2 QOS_OUT(10000, 100, 155, 0x02, 13)
+/* QoS configuration support setting requirements for the UGG and UGT */
+#define QOS_16_1_gs QOS(7500, 15, 30, 0x02, 1)
+#define QOS_16_2_gs QOS(10000, 20, 40, 0x02, 1)
+#define QOS_32_1_gs QOS(7500, 15, 60, 0x02, 1)
+#define QOS_32_2_gs QOS(10000, 20, 80, 0x02, 1)
+#define QOS_48_1_gs QOS(7500, 15, 75, 0x02, 1)
+#define QOS_48_2_gs QOS(10000, 20, 100, 0x02, 1)
+#define QOS_32_1_gr QOS(7500, 15, 60, 0x02, 1)
+#define QOS_32_2_gr QOS(10000, 20, 80, 0x02, 1)
+#define QOS_48_1_gr QOS(7500, 15, 75, 0x02, 1)
+#define QOS_48_2_gr QOS(10000, 20, 100, 0x02, 1)
+#define QOS_48_3_gr QOS(7500, 15, 90, 0x02, 1)
+#define QOS_48_4_gr QOS(10000, 20, 120, 0x02, 1)
 
 /* One unidirectional CIS. Unicast Server is Audio Sink */
 #define AC_1_4 QOS_OUT(10000, 10, 40, 0x02, 2)
@@ -810,6 +823,66 @@ static const struct iso_client_data connect_48_6_2 = {
 	.expect_err = 0
 };
 
+static const struct iso_client_data connect_16_1_gs = {
+	.qos = QOS_16_1_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_16_2_gs = {
+	.qos = QOS_16_2_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_32_1_gs = {
+	.qos = QOS_32_1_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_32_2_gs = {
+	.qos = QOS_32_2_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_1_gs = {
+	.qos = QOS_48_1_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_2_gs = {
+	.qos = QOS_48_2_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_32_1_gr = {
+	.qos = QOS_32_1_gr,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_32_2_gr = {
+	.qos = QOS_32_2_gr,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_1_gr = {
+	.qos = QOS_48_1_gr,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_2_gr = {
+	.qos = QOS_48_2_gr,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_3_gr = {
+	.qos = QOS_48_3_gr,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_4_gr = {
+	.qos = QOS_48_4_gr,
+	.expect_err = 0
+};
+
 static const struct iso_client_data connect_invalid = {
 	.qos = QOS(0, 0, 0, 0, 0),
 	.expect_err = -EINVAL
@@ -2945,6 +3018,42 @@ int main(int argc, char *argv[])
 	test_iso("ISO QoS 48_6_2 - Success", &connect_48_6_2, setup_powered,
 							test_connect);
 
+	test_iso("ISO QoS 16_1_gs - Success", &connect_16_1_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 16_2_gs - Success", &connect_16_2_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 32_1_gs - Success", &connect_32_1_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 32_2_gs - Success", &connect_32_2_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_1_gs - Success", &connect_48_1_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_2_gs - Success", &connect_48_2_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 32_1_gr - Success", &connect_32_1_gr, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 32_2_gr - Success", &connect_32_2_gr, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_1_gr - Success", &connect_48_1_gr, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_2_gr - Success", &connect_48_2_gr, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_3_gr - Success", &connect_48_3_gr, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_4_gr - Success", &connect_48_4_gr, setup_powered,
+							test_connect);
+
 	test_iso("ISO QoS - Invalid", &connect_invalid, setup_powered,
 							test_connect);
 
-- 
2.42.0

