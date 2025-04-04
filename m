Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290BB2248AA
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795614; cv=none; b=LjHQYA6Jjxyk9obvK1UQ6swjN9RFpTpSuquUcTqL9HVVInEZGgr8XGe0D6cZoU3/d6qw6vOKzUFbTpkWf32NpiY1YZk37FEa/h3qS3w3xZtsspIl4aeXkUs4sL5a98p/0LYzrIuz8eQ+dn0es2KaLxwuYGNWqQ+YUYz8CsZm0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795614; c=relaxed/simple;
	bh=MgGuLFJ2DjfVF7ek98JsWFIEL2sH9WB3iOfFHAUb3Oc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4Ch5U8BFnvxwzdBjbyVc2Hvqn+g4Qp2evgILxSdKoBCk/RbEUCz2OhQEq53o2kEf31ppDILRT2ZDGurb7uZUYtAEjYqlmV1zdm8P3tDcFIC6aSQz8B6Fg/HpFKLZZBdEaNmReEc/qfTKxlHhosDp4FyACBzuX0M7OMij4qyKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKweWxT9; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKweWxT9"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5259327a93bso1128051e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795610; x=1744400410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gA3QOuG3Dd4SRx2ENqGs0NC8RCaJrlEWYszAo+sPZBU=;
        b=aKweWxT9ZnbHoy/luSlJcaJKdjWTcRYhVH1AZyV+VsktJotJ2u7woIjaC46wAhI2gP
         R+PycMqUS/9ew1JIIdPkBq63s2aBxQIrIF/k1Hl/nbbEozeQ0UvGh8NFMNTWrB1NDT3q
         jRbtZgPkJLuLbA4J0yjudRY7qNisDdvtWJc8ABeqk5J2KWup1CK0zLbHzzThESx+bDCv
         8EZsBvLIEF7lAx9YS4T2gqAyCWA9QJXej8OL6vWqF7Ka1f+zOxax9oLvsIvvQXo9jd3X
         OeRRxCNeofAwT1F/lYAzRIEub6XSyc51J41cW3QEx1JkWgw72qt7sBk7yeb2vp8aAbGb
         B2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795610; x=1744400410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA3QOuG3Dd4SRx2ENqGs0NC8RCaJrlEWYszAo+sPZBU=;
        b=okmztehc7FfpuuFN+6zTvnzO6ApJpt6XbdrifGoNFw08izfzY6DmFd04uy0bG73L/J
         jROcz4I7wtC2q0tmJlI9lfi4LfhjC9e/WkHMr99DcMjXj5m99Wze3GrdRFVVrri+pH/d
         mKP0MYjKpJ5nU7PcSJvi5cYw3mNbLGahXEz8JeprYx/GlQJ+C5f1GyqtQHBjVCDLEqsP
         XNPhaOSLffwBjwo0G5whXYFsTwVbAFAqYRzPZ9aepXB0X0/k94QuFK4aur4eO4clF10w
         I/I5h1p2/qimVw+5CFXqhykbdJduPqLi+bVfXUmVSV8rDLVYclQr1Wlk7Mxkrr13tZKv
         KVuQ==
X-Gm-Message-State: AOJu0YzEYffpXf4RxrHApWrtqVx0LcP4BMC8kIdFEyh8vh/5kKnRzGlI
	zsci7FXCcNOQTdTNhi5vk1SXso7QvgOUVokbcMKS1CrbNNyL31VUWF8AbLDn3X0=
X-Gm-Gg: ASbGncsqLYWjYE7KfXN5lapy+u3j1YGwTcPyre2C1/G3mq4EOu39I08tCqZW1hjPaWp
	7S5sMOCdAqY2A0Sz6HsSfIA19CFa9/++VbLj1pw/RNgWS0VWILrsDiSDqraAtvWyhZLb7vQpwmH
	Smtk0aQulvm6UJ2dbU7ybsShA4vdYd4NXQyWs6UK2Qz6ePCase4B3J2ekhTD0vp6fjdMCJH6BfM
	lcwJZKCYghtBKcmfeL9kPto3f/3RJx6/diAQKfjHZgRS9S2/SeLoDXM9AIvcFME5Ic7FcNXPMpK
	7TAgeJhNICwyHj87bfeQet195+iPhwbGEiaIMuS15lXD3w0M3RC1/t5yJ+JF6aNKRHRcLja4bS3
	o3J0BABgyJTJ3Iw==
