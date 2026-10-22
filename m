Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684034;
	b=16j0Z7UF0/qzc5GHsx2z89jleCMJ9B1cOmRq2zTSiWQ8+cq+oufRxs98zvcVF8KUIQ8f
	 ypcXNuWUF1whbbDWKhVZXJCg3wGXdLq9PGxc81cuJpGtnIK7LELfVUxPrQwp9BeyfyAxJ
	 z6dII1tPe0J98+zWhj8s8Noz+1Ie2If5GFH/dArSK15Mx2/OPOnAvLtWtkD7MbvjFflZv
	 hNphbHbUgK/F6TsppG9IqhVgtecum2gtWb3gM8vi5eKtOkQITU4c3WfC+cJ+yqLF1Ira2
	 f+Sikgm68fUf0F3hjmm+NA8N4drCyqcA5tmRiBjAKlzNnBGH2clWsMiwSz9okZ+eSyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U5RGx/SFMKAAIp2V6O9UsgV4zKkxpfr0MDirAub5cMM=;
	b=aFbrRbgGivMFFOysMIXN6QRqxLu/N6Vqpfg+vimRZAVUx2mxE4eBWikD/jnocNkVH+sm
	 JPEC/+SZUGRpmtncXnfPD5kA+jpWl7rFaSsk5BGdAHWmrkdylIHlxailBQAdaJVsJXCH3
	 JZ3uS/iCUMTGkS0SQsrfKU6MjyJ49OO4GOVsEZf/V54PElOy8apewWozTxx7cCRLrsbpJ
	 v3RklY+s3A53a+DOCx/G0yem9YM6ct/1LvTvuXQ+YGBKFxWtE/jCRPy87W77pOHjqteBN
	 suBgq4RVe0jTrIPpn/TmiclmGQzBklgSAuvMpGY4zUoVBA7rCEwr+ZH9HDQv4LJN+UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nB01DACM;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBD606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0DBD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nB01DACM
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so3362e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684032; x=1793288832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U5RGx/SFMKAAIp2V6O9UsgV4zKkxpfr0MDirAub5cMM=;
        b=nB01DACM1HH7CTlV3cj1X5C8uE6Stdxogt20Bj2yq+5YhlwinrASr5xDSrTl3oPjuY
         csp7OAX+88C6LotcPZaoCTLB6RmG0U66DWUyklSzQTPo/PJ1hOINTiQLza9fKkxRufNO
         qDZmSj5i+Qj+J/uB7hUtCootBIgE3DGIYvGxMfGLR1dEodeLdV9Y1OI2zME1/Ri4/xmx
         BSV4rsXRppn1ntrw0Dv/E5hJ5s+RTQ2+hCwEHaVlolEiRcTdgW1ra6GCHefk9wsSrIJ3
         fWO/CE33C41vtuMnGzaOCFeHozpmBZKbolTHx/5s1Alja2XBN8l8aHjJ7IZHgQof/R0C
         uODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684032; x=1793288832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=U5RGx/SFMKAAIp2V6O9UsgV4zKkxpfr0MDirAub5cMM=;
        b=2LXYHFYVWzFKyVcIhc+H1/gmFg3jpyFwHBGJetyVa0Jl6Fm/WrGcFXVb2vCJLaEnax
         x0dm7gPsjTU6/gwnLCwzoFOJAhupComB385rUP0de/Urgd4ja3U706/zKkhcqGBGdNGL
         FIp93YflbKTBspXHeILGO4jH5SBtEI8YCkroO/tkTZ3qhCsd0z2ro36WVhaH91U6NJLb
         5KicTYVXbYycDKAHZ1LzKglp0Sy8tI0BSxJCVY3xGkvp1mP+GafecgvbApXO0neZ6nM1
         JMIDQAfHECSP80aKV7RAnuqzpj8V6qwDcL8tsos2aYd4YRu3CUwgX2liknS981YzgL8Z
         NHYA==
X-Gm-Message-State: AFq9FYIJXPIQX5t/V1bmu9HxiZ62dGBuONkaudceSWJ+DGWx8g1V96aj
	ShE4Y8ONVS+Slm5C+nsj8FbGqZc9Dp1+ZQJEAk+PYtpGtWDDnA1iBpCvMBQndCqQzGo=
X-Gm-Gg: AYBFou2LL/PTQcASRb1ophFp5KvH7lOG9PDW0Ew4yYQXHLACeunjt1Ny1+it2UI3lib
	yu3FhVbJJFAVdWsAmGpGliSiKbYVl7cI2pJ/IYFt9iWCGmgUapbWTvjx5M5xkvATWTOUNXJ/oh1
	Vn7DdegpWU/ZynXV2cMZFXugQ9ka2pBrAdAnL/35HVkVsArLEtXqIOsYxcmpZGpyAq3dT+vWjP+
	577i3CrHJYgFwVOMKNPgLLOv/wcV8xJfYQ1ys2BoNxM+E7XV7r58PLskwzDBXgf5l2Npk/GSsBO
	7Z6+Xkmeicp1pdHJOW0NLb4hs0rDioNnjLStm9rllqTjwognIen1RnKfV1OvRgRyPTUnsAzyd2Z
	MGyUcOaMmreVVgZdLtujZ/EvcJZNrlRmGbkHeqp8zcSr647noKppi7qr4qvZGW8xS0C7IrzfHGN
	2g2mmMmBSK3DKGv/e+B47+mCQa2xDyQ20uDips1szYmpaMIkCY8ldioaUqSHCNYyT3NcddP2ZA1
	0SKVSo4Gt02uFfqbZI2PCNHlT93ldnOjpkcB23PFkIOeXDg2/AqYNz2Ema+hZ6GfRJc96XhRBGR
	q4vFUl1TX6by+T0bW1Lq9L9gvq53D8+OpuUaTpsWH7LDjQ==
