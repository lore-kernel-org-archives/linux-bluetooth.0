Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5285224232
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795612; cv=none; b=mEBQu1T2IdBJR+UEjca2sqP9vhjQ+yTtNHN/eS6k7D8L2sdxPqTfx8z4Rwct5Ah+p7NcF1IwVfeeEnO2os3+EZFAfkfy1zw7JRXXBDN+1AnOgK2a+wqZn3JGuti/nXmShljKGLGKjy/9Lv+/wfYBceTTzRuC0xu8H4OZ9pgJkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795612; c=relaxed/simple;
	bh=KQ6zjReTABiBm3jtq26ekRlm8NKBE4mxeC93WXb6TPw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fa+HlWYMsoEB7pwcCeHeglbLMENYNHfm2wOOjsS3t/dm5jZU0n29amtzunURzblrAjnm7btRjkdUSOzpquRfiK29NQelokV+KoH4q9pyc1S018VnF/pIbOAcM+S5RM4HPvwshLj3WIH+OSv3PBjYCRAZipQvwALYCEj9amGVQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxOYAnT2; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxOYAnT2"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1084843241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 12:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795608; x=1744400408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnW6bQ2pyqKtX+lZBOs0Rlk2R9hc1cl6F5/z4bS5Tbw=;
        b=mxOYAnT2GD2PWbwpvq8cdpg9D0osLksfXv07n+AN3ltBICm4DUFIqxk29JbEHRrQYy
         if/L0jl3bsGFc5Zxf9WoD+vqqifrg02UdwXVo12nY1HMAcVqDysuBQENlZ6HOg3RsNDD
         5N5m9wrKp11X6MuUypL6mQTByd9x6GUop++IdTM+WhaGg8IOmJvcjz/QH4nhldsVaQfx
         ouKDXVpYgjUgB0YFKTFeXal5IQ/LMPsUUHqL370L8dHGTWsSIA/ldEMPF2H120wQoHag
         MfLj+1w+lwYFHJaTqTTkwokfo5eO7h8V5CeVDPhPuE37X4vfnF8tq5iRVftu/uwUY64F
         R1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795608; x=1744400408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnW6bQ2pyqKtX+lZBOs0Rlk2R9hc1cl6F5/z4bS5Tbw=;
        b=DMYOiY3ZDDHq8c6v1SLkM+NZC5BUSg5fCfAgX4KPeHQnjXMwBA5QN5ET3Fo03f0BQ+
         S+vupL4rQ2bcbTwB1FoD1aTg6AMtEFjup8JQ3GbGbZPHvomgKX81WXNMbtLpm1Jgo5mv
         B8/pGV5lHR1G0LjQE4BwS9Y364cSonsKXws3RK9jVZ9SOdszbuqmbwyYuETk/YNBRGiA
         ffWjV2q5cJJZjfzIR+OHUv/RsZJdkXw6z1NdJt8VsiIaCDyd39FlTug3Nxm897SDiu3u
         AX+AqZfeR19gwyl8tfHVmlnFU9YPu/batEuWoMQbkYPi8nY8Arw2JTKRwHv6OK26Lp+W
         WKyA==
X-Gm-Message-State: AOJu0YwtleP3d7XZB2vOn1T9Jmt+EAke1+ODb8+bhPXFiLLM67MLyrax
	wpzgKSJ7divcN+afpkFalZsK02c9C2tBX5/ncEcwbGYsKhILFsPAJ/W7wO/07d0=
X-Gm-Gg: ASbGncuB8BOz4788v+z+yfdjpaxmumvQpU14kPhciTj4KH5nRj5z3/PzmNmsqk+Eze6
	EeMnFuzReiiHt2W/U+oq0cnUVu8sgFdvB3Up31QAyuMr3HfkRwAHwjsFWJ6e8JWigSHNGJxoS2N
	cSYBCSmxAxJlmihsr144WXJGnij458bXe7TMpu44R8w2rGrshrFxTHVhKfc+SplUKUXc/JcQTUs
	FDZEWItgw9h0bwz8q0eAKXM1B7rSS+Hp11SLZXv7FVsr7/+yttm2jzOBHOWSbMwoVOnSGg1fv8+
	OiT05RP55FH2oqSb6eJ4c5XBmkC31l23g+gm5J9Cgc95MYJeKaIvgVwlOJH0wDcKPYMaWlni4r7
	YRKHlXUD5olGyuw==
X-Google-Smtp-Source: AGHT+IHoCH//hILwWK57HucwFh1+KkvCyPNNln3iQD7pTRRybUSC2nWKIrpv3XeA7m9OwGjnfz2RkQ==
X-Received: by 2002:a05:6102:5787:b0:4c1:93df:e838 with SMTP id ada2fe7eead31-4c8554b41a4mr4836550137.23.1743795608131;
        Fri, 04 Apr 2025 12:40:08 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8738b1d352esm718587241.19.2025.04.04.12.40.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:40:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 03/11] test-bap: Introduce USR/SCC - VS tests for LC3
Date: Fri,  4 Apr 2025 15:39:41 -0400
Message-ID: <20250404193959.359008-4-luiz.dentz@gmail.com>
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

BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS]

