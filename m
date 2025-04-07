Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366721D3D1
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056105; cv=none; b=GNOGwJ6aQMAKXtr1buv3IkfHKV8xt/ScvF7hbN0EQ0NG4yCWsKQqjzS4H0XWs4dzu2xX89qHrRHZWsuZyrldrXRzx/jDnbP4cSkF0RoImDe0NLuR4e5BjY8t/qNCLUtpvVh6mFTA4E+MhG6IfxTSErmh4aOkfN4XD5lqFtwi7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056105; c=relaxed/simple;
	bh=FTq5/V+iogtJeZkC/UenAFmUAy06o6f90boKqROll7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfN/N/Vdq0xix9atoms+IXSq5W2OHG0H7FlebCgfOxZODDBt+PG/n6b98xhXUhkMdr47l9gGNZwKh/NcBuXAKXOcm+vvwJnwllnLxjlDrnSqCepc5bmwDRMu3x4DW6J44UoeNuDy9WE8wjEqjnWl3Rt91N1WhAxWjgFqA8H44co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ3qlR94; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ3qlR94"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-520847ad493so4492427e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056102; x=1744660902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/ot1Gcq7j/PUQT5etOON0qwHsX7Yfvn6hVkJYnsevY=;
        b=dJ3qlR94YMNXzKVvojG7+2ngL91w6hzv8tDLwa6ztLbcbrg/KLyeLn7w9D5awwz7Zr
         q8Vn9ElD/JjOOLrMiS7lE1IMNM7e/Sb0g9rjQUgFJJG3qkBPtFr/hPIJu+0UZQeucF3R
         HFkysHGNGYSUYTlVZAmBIaZ7dxCnLDTNS2xFkKHY0BjYFDZWvWFUyI43iKdqjcHiQieP
         1YfpbLePKnmGZ6WUzveryKLOmvkEgjellkTerrg+yEs3wEpQIhqKxesGLiz06YK4L3VG
         hWdH8bilYePAZNSXww05ZglHUP9ptx2fflChJtLiQjt4oKa1ne+jPdmVfkzJSm53ZC4C
         uj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056102; x=1744660902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/ot1Gcq7j/PUQT5etOON0qwHsX7Yfvn6hVkJYnsevY=;
        b=LMCaPvhqRJG/kSO7tSI/13OnSvstii4g+Y4utM9gGC4U5sYl7fIxC842cuxa6/fH7t
         gWIrC2SmfWc0FrydEUi75Ped112h/Er9AEiros/5ooAM6nzNlUkLllxRzjH1N0p/NU/v
         GiPLo0phwBis14Xw0+VCBYrYRZSRpqFvZtsDjGMFFxzvTtAhytuznoCUkk970iBzBFeK
         5svBk1pPTjPybv5ofOJEqqxMqyQ3GK4WtmxTMT5POzTTGWirjXVlxy0BSHBOZc5CCuQR
         QnPBF54rnFCBgiC1ersk1WfpWlAlc5gtIwWdZmRANAoeSgLqMkUBXvF6oL26WMm+D5tK
         pr+w==
X-Gm-Message-State: AOJu0YytQoSIFS+0WtWET/s8SIaXNR2ttaaBGIJdZ7dRJllrKNRPW8DR
	g6Av5723Eoqq8exUDhW+tOQUinfnZs1HoEd6zOye4XKl7QCqjPm6IpSt2MQH
X-Gm-Gg: ASbGncvGmpUd2QGtaO9zT7hcclexWd/ujzOg0rdS5rJQQ/ItmYL9MEjoxHLeuLfBjuG
	5epEZHEFQClekynZ+ZcMrX9MdJVaVJtGX0oY5lLaIQ0eSIc31xivdkIfUgL+39yDVfmT7yGUFon
	hbzkIwRg+O9xp4wP71cyV/hzSI62Ts2o27Q4v0AN0Xj3V5ZE94baN2eS04udQUI+1suwrDcw6F5
	LAMV21OonMrIYdbjZ79VuiKfte/TUxBfeKcxLZP9jmtF5pfAeEp243oLZq2F+K8G0KbduMKgw89
	0N954wTiNz1F6pBZMZDtt9M2n6t72HtxFV+u2INTjJxhyu7k/PxQHgvHOwbvGFoA6XshAhe35os
	mr0/03PZUDsFNfw==
X-Google-Smtp-Source: AGHT+IEoDhxrpqAbtBLUlLB5QToAdd2aI5YpFHjF4wRucyRyBMDktjcOkUUY6IkweZvNmYbFmSDJog==
X-Received: by 2002:a05:6122:251f:b0:520:61ee:c7f9 with SMTP id 71dfb90a1353d-52773051a54mr7821456e0c.7.1744056101740;
        Mon, 07 Apr 2025 13:01:41 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/15] test-bap: Introduce USR/SCC Enable tests for LC3
Date: Mon,  7 Apr 2025 16:01:12 -0400
Message-ID: <20250407200124.881534-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407200124.881534-1-luiz.dentz@gmail.com>
References: <20250407200124.881534-1-luiz.dentz@gmail.com>
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

