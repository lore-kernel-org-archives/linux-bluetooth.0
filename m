Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078D2206B6
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056099; cv=none; b=Rdz2oSa0HOcApyWO7igwJEkKn099qzHwo/XKCkLMGwlojooXVvmCEnxN3L4SbKUPAKjqsgB6Z7cEXNreNoDXzAaOFid891U+HiDORg6NR1ZP744QRqhm9rgaLKhTMtYP0nZZdEzfeKpNFOHjMd6XGFdh0EgKj52lylg/6HXwDHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056099; c=relaxed/simple;
	bh=KQ6zjReTABiBm3jtq26ekRlm8NKBE4mxeC93WXb6TPw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxsCBSiYhbWK6IWjh+Ur2+MnKLmYD6yo1QbmabRx+93pGo1K414nekjwXivnST3w0CYOQsABnoVmQriKQ+jYTYH3B6gKvSB1tKCBU6oz755BQjxa0PYynCrapvYDpdAMdfRzPEA9fxeL7xtDVOpaXaceRn4qEHfR7doqm6FvBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UryfL7kn; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UryfL7kn"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5262475372eso2189124e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056096; x=1744660896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnW6bQ2pyqKtX+lZBOs0Rlk2R9hc1cl6F5/z4bS5Tbw=;
        b=UryfL7kn4AuJUSFpCQdIaDKZplDg1saeWbuczObxwZl9/iuljrQOCNKyPTw4WCaLQA
         njw6fX74sfj6+M0OlXD/Kq6QMC0g+3zzklAI0Xvs7AcKk9ORwKrcFWmj15GlGlIBz+ZI
         SYdM4ISOethLeQqSwqaBtJra/Gje2reSOY/67Kov2VBx9/hLYYo+4PFdbsPpP6b+EFzl
         YpiZrQSof3UsmXjwc1E62gEs/UMSwWAymhdZMGjIIChLJJh40zT0rDluaeF4fYSyZY4G
         p3h0Nbyvnc32DUnGdEMLH6N3jtRW7qsxvsebRz/Tsp/aIocffIniWfarhMi2LE8d8gUr
         y5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056096; x=1744660896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnW6bQ2pyqKtX+lZBOs0Rlk2R9hc1cl6F5/z4bS5Tbw=;
        b=bCcYbQ41KHFZ5LpkmMv2w6cjPOsekxB3suPt0vqBeGlVTTfCfPBDhjiBYPlEtpKCpu
         exk5ljIvAquv295vU23ocwXXvm8RJHX72zDHgkd34Sw4YCacrcY1ZebuQRUDMtRb5haN
         xWwhliupWvZT5c0zJ3TR2mszJLtTuyYdarsyxfWnn8lFBLJLDqOXIL8l9Rb5bnSi6m8r
         k3JaSJLPP97csq7LQiaV4QWGUf5nlBmOjxAsZuG90frGJDdcN8h7jHljUr/9nH73u93A
         RiL1OTF81DMW5syD8CIAO12+joyPn3SPJ5t7Jg56wq1pLeWE1NbnWqrLZ4xCUk6Z8fjA
         l5Iw==
X-Gm-Message-State: AOJu0Yxq2J6uDnWv/iC9YNvfg9qvLI08QBI78DOklLGEN6m/gqhGvfQp
	tN2mOseMhuhvuDZp8XugPZEz37lyjpNoARrIfakiHwDUSQkFRvKVBbRuBHyF
X-Gm-Gg: ASbGnct+I8O9vHtRP9JzREGABgmeTMGv/bjJxi5BouV8I9Ow9o8sa8lA2Vvbp+/FvRx
	r2eOzjR1xkDwgWTE4cmcIBsuJUl2ktUo7PD13YkC0GZKVH3Wc/AGzPpHR0cbjVLX0bfwAUNqRkA
	poUgU743zIqWfDN/xhiyKvs5ef2LnqvkZuiwBVD8CtQMVFcrk2JYupm9DSJm7dA8LTEnQU8SNnj
	J7Yh7JlVALQ1JbaxusF4oGuSZ5Jj9qWvpHR//euJHqx194mNZfP1XA+oqNJSf+B0NuaN63m1Br2
	Y1owUuGyHC1pekBoY5OEXMmulXI3v+evAT+UpQPivPcFRhvJ6UmL0IIjGkbdmroIR6q/2ZYcA2c
	fS2/ztManvMnd4g==
X-Google-Smtp-Source: AGHT+IGUE1BZB0Q99Ebc/E9d8wJXMr81AJ66fILFeXZi3mTRMMbSn0OzK2dtV3wsKbDWzyQhp2HBjQ==
X-Received: by 2002:a05:6122:8288:b0:525:aecb:6306 with SMTP id 71dfb90a1353d-52765dc9a76mr9768345e0c.11.1744056095798;
        Mon, 07 Apr 2025 13:01:35 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 03/15] test-bap: Introduce USR/SCC - VS tests for LC3
Date: Mon,  7 Apr 2025 16:01:09 -0400
Message-ID: <20250407200124.881534-4-luiz.dentz@gmail.com>
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

