Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805336C9EC
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172030; cv=none; b=KRQVUtVPy4+0g5isdaNXsCPGaKwiisTo+vj5Y/oLPzNNRWsGJQCZyfNE51h+bzbO/xoX9AKVHg3hL2+cUyRaSdnUmQZW2wlUPSTClIhG/jW2ZLIMq44fki+C1eo/gPr7gh9EefgfV8hyC5L3D7IHr5xCM/eQj8giu45nejg/cQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172030; c=relaxed/simple;
	bh=UPa7sWgF15wsmiTaWg2YyNk8F69FjAtGeWcoFQWicLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiFm4kKwbycKfZVmNFou9aGyzhs+VgXuxMhwj1HT+WTMDerOfvMNlXHlS5zwQRlXG7sHdnmSR51Llwb1SUMqpcI6YhPgb5QWLTWOzWKoy3L2TKUyTj9v0aIsKMUko4QNiioFjg6JzfkOtkiM8MgnQwrZEV77gOYYzETSfBHMe4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0Kvh1B/; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0Kvh1B/"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c3163a88a1so640842e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787172026; x=1787776826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EQhUeHGZS+GWINOrvMwhsFvDuB2bVJ+3Fw7ksN/E/Xg=;
        b=e0Kvh1B/bIPhcs72snvhx+nlvIYorV86QXDI5VDEcl/MloMn5jk3bFGNh0nQPP7DcQ
         rudS33bG7INLEbI4cHhiBISmYmRt+2CR4YO5hC2PzX1uVK849Kf0D1aiVbjRGVAlAhfm
         pTZMddMWjvbewQO/0BRRRCvlut2ggRG8dBViNkP0PqNs4TRxizcBxNw5St5Y8s0JaCzs
         G2EK/hmnkj76hRxAzo/uD6Nwh4+33kaivEWjPSqWi2IC1HNTwC11S6ROx4o8C4dUc+Hk
         aYYjPwOJ0AXpfXrVDY/xrZfFz6KoNmb5rmIZ53jekT8nmdiLHwPvotccTbiWWF2uL0wP
         j+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172026; x=1787776826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EQhUeHGZS+GWINOrvMwhsFvDuB2bVJ+3Fw7ksN/E/Xg=;
        b=XotDHlJzYRBHN0zHnJKGe+LfeX7ZL5R233P9XXuyZBTIbYCa3LP5Vnt8YT1h3eoGZi
         9s+WFzsYiif59C9OIrdeYtOui4Z/sr0kgrGXHVSMELxPvkGQLBLFVdzYVpmFDUkEJoQR
         6JQBU+uu5URrdD2yqoRfLyOESfMxD8xW7v59iXhMidrzrqBwwlZgYwhPHhhf0TxFCPc6
         0t/0OMkiI9McrXOQ1j5kORIouVfitrf0tsl5F7yRID1iUXTX6GgkbU+ZgUKpqQYwLXQc
         YDgMiniina05eHKR149Vyk1vFncyYUo3i8TzgF5Ug7NDLt4Bedi9SCnR7LO9Dkz/5hKD
         EG1g==
X-Gm-Message-State: AOJu0Yx7ytQqktABUkgnM2Wi5rKE4cp4DtNxy9Y9UmZT5P7uY6AOGhZc
	vJ3j8MVOqcBwzOuJ1p3vv/PkzR/bgtqSOtGqI2Atsw89Xj6uniCCx5CFj96VJLJLoWvj7Q==
X-Gm-Gg: AR+sD11kv7szAQJqMWVh3Ac3xOYmlgb4KOfhdIk9sa8nxGk8uY9WIq20UvK9LoAMn/5
	CyQDS3LM1Js6c1CwJiLcREho7EVgEkfH6Dgkidk8y/RdVkZTxo3x4NJLYmoVVFZXqo3YjJ2TWmj
	rFl4BZbAgUdqs/6HtXHWMg4JUXrCOW70+/WPNQV4QSyw1cV7UsPgPGQtccdKUEvttjfg247vxXi
	dAnNC63c/h3tmYC1skBXxaY3hRuGWyiwEQQbrt1pZ/ODqJl0szVwUvgTbb5jFXwRFawO8rM3vzK
	3kStOmvscUaPcFAuIs+MOpYCC2cSXag4lRkVIpqo4RqVTI7LZSjO1neqeRTlL9vEi2Lw8M12bNq
	6iTDPdeNYcGvYS7ArbXf2hFWDKS8DNbjcci0P4lINgO3iQIzlSaFLO7EVg3FD0e7TGpKFLUczYm
	Y9Q9C6WlP0bn/8aoO+SJnZa0zyqjbDie2ew5fOaAUtjPle2SxE7VKyippHCXDwKe0WIhlUhoPVc
	0BUU7a7Re3tH2D/dI3udNGsphNFlzKZj+CamNMB2ldQl7i4eO4jQR9xcmsgwW858Q==
X-Received: by 2002:a05:6122:3106:b0:5bf:9bd1:791 with SMTP id 71dfb90a1353d-5c5e3bbc48amr2863542e0c.1.1787172025743;
        Wed, 19 Aug 2026 13:40:25 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2486864sm3496404e0c.0.2026.08.19.13.40.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:40:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/8] unit/test-util: Add str2utf8 tests