X-Google-Smtp-Source: AGHT+IFEE/SWkLOXVMRXytRdOKy0+DRX+VuW91AU0A/Ps0w5A5WPVC09NFu5n5xguG8a1VvjWFnK3A==
X-Received: by 2002:a05:6102:5043:b0:4af:fca2:1b7 with SMTP id ada2fe7eead31-4c8568f0040mr3559408137.14.1743795609904;
        Fri, 04 Apr 2025 12:40:09 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8738b1d352esm718587241.19.2025.04.04.12.40.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:40:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 04/11] test-bap: Introduce USR/SCC QoS tests for LC3
Date: Fri,  4 Apr 2025 15:39:42 -0400
Message-ID: <20250404193959.359008-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404193959.359008-1-luiz.dentz@gmail.com>
References: <20250404193959.359008-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Unicast Server Performs Config QoS – LC3

Test Purpose:
Verify that a Unicast Server IUT can perform a Config QoS operation
initiated by a Unicast Client for the LC3 codec.

Pass verdict:
In step 2, the IUT sends a notification of the ASE Control Point
characteristic with Response_Code set to Success (0x00) for the requested
ASE_ID and opcode.
In step 3, the notified ASE characteristic value is correctly formatted, has
the ASE_ID field set to Test_ASE_ID, the ASE_State field set to 0x02
(QoS Configured), and the Additional_ASE_Parameters field containing the
CIG_ID, CIS_ID, and QoS configuration values requested in step 2.

