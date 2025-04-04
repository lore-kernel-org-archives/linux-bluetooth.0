Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13107224238
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795617; cv=none; b=AlughO4pAAY6Hr6ghAOubna4JQ4XJq9723Wstc+DdZnlJWPkjtz3RxkPQ8cetRb6M4+hV63eNLUv6Jj8erCP9eLwcmxbJYSsal9DWE9tRp3d6KAWz4anfN5HyYf4gAoxZfDkKjrb27UULOXtcYVDshsqPAeBMBEB0tzRj94FNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795617; c=relaxed/simple;
	bh=FTq5/V+iogtJeZkC/UenAFmUAy06o6f90boKqROll7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuslT24Fs+JFsJBebhtaiqv/ex5hDBhk2ChMEWEGXz2+F4HtTjBGXmpeMXom5cuJWtpwU3dPTpTk26h2g4NS8fYsIwyti9i+nS1muHYf5uBt5aqbr+zyqlQZKBsdQgdiIX6GazE8VNObthaNE/Hc0U19Pgz/v/zsFQCGMr9wfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixiEpbcD; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixiEpbcD"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5262475372eso1186787e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795614; x=1744400414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/ot1Gcq7j/PUQT5etOON0qwHsX7Yfvn6hVkJYnsevY=;
        b=ixiEpbcDodxRF64vTtvfFkaTunThhOtuxAVDHaEl4NV86F3HWads/q4BZW9EnsAQ87
         P+abZ2yZDdt+E9NhdNhsDGS5B1g31Y3szVN0bLfoZRo5UldHzrPY4Wj0De2Acey7Knqf
         22LRhgqtHwGfyFwuJazGPMcRlqeuboBUBEaxLZZApS5CE75rhtHWQoHv6l3SbMwjIHod
         mx8YkDZfDu3TjHbasfP2f2WShdLFwj6sgERBeqxi8hQJtb7Rf924bWq0Y5woHpfMJX2u
         QHnKlQrTT7o1uTNZDWVMyl9nyj5EW1rhj0KvkXqGnZUOiTYenAEqaxMj6jLAXcQEnfcd
         SnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795614; x=1744400414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/ot1Gcq7j/PUQT5etOON0qwHsX7Yfvn6hVkJYnsevY=;
        b=mU+Ra8bs/uukwoHbc/ZcWdrF/w4xYOGvNuYacJ4GVwjhAylpP7Fcx0aZZxOkRVpkcS
         LkyStRMt6MuzH+KdqFugGfw+O1GQ/iKfr+Vr9OjHS+j03mjFKlxtmBfg0/FDtAF3K6dV
         Qga6GFijgAQILNC1kRCurFbSP6N/ZiLajafWueZex8Z7WaABAWMelZI8XcIAx6KlytwQ
         /Xt76Uk0c4oNqjve+7GwbTUU613sw9HvtK+7LBsrcIA91e5IYRzWHJ0Qb9Zi/FkGu5G4
         XW0c3FDQ32jwsY92clS42zRYFV/k/XPzKvDaK0pGi24y27f3IUeb3c0PCHvcAqX0fd0V
         6zvw==
X-Gm-Message-State: AOJu0YwUWs8F/31QiUJ+5Irbqjh5P21WeekxoghYTuUKBneUlz2nIhlA
	M2gWyFvBhKWhtwJjBX7gkIZtbM3wVGWzb5sHoCUEjl0vKoL+64kdU8IBqD+xncA=
X-Gm-Gg: ASbGncuu920i7Dxt1E+yorb6B2Tbf+stxcTBKlJWN0u0udRrXvcjy/pHyzpegau8ngB
	OPrkjJX8G0UUoJsqVwEOEQf7/J3qoNLFTDfg3JC/3rrFF6beaA6r3PB+oMnseL9bPIiM3gpaoW2
	MMA/wJ+e/9BKumR5jUOofXK94uhF/XNDvr0ReT+8KcyZPgBEu9dRNIJWjltSYqZwyRQQfD2a+Zp
	SRA2yyL9bHMKqcyiwo/pWmWj9tjgX5IYnR9IXTp3VB9JoZc0qzdV2zDUHZ4otdWoREDDXb1Wms7
	w7htX1NXvf00Y4Z8cS6T9kHNqu25GHL350KKoyyvevDK+XnsBpMo8LUF4+3WmqgVLJwKK/w3trn
	UdFvWVFvGihVuNA==
