Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03A227B94
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795623; cv=none; b=lf5mAsEuScle0pkCzdu19qzpycjS++URl86x+kTZznfbEQ5d8rIMHkANweT22/NterfjpZsqByFev2Cg3bytyxZtptCxCPvrhXGw/Inz15HA8qcKaFzc+hYEAqyplNxvANvDt4R0+pNswg0b7kQQsILu0PPgkPUL2Pcz+7x+Tds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795623; c=relaxed/simple;
	bh=sUscmQJlqFR2lS0AjSQV2lEVK/T+ghgD+cWQTpeyb20=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBHp0b0wzPLXQok2OMbjx3kEXpmn8vd+21iHp5xzcSE2mEixhuD2mrJw0hcQCIghVf1YS09mvoP4T8COc8VoLsKJYQlfjFDNa5g1HMtFVAuwM1vp9UYeG1BdQYq6GAj7HXzLolnv6PZW4VKpj/xDBuohP1xR+Ehv3h+3XKv5lxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElZBIUHJ; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElZBIUHJ"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523ffbe0dbcso2430234e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795620; x=1744400420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjGAIa1i+etugNmeAp6Vtd5kmpIXm+DHp1189Qjs204=;
        b=ElZBIUHJapISB3+Ke/UzbMfmqFySffRG6zAEkdJyRbtvPcSHfSJ9Mn7XcwtYEG2yhq
         v8NXd9Ig9/mZK8sejBWDPlJCozC2ENF96cFzqSSglKIoORRGY7QcG6TgTEhLtn23rIq6
         +sg2rIF1vusuV50chomF/GNCc7qm0r98ptD/CSeaGFDRegkdjQ8egRYB7mFaULilT4BG
         EAo2Ktk/CHETxMDrRvA+uTQonznastLLkWMgDnO56ZBYyASbwAzFyuDtMVe6ExO6k1V3
         h/pDg4Q9kZ2pTVcdlrgSNJhduAUP0FekUsbdzUG3lKM/Ea2SXsAyw6rbXHPn5XlWAKnM
         IRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795620; x=1744400420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjGAIa1i+etugNmeAp6Vtd5kmpIXm+DHp1189Qjs204=;
        b=dcnDu5uAmQmc/kbdeT6YO45u3lHoSlLE2j84F9WTrxZUKuZsT3C0F0IzcqxJbtT0R8
         98rCH3iBYmIIO4ZBNe3yCELh+bmqM3lZq0Usx6qNDbjNz+qGkTqGiEcjqhtEk6l4a6OP
         F5mNGMC4XZmPIvppzCj3U9ZSxAzUOoimzrXstM6TJmA/4flHiUNXXr8UZKnHk58m92e7
         6jw3KSd06ROp/4Q+TrGvcLFMVr/MnO3LukzmTgVGUSsHSViKdp2GJPY3AEXMLoIpTR+M
         FCfMN6t4wa3ZM3oelmQDfO8HtXARKUyRHbJ8UiVg3b46Vvi/PcyVefvN5YewANGI/dvO
         blqg==
X-Gm-Message-State: AOJu0Yy+9lwL25mKKiqJJFNVRFkWtWdoswG4hplDJecDyJ+t3Tlxq5Va
	LdsQ7/H2hN2LuBiRSqanidFY7Xdm5lTJybuaQZLbINM1JspdshlArcIghPWrbtc=
X-Gm-Gg: ASbGncsf3vQINSsnfYYhlODTUqcRFi/4TGUnWfo9sc+BKQ5j31R2kq1mqUZCJK+waBg
	U6AXJSrcg7Pe12k/wiIPvV7EDyncOUAipehzhXvwHW75b1+sknTKUi2RdfjWDjloKH85iuPRnDD
	jW4K1cNPHgD3KuY/HO3k29++8Ov2MqH46+a718kqEog9fiN1H7rCyNvHlZSVhpOjRGxCy93oBKo
	Ajil+fmnTlWZtuGrgPqWu7vc4Uujnl3gPebnEI2QF0j8ovNcEiRX/q67oU5Y8I6PU6x2RxTR1yp
	DBvMFuV7IQoPp97NRqSf60D7U9h1Ug2FX6SRzaIYXe+0iTM3dx1GgGypn+J0+TqG4oVsDaSAX9r
	MwoaGgHnwW0Q8sA==
X-Google-Smtp-Source: AGHT+IF0EzRqTrJm6ASMIEYfWxpo9204kOgSTNUVFAl8x+UjeWoKTWmXvy6a3fgRVMY44dEZPcDsGQ==
X-Received: by 2002:a05:6102:15a4:b0:4bf:fb80:9429 with SMTP id ada2fe7eead31-4c86364e93dmr769415137.4.1743795619813;
        Fri, 04 Apr 2025 12:40:19 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8738b1d352esm718587241.19.2025.04.04.12.40.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:40:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 09/11] test-bap: Introduce USR/SCC Release tests for LC3
Date: Fri,  4 Apr 2025 15:39:47 -0400
Message-ID: <20250404193959.359008-10-luiz.dentz@gmail.com>
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