Test Summary
------------
BAP/USR/SCC/BV-069-C [USR SNK Config QoS, LC3 8_1_1] Passed
BAP/USR/SCC/BV-070-C [USR SNK Config QoS, LC3 8_2_1] Passed
BAP/USR/SCC/BV-071-C [USR SNK Config QoS, LC3 16_1_1] Passed
BAP/USR/SCC/BV-072-C [USR SNK Config QoS, LC3 16_2_1] Passed
BAP/USR/SCC/BV-073-C [USR SNK Config QoS, LC3 24_1_1] Passed
BAP/USR/SCC/BV-074-C [USR SNK Config QoS, LC3 24_2_1] Passed
BAP/USR/SCC/BV-075-C [USR SNK Config QoS, LC3 32_1_1] Passed
BAP/USR/SCC/BV-076-C [USR SNK Config QoS, LC3 32_2_1] Passed
BAP/USR/SCC/BV-077-C [USR SNK Config QoS, LC3 44.1_1_1] Passed
BAP/USR/SCC/BV-078-C [USR SNK Config QoS, LC3 44.1_2_1] Passed
BAP/USR/SCC/BV-079-C [USR SNK Config QoS, LC3 48_1_1] Passed
BAP/USR/SCC/BV-080-C [USR SNK Config QoS, LC3 48_2_1] Passed
BAP/USR/SCC/BV-081-C [USR SNK Config QoS, LC3 48_3_1] Passed
BAP/USR/SCC/BV-082-C [USR SNK Config QoS, LC3 48_4_1] Passed
BAP/USR/SCC/BV-083-C [USR SNK Config QoS, LC3 48_5_1] Passed
BAP/USR/SCC/BV-084-C [USR SNK Config QoS, LC3 48_6_1] Passed
BAP/USR/SCC/BV-085-C [USR SRC Config QoS, LC3 8_1_1] Passed
BAP/USR/SCC/BV-086-C [USR SRC Config QoS, LC3 8_2_1] Passed
BAP/USR/SCC/BV-087-C [USR SRC Config QoS, LC3 16_1_1] Passed
BAP/USR/SCC/BV-088-C [USR SRC Config QoS, LC3 16_2_1] Passed
BAP/USR/SCC/BV-089-C [USR SRC Config QoS, LC3 24_1_1] Passed
BAP/USR/SCC/BV-090-C [USR SRC Config QoS, LC3 24_2_1] Passed
BAP/USR/SCC/BV-091-C [USR SRC Config QoS, LC3 32_1_1] Passed
BAP/USR/SCC/BV-092-C [USR SRC Config QoS, LC3 32_2_1] Passed
BAP/USR/SCC/BV-093-C [USR SRC Config QoS, LC3 44.1_1_1] Passed
BAP/USR/SCC/BV-094-C [USR SRC Config QoS, LC3 44.1_2_1] Passed
BAP/USR/SCC/BV-095-C [USR SRC Config QoS, LC3 48_1_1] Passed
BAP/USR/SCC/BV-096-C [USR SRC Config QoS, LC3 48_2_1] Passed
BAP/USR/SCC/BV-097-C [USR SRC Config QoS, LC3 48_3_1] Passed
BAP/USR/SCC/BV-098-C [USR SRC Config QoS, LC3 48_4_1] Passed
BAP/USR/SCC/BV-099-C [USR SRC Config QoS, LC3 48_5_1] Passed
BAP/USR/SCC/BV-100-C [USR SRC Config QoS, LC3 48_6_1] Passed
BAP/USR/SCC/BV-101-C [USR SNK Config QoS, LC3 8_1_2] Passed
BAP/USR/SCC/BV-102-C [USR SNK Config QoS, LC3 8_2_2] Passed
BAP/USR/SCC/BV-103-C [USR SNK Config QoS, LC3 16_1_2] Passed
BAP/USR/SCC/BV-104-C [USR SNK Config QoS, LC3 16_2_2] Passed
BAP/USR/SCC/BV-105-C [USR SNK Config QoS, LC3 24_1_2] Passed
BAP/USR/SCC/BV-106-C [USR SNK Config QoS, LC3 24_2_2] Passed
BAP/USR/SCC/BV-107-C [USR SNK Config QoS, LC3 32_1_2] Passed
BAP/USR/SCC/BV-108-C [USR SNK Config QoS, LC3 32_2_2] Passed
BAP/USR/SCC/BV-109-C [USR SNK Config QoS, LC3 44.1_1_2] Passed
BAP/USR/SCC/BV-110-C [USR SNK Config QoS, LC3 44.1_2_2] Passed
BAP/USR/SCC/BV-111-C [USR SNK Config QoS, LC3 48_1_2] Passed
BAP/USR/SCC/BV-112-C [USR SNK Config QoS, LC3 48_2_2] Passed
BAP/USR/SCC/BV-113-C [USR SNK Config QoS, LC3 48_3_2] Passed
BAP/USR/SCC/BV-114-C [USR SNK Config QoS, LC3 48_4_2] Passed
BAP/USR/SCC/BV-115-C [USR SNK Config QoS, LC3 48_5_2] Passed
BAP/USR/SCC/BV-116-C [USR SNK Config QoS, LC3 48_6_2] Passed
BAP/USR/SCC/BV-117-C [USR SRC Config QoS, LC3 8_1_2] Passed
BAP/USR/SCC/BV-118-C [USR SRC Config QoS, LC3 8_2_2] Passed
BAP/USR/SCC/BV-119-C [USR SRC Config QoS, LC3 16_1_2] Passed
BAP/USR/SCC/BV-120-C [USR SRC Config QoS, LC3 16_2_2] Passed
BAP/USR/SCC/BV-121-C [USR SRC Config QoS, LC3 24_1_2] Passed
BAP/USR/SCC/BV-122-C [USR SRC Config QoS, LC3 24_2_2] Passed
BAP/USR/SCC/BV-123-C [USR SRC Config QoS, LC3 32_1_2] Passed
BAP/USR/SCC/BV-124-C [USR SRC Config QoS, LC3 32_2_2] Passed
BAP/USR/SCC/BV-125-C [USR SRC Config QoS, LC3 44.1_1_2] Passed
BAP/USR/SCC/BV-126-C [USR SRC Config QoS, LC3 44.1_2_2] Passed
BAP/USR/SCC/BV-127-C [USR SRC Config QoS, LC3 48_1_2] Passed
BAP/USR/SCC/BV-128-C [USR SRC Config QoS, LC3 48_2_2] Passed
BAP/USR/SCC/BV-129-C [USR SRC Config QoS, LC3 48_3_2] Passed
BAP/USR/SCC/BV-130-C [USR SRC Config QoS, LC3 48_4_2] Passed
BAP/USR/SCC/BV-131-C [USR SRC Config QoS, LC3 48_5_2] Passed
BAP/USR/SCC/BV-132-C [USR SRC Config QoS, LC3 48_6_2] Passed
Total: 64, Passed: 64 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 2 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 470f59d387e5..4bd5ef8b9847 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -2268,7 +2268,7 @@ static struct test_config cfg_src_48_6_1 = {
  */
 #define QOS_SRC(_qos...) \
 	IOV_DATA(0x52, 0x22, 0x00, 0x02, 0x01, 0x03, 0x00, 0x00, _qos), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x02, 0x01, 0x01, 0x00, 0x00), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x02, 0x01, 0x03, 0x00, 0x00), \
 	IOV_NULL, \
 	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x02, 0x00, 0x00, _qos)
 
