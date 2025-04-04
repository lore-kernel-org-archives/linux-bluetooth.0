Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5B22538F
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795616; cv=none; b=O1RE8rcK8sg0CKlHcDO/iWpT8cAtswISXLzHZRMi9XG/IJfVlM1psdfPIROCNtp7Yo2EjW8G7mtSe85hMj/tEqQ1gETj4brQIzBbfnka7PQW4L7V8nX87D2eNu5pP3p6pdU5FVwf2lMT+C9fpX0mHh+P7hir7g1CEMH8yWC1xAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795616; c=relaxed/simple;
	bh=k4mTeg3N2nFLrcmIeFZW+iYlyOpN0M4pQPLjJ92/wXQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL0xEINxf/tuEgj14OztoH444aEcPmSXXb8URtQWIYXoB+4OfI8pZmZRNFKKwya87eAWBm6AkOX3a36S03q0Tz71iXj/cHz353TwDJ7hAuQ5EQvxCx+CUbfWSoRsw1lXj2LW5l94o0qEuma5cvam9v4p/av3D8v7UzNgn+eS8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwdihDRJ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwdihDRJ"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86d3805a551so1090492241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795612; x=1744400412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVaX20wo7w1Y3NZXUbSGU27hwlvxAUbfzuc80lnuofE=;
        b=jwdihDRJyvGBqXlorF0LfqwH/50W8Dd9QlgdTgXfS/Fc1qVEHjexgx13XedH6nMLtm
         1CPtS1ZmdGq+jlvAcUlgD6S8NIolCXenuRTI/+oFd9Eiv9itmBYKq2la/jq/hzN/QwjF
         KUbhYPNirHyvpTRlCfPM5Kftr8KihI+6c5wfzfJ80h3WSOZdGh/AkJbEKh1DlkpEp8Ve
         OsdGM0olb2o/HnMnTRgY3j+M7OGr4UMyJzK/c5Ob6LdqACEsu7bZ7ofFNadpkwskB2+9
         1Q0jF/7JxsqAAIHaU6GHDPhCFgEez4TUV1NpYN5joPLvVjPZgqkl+AzhxzVQ7sd1CMfu
         5QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795612; x=1744400412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVaX20wo7w1Y3NZXUbSGU27hwlvxAUbfzuc80lnuofE=;
        b=GfpacfGao6je9iZiRpqr69Kq+D9RH26IAHLDneEXUy+Zn8snO8F3uGrb0Cb1XkFdkA
         3CWQr4QR5Ky3ZMp6fntNYGCVA2+orlgfbrX4+C7dhg5jwoABdV2mn4E1LaBJP1lwi7cf
         Mjhd32sWvbzwgfUxJGKFNqDsNdK5ZbyQMqJsVdwBzCEePf/d035moal9lwcoksnh3Ni8
         im1GvG2DQtaARsqy5H+DDTiRd25egtPNV/kFOeZBeoWBR1LJAo/JAVYc8PhTbjLzrZUg
         A4e+Q99dbg8B1cq1wjKEgq8V6jANGNvJ0NDcf/dVEMFzuiaO5paJLBXFMjC7ro6+eoK5
         0B0g==
X-Gm-Message-State: AOJu0YzqzC/+XLpj/x+hr9Z03YgK65FoLJ/opqVO9mY9emWFa0OtMOZz
	wpY8Uga+IJw/uZOXdZHhGHZHvAnrALOavG13yRyNfDZdhFByqkFkaMBeFjzDOtA=
X-Gm-Gg: ASbGncs9Ax2ACizZQOL4ROhrWfYQQtYMzKSe+GWxzg43h4VgXZwJlXs5O0trN1bvPW4
	ueA9VgaByskFZ/gemy+Rfoh8p9QO8mpqljZfnVikBpdnwfn3YIX82BecOQLgWsdh2zctfsCTSvZ
	o0ckrMYAyS9fQY/EzJKW+gyOtJD1+/buaMznopgq0ZaRWtBfrOfV3SiOJA2AZllKmLdoa3ujY+K
	2fyVclzK9tr7DwxIXNn81xnUGQDyNPc0I+QjJI/EEEIbPp43ifAxpKwhWMfKhEF/7FxFGNfcFwz
	jPwPYuFW20YFsAe0DOaO4Y3vM38Z512IZvmfo41tsKKCiitYpbmCaiz+QtdxxXSNjXssW7k2h2G
	trzX3xDrCeQ+dsQ==
X-Google-Smtp-Source: AGHT+IGe5Gk5lxTsw2zZ0Cgd1jzYbcQjaudNcjfd0Mz3vCwJCj4q2no3OlfRjzLYaAQDFFsf13uIYg==
X-Received: by 2002:a05:6102:334c:b0:4bb:d7f0:6e70 with SMTP id ada2fe7eead31-4c85537fe64mr4065280137.5.1743795611989;
        Fri, 04 Apr 2025 12:40:11 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8738b1d352esm718587241.19.2025.04.04.12.40.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:40:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 05/11] test-bap: Introduce USR/SCC QoS tests for VS
Date: Fri,  4 Apr 2025 15:39:43 -0400
Message-ID: <20250404193959.359008-6-luiz.dentz@gmail.com>
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

