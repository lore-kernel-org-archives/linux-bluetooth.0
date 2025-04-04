Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C5227EB9
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795628; cv=none; b=mQRF/Y8JzH/JZVxdUI81opv2xQoGCfvKLXZkLoMjMJJM6XMIm3gw0bYKrzKHJh1MiBSNpEmcJcET1iwqo6ku6XMrtnC1CJ8k3J/dpqTf7OoGeJhF/U4xDGlQ7mW8mKh4q2GPK2ISumUltWOj3TNxt9toCY5YfHnGBiSB4hKOEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795628; c=relaxed/simple;
	bh=CXLxyP410fRpt64ZOOLY4z3YvvSGAudaFdOL6DsKMPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAyDEu6Vtwriu3dHTacqvh57kGIU1iVfVBEpy6k2kFPd9XX2IkmnxhffWov5inyVCwe85ixfKvdcIXtqJCrD899B12Ov4WlXQL6vlmPtFKLwp5JydBFaAey+rlEo8fRNW6OM2trZE4JRQdpOUZ+W6mGi8Uo7fm17RJkKI7zXpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFgF6FmG; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFgF6FmG"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso1128409241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795624; x=1744400424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8jttERukblywXwrKsL0Af2/sHwoQGtFPkhNzIFFZIk=;
        b=nFgF6FmG8XsVNiAMff9iukdOlYWvvIPESZmgqn7noyqTfMpR6C9BHOtFcCMzJn7unj
         yC0OahDpJZh3Jv7QC4YddMBkF4rPZnTd3ZijZ5anuZcJOz8owz0WzywsEgqgu6nVAyBP
         1pP7zzP44IZFOpOYdP3N96Mr5RgFTcfYEoyu+EL1hxXBWONJ/ZyXcSV373JuKN+Ww3sx
         /GDkIFx5Gmqf4O+K0GthEHjcLKaoWrqtYsWMuDVk+N9l9NU/0Kje2Ex/sS/LVKnX9rEc
         UAdVCCyMJYGl7SA5W1rxRLbKQFPIFC6N0t0bE/xwAFqRrpJa+25EmW1T4r4TXljaS1qk
         6Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795624; x=1744400424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8jttERukblywXwrKsL0Af2/sHwoQGtFPkhNzIFFZIk=;
        b=UPXGb2Cj/Ad4vm9cX+irqScFHl71Ay7YSiALZ7Ks7O1pNIt4wiP0Lc2Q1CXvNS0TXH
         qwKWc33qH2GGRbh8/eNIJFssAVi0zIleimFQpcCotfFTrpK4h9yuvjFz6n+ml8rszr18
         zoQ1vtjCqsiNgCNfCNiEcCG3H8qK8QszLcutmtRRlGHvo6dgbHazHmIiomUzAD7jVa6e
         O7XmSTp5aozJyZJO3f6UrsYXErHjQEq6NEeLZYCua5VFbn7YNe+cq421BS107ii242oQ
         xXhjxLK5oXalLvwmRvswyryT6kafI1CtgaA06fe9Bs1w1pXdx3dSilPUxiTADyKSspdS
         m1Cw==
X-Gm-Message-State: AOJu0YzbHgwv/c7RwxwCjz8cKbFdpkFO2+Cm+KZ4LOijTmytBYhdZfyr
	4KAfxoww/Qf3zyOLn8ulUGfqrB4fApwhCaAEgsn+jfLG95jaszJ5JaLgf8j7IzQ=
X-Gm-Gg: ASbGncuA0+Gy5j54JugdUyiBxBy6cQtRj5tM/J68XWqCX0spQorCJKs3DKV05qGOydB
	j1c+X8ON73skuam2BHgFNFBIE4ZMhGurBtzROiKc7FG9KZ71syuvvp+LjKX20RyNaZsesxoL4GL
	uNEeqX+m6QhRiKum74DAJgAI0I4glGo3LJiFdntdHg75ZRdftxCe+0bIR6Lq7um/Yu7++UuOfFN
	+/lzrEZ+cGphFhGOxDrcfrzOOlcvdIqyiZCMqdfXRrQsm3aVV9dGinaDSWIFmEHI111Wi8NTtjr
	RX6vRoeVS22L2gehjkM0lAaYUK2wci3whRXQj7IJBwKcXtS6EawDmKzuh713Sorwmf95fPz6Yho
	1oTM9x6QGXDGY1A==
X-Google-Smtp-Source: AGHT+IGwsOpiFIqmZVVO7XZj2lw0KgBT9Zyy1C4pDxpFGYq/fiQ+QUJ7ix2CAFehHKrP7K2BJG/LmA==
X-Received: by 2002:a05:6102:54aa:b0:4c3:7f7:92f4 with SMTP id ada2fe7eead31-4c85539d9c7mr3799750137.6.1743795624183;
        Fri, 04 Apr 2025 12:40:24 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8738b1d352esm718587241.19.2025.04.04.12.40.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:40:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 11/11] test-bap: Introduce USR/SCC Metadata tests for LC3
Date: Fri,  4 Apr 2025 15:39:49 -0400
Message-ID: <20250404193959.359008-12-luiz.dentz@gmail.com>
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

Unicast Server Performs Update Metadata Operation

Test Purpose:
Verify that a Unicast Server IUT can perform an Update Metadata operation
initiated by a Unicast Client.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic with
Response_Code set to Success (0x00) for the requested ASE_ID and opcode.

