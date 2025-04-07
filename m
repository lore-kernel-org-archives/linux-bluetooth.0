Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840411B87F0
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056105; cv=none; b=eZ3n1tMtrEcLAGF6oOZQ63p2de3lDHOR/wWhnabUxNQ5CvdGJCNQuXLs0rsp6lRWBbGyIZHVCVxDYG2/RwxiX7XkJWIrBeHbHwAR47OdowYZ9NHdfYaWVnEjsBNrAF0WiPemM3XL37t8wkBv/WEDZlYhjB43aS8V33jEcWzMbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056105; c=relaxed/simple;
	bh=k4mTeg3N2nFLrcmIeFZW+iYlyOpN0M4pQPLjJ92/wXQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMqXnoujox9V31ZMu7iWsE8kCDM2upKKqgkn5gGA4R1NdY9PtYHwm4oN6ztJ+g9UD6PDzUh/0ey4VpgYaiyxkZRAfMM7Sftt3ca4n2J7yFOyVSpQGe3goION5d7QS84bZQnDcZrWEb205BTDO88xb51pBtnaCZ0P0VeD613SzDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrGpvFfe; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrGpvFfe"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523edc385caso1944934e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056102; x=1744660902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVaX20wo7w1Y3NZXUbSGU27hwlvxAUbfzuc80lnuofE=;
        b=CrGpvFfeKmLgfVQxcZZzYcbd7wLkJZ6jJe/PRKIMeeeaxauyCIDCCI5u3JaLm4DHCg
         aA9iwSSm6liV9wuBmkjEkYfa2hrCpCqQXHa+AST3Vnjy1ciSImrUsOlrbR1w9JxjRpZb
         XuCdqCmq7Qns0Btz+CLKdQ5yF1mH7ntmOZZEIGgBJMoEM0fzSqzLX/3HsxnLBXAH8Z//
         zuwXOmhrIIA4S75EzYneALSfkSAlmJ8XtV+7zyYh1oksne3paM0lqDvQag1qeNt4H5MI
         dlS3V74iljW9GKzTMVFtzLIpMoTpOgcgKpiL6ZXkDEdxXZwZ//bFYfTlvH6CRscI/aWy
         hkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056102; x=1744660902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVaX20wo7w1Y3NZXUbSGU27hwlvxAUbfzuc80lnuofE=;
        b=i2x6gOZCUhVI/iEAjH21RXgqGh+OM3hfZz041KyI3T7g1XSo7uW4ovF4n7eeKCIC92
         ywbQHtd4rgf0DnmN6p/ZfQFGTpn7kMWkqmvBD/BLnFbSEjA6zR5FIgfnNh19RCv+YSUO
         e4gtXF1c0ljQP/Zua44GALpeRwrdxZ5nKMx3YK40iwhPX0iK550Qu77ySI4GWNlXAPvd
         Zihtd0ztS9WvgBW/CQwwH0v+TpKP6lRr+s3dhwoZhuJk896RUYPolNXCv4HvFQsoyGmu
         zKUAHL+vYoCRaCS3qpHBiWXVOlYT2MG4GTAGqPU8tlyRLJtiT1CtWwhGNdf/zwLHWhzQ
         eZjQ==
X-Gm-Message-State: AOJu0YyN8B3RoJ8AKX2P4kwOBhoX70rFvcUF4BhWUP5UyLUPZFXL/VrU
	YdQwuoI1qoGeoj/2eASDcldKq+brZId4yoVQed3MXPLvM+//UKrfko33P+4w
X-Gm-Gg: ASbGnct3cx+rTZNnVxz8Q8PQPDAf0oavJLexH81/s0A6uiNOLa2o/XOHFr4fn+FK/8X
	xbDQBerItv0AFY9xt+SJ8y9k8J6MrKvAyx5P+M6821tjiwoFr1gdWB7T5R8QBs8MBnx/Y2xwZzi
	lxZwJ4rp4HiWyhGRx+sPda/eN7FixU0WnGMQNDIuFougjKxz9DtQaV/TRnguTYY/vWbQTaZhgcs
	jQfXMPDisgXn8T+j8DF1PML1+stW3PV+vNmTh+rRun1674yS1ZX+I11PHJeaVr528VatMzTy1wR
	IbCl9EPj/4k5u8HPeYGwtkFAMXN++Dnukl3GfXjUezl+r0PPXdw5vWXku6MmpnzytYYH5QkNfXc
	P6jR613aVQzH3Lw==
