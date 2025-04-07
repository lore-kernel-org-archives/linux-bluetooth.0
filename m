Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F01B87F0
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056111; cv=none; b=he8gLpKypWpcKdhXjZoZTSwCht4Fhsw67d2yy46Q2htMhxTpltl3dQmFXCJ8zCvmTHiVLxxl7/oIOmMzlgjjTccajQhwcAs3U/GnHJPPmhk++f6Gf91Hkm12PKd6Pb9ut4GvQt6/mB3YQ1/is8xLsS50U8VTTusjfPpfy4QJOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056111; c=relaxed/simple;
	bh=csyXIAGZsx/4/kbyX+yl4X0nadT51zQGk9f42m+3hFI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPKGIlEWU52yd/1jm4CTM6FEs2kcPkhsu5cwIVE4nXjdEZcjuF+c6WclIzf/KcQ5BP3+6X/IBSuFXzCh0Gwts4/GAJo3KsuQZz/C7kBavs0a8Y9Ney27HahyMUDP9zaKwQdtt7Gynqm109afXMzDSHNbl8MyHLj4DgaBcn9u7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCOL7vT0; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCOL7vT0"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5240b014f47so2125113e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056108; x=1744660908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abiJZqZPSgloceKnqEePK/H3ytaF6NiSgkualltBJX8=;
        b=jCOL7vT04sG/lKChlMg+fhHBPZ/67puFh9+jnhN6EX85WOQLM9Pk/xwYQUXe8LrMgw
         Qg8r8Avy2sWfbOeAJyh6vE2eWpIoatFlRwhnsZeJUI9NhzHZgkJIZBcxcpPVzR9aZjRd
         MzxwtibeNCBwyAvBtGrN1n8l4kKyqJDUn0+Apxjm3EetmgFiXbSJNPmAAgnYOvm9+5OD
         0AsR0MfL6jCxQuYRGan6V0PEq87dVmxXLxrTe7TRRa2fs3RpvF/7eN6bDUu7OtEcBKhz
         KCusY5WHUyVunScXFSpUJwMS1+hfRacZ1k7Wxfv2GDEuk/31b/DbWKOU25laCVTRBs4f
         krog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056108; x=1744660908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abiJZqZPSgloceKnqEePK/H3ytaF6NiSgkualltBJX8=;
        b=BYyWOeqQMW0rtuIzaiJnJ9XSMmLRTVxkLR748uyILy2dSTHuqy7qf66Z8izFKoRMfk
         BAab06L3aPkhSTlvUwMA+TCsIju2Z3NTJ1umPPooM4dnQuLRWlQpJ49frStcXH4DJEGA
         g3wYkMvEjzy7jLRXlxObqPtdQMUwP3MGO/n9REW0tI6vBHlKaOlpnfrNZ4Lk5Wtklxx2
         5IkikO+prY//EAjYDelNrLFul2QN4xFdynCrLvEQEspHUcT6v+HBw8cADmr/oG1Sp7u0
         0g4RyAp7xLKwJhpc5FmoRzJPhKp2GyOt3fTOaO3cuxnvXGv9nfcWuB0907XhyvmUBJgk
         YVuA==
X-Gm-Message-State: AOJu0YzAARqoqDr5S0snaFFOhOuuKxofuaa9U97kJKoP7b0ZkGgsw3i1
	ubZjQgwuf5wubLjMbI/r2g3Ee7y/P4Py6HXrlkD0PONho+80qIKl4gSTMk7E
X-Gm-Gg: ASbGnctpOg7xgvvhrZFUsBGPL9JUFOA62xZpSj3H5DncdI9GjI+F0MiIuN53/66IyeZ
	T3vxr1+0/jinRCSHq1d/2hVhXQb4LgMyZTmavFAUzmuPba0YzWnUQttgxdliUqV3lhKq/naUCSX
	B1kJr6UolHF+wR6EPSc4zIqtxLyhw2OQzYNQzaJqKcz7P1oEOgnP3ILcwjQVCeOp4bKoBEFVHct
	lYz4fYA6reLmKV1GtloERqCDoaER1SPYWDnDZrtm1bRY3c7dULFa3VFkdpnplllqvphCJqY5XrL
	RmL+5ZIdviMTyvIyeBJeLvuCVvR6qMREIdy9d04ouAtW5lcT7mtTQ+z3ozgIS+rEwzzeX6LfCLB
	4C5k30ILtLW+XbA==
X-Google-Smtp-Source: AGHT+IEW94Rxxu78ixBOn6SUaL6RJ1ze6R1Cd8XuZd/53w3moKrv7h6JKFzgHHKhUvQ+IE2E3Xggig==
X-Received: by 2002:a05:6122:181d:b0:520:61ee:c815 with SMTP id 71dfb90a1353d-527645b9e94mr10128888e0c.10.1744056105570;
        Mon, 07 Apr 2025 13:01:45 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/15] test-bap: Introduce USR/SCC Enable tests for LC3
Date: Mon,  7 Apr 2025 16:01:13 -0400
Message-ID: <20250407200124.881534-8-luiz.dentz@gmail.com>
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