X-Google-Smtp-Source: AGHT+IHadNGvjc2W+wd6Jwui2FPnQVXKcSVgPcIhUqtYYELYYeniEC3U5pTc50JRxfrGy4OQ3LBCPg==
X-Received: by 2002:a05:6102:5681:b0:4b2:c391:7d16 with SMTP id ada2fe7eead31-4c8568c14afmr3898000137.7.1743795613972;
        Fri, 04 Apr 2025 12:40:13 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8738b1d352esm718587241.19.2025.04.04.12.40.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:40:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 06/11] test-bap: Introduce USR/SCC Enable tests for LC3
Date: Fri,  4 Apr 2025 15:39:44 -0400
Message-ID: <20250404193959.359008-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404193959.359008-1-luiz.dentz@gmail.com>
References: <20250404193959.359008-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Unicast Server Performs Client-Initiated Enable Operation

Test Purpose:
Verify that a Unicast Server IUT can handle a client-initiated Enable
operation for an ASE with a Unicast Client that is either in the Audio Sink
role or the Audio Source role.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic with
Response_Code set to 0x00 (Success) for the requested ASE_ID and opcode.

Test Summary
------------
BAP/USR/SCC/BV-135-C [USR SNK Enable]                Passed
BAP/USR/SCC/BV-136-C [UCL SRC Enable]                Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 7edb8d8a9b7d..5edcc739b675 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -3273,7 +3273,7 @@ static struct test_config cfg_src_enable = {
 #define SRC_ENABLE \
 	IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x03, 0x04, 0x03, 0x02, 0x01, \
 			00), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x03, 0x01, 0x01, 0x00, 0x00), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x03, 0x01, 0x03, 0x00, 0x00), \
 	IOV_NULL, \
 	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x03, 0x00, 0x00, 0x04, 0x03, 0x02, \
 			0x01, 0x00)
@@ -3291,7 +3291,7 @@ static struct test_config cfg_src_enable = {
  * The IUT successfully writes to the ASE Control Point characteristic with the
  * opcode set to 0x03 (Enable) and the specified parameters.
  */
-static void test_scc_enable(void)
+static void test_ucl_scc_enable(void)
 {
 	define_test("BAP/UCL/SCC/BV-101-C [UCL SRC Enable]",
 			test_setup, test_client, &cfg_snk_enable,
@@ -3301,6 +3301,33 @@ static void test_scc_enable(void)
 			SCC_SRC_ENABLE);
 }
 
+/* Unicast Server Performs Client-Initiated Enable Operation
+ *
+ * Test Purpose:
+ * Verify that a Unicast Server IUT can handle a client-initiated Enable
+ * operation for an ASE with a Unicast Client that is either in the Audio Sink
+ * role or the Audio Source role.
+ *
+ * Pass verdict:
+ * The IUT sends a notification of the ASE Control Point characteristic with
+ * Response_Code set to 0x00 (Success) for the requested ASE_ID and opcode.
+ */
+static void test_usr_scc_enable(void)
+{
+	define_test("BAP/USR/SCC/BV-135-C [USR SNK Enable]",
+			test_setup_server, test_server, &cfg_snk_enable,
+			SCC_SNK_ENABLE);
+	define_test("BAP/USR/SCC/BV-136-C [UCL SRC Enable]",
+			test_setup_server, test_server, &cfg_src_enable,
+			SCC_SRC_ENABLE);
+}
+
+static void test_scc_enable(void)
+{
+	test_ucl_scc_enable();
+	test_usr_scc_enable();
+}
+
 static struct test_config cfg_snk_disable = {
 	.cc = LC3_CONFIG_16_2,
 	.qos = LC3_QOS_16_2_1,
-- 
2.49.0