Date: Wed, 19 Aug 2026 16:40:04 -0400
Message-ID: <20260819204008.2292225-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819204008.2292225-1-luiz.dentz@gmail.com>
References: <20260819204008.2292225-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Cover the cases str2utf8() is meant to handle: well-formed input that
has to be left alone, whitespace stripping, input that is not NUL
terminated, and the ill-formed sequences that have to be replaced,
including the overlong encodings, the UTF-16 surrogates and the code
points past U+10FFFF.

Also check that a maximal subpart is replaced by a single U+FFFD rather
than one per byte, and that the result is always well-formed UTF-8.

Assisted-by: Claude:claude-opus-5
---
 unit/test-util.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/unit/test-util.c b/unit/test-util.c
index 1672b32eb39c..f0b1bb7994fb 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -83,6 +83,85 @@ static void test_min_max(const void *data)
 	tester_test_passed();
 }
 
+struct str2utf8_data {
+	const char *input;	/* Not NUL terminated, len bytes are used */
+	size_t len;
+	const char *expected;
+};
+
+#define FFFD "\xef\xbf\xbd"		/* U+FFFD REPLACEMENT CHARACTER */
+
+static const struct str2utf8_data str2utf8_tests[] = {
+	/* Nothing to do */
+	{ "", 0, "" },
+	{ "Pixel 7", 7, "Pixel 7" },
+	/* Well-formed multi-byte sequences are kept as they are */
+	{ "\xe2\x82\xac 5", 5, "\xe2\x82\xac 5" },		/* U+20AC */
+	{ "\xf0\x9f\x94\x8a", 4, "\xf0\x9f\x94\x8a" },		/* U+1F50A */
+	/* Leading and trailing whitespace is removed */
+	{ "  spaced  ", 10, "spaced" },
+	{ "\t\r\nname\n\r\t", 10, "name" },
+	{ "   ", 3, "" },
+	/* The name is not NUL terminated, only len bytes are used */
+	{ "truncated", 4, "trun" },
+	/* A byte that can never appear in UTF-8 */
+	{ "ab\xff""cd", 5, "ab" FFFD "cd" },
+	/* A continuation byte cannot start a sequence */
+	{ "ab\x80""cd", 5, "ab" FFFD "cd" },
+	/* One U+FFFD per maximal subpart, not per byte */
+	{ "ab\xe2\x82""cd", 6, "ab" FFFD "cd" },
+	/* A sequence cut short by len is still one maximal subpart */
+	{ "ab\xe2\x82\xac", 4, "ab" FFFD },
+	/* Latin-1 text is not valid UTF-8 */
+	{ "caf\xe9", 4, "caf" FFFD },
+	/* Overlong encodings are rejected, C0 and C1 are never valid */
+	{ "\xc0\x80", 2, FFFD FFFD },
+	{ "\xc0\xaf", 2, FFFD FFFD },
+	/* UTF-16 surrogates have no UTF-8 encoding */
+	{ "\xed\xa0\x80", 3, FFFD FFFD FFFD },
+	/* U+10FFFF is the last code point, F5 to FF are out of range */
+	{ "\xf4\x90\x80\x80", 4, FFFD FFFD FFFD FFFD },
+	{ "\xf5\x80\x80\x80", 4, FFFD FFFD FFFD FFFD },
+	/* The last code point itself is fine */
+	{ "\xf4\x8f\xbf\xbf", 4, "\xf4\x8f\xbf\xbf" },
+	/* Replacement and stripping combined */
+	{ " \xff ", 3, FFFD },
+};
+
+static void test_str2utf8(const void *data)
+{
+	size_t i;
+
+	for (i = 0; i < sizeof(str2utf8_tests) /
+				sizeof(str2utf8_tests[0]); i++) {
+		const struct str2utf8_data *test = &str2utf8_tests[i];
+		char *str = str2utf8((const uint8_t *) test->input,
+								test->len);
+
+		assert(str);
+		if (strcmp(str, test->expected)) {
+			printf("test %zu: expected \"%s\", got \"%s\"\n", i,
+							test->expected, str);
+			free(str);
+			tester_test_failed();
+			return;
+		}
+
+		/* The result is always well-formed UTF-8 */
+		assert(strisutf8(str, strlen(str)));
+
+		free(str);
+	}
+
+	tester_test_passed();
+}
+
+static void test_str2utf8_null(const void *data)
+{
+	assert(!str2utf8(NULL, 0));
+	tester_test_passed();
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -95,6 +174,10 @@ int main(int argc, char *argv[])
 			test_cleanup_type, NULL);
 	tester_add("/util/cleanup_fd", NULL, NULL,
 			test_cleanup_fd, NULL);
+	tester_add("/util/str2utf8", NULL, NULL,
+			test_str2utf8, NULL);
+	tester_add("/util/str2utf8_null", NULL, NULL,
+			test_str2utf8_null, NULL);
 
 	return tester_run();
 }
-- 
2.54.0

