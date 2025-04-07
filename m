Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DBF221573
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056101; cv=none; b=VzQnx569Am5oT/Kg7CHUyF8Xba94HfF9T74/Ap/93oz0oz2o6vpvZjoQDXnGTHGPMh1BVBgmIK3hQQxiXIeY+mvxriHXe5tFPwv23EbEaZivbLRpvfT+OOuhSkenR2r6qPTb3x0v4j7NgFJOt+CBvBJp/zHqH/m107luBytRCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056101; c=relaxed/simple;
	bh=MgGuLFJ2DjfVF7ek98JsWFIEL2sH9WB3iOfFHAUb3Oc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWMQ+W3Ik9JnaFykefyYUkN6iDdqNJiS9k40P3BM+R6+UyUMnVZN9Ozv4wRS+4Xab3r15sfF+iuL8C5hDQ6B/UNUOm7X+MLw2Hc7YcHZlQ5iSvql370rtz/D+lbFw1ycustk6ANsE2giNbhFi8cnI47fmlm6s6OTLp1ADmZQ8rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8CReIDE; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8CReIDE"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5240317b3e0so1729375e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056098; x=1744660898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gA3QOuG3Dd4SRx2ENqGs0NC8RCaJrlEWYszAo+sPZBU=;
        b=Y8CReIDEq2XG6Xn65tf74fAcMVPyg7os/yqIUCehivu9ODZL5ffAj0EnQ87lqVHuaI
         VInojYBqSYOUgizBVuokecgkD5uAbrA3NeHj6GLkK+gNR8svkI57u94ZLnnDpu4zwQkR
         v5mME58vAh7huQ6SjsvRBUolTAPyy1UPN/bp+Vl13Q9a4nSIarWAxRhbVhf3ouZcc0Av
         ZMUy8XDdARVtUV2llLgCw+zmrEQ7NVjWXkdNMZHl6LjSorzTvO2kbOAimdsoyC+zixVN
         56z08ioNtLGD/JBe5o2hi2zC1MpchAeHYtQfyeISftSwowdJGgxZoVkVLdsxjy4BdKzP
         hhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056098; x=1744660898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA3QOuG3Dd4SRx2ENqGs0NC8RCaJrlEWYszAo+sPZBU=;
        b=MMS5t6BQ2rrx2KPqfYieH8imHGq+Gr9GLrDT2Fj9lAWUl12cjjt1QBHI5A3wLfAh7t
         Lsey7eaYC8jOBbaLJPI4SIWcRduohKT2SXeVYuwEdEL4d0mOYA6J0z8rt1d3npHnhFaY
         r01cJwwwIOL6bkNWKeI+CpSjVrX8qz88tajycWTyOgkQRQihdvG/ZZNdra3LiKBylL2H
         sAuveLkwITy08srWkp+00WeCl6F5JzBjyYJKXhn4jmcvfDiKqs69IjrI+43gaTbUDX7F
         I05PEQwlHjj9LQpnCufP7djNsErKC4YocT/QyW7nzzkNPgYIsTnW2nGCYwF59GsUQrwR
         UCYA==
X-Gm-Message-State: AOJu0YwqKgk40vF5Oa0qsWeY6SX1nHzBUnA38eD65XBN6gOKVq1keY/3
	VboAyi+oDWHm21ZBi0iBON1v4tghUqkyQYEa0koBr37GKKIU0PDNoQ4pAf0Y
X-Gm-Gg: ASbGncvJr/znOiHuENDhHhCnMUyWpxX9UhLMqWYbAxuuge6b05UcIEF26W4vTTAEf5P
	0iSslxa8Ax1oZcMC2ZUQPCCIBO2p9j0nSOZDBYKAa143Dm1oPlHL/NYfgWD5BEvutA6+T3uxKGE
	/Qg/DuHxhRAnl8VgrHvD7wOLHsFidQP7W6w5/XsoL2ANjaLC8XzzdMkwUH/eJ1ypLPXAbhSoX8W
	ozLhJ3Wwj6YPc786g2z50UY9TBL97oJRUrfp6LgrDGVoguLLqvdNKVlnFgmiisLY74vdarNNk/m
	+FQIkapO/hkFw7w4Gio0omBM//CXUfzltxqmmlkMVjAwg2AvIlqi9uX4crOAGIUZDOKJC/5CIpO
	swZPfNgpVPsU76CO7DsASbYjP
X-Google-Smtp-Source: AGHT+IHep4LxOlVAJNRD960TW2FMEEwNgSAXFXfL5/KVCOSB5+4SGlHhnddbQhJvXo+He+YFurOr/g==
X-Received: by 2002:a05:6122:2016:b0:520:6773:e5bf with SMTP id 71dfb90a1353d-52765c22e36mr8360589e0c.1.1744056097706;
        Mon, 07 Apr 2025 13:01:37 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 04/15] test-bap: Introduce USR/SCC QoS tests for LC3
Date: Mon,  7 Apr 2025 16:01:10 -0400
Message-ID: <20250407200124.881534-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407200124.881534-1-luiz.dentz@gmail.com>
References: <20250407200124.881534-1-luiz.dentz@gmail.com>
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

