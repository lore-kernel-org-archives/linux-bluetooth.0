Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB68221D88
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056119; cv=none; b=Bf74W65sN4breg3D2wuTQ+1d8ykrkGbKssgNordA87PzzQx5XVESUcjJihsyWRKthv2urTdg/gCkLlybtYExUsUSVO7YfQS2fUdr8IYgPl/mHsIwEn1N0des6IUv8aF+VBk0T+sidVJYssVSjZg3qeg88+dgu8tv/+PYNKkJ0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056119; c=relaxed/simple;
	bh=sUscmQJlqFR2lS0AjSQV2lEVK/T+ghgD+cWQTpeyb20=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbsaveMyaAgjPviUpFqCPa4/49xLmoXOod+Qo7oRBW2AFuu/ZpOhxTA4/Ie8CKWJ3hJdGTw2Kb8P9rame+EYY29GiWX8pgVS3RBgmmeNPAu5unlO1SyK+PiqKN7JIUIOHjJ0QMwsel3M9ovbbWiS86R/PyI7QAZghWvgyIt5lCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INw5KEzW; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INw5KEzW"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-52403e39a23so3856448e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056116; x=1744660916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjGAIa1i+etugNmeAp6Vtd5kmpIXm+DHp1189Qjs204=;
        b=INw5KEzWWmZebAdwrG9jL/5gnYguxkisa5LVapUQjxFQKacN+6W5uPbJZytwJ2o15N
         b1XdOpmkv5K2tP91Hr7/hJ7ExNT/dALsJ+1wN3OZsEfmAtoIHCjnFAV+ZVILqmmkVNd8
         WvbCfEULEVcsQdlhKfldo8CpA8BYrVJo/l45BZ0AkrB+jcmL7eMwoHmOooOqFops26mi
         ZFOgaiXKPQg5UISVhtP3g5Crrzpm/InbAKAUSP7u9wigDTVOoLniai6ngJNSpolIV2lK
         SbwtFlnN7B8zHm9kYEwxLOSRcqX0u7zCwzn4ppYeMUKyvaB/AndIFVtCpBqMmG5uGRvf
         biKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056116; x=1744660916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjGAIa1i+etugNmeAp6Vtd5kmpIXm+DHp1189Qjs204=;
        b=xEJYbAR5mbfOOeXry5MkAiwiwvRRmBl/0pWP1Vx0KrIZnHNeYvC8a/CDwBes/cz3qB
         3UDs+mZqP1NG4zOtf+eAxzyGJGGXqpIPUhTi/EZNuGuqB42e4VaJgoTe7Kd7bohTE2Ry
         lCbGX3dqyuUse9ub2yDS/wqAM5hUZ2qR3rqYllqEb3dpS7aMuUCV9oZhzbz/KxvhGlPq
         +8a471PWpFS4XP0RBI7LoCjbwdeBMLWrpiQrmukpVzDkWLd8YBpTSUHdSGZ/+dro06A5
         oVHYA0c2E0lBG8Z4WEJwO8vkr+HFdTRwgx8Y/tEDeLEgW5Jaeh6eV0IDzFFBCI5/I37c
         wP0A==
X-Gm-Message-State: AOJu0YwaoBp5xu3AqtQSd+g0y5jWAuRhiHmHt2nChfYqxpGgYojX3lON
	iN+I/MO+qbghj7jNjJSx2iaFvehXJCbJVRhqSoU6w95w1+FfbdAZNk+dItZB
X-Gm-Gg: ASbGncvLD5BsAF8BXlpKEZseY9tshvKGxgtW2rEe/ymr8FbnJB5TS6Ky10SG3uU5T4S
	qZYaY9STvj2p52tGpKeX6owJhLoyBBoekWwCQ8xxuOHQdA5UEKp0g3XFxiKupOy8Hx57cmvLD2t
	NNVU89xwuCScKc6eTwFRIg21ElMv2gSs22PbVVwzDdWnMsiTQ+5xlKard6vW4jwjixhS3FjVt79
	WNlYVdClnib+fZYja8pW1ivrhncBFR98x0pT967L/O5vkeu3S1FlsvsvrsclOa9j9CTMbe1QF1M
	9NIT9Q52GyCk/T1b7xPmWI7yymMuKKFtl668AolLKmExFzFufekGn55mFtD42VfD4vRxrOuZu6Q
	sP/sGkPK0wttVQg==
X-Google-Smtp-Source: AGHT+IG/iAfQ5TO/cEjYNH6tMyAh4xRYPykhvqTh+LIOnMIZM51iXqoshiCD6WRnsmMtA69yubMBnQ==
X-Received: by 2002:a05:6122:251f:b0:520:61ee:c7f9 with SMTP id 71dfb90a1353d-52773051a54mr7824333e0c.7.1744056116230;
        Mon, 07 Apr 2025 13:01:56 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/15] test-bap: Introduce USR/SCC Release tests for LC3
Date: Mon,  7 Apr 2025 16:01:16 -0400
Message-ID: <20250407200124.881534-11-luiz.dentz@gmail.com>
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