Test Summary
------------
BAP/USR/SCC/BV-161-C [USR SRC Update Metadata in Enabling State] Passed
BAP/USR/SCC/BV-162-C [USR SNK Update Metadata in Enabling or Streaming state] Passed
BAP/USR/SCC/BV-163-C [USR SRC Update Metadata in Streaming State] Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 56 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index c77fc83d83de..9a07bd8f53e7 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -3734,6 +3734,9 @@ static void test_ucl_scc_release(void)
  * Verify the behavior of a Unicast Server IUT when a Unicast Client initiates
  * a Release operation.
  *
+ * Pass verdict:
+ * The IUT sends a notification of the ASE Control Point characteristic value.
+ *
  */
 static void test_usr_scc_release(void)
 {
@@ -3815,15 +3818,13 @@ static struct test_config cfg_snk_metadata = {
  *    Data: 0701010000
  * ATT: Handle Value Notification (0x1b) len 37
  *   Handle: 0x0016
- *     Data: 01010102010a00204e00409c00204e00409c00_qos
+ *     Data: 0103000000
  */
 #define ASE_SNK_METADATA \
 	IOV_DATA(0x52, 0x22, 0x00, 0x07, 0x01, 0x01, 0x00), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x07, 0x01, 0x01, 0x00, 0x00), \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x05, 0x00, 0x00, 0x4c, 0x1d, 0x00, \
-			0x00, 0x02, 0x1a, 0x00, 0x02, 0x08, 0x00, 0x40, 0x9c, \
-			0x00)
+	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x03, 0x00, 0x00, 0x00)
 
 #define SCC_SNK_METADATA \
 	SCC_SNK_ENABLE, \
@@ -3845,18 +3846,16 @@ static struct test_config cfg_src_metadata = {
  *    Data: 0701030000
  * ATT: Handle Value Notification (0x1b) len 37
  *   Handle: 0x001c
- *     Data: 030300000403020100
+ *     Data: 0303000000
  */
-#define ASE_SRC_METADATA \
+#define ASE_SRC_METADATA(_state) \
 	IOV_DATA(0x52, 0x22, 0x00, 0x07, 0x01, 0x03, 0x00), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x07, 0x01, 0x03, 0x00, 0x00), \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x05, 0x00, 0x00, 0x4c, 0x1d, 0x00, \
-			0x00, 0x02, 0x1a, 0x00, 0x04, 0x08, 0x00, 0x40, 0x9c, \
-			0x00)
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, _state, 0x00, 0x00, 0x00)
 #define SCC_SRC_METADATA \
 	SCC_SRC_ENABLE, \
-	ASE_SRC_METADATA
+	ASE_SRC_METADATA(0x03)
 
 static void state_start_metadata(struct bt_bap_stream *stream,
 					uint8_t old_state, uint8_t new_state,
@@ -3886,7 +3885,7 @@ static struct test_config cfg_src_metadata_streaming = {
 #define SCC_SRC_METADATA_STREAMING \
 	SCC_SRC_ENABLE, \
 	SRC_START, \
-	ASE_SRC_METADATA
+	ASE_SRC_METADATA(0x04)
 
 /* Unicast Client Initiates Update Metadata Operation
  *
@@ -3898,7 +3897,7 @@ static struct test_config cfg_src_metadata_streaming = {
  * The IUT successfully writes to the ASE Control Point characteristic with the
  * opcode set to 0x07 (Update Metadata) and the specified parameters.
  */
-static void test_scc_metadata(void)
+static void test_ucl_scc_metadata(void)
 {
 	define_test("BAP/UCL/SCC/BV-115-C [UCL SNK Update Metadata in Enabling "
 			"State]",
@@ -3914,6 +3913,39 @@ static void test_scc_metadata(void)
 			SCC_SRC_METADATA_STREAMING);
 }
 
+/* Unicast Server Performs Update Metadata Operation
+ *
+ * Test Purpose:
+ * Verify that a Unicast Server IUT can perform an Update Metadata operation
+ * initiated by a Unicast Client.
+ *
+ * Pass verdict:
+ * The IUT sends a notification of the ASE Control Point characteristic with
+ * Response_Code set to Success (0x00) for the requested ASE_ID and opcode.
+ */
+static void test_usr_scc_metadata(void)
+{
+	define_test("BAP/USR/SCC/BV-161-C [USR SRC Update Metadata in Enabling "
+			"State]",
+			test_setup_server, test_server, &cfg_src_metadata,
+			SCC_SRC_METADATA);
+	define_test("BAP/USR/SCC/BV-162-C [USR SNK Update Metadata in Enabling "
+			"or Streaming state]",
+			test_setup_server, test_server, &cfg_snk_metadata,
+			SCC_SNK_METADATA);
+	define_test("BAP/USR/SCC/BV-163-C [USR SRC Update Metadata in Streaming"
+			" State]",
+			test_setup_server, test_server,
+			&cfg_src_metadata_streaming,
+			SCC_SRC_METADATA_STREAMING);
+}
+
+static void test_scc_metadata(void)
+{
+	test_ucl_scc_metadata();
+	test_usr_scc_metadata();
+}
+
 #define SNK_ENABLE \
 	IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x01, 0x04, 0x03, 0x02, 0x01, \
 			00), \
-- 
2.49.0

