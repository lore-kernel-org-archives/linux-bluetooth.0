Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0262222C4
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056125; cv=none; b=LlmzHpNZhUxz5YCowCTBENjYTnwGZNktqjNdulEpSlwdG7qH7p621/zHZ4S6Jgs2TUa0OQFA+EUg4xyn7iTMX/ILbRFITCvNOAMckphoSjM2GwGKBsoTsTBTLeM5NjrhqlLKbXWzdfKXrTvlXN2s7g6y9R0o6YYmLClFJvxQRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056125; c=relaxed/simple;
	bh=CXLxyP410fRpt64ZOOLY4z3YvvSGAudaFdOL6DsKMPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZQ3q4Jrdvh0NMbAJprOpR+YooYby6yUWwTz0Ce2MBpag5Z1GjN8yHqbPjmuOh/lpfTjqkK96DgvuioO+opXj6mnnOiDZsYVEi8CAwC3vxM1TROmqrWJmjpHrvsUXQPhyByp9aRSeu8bHwlCHnhNUfJTqkqfD16JxWWjoFxHXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTjgfD4I; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTjgfD4I"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-52403e39a23so3856521e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056122; x=1744660922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8jttERukblywXwrKsL0Af2/sHwoQGtFPkhNzIFFZIk=;
        b=dTjgfD4IfLIkGYJf5x0gmjeo1NRoDkvyXmkdMYhjEhhKRdGU8vcjVbzBPslS0J9Jmf
         eA/T7/Jxawi1+7dSEalyZP4G/yCqyb4Y1PpXx17pTPKu8QxfIzkwZaZ/Nv6r/tDIxEmM
         qdwGQjZUdbtYRnVOFgdSS7afaWPNzICNuXgv2HlqCe2vSV5fjYwzQx+8of+Y2fJ5QoFH
         HZVvJad2CudjE6L/xaVfvHo7LPlTFnycmw7a6Am8A3r4LKuRWWuCaaiU8WSxoJL1F4Di
         5km4xE11T2exHyGyOIf/XyjHozNtL8NTHpwdkjnusjZdBBoHyr5uM+SOFLLLhIrtqCVJ
         UKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056122; x=1744660922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8jttERukblywXwrKsL0Af2/sHwoQGtFPkhNzIFFZIk=;
        b=eyfc+ORGzdDyiUgh+/fp+xly8N+x3gkwJUB1E8g3jrfIEap2l+DGG/t4IdTSw4yXJW
         grWIWJbxrhPs1MEUbCUj/5pg7GpbZbIEoZ+OEHLFLyz8kX0BroU57xWC0vv8/HC+g0iN
         fe6a7VTf8upr1kr1/6lw2t0AXLE1YKXVOeLdaNtMWld6Lo2cu9SUQXcJwGG+HI0Bp3Pf
         Lyv8tkdLZ2CgRDuZhzNBeoSqCpgHDf/aeZsxYIui3SSniurtMViSdzkkEV7WQvjF+tfL
         dO1BOMoi+ETDCX71lWgwtkBN+uokIyqALyY+upOjlULPKI/ns50J0yW48ta4oMFUH3jv
         Z9qw==
X-Gm-Message-State: AOJu0YyTF1L+9CJ7TsKHZd3JPDyO2vRj+TvXSgunZ8WI2L/WYw7dbsSw
	eTgqTwNBw82QGt58tgO5j02htB1WvcfxTCRX+uUTwNiKTLz3ICsBc/w9vmNE
X-Gm-Gg: ASbGncvuSiMOtlH+hScx+LzGtppGwOIvnP8zhh/Y3IH7+ZXNeI2p9m4OCYJuWMeXp4i
	kuCXOc/2KxpbNC8ISDAYaaNCpEhrEixZPj8EQGABbimlJtvYHMMkKmFrSKeFaR2tcTfS/qlZFkE
	NpBK+aVEsXa0uc4ei3um1RI2lvm+B72/aDKDXdDvFPEjqjnWVjoxTFdIsx0HJ6P+SHt5K57E7qO
	srUrzFapSK4NzYAH9f00O+SbDlCTbrTCQmJKAuJ3APbAniaJ+/ud2SmD241watWF5Hby/3FdEo7
	lbGszOP9tTEFVdJTM73QSocfHRYy48Msi+ITH/alrs4QHVh3Uz6SWjJ5IlJrUfPzFIrPIgFSzVd
	h6FRsos0Iz1Ogzw==
X-Google-Smtp-Source: AGHT+IHWIM8Bw5JCFV3YRtxf8uUjp4pVkWhtCKaSQZ+mhtE14wIBURSyFPCiF9nmCtu8z6wcKbr7Aw==
X-Received: by 2002:a05:6122:78f:b0:523:dd87:fe95 with SMTP id 71dfb90a1353d-527730aab63mr8137727e0c.9.1744056122306;
        Mon, 07 Apr 2025 13:02:02 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.02.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:02:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 12/15] test-bap: Introduce USR/SCC Metadata tests for LC3
Date: Mon,  7 Apr 2025 16:01:18 -0400
Message-ID: <20250407200124.881534-13-luiz.dentz@gmail.com>
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