Test Purpose:
Verify that a Unicast Server Audio Sink IUT can perform a Config
Codec operation initiated by a Unicast Client for a vendor-specific
codec for an ASE in the Idle state, the Codec Configured state, and
the QoS Configured state.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic
with the Response_Code field set to 0x00 (Success) for the requested
ASE_ID and opcode.

Test Summary
------------
BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS]      Passed
BAP/USR/SCC/BV-034-C [USR SRC Config Codec, VS]      Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 69 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index dc199f4871e1..470f59d387e5 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -515,16 +515,30 @@ static void test_setup_server(const void *user_data)
 
 	data->ccc_states = queue_new();
 
-	data->snk = bt_bap_add_pac(db, "test-bap-snk", BT_BAP_SINK, LC3_ID,
-							data->qos, data->caps,
+	if (data->cfg && data->cfg->vs)
+		data->snk = bt_bap_add_vendor_pac(db, "test-bap-snk",
+							BT_BAP_SINK, 0x0ff,
+							0x0001, 0x0001,
+							data->qos, NULL,
 							NULL);
+	else
+		data->snk = bt_bap_add_pac(db, "test-bap-snk", BT_BAP_SINK,
+							LC3_ID, data->qos,
+							data->caps, NULL);
 	g_assert(data->snk);
 
 	bt_bap_pac_set_ops(data->snk, &ucast_pac_ops, NULL);
 
-	data->src = bt_bap_add_pac(db, "test-bap-src", BT_BAP_SOURCE, LC3_ID,
-							data->qos, data->caps,
+	if (data->cfg && data->cfg->vs)
+		data->src = bt_bap_add_vendor_pac(db, "test-bap-snk",
+							BT_BAP_SOURCE, 0x0ff,
+							0x0001, 0x0001,
+							data->qos, NULL,
 							NULL);
+	else
+		data->src = bt_bap_add_pac(db, "test-bap-src", BT_BAP_SOURCE,
+							LC3_ID, data->qos,
+							data->caps, NULL);
 	g_assert(data->src);
 
 	bt_bap_pac_set_ops(data->src, &ucast_pac_ops, NULL);
@@ -1756,12 +1770,12 @@ static void test_usr_scc_cc_lc3(void)
 			SCC_SNK_48_6);
 	/* 4.9.2 Unicast Server as Audio Source Performs Config Codec – LC3
 	 *
-	 * Test Purpose
+	 * Test Purpose:
 	 * Verify that a Unicast Server Audio Source IUT can perform a Config
 	 * Codec operation initiated by a Unicast Client for an ASE in the Idle
 	 * state, the Codec Configured state.
 	 *
-	 * Pass verdict
+	 * Pass verdict:
 	 * The IUT sends a Response_Code of 0x00 (Success) in response to each
 	 * Config Codec operation.
 	 *
@@ -1873,7 +1887,7 @@ static struct test_config cfg_src_vs = {
  * parameter is formatted with octet 0 set to 0xFF, octets 1–2 set to
  * TSPX_VS_Company_ID, and octets 3–4 set to TSPX_VS_Codec_ID.
  */
-static void test_scc_cc_vs(void)
+static void test_ucl_scc_cc_vs(void)
 {
 	define_test("BAP/UCL/SCC/BV-033-C [UCL SRC Config Codec, VS]",
 			test_setup, test_client, &cfg_snk_vs, SCC_SNK_VS);
@@ -1881,6 +1895,47 @@ static void test_scc_cc_vs(void)
 			test_setup, test_client, &cfg_src_vs, SCC_SRC_VS);
 }
 
+static void test_usr_scc_cc_vs(void)
+{
+	/* BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS]
+	 *
+	 * Test Purpose:
+	 * Verify that a Unicast Server Audio Sink IUT can perform a Config
+	 * Codec operation initiated by a Unicast Client for a vendor-specific
+	 * codec for an ASE in the Idle state, the Codec Configured state, and
+	 * the QoS Configured state.
+	 *
+	 * Pass verdict:
+	 * The IUT sends a notification of the ASE Control Point characteristic
+	 * with the Response_Code field set to 0x00 (Success) for the requested
+	 * ASE_ID and opcode.
+	 */
+	define_test("BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS]",
+			test_setup_server, test_server, &cfg_snk_vs,
+			SCC_SNK_VS);
+	/* BAP/USR/SCC/BV-034-C [USR SRC Config Codec, VS]
+	 *
+	 * Test Purpose:
+	 * Verify that a Unicast Server Audio Source IUT can perform a Config
+	 * Codec operation initiated by a Unicast Client for a vendor-specific
+	 * codec for a Source ASE in the Idle state.
+	 *
+	 * Pass verdict:
+	 * The IUT sends a notification of the ASE Control Point characteristic
+	 * with the Response_Code field set to 0x00 (Success) for the requested
+	 * ASE_ID and opcode.
+	 */
+	define_test("BAP/USR/SCC/BV-034-C [USR SRC Config Codec, VS]",
+			test_setup_server, test_server, &cfg_src_vs,
+			SCC_SRC_VS);
+}
+
+static void test_scc_cc_vs(void)
+{
+	test_ucl_scc_cc_vs();
+	test_usr_scc_cc_vs();
+}
+
 static struct test_config cfg_snk_8_1_1 = {
 	.cc = LC3_CONFIG_8_1,
 	.qos = LC3_QOS_8_1_1,
-- 
2.49.0