X-Received: by 2002:a05:6122:3122:b0:5ea:db3c:4a3f with SMTP id 71dfb90a1353d-5eaebc14cdemr2518818e0c.2.1792684032504;
        Thu, 22 Oct 2026 08:47:12 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 02/27] shared/tester: Time out teardown
Date: Thu, 22 Oct 2026 11:46:35 -0400
Message-ID: <20261022154701.3959500-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A teardown with no timeout blocks every following test if what it waits
for never happens, e.g. mgmt-tester waiting for the removal of an index
the kernel never added since the controller failed to initialize:

  Set Low Energy on 6.2 - SCI Setting - test timed out
  Set Low Energy on 6.2 - SCI Setting - teardown

Give teardown the timeout of the test, but at least 30 seconds, as it
may have to wait for the kernel to time out commands still sent to a
controller being removed, 2 seconds each. When it expires report the
test as timed out and do not run the remaining tests: the callbacks of
the test may still complete later, and would be taken for those of the
test running then.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/tester.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index eb2e923fd790..4065545793aa 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -423,6 +423,55 @@ static int tester_summarize(void)
 	return failed;
 }
 
+static gboolean done_callback(gpointer user_data);
+
+static bool teardown_timeout(gpointer user_data)
+{
+	struct test_case *test = user_data;
+
+	test->timeout_id = 0;
+
+	if (!test_current || test_current->data != test)
+		return FALSE;
+
+	/* Give up waiting, e.g. for an index that was never added to be
+	 * removed, rather than blocking for good. Its callbacks may still
+	 * complete later, and would be taken for those of the test running
+	 * then, so do not run the remaining tests.
+	 */
+	test->result = TEST_RESULT_TIMED_OUT;
+	test->stage = TEST_STAGE_INVALID;
+
+	print_progress(test->name, COLOR_RED, "teardown timed out");
+	tester_warn("Not running the remaining tests");
+
+	while (test_current->next)
+		test_current = test_current->next;
+
+	g_idle_add(done_callback, test);
+
+	return FALSE;
+}
+
+/* Teardown may have to wait for the kernel to time out commands still sent
+ * to a controller being removed, 2 seconds each, so only give up on a
+ * teardown that clearly does not complete.
+ */
+#define TEARDOWN_TIMEOUT	30
+
+static void teardown_timeout_start(struct test_case *test)
+{
+	if (test->timeout_id > 0) {
+		timeout_remove(test->timeout_id);
+		test->timeout_id = 0;
+	}
+
+	if (test->timeout > 0)
+		test->timeout_id = timeout_add_seconds(
+					MAX(test->timeout, TEARDOWN_TIMEOUT),
+					teardown_timeout, test, NULL);
+}
+
 static gboolean teardown_callback(gpointer user_data)
 {
 	struct test_case *test = user_data;
@@ -430,6 +479,8 @@ static gboolean teardown_callback(gpointer user_data)
 	test->teardown_id = 0;
 	test->stage = TEST_STAGE_TEARDOWN;
 
+	teardown_timeout_start(test);
+
 	print_progress(test->name, COLOR_MAGENTA, "teardown");
 	test->teardown_func(test->test_data);
 
@@ -629,10 +680,7 @@ void tester_setup_failed(void)
 	test->result = TEST_RESULT_FAILED;
 	test->stage = TEST_STAGE_POST_TEARDOWN;
 
-	if (test->timeout_id > 0) {
-		timeout_remove(test->timeout_id);
-		test->timeout_id = 0;
-	}
+	teardown_timeout_start(test);
 
 	print_progress(test->name, COLOR_RED, "setup failed");
 	print_progress(test->name, COLOR_MAGENTA, "teardown");
@@ -745,6 +793,11 @@ void tester_post_teardown_complete(void)
 	if (test->stage != TEST_STAGE_POST_TEARDOWN)
 		return;
 
+	if (test->timeout_id > 0) {
+		timeout_remove(test->timeout_id);
+		test->timeout_id = 0;
+	}
+
 	print_progress(test->name, COLOR_MAGENTA, "teardown complete");
 
 	g_idle_add(done_callback, test);
@@ -762,6 +815,11 @@ void tester_post_teardown_failed(void)
 	if (test->stage != TEST_STAGE_POST_TEARDOWN)
 		return;
 
+	if (test->timeout_id > 0) {
+		timeout_remove(test->timeout_id);
+		test->timeout_id = 0;
+	}
+
 	print_progress(test->name, COLOR_RED, "teardown failed");
 
 	g_idle_add(done_callback, test);
-- 
2.56.0

