Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B74225A5B
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795619; cv=none; b=hF/Y4Yp2upIsxsCOrRQQ8Rj2b5aI/8pg69064NkH5wN6vufsPm8xqglQkMKKP9TCZkwKG7GgIZTM2rMNCWh3IYWyHqoIM/09jOvSe7gdaVyR+4PEL08eDUPAEkyd1WNKByrB7S8VOccvvHH4jfufQrVR5pttX54ovbBInNQDsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795619; c=relaxed/simple;
	bh=csyXIAGZsx/4/kbyX+yl4X0nadT51zQGk9f42m+3hFI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQU5KWXO0Ss4UelEgK9v1E2+EWJezJ2/rLtdyzypgiXh02JZPD3GRUYmT99daMjsW3WgxVIk1gWrJOavWx0+Q38YErxuYyJ1ApPDW4zrFu7oZD2MciBQvkWv/1Wa9ivzbSBynC0/iT1/aF5+tqiB3/sCcxAqBguIOiidbV9p+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1tg/wz8; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1tg/wz8"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d377306ddso1102589241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795616; x=1744400416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abiJZqZPSgloceKnqEePK/H3ytaF6NiSgkualltBJX8=;
        b=H1tg/wz8NqjitzvR7toU7P8NBFvnMXxMxSBwauKxb/S5IG6dEFYAXLGhe9qN731FNT
         I6fSfEKnyMc47GIbwwUSXt2uoaUGsXP3KGc2Y4/PevKF3IyqNPMBcD9p8lX+Pi0NtCdM
         6id0Kq3fa98btl1BG+ffgUZ/vjohMrwQSfOiaaTTI0sb4vF0fvqIwjFpn7/BEh788OgU
         G3Tci898PXUV2iDO1tp1Yh+GfCwr+dTK4dqK4y/wJuESS0LGH8V9JMZduARxVLvNHGNV
         LzoCAodfIQQ6b9kECbWloQ5dhXMIC+CJ+H2mJ8MnDBfEOe4wMGVZ8GOGiSC1LaoPDRy/
         QHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795616; x=1744400416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abiJZqZPSgloceKnqEePK/H3ytaF6NiSgkualltBJX8=;
        b=GBq3zMlpkxNs+r7zAXD9BEmupMbYR4D9eZoTUVWlTa7a2Czcpi4yfbV9ttfK2YvIGV
         5UgaPSwR+b8wT+Gmqm+HTIYY9Fmt6r4W2QC/Xri6IFfTS3UHzFUD1xGg+68iQA5v3nC7
         ipq4My9GGRMOto9/YiZ58BtlWb5QOYfxK/+5Onb5C6tqGJw2BdsXO1y8lcwajQXBLQaD
         yw5Q0GsGio4mbZzkBUvPhHqoOQudKgXfUorT8zlRwm+QT+rA0FqosCo088PaXkPkqV25
         oXQ/PTLnjsuG+s73hPpdhQKIdAdzkbK7uZkCmFQ2Cp5BbWYndZCHmfxO6elkQi9XNbd7
         51VA==
X-Gm-Message-State: AOJu0YynBzKvE9tQw3cCvklAStCUWQDKxEu2JZ2nxL4wigVfVJRFAVZE
	CdR/3SZAhSPcuVCYPmBp3WhNEIr546JAmXiHosPCzP7N0jcs7huj8vuZU30y2PA=
X-Gm-Gg: ASbGncsmG2Ggz4uOce6H5jaP+0nLDIKU3G1v0fdGgzKqsCe22BH7xLWuogAiGQoXTaQ
	DtiVrW5syx0sJWLgARurrGiZtFq+tXymrZjb5ZjSlEgjm/O2ruiK+WISB2vcXiYv+r5x9ir9Pi4
	1kBCWeQ4V09sn3AFhKId3uR6GAaeUfBi+njNOZTLrQbbbB/9x29MQm9Fk0ZhXE8Xon9s1dYXhxo
	FOk++h2UMo23napd1IDJzha2WDhRdyOSaAz42dLOpmFHVJKGfkbV9osu+woSW6vmxI81WHldPuh
	EJhDZ4135cgWRbENN5xhcBGjnJ7hVNeSx1qQjUT8PjlX1LrzN+YLUasGq1cEhQ9qROkpwqFEmvW
	T6bGG7fS7MxS28Q==