@@ -2744,7 +2744,7 @@ static struct test_config cfg_src_48_6_2 = {
  * The IUT successfully writes to the ASE Control Point characteristic with the
  * opcode set to 0x02 (Config QoS) and the specified parameters.
  */
-static void test_scc_qos_lc3(void)
+static void test_ucl_scc_qos_lc3(void)
 {
 	define_test("BAP/UCL/SCC/BV-035-C [UCL SRC Config QoS, LC3 8_1_1]",
 			test_setup, test_client, &cfg_snk_8_1_1,
@@ -2940,6 +2940,223 @@ static void test_scc_qos_lc3(void)
 			SCC_SRC_48_6_2);
 }
 
+/* 4.9.5 Unicast Server Performs Config QoS – LC3
+ *
+ * Test Purpose:
+ * Verify that a Unicast Server IUT can perform a Config QoS operation
+ * initiated by a Unicast Client for the LC3 codec.
+ *.
+ * Pass verdict:
+ * In step 2, the IUT sends a notification of the ASE Control Point
+ * characteristic with Response_Code set to Success (0x00) for the requested
+ * ASE_ID and opcode.
+ * In step 3, the notified ASE characteristic value is correctly formatted, has
+ * the ASE_ID field set to Test_ASE_ID, the ASE_State field set to 0x02
+ * (QoS Configured), and the Additional_ASE_Parameters field containing the
+ * CIG_ID, CIS_ID, and QoS configuration values requested in step 2.
+ */
+static void test_usr_scc_qos_lc3(void)
+{
+	define_test("BAP/USR/SCC/BV-069-C [USR SNK Config QoS, LC3 8_1_1]",
+			test_setup_server, test_server, &cfg_snk_8_1_1,
+			SCC_SNK_8_1_1);
+	define_test("BAP/USR/SCC/BV-070-C [USR SNK Config QoS, LC3 8_2_1]",
+			test_setup_server, test_server, &cfg_snk_8_2_1,
+			SCC_SNK_8_2_1);
+	define_test("BAP/USR/SCC/BV-071-C [USR SNK Config QoS, LC3 16_1_1]",
+			test_setup_server, test_server, &cfg_snk_16_1_1,
+			SCC_SNK_16_1_1);
+	define_test("BAP/USR/SCC/BV-072-C [USR SNK Config QoS, LC3 16_2_1]",
+			test_setup_server, test_server, &cfg_snk_16_2_1,
+			SCC_SNK_16_2_1);
+	define_test("BAP/USR/SCC/BV-073-C [USR SNK Config QoS, LC3 24_1_1]",
+			test_setup_server, test_server, &cfg_snk_24_1_1,
+			SCC_SNK_24_1_1);
+	define_test("BAP/USR/SCC/BV-074-C [USR SNK Config QoS, LC3 24_2_1]",
+			test_setup_server, test_server, &cfg_snk_24_2_1,
+			SCC_SNK_24_2_1);
+	define_test("BAP/USR/SCC/BV-075-C [USR SNK Config QoS, LC3 32_1_1]",
+			test_setup_server, test_server, &cfg_snk_32_1_1,
+			SCC_SNK_32_1_1);
+	define_test("BAP/USR/SCC/BV-076-C [USR SNK Config QoS, LC3 32_2_1]",
+			test_setup_server, test_server, &cfg_snk_32_2_1,
+			SCC_SNK_32_2_1);
+	define_test("BAP/USR/SCC/BV-077-C [USR SNK Config QoS, LC3 44.1_1_1]",
+			test_setup_server, test_server, &cfg_snk_44_1_1,
+			SCC_SNK_44_1_1);
+	define_test("BAP/USR/SCC/BV-078-C [USR SNK Config QoS, LC3 44.1_2_1]",
+			test_setup_server, test_server, &cfg_snk_44_2_1,
+			SCC_SNK_44_2_1);
+	define_test("BAP/USR/SCC/BV-079-C [USR SNK Config QoS, LC3 48_1_1]",
+			test_setup_server, test_server, &cfg_snk_48_1_1,
+			SCC_SNK_48_1_1);
+	define_test("BAP/USR/SCC/BV-080-C [USR SNK Config QoS, LC3 48_2_1]",
+			test_setup_server, test_server, &cfg_snk_48_2_1,
+			SCC_SNK_48_2_1);
+	define_test("BAP/USR/SCC/BV-081-C [USR SNK Config QoS, LC3 48_3_1]",
+			test_setup_server, test_server, &cfg_snk_48_3_1,
+			SCC_SNK_48_3_1);
+	define_test("BAP/USR/SCC/BV-082-C [USR SNK Config QoS, LC3 48_4_1]",
+			test_setup_server, test_server, &cfg_snk_48_4_1,
+			SCC_SNK_48_4_1);
+	define_test("BAP/USR/SCC/BV-083-C [USR SNK Config QoS, LC3 48_5_1]",
+			test_setup_server, test_server, &cfg_snk_48_5_1,
+			SCC_SNK_48_5_1);
+	define_test("BAP/USR/SCC/BV-084-C [USR SNK Config QoS, LC3 48_6_1]",
+			test_setup_server, test_server, &cfg_snk_48_6_1,
+			SCC_SNK_48_6_1);
+	define_test("BAP/USR/SCC/BV-085-C [USR SRC Config QoS, LC3 8_1_1]",
+			test_setup_server, test_server, &cfg_src_8_1_1,
+			SCC_SRC_8_1_1);
+	define_test("BAP/USR/SCC/BV-086-C [USR SRC Config QoS, LC3 8_2_1]",
+			test_setup_server, test_server, &cfg_src_8_2_1,
+			SCC_SRC_8_2_1);
+	define_test("BAP/USR/SCC/BV-087-C [USR SRC Config QoS, LC3 16_1_1]",
+			test_setup_server, test_server, &cfg_src_16_1_1,
+			SCC_SRC_16_1_1);
+	define_test("BAP/USR/SCC/BV-088-C [USR SRC Config QoS, LC3 16_2_1]",
+			test_setup_server, test_server, &cfg_src_16_2_1,
+			SCC_SRC_16_2_1);
+	define_test("BAP/USR/SCC/BV-089-C [USR SRC Config QoS, LC3 24_1_1]",
+			test_setup_server, test_server, &cfg_src_24_1_1,
+			SCC_SRC_24_1_1);
+	define_test("BAP/USR/SCC/BV-090-C [USR SRC Config QoS, LC3 24_2_1]",
+			test_setup_server, test_server, &cfg_src_24_2_1,
+			SCC_SRC_24_2_1);
+	define_test("BAP/USR/SCC/BV-091-C [USR SRC Config QoS, LC3 32_1_1]",
+			test_setup_server, test_server, &cfg_src_32_1_1,
+			SCC_SRC_32_1_1);
+	define_test("BAP/USR/SCC/BV-092-C [USR SRC Config QoS, LC3 32_2_1]",
+			test_setup_server, test_server, &cfg_src_32_2_1,
+			SCC_SRC_32_2_1);
+	define_test("BAP/USR/SCC/BV-093-C [USR SRC Config QoS, LC3 44.1_1_1]",
+			test_setup_server, test_server, &cfg_src_44_1_1,
+			SCC_SRC_44_1_1);
+	define_test("BAP/USR/SCC/BV-094-C [USR SRC Config QoS, LC3 44.1_2_1]",
+			test_setup_server, test_server, &cfg_src_44_2_1,
+			SCC_SRC_44_2_1);
+	define_test("BAP/USR/SCC/BV-095-C [USR SRC Config QoS, LC3 48_1_1]",
+			test_setup_server, test_server, &cfg_src_48_1_1,
+			SCC_SRC_48_1_1);
+	define_test("BAP/USR/SCC/BV-096-C [USR SRC Config QoS, LC3 48_2_1]",
+			test_setup_server, test_server, &cfg_src_48_2_1,
+			SCC_SRC_48_2_1);
+	define_test("BAP/USR/SCC/BV-097-C [USR SRC Config QoS, LC3 48_3_1]",
+			test_setup_server, test_server, &cfg_src_48_3_1,
+			SCC_SRC_48_3_1);
+	define_test("BAP/USR/SCC/BV-098-C [USR SRC Config QoS, LC3 48_4_1]",
+			test_setup_server, test_server, &cfg_src_48_4_1,
+			SCC_SRC_48_4_1);
+	define_test("BAP/USR/SCC/BV-099-C [USR SRC Config QoS, LC3 48_5_1]",
+			test_setup_server, test_server, &cfg_src_48_5_1,
+			SCC_SRC_48_5_1);
+	define_test("BAP/USR/SCC/BV-100-C [USR SRC Config QoS, LC3 48_6_1]",
+			test_setup_server, test_server, &cfg_src_48_6_1,
+			SCC_SRC_48_6_1);
+	define_test("BAP/USR/SCC/BV-101-C [USR SNK Config QoS, LC3 8_1_2]",
+			test_setup_server, test_server, &cfg_snk_8_1_2,
+			SCC_SNK_8_1_2);
+	define_test("BAP/USR/SCC/BV-102-C [USR SNK Config QoS, LC3 8_2_2]",
+			test_setup_server, test_server, &cfg_snk_8_2_2,
+			SCC_SNK_8_2_2);
+	define_test("BAP/USR/SCC/BV-103-C [USR SNK Config QoS, LC3 16_1_2]",
+			test_setup_server, test_server, &cfg_snk_16_1_2,
+			SCC_SNK_16_1_2);
+	define_test("BAP/USR/SCC/BV-104-C [USR SNK Config QoS, LC3 16_2_2]",
+			test_setup_server, test_server, &cfg_snk_16_2_2,
+			SCC_SNK_16_2_2);
+	define_test("BAP/USR/SCC/BV-105-C [USR SNK Config QoS, LC3 24_1_2]",
+			test_setup_server, test_server, &cfg_snk_24_1_2,
+			SCC_SNK_24_1_2);
+	define_test("BAP/USR/SCC/BV-106-C [USR SNK Config QoS, LC3 24_2_2]",
+			test_setup_server, test_server, &cfg_snk_24_2_2,
+			SCC_SNK_24_2_2);
+	define_test("BAP/USR/SCC/BV-107-C [USR SNK Config QoS, LC3 32_1_2]",
+			test_setup_server, test_server, &cfg_snk_32_1_2,
+			SCC_SNK_32_1_2);
+	define_test("BAP/USR/SCC/BV-108-C [USR SNK Config QoS, LC3 32_2_2]",
+			test_setup_server, test_server, &cfg_snk_32_2_2,
+			SCC_SNK_32_2_2);
+	define_test("BAP/USR/SCC/BV-109-C [USR SNK Config QoS, LC3 44.1_1_2]",
+			test_setup_server, test_server, &cfg_snk_44_1_2,
+			SCC_SNK_44_1_2);
+	define_test("BAP/USR/SCC/BV-110-C [USR SNK Config QoS, LC3 44.1_2_2]",
+			test_setup_server, test_server, &cfg_snk_44_2_2,
+			SCC_SNK_44_2_2);
+	define_test("BAP/USR/SCC/BV-111-C [USR SNK Config QoS, LC3 48_1_2]",
+			test_setup_server, test_server, &cfg_snk_48_1_2,
+			SCC_SNK_48_1_2);
+	define_test("BAP/USR/SCC/BV-112-C [USR SNK Config QoS, LC3 48_2_2]",
+			test_setup_server, test_server, &cfg_snk_48_2_2,
+			SCC_SNK_48_2_2);
+	define_test("BAP/USR/SCC/BV-113-C [USR SNK Config QoS, LC3 48_3_2]",
+			test_setup_server, test_server, &cfg_snk_48_3_2,
+			SCC_SNK_48_3_2);
+	define_test("BAP/USR/SCC/BV-114-C [USR SNK Config QoS, LC3 48_4_2]",
+			test_setup_server, test_server, &cfg_snk_48_4_2,
+			SCC_SNK_48_4_2);
+	define_test("BAP/USR/SCC/BV-115-C [USR SNK Config QoS, LC3 48_5_2]",
+			test_setup_server, test_server, &cfg_snk_48_5_2,
+			SCC_SNK_48_5_2);
+	define_test("BAP/USR/SCC/BV-116-C [USR SNK Config QoS, LC3 48_6_2]",
+			test_setup_server, test_server, &cfg_snk_48_6_2,
+			SCC_SNK_48_6_2);
+	define_test("BAP/USR/SCC/BV-117-C [USR SRC Config QoS, LC3 8_1_2]",
+			test_setup_server, test_server, &cfg_src_8_1_2,
+			SCC_SRC_8_1_2);
+	define_test("BAP/USR/SCC/BV-118-C [USR SRC Config QoS, LC3 8_2_2]",
+			test_setup_server, test_server, &cfg_src_8_2_2,
+			SCC_SRC_8_2_2);
+	define_test("BAP/USR/SCC/BV-119-C [USR SRC Config QoS, LC3 16_1_2]",
+			test_setup_server, test_server, &cfg_src_16_1_2,
+			SCC_SRC_16_1_2);
+	define_test("BAP/USR/SCC/BV-120-C [USR SRC Config QoS, LC3 16_2_2]",
+			test_setup_server, test_server, &cfg_src_16_2_2,
+			SCC_SRC_16_2_2);
+	define_test("BAP/USR/SCC/BV-121-C [USR SRC Config QoS, LC3 24_1_2]",
+			test_setup_server, test_server, &cfg_src_24_1_2,
+			SCC_SRC_24_1_2);
+	define_test("BAP/USR/SCC/BV-122-C [USR SRC Config QoS, LC3 24_2_2]",
+			test_setup_server, test_server, &cfg_src_24_2_2,
+			SCC_SRC_24_2_2);
+	define_test("BAP/USR/SCC/BV-123-C [USR SRC Config QoS, LC3 32_1_2]",
+			test_setup_server, test_server, &cfg_src_32_1_2,
+			SCC_SRC_32_1_2);
+	define_test("BAP/USR/SCC/BV-124-C [USR SRC Config QoS, LC3 32_2_2]",
+			test_setup_server, test_server, &cfg_src_32_2_2,
+			SCC_SRC_32_2_2);
+	define_test("BAP/USR/SCC/BV-125-C [USR SRC Config QoS, LC3 44.1_1_2]",
+			test_setup_server, test_server, &cfg_src_44_1_2,
+			SCC_SRC_44_1_2);
+	define_test("BAP/USR/SCC/BV-126-C [USR SRC Config QoS, LC3 44.1_2_2]",
+			test_setup_server, test_server, &cfg_src_44_2_2,
+			SCC_SRC_44_2_2);
+	define_test("BAP/USR/SCC/BV-127-C [USR SRC Config QoS, LC3 48_1_2]",
+			test_setup_server, test_server, &cfg_src_48_1_2,
+			SCC_SRC_48_1_2);
+	define_test("BAP/USR/SCC/BV-128-C [USR SRC Config QoS, LC3 48_2_2]",
+			test_setup_server, test_server, &cfg_src_48_2_2,
+			SCC_SRC_48_2_2);
+	define_test("BAP/USR/SCC/BV-129-C [USR SRC Config QoS, LC3 48_3_2]",
+			test_setup_server, test_server, &cfg_src_48_3_2,
+			SCC_SRC_48_3_2);
+	define_test("BAP/USR/SCC/BV-130-C [USR SRC Config QoS, LC3 48_4_2]",
+			test_setup_server, test_server, &cfg_src_48_4_2,
+			SCC_SRC_48_4_2);
+	define_test("BAP/USR/SCC/BV-131-C [USR SRC Config QoS, LC3 48_5_2]",
+			test_setup_server, test_server, &cfg_src_48_5_2,
+			SCC_SRC_48_5_2);
+	define_test("BAP/USR/SCC/BV-132-C [USR SRC Config QoS, LC3 48_6_2]",
+			test_setup_server, test_server, &cfg_src_48_6_2,
+			SCC_SRC_48_6_2);
+}
+
+static void test_scc_qos_lc3(void)
+{
+	test_ucl_scc_qos_lc3();
+	test_usr_scc_qos_lc3();
+}
+
 static struct test_config cfg_snk_qos_vs = {
 	.cc = IOV_NULL,
 	.qos = QOS_UCAST,
-- 
2.49.0