Unicast Server Performs Client-Initiated Release Operation

Test Purpose:
Verify the behavior of a Unicast Server IUT when a Unicast Client initiates
a Release operation.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic value.

Test Summary
------------
BAP/USR/SCC/BV-143-C [USR SRC Release in Codec Configured state] Passed
BAP/USR/SCC/BV-144-C [USR SNK Release in Codec Configured state] Passed
BAP/USR/SCC/BV-145-C [USR SRC Release in QoS Configured state] Passed
BAP/USR/SCC/BV-146-C [USR SNK Release in QoS Configured state] Passed
BAP/USR/SCC/BV-147-C [USR SRC Release in Enabling state] Passed
BAP/USR/SCC/BV-148-C [USR SNK Release in Enabling or Streaming state] Passed
BAP/USR/SCC/BV-149-C [USR SRC Release in Streaming state] Passed
BAP/USR/SCC/BV-150-C [USR SRC Release in Disabling state] Passed
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 56 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 73dac275907e..c77fc83d83de 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -1160,10 +1160,6 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 	data->bap = bap;
 
 	bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
-
-	if (data->cfg && data->cfg->state_func)
-		bt_bap_state_register(data->bap, data->cfg->state_func, NULL,
-						data, NULL);
 }
 
 static void test_server(const void *user_data)
@@ -3525,7 +3521,7 @@ static struct test_config cfg_src_cc_release = {
 	IOV_DATA(0x52, 0x22, 0x00, 0x08, 0x01, 0x03), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x08, 0x01, 0x03, 0x00, 0x00), \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x00)
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x06)
 
 #define SCC_SRC_CC_RELEASE \
 	SCC_SRC_16_2, \
@@ -3552,7 +3548,7 @@ static struct test_config cfg_snk_cc_release = {
 	IOV_DATA(0x52, 0x22, 0x00, 0x08, 0x01, 0x01), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x08, 0x01, 0x01, 0x00, 0x00), \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x16, 0x00, 0x03, 0x00)
+	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x06)
 
 #define SCC_SNK_CC_RELEASE \
 	SCC_SNK_16_2, \
@@ -3699,7 +3695,7 @@ static struct test_config cfg_src_disable_release = {
  * The IUT successfully writes to the ASE Control Point characteristic with the
  * opcode set to 0x08 (Release) and the specified parameters.
  */
-static void test_scc_release(void)
+static void test_ucl_scc_release(void)
 {
 	define_test("BAP/UCL/SCC/BV-106-C [UCL SNK Release in Codec Configured"
 			" state]",
@@ -3732,6 +3728,52 @@ static void test_scc_release(void)
 			SCC_SRC_DISABLE_RELEASE);
 }
 
+/* Unicast Server Performs Client-Initiated Release Operation
+ *
+ * Test Purpose:
+ * Verify the behavior of a Unicast Server IUT when a Unicast Client initiates
+ * a Release operation.
+ *
+ */
+static void test_usr_scc_release(void)
+{
+	define_test("BAP/USR/SCC/BV-143-C [USR SRC Release in Codec Configured"
+			" state]",
+			test_setup_server, test_server, &cfg_src_cc_release,
+			SCC_SRC_CC_RELEASE);
+	define_test("BAP/USR/SCC/BV-144-C [USR SNK Release in Codec Configured"
+			" state]",
+			test_setup_server, test_server, &cfg_snk_cc_release,
+			SCC_SNK_CC_RELEASE);
+	define_test("BAP/USR/SCC/BV-145-C [USR SRC Release in QoS Configured"
+			" state]",
+			test_setup_server, test_server, &cfg_src_qos_release,
+			SCC_SRC_QOS_RELEASE);
+	define_test("BAP/USR/SCC/BV-146-C [USR SNK Release in QoS Configured"
+			" state]",
+			test_setup_server, test_server, &cfg_snk_qos_release,
+			SCC_SNK_QOS_RELEASE);
+	define_test("BAP/USR/SCC/BV-147-C [USR SRC Release in Enabling state]",
+			test_setup_server, test_server, &cfg_src_enable_release,
+			SCC_SRC_ENABLE_RELEASE);
+	define_test("BAP/USR/SCC/BV-148-C [USR SNK Release in Enabling or"
+			" Streaming state]",
+			test_setup_server, test_server, &cfg_snk_enable_release,
+			SCC_SNK_ENABLE_RELEASE);
+	define_test("BAP/USR/SCC/BV-149-C [USR SRC Release in Streaming state]",
+			test_setup_server, test_server, &cfg_src_start_release,
+			SCC_SRC_START_RELEASE);
+	define_test("BAP/USR/SCC/BV-150-C [USR SRC Release in Disabling state]",
+			test_setup_server, test_server,
+			&cfg_src_disable_release, SCC_SRC_DISABLE_RELEASE);
+}
+
+static void test_scc_release(void)
+{
+	test_ucl_scc_release();
+	test_usr_scc_release();
+}
+
 static void bap_metadata(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
-- 
2.49.0