X-Google-Smtp-Source: AGHT+IEQvWSapHhG0j0oicIlGPO7vfYqt1K8WxYDja5vDgffK/u/XDhBkLo6Mc2uXh6B/jfvZTNrGQ==
X-Received: by 2002:a05:6122:17a7:b0:526:19e6:fa34 with SMTP id 71dfb90a1353d-5276443fbf8mr9100658e0c.1.1744056099816;
        Mon, 07 Apr 2025 13:01:39 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/15] test-bap: Introduce USR/SCC QoS tests for VS
Date: Mon,  7 Apr 2025 16:01:11 -0400
Message-ID: <20250407200124.881534-6-luiz.dentz@gmail.com>
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

Unicast Server Performs Config QoS – Vendor-Specific

Test Purpose:
Verify that a Unicast Server IUT can handle a Config QoS operation for a
vendor-specific codec.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic with
Response_Code set to Success (0x00) for the requested ASE_ID and opcode

Test Summary
------------
BAP/USR/SCC/BV-133-C [USR SNK Config QoS, VS]        Passed
BAP/USR/SCC/BV-134-C [USR SRC Config QoS, VS]        Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 4bd5ef8b9847..7edb8d8a9b7d 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -2940,7 +2940,7 @@ static void test_ucl_scc_qos_lc3(void)
 			SCC_SRC_48_6_2);
 }
 
-/* 4.9.5 Unicast Server Performs Config QoS – LC3
+/* Unicast Server Performs Config QoS – LC3
  *
  * Test Purpose:
  * Verify that a Unicast Server IUT can perform a Config QoS operation
@@ -3191,16 +3191,42 @@ static struct test_config cfg_src_qos_vs = {
  * The IUT successfully writes to the ASE Control Point characteristic with the
  * opcode set to 0x02 (Config QoS) and the specified parameters.
  */
-static void test_scc_qos_vs(void)
+static void test_ucl_scc_qos_vs(void)
 {
 	define_test("BAP/UCL/SCC/BV-099-C [UCL SNK Config QoS, VS]",
 			test_setup, test_client, &cfg_src_qos_vs,
 			SCC_SRC_QOS_VS);
-	define_test("BAP/UCL/SCC/BV-100-C [UCL SRC QoS Codec, VS]",
+	define_test("BAP/UCL/SCC/BV-100-C [UCL SRC Config QoS, VS]",
 			test_setup, test_client, &cfg_snk_qos_vs,
 			SCC_SNK_QOS_VS);
 }
 
+/* Unicast Server Performs Config QoS – Vendor-Specific
+ *
+ * Test Purpose:
+ * Verify that a Unicast Server IUT can handle a Config QoS operation for a
+ * vendor-specific codec.
+ *
+ * Pass verdict:
+ * The IUT sends a notification of the ASE Control Point characteristic with
+ * Response_Code set to Success (0x00) for the requested ASE_ID and opcode.
+ */
+static void test_usr_scc_qos_vs(void)
+{
+	define_test("BAP/USR/SCC/BV-133-C [USR SNK Config QoS, VS]",
+			test_setup_server, test_server, &cfg_snk_qos_vs,
+			SCC_SNK_QOS_VS);
+	define_test("BAP/USR/SCC/BV-134-C [USR SRC Config QoS, VS]",
+			test_setup, test_client, &cfg_src_qos_vs,
+			SCC_SRC_QOS_VS);
+}
+
+static void test_scc_qos_vs(void)
+{
+	test_ucl_scc_qos_vs();
+	test_usr_scc_qos_vs();
+}
+
 static struct test_config cfg_snk_enable = {
 	.cc = LC3_CONFIG_16_2,
 	.qos = LC3_QOS_16_2_1,
-- 
2.49.0