X-Google-Smtp-Source: AGHT+IGaSSQPynYR3la62Ef29Wf1zndMcFBOH3HoprRP/Q19C0Rs8Vf/+6ZCNkCCheygeSZ1VBYf2A==
X-Received: by 2002:a05:6102:38d4:b0:4c1:a66f:a468 with SMTP id ada2fe7eead31-4c86378748amr602337137.22.1743795615828;
        Fri, 04 Apr 2025 12:40:15 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8738b1d352esm718587241.19.2025.04.04.12.40.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:40:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 07/11] test-bap: Introduce USR/SCC Enable tests for LC3
Date: Fri,  4 Apr 2025 15:39:45 -0400
Message-ID: <20250404193959.359008-8-luiz.dentz@gmail.com>
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

Unicast Server Performs Client-Initiated Disable Operation

Test Purpose:
Verify that a Unicast Server IUT can perform a client-initiated Disable
operation for an ASE in the Enabling or Streaming state.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic.

Test Summary
------------
BAP/USR/SCC/BV-137-C [USR SRC Disable in Enabling State] Passed
BAP/USR/SCC/BV-138-C [USR SNK Disable in Enabling or Streaming state] Passed
BAP/USR/SCC/BV-139-C [USR SRC Disable in Streaming State] Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 5edcc739b675..73dac275907e 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -3349,8 +3349,8 @@ static struct test_config cfg_snk_disable = {
 	IOV_DATA(0x52, 0x22, 0x00, 0x05, 0x01, 0x01), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x05, 0x01, 0x01, 0x00, 0x00), \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x02, 0x00, 0x00, 0x4c, 0x1d, 0x00, \
-			0x00, 0x02, 0x1a, 0x00, 0x02, 0x08, 0x00, 0x40, 0x9c, \
+	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x02, 0x00, 0x00, 0x10, 0x27, 0x00, \
+			0x00, 0x02, 0x28, 0x00, 0x02, 0x0a, 0x00, 0x40, 0x9c, \
 			0x00)
 
 #define SCC_SNK_DISABLE \
@@ -3378,9 +3378,8 @@ static struct test_config cfg_src_disable = {
 	IOV_DATA(0x52, 0x22, 0x00, 0x05, 0x01, 0x03), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x05, 0x01, 0x03, 0x00, 0x00), \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x05, 0x00, 0x00, 0x4c, 0x1d, 0x00, \
-			0x00, 0x02, 0x1a, 0x00, 0x04, 0x08, 0x00, 0x40, 0x9c, \
-			0x00)
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x05, 0x00, 0x00, 0x04, 0x03, 0x02, \
+		 0x01, 0x00)
 #define SCC_SRC_DISABLE \
 	SCC_SRC_ENABLE, \
 	ASE_SRC_DISABLE
@@ -3439,7 +3438,7 @@ static struct test_config cfg_src_disable_streaming = {
  * The IUT successfully writes to the ASE Control Point characteristic with the
  * opcode set to 0x05 (Disable) and the specified parameters.
  */
-static void test_scc_disable(void)
+static void test_ucl_scc_disable(void)
 {
 	define_test("BAP/UCL/SCC/BV-103-C [UCL SNK Disable in Enabling State]",
 			test_setup, test_client, &cfg_src_disable,
@@ -3453,6 +3452,35 @@ static void test_scc_disable(void)
 			SCC_SRC_DISABLE_STREAMING);
 }
 
+/* Unicast Server Performs Client-Initiated Disable Operation
+ *
+ * Test Purpose:
+ * Verify that a Unicast Server IUT can perform a client-initiated Disable
+ * operation for an ASE in the Enabling or Streaming state.
+ *
+ * Pass verdict:
+ * The IUT sends a notification of the ASE Control Point characteristic.
+ */
+static void test_usr_scc_disable(void)
+{
+	define_test("BAP/USR/SCC/BV-137-C [USR SRC Disable in Enabling State]",
+			test_setup_server, test_server, &cfg_src_disable,
+			SCC_SRC_DISABLE);
+	define_test("BAP/USR/SCC/BV-138-C [USR SNK Disable in Enabling or "
+			"Streaming state]",
+			test_setup_server, test_server, &cfg_snk_disable,
+			SCC_SNK_DISABLE);
+	define_test("BAP/USR/SCC/BV-139-C [USR SRC Disable in Streaming State]",
+			test_setup, test_client, &cfg_src_disable_streaming,
+			SCC_SRC_DISABLE_STREAMING);
+}
+
+static void test_scc_disable(void)
+{
+	test_ucl_scc_disable();
+	test_usr_scc_disable();
+}
+
 static void bap_release(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
-- 
2.49.0

