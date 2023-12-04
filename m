Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPLJV6xW"
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6456134
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 14:15:35 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4b2dc44d54aso437195e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 14:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701728133; x=1702332933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nilNZRtTQifRr2NjZFoVre08KbRTer2dFroHFKuf5O4=;
        b=TPLJV6xWWxhQATdsynfAiJW8XZGzqCSJNb6z8E1+zp61rqS9DiZOpHqGFEYE2B8nB7
         EOabWFPwM/jV506RWKa8RgYjXfwYAoKy0WwSHP1GoMrD5vi/A6joYV12WTzG1a5xt8iU
         fMys55HwY/vV4sG9vdUza6F590YNnoHaxb9Cc6dnx1EvZpJhDzpLAHLZd0qxAzJyWFtn
         GnMg6YVYEO5jBBxBE/YE7xSTjNbCbibcu9CkZkaFSZzFcO3EK4XhWfapT7pYbfdgP7kv
         9jQBfhcL4UzFPXJ5Jp5HfXTv3OcfKIw6J7AWrLP63y3vLDJ2OAEfItXCzL8KXD7v+P/c
         wRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728133; x=1702332933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nilNZRtTQifRr2NjZFoVre08KbRTer2dFroHFKuf5O4=;
        b=ddFfqCcgBymZ8/I48+A0aAftL6d4cluk68JXlObNHwjewabdeiyw2GDNIMrDE2BD3Z
         bvpzrVfjoWi7RU3iP5hOVjdvPGRyhqX00ND99+5cjFj6czuRtIZBjWD0JHxAy4+4cb4u
         ut6JyOQnFVXK4ZfsXeeYkeDkLdDJ9dJwssMVSDnqs0yMNds+gh6Onbgqkw9BHYUhIoFg
         pkT/UrrdhOBAvFPKIkJABE7yQMgKQ7tBhieHEHPE0Mxh44bOO3yvT76fl5ZJa/p6rsc7
         Vi9Vy8BWw/2E17bphjeOdBhFW1kjLDFqc3CklJ1o/4WeVHCkavaM6LveKtuR1yaW+Iqz
         OqSw==
X-Gm-Message-State: AOJu0Yx0GIHv+e2MTH/cTqM/5cRQnAXbnZm3Tb9tnwGwUU62bECXLo79
	Vmgf2nO6hfcKOEuP0iogysUSK5AYW7U=
X-Google-Smtp-Source: AGHT+IEi2ONZrbxPxfbrSjURjouv4lco3XPthQuxzipgk9LcYbLxcv9lJUeIRpgxcG5s8QbaX/f5Qg==
X-Received: by 2002:a67:e9d7:0:b0:464:8402:70e5 with SMTP id q23-20020a67e9d7000000b00464840270e5mr1839940vso.54.1701728133480;
        Mon, 04 Dec 2023 14:15:33 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bl13-20020a056102508d00b0044d4e63aa03sm1136612vsb.25.2023.12.04.14.15.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:15:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/8] test-bap: Add SCC Config QoS, VS tests
Date: Mon,  4 Dec 2023 17:15:22 -0500
Message-ID: <20231204221527.2990674-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204221527.2990674-1-luiz.dentz@gmail.com>
References: <20231204221527.2990674-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

4.8.4 Unicast Client Initiates Config QoS – Vendor-Specific (Page 46)

  Test Purpose:
  Verify that a Unicast Client IUT can initiate a Config QoS operation for a
  vendor-specific codec.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic with the
  opcode set to 0x02 (Config QoS) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-099-C [UCL SNK Config QoS, VS]        Passed
BAP/UCL/SCC/BV-100-C [UCL SRC Config QoS, VS]        Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 303388e35c14..fdfedde6b965 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -2146,11 +2146,54 @@ static void test_scc_qos_lc3(void)
 			test_client, &cfg_src_48_6_2, SCC_SRC_48_6_2);
 }
 
+static struct test_config cfg_snk_qos_vs = {
+	.cc = IOV_NULL,
+	.qos = QOS_UCAST,
+	.snk = true,
+	.vs = true,
+	.state = BT_BAP_STREAM_STATE_QOS
+};
+
+#define SCC_SNK_QOS_VS \
+	SCC_SNK_VS, \
+	QOS_SNK(0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, \
+		0x00, 0x00, 0x00)
+
+static struct test_config cfg_src_qos_vs = {
+	.cc = IOV_NULL,
+	.qos = QOS_UCAST,
+	.src = true,
+	.vs = true,
+	.state = BT_BAP_STREAM_STATE_QOS
+};
+
+#define SCC_SRC_QOS_VS \
+	SCC_SRC_VS, \
+	QOS_SRC(0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, \
+		0x00, 0x00, 0x00)
+
+/* Test Purpose:
+ * Verify that a Unicast Client IUT can initiate a Config QoS operation for a
+ * vendor-specific codec.
+ *
+ * Pass verdict:
+ * The IUT successfully writes to the ASE Control Point characteristic with the
+ * opcode set to 0x02 (Config QoS) and the specified parameters.
+ */
+static void test_scc_qos_vs(void)
+{
+	define_test("BAP/UCL/SCC/BV-099-C [UCL SNK Config QoS, VS]",
+			test_client, &cfg_src_qos_vs, SCC_SRC_QOS_VS);
+	define_test("BAP/UCL/SCC/BV-100-C [UCL SRC QoS Codec, VS]",
+			test_client, &cfg_snk_qos_vs, SCC_SNK_QOS_VS);
+}
+
 static void test_scc(void)
 {
 	test_scc_cc_lc3();
 	test_scc_cc_vs();
 	test_scc_qos_lc3();
+	test_scc_qos_vs();
 }
 
 int main(int argc, char *argv[])
-- 
2.43.0

