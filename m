Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C080374198
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172034; cv=none; b=rD852slgbK6ZXCoS4Ruy2f+nuZ+RwBozAtzehTm9nXrg1J/Y0lJ6p9X5EiZU9n1nNVM1MJLwOgskysNjOaQc9IXL4QXm2dVCk9RZhGRYqX3v3P0Y4RqLkYzG+JeToTBViuKMO/55tryOm58XJVN5XzoqKCsu8qmW0NKlqGAIKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172034; c=relaxed/simple;
	bh=9hlHPMUSpZfSPV/kKGCmXt8+11ZbWbaMeWmI0IMSJ2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbDFt+5R9398+Wwg/gRDRmQ+M08u/60M5bBJ/qoGFJ77OndtzQY3Og9fdKB3C9cXHhCQ5Q2zT0Z5H7F4DkgPSgoRW5GkEJPq+raT+3xLEfFrUFvLZ+9R2oPok5pxHvSQ3hc/mJvCABVslTETD2LkhoAxIbIpqIvE2qdOngvSBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRgTmgCX; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRgTmgCX"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c375a9e76cso1002767e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787172032; x=1787776832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OeOSMeS6K++zfh8cn0//khtf3rsH7G0Jb/ibEHEW2CE=;
        b=BRgTmgCXyFLaRDj7PNt293jRJNwitGQ0jerwUx1Nc3BzAXD/9RBKh+otglxqOWEPLw
         T58AvdpShgjS/AG8s1Qs4+SuVxIdO9iD6fIHfxzDrLtcTy7M8CnJKHBZkIZat3EMkQ70
         RkmLI+rlnfwJCjo3z4ye3HgFjxbVGaQ+ZMeYuSIeblkqah3MSWvGR+f+I0cDqcErsMfA
         NMZJX7W31B1dIPfiPAblpwOpWsU30xb6nmM3Q3Jilu1q1uz3MuCNYey0h3FsLOMoktDv
         w/rNgS5JvFcz0HQIh4Vvozv4n/nxVwlTMPSvwXKC2ff3/qXqaK5QVKxJnXQJaWGqKWIz
         2gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172032; x=1787776832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OeOSMeS6K++zfh8cn0//khtf3rsH7G0Jb/ibEHEW2CE=;
        b=eR9XvVIlLX7RkFMLprEbgdGewf0Ew1aVh52av4jWXn8iAd+nSVqMcmlAA8KC0pHlTI
         XigVioWlpDX8X4JQ75f6X08BWSipuaHjVeHUFCjvGtPdrB4CHMVlCwjrWb3vVlvix3/p
         /7VnUXZc4rHlV+pL/U/1uKUxVkUTk6J9rGVtm+ml18kNNvyuX3VeAQlempZLLkI0q+tw
         Of7telY6xS15NjUM/J6fMm4KCGxsQN+vIDvdKe77AVColAfAjM+5hoisVFXAT6WnKuFE
         K1N2VexwxaZW4dNQP820aKvQB3eWLKVDrWFnbnc2mXOHngkFNsu3DJQVSt6EhzQJbNUg
         dgFA==
X-Gm-Message-State: AOJu0YzvvFY+PapktQOKzXRVAEdQ6PjNUR17QupWpbR0eLPe4iA83KET
	3MkAqztfNP3GbJinTxaCAMDOdUW/oaGIEPYoE5eMjswtH3Qwn83UReUtMRx51PJdr1qKyQ==
X-Gm-Gg: AR+sD13ibc9tJeY6VOwKKFBbPVt+DtZXpIV0tfIdTKT1JxCej+mH3EluPIzbB32WnhA
	pjgAdgoX/JdlwXPxwpCG+iewZiB0YpH4At7miVafGQ1NovA4Rh5TMv77wTrSfwrQEqKQeMkX2Hu
	FbT3/mhqvs02RsBY1fAEBUJxo2s1+0Awk7G2fTAB+KisVqedKQQDzJmtTE4HuEZKFcHzvtRi0hL
	Y242N9LudoeuuYMxYCOnQd4iKcofruSyi8H6PkF6LeJly+Vfp4CqsvRwv9OQFlXx+HKB4IfC1xn
	z92iRhLXj4qg/+U7X776j4UH1qC7Mi70eZS4Rr4sSIKIQTcezl55Sk5XPT240R56Unnv8jj3ZeW
	tbwuBIAaSMsVm6MrXB7474NerWWH/TTXOWl/ky9mop3m/kncDgzPUVvfHcmLQeocpr6wQs/wDKR
	J92mbjLuEzxE9rOO0mKK2BnLvesPzqNYiAD+A4J14SMdZM1dU3iYgCf9akgzhYLV2Vfmj5LVsat
	Oyw8uhL8WCwkXB4QDw8p2//o0s4s3e8LQQR4mh8PfbddJST3LyXKq0=
X-Received: by 2002:a05:6122:3309:b0:5bb:eebe:7ffd with SMTP id 71dfb90a1353d-5c5e3e4bd91mr3370996e0c.8.1787172031914;
        Wed, 19 Aug 2026 13:40:31 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2486864sm3496404e0c.0.2026.08.19.13.40.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:40:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 8/8] unit/test-util: Cover strtoutf8 with the str2utf8 tests
Date: Wed, 19 Aug 2026 16:40:08 -0400
Message-ID: <20260819204008.2292225-9-luiz.dentz@gmail.com>
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

strtoutf8() and str2utf8() are the two ways of dealing with a name that
is not valid UTF-8, so run them over the same inputs and keep the two
expected results side by side, which documents how they differ:
strtoutf8() truncates at the first ill-formed sequence and leaves the
whitespace alone, str2utf8() replaces the ill-formed sequences and
strips.

The expected results were checked against Python, taking the longest
prefix that decodes as strict UTF-8, over every one, two and three byte
sequence, 16646655 of them, with no mismatch.

Assisted-by: Claude:claude-opus-5
---
 unit/test-util.c | 94 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 28 deletions(-)

diff --git a/unit/test-util.c b/unit/test-util.c
index f0b1bb7994fb..e605d17b6b56 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -83,65 +83,101 @@ static void test_min_max(const void *data)
 	tester_test_passed();
 }
 
-struct str2utf8_data {
+struct utf8_data {
 	const char *input;	/* Not NUL terminated, len bytes are used */
 	size_t len;
-	const char *expected;
+	const char *str2utf8;	/* Ill-formed sequences replaced, stripped */
+	const char *strtoutf8;	/* Truncated at the first ill-formed one */
 };
 
 #define FFFD "\xef\xbf\xbd"		/* U+FFFD REPLACEMENT CHARACTER */
 
-static const struct str2utf8_data str2utf8_tests[] = {
+static const struct utf8_data utf8_tests[] = {
 	/* Nothing to do */
-	{ "", 0, "" },
-	{ "Pixel 7", 7, "Pixel 7" },
+	{ "", 0, "", "" },
+	{ "Pixel 7", 7, "Pixel 7", "Pixel 7" },
 	/* Well-formed multi-byte sequences are kept as they are */
-	{ "\xe2\x82\xac 5", 5, "\xe2\x82\xac 5" },		/* U+20AC */
-	{ "\xf0\x9f\x94\x8a", 4, "\xf0\x9f\x94\x8a" },		/* U+1F50A */
+	{ "\xe2\x82\xac 5", 5, "\xe2\x82\xac 5",		/* U+20AC */
+						"\xe2\x82\xac 5" },
+	{ "\xf0\x9f\x94\x8a", 4, "\xf0\x9f\x94\x8a",	/* U+1F50A */
+						"\xf0\x9f\x94\x8a" },
 	/* Leading and trailing whitespace is removed */
-	{ "  spaced  ", 10, "spaced" },
-	{ "\t\r\nname\n\r\t", 10, "name" },
-	{ "   ", 3, "" },
+	{ "  spaced  ", 10, "spaced", "  spaced  " },
+	{ "\t\r\nname\n\r\t", 10, "name", "\t\r\nname\n\r\t" },
+	{ "   ", 3, "", "   " },
 	/* The name is not NUL terminated, only len bytes are used */
-	{ "truncated", 4, "trun" },
+	{ "truncated", 4, "trun", "trun" },
 	/* A byte that can never appear in UTF-8 */
-	{ "ab\xff""cd", 5, "ab" FFFD "cd" },
+	{ "ab\xff""cd", 5, "ab" FFFD "cd", "ab" },
 	/* A continuation byte cannot start a sequence */
-	{ "ab\x80""cd", 5, "ab" FFFD "cd" },
+	{ "ab\x80""cd", 5, "ab" FFFD "cd", "ab" },
 	/* One U+FFFD per maximal subpart, not per byte */
-	{ "ab\xe2\x82""cd", 6, "ab" FFFD "cd" },
+	{ "ab\xe2\x82""cd", 6, "ab" FFFD "cd", "ab" },
 	/* A sequence cut short by len is still one maximal subpart */
-	{ "ab\xe2\x82\xac", 4, "ab" FFFD },
+	{ "ab\xe2\x82\xac", 4, "ab" FFFD, "ab" },
 	/* Latin-1 text is not valid UTF-8 */
-	{ "caf\xe9", 4, "caf" FFFD },
+	{ "caf\xe9", 4, "caf" FFFD, "caf" },
 	/* Overlong encodings are rejected, C0 and C1 are never valid */
-	{ "\xc0\x80", 2, FFFD FFFD },
-	{ "\xc0\xaf", 2, FFFD FFFD },
+	{ "\xc0\x80", 2, FFFD FFFD, "" },
+	{ "\xc0\xaf", 2, FFFD FFFD, "" },
 	/* UTF-16 surrogates have no UTF-8 encoding */
-	{ "\xed\xa0\x80", 3, FFFD FFFD FFFD },
+	{ "\xed\xa0\x80", 3, FFFD FFFD FFFD, "" },
 	/* U+10FFFF is the last code point, F5 to FF are out of range */
-	{ "\xf4\x90\x80\x80", 4, FFFD FFFD FFFD FFFD },
-	{ "\xf5\x80\x80\x80", 4, FFFD FFFD FFFD FFFD },
+	{ "\xf4\x90\x80\x80", 4, FFFD FFFD FFFD FFFD, "" },
+	{ "\xf5\x80\x80\x80", 4, FFFD FFFD FFFD FFFD, "" },
 	/* The last code point itself is fine */
-	{ "\xf4\x8f\xbf\xbf", 4, "\xf4\x8f\xbf\xbf" },
+	{ "\xf4\x8f\xbf\xbf", 4, "\xf4\x8f\xbf\xbf",
+						"\xf4\x8f\xbf\xbf" },
 	/* Replacement and stripping combined */
-	{ " \xff ", 3, FFFD },
+	{ " \xff ", 3, FFFD, " " },
 };
 
 static void test_str2utf8(const void *data)
 {
 	size_t i;
 
-	for (i = 0; i < sizeof(str2utf8_tests) /
-				sizeof(str2utf8_tests[0]); i++) {
-		const struct str2utf8_data *test = &str2utf8_tests[i];
+	for (i = 0; i < sizeof(utf8_tests) / sizeof(utf8_tests[0]); i++) {
+		const struct utf8_data *test = &utf8_tests[i];
 		char *str = str2utf8((const uint8_t *) test->input,
 								test->len);
 
 		assert(str);
-		if (strcmp(str, test->expected)) {
+		if (strcmp(str, test->str2utf8)) {
 			printf("test %zu: expected \"%s\", got \"%s\"\n", i,
-							test->expected, str);
+							test->str2utf8, str);
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
+static void test_strtoutf8(const void *data)
+{
+	size_t i;
+
+	for (i = 0; i < sizeof(utf8_tests) / sizeof(utf8_tests[0]); i++) {
+		const struct utf8_data *test = &utf8_tests[i];
+		char *str;
+
+		/* strtoutf8() works in place, so it needs a writable copy */
+		str = malloc(test->len + 1);
+		assert(str);
+		memcpy(str, test->input, test->len);
+		str[test->len] = '\0';
+
+		assert(strtoutf8(str, test->len) == str);
+
+		if (strcmp(str, test->strtoutf8)) {
+			printf("test %zu: expected \"%s\", got \"%s\"\n", i,
+							test->strtoutf8, str);
 			free(str);
 			tester_test_failed();
 			return;
@@ -178,6 +214,8 @@ int main(int argc, char *argv[])
 			test_str2utf8, NULL);
 	tester_add("/util/str2utf8_null", NULL, NULL,
 			test_str2utf8_null, NULL);
+	tester_add("/util/strtoutf8", NULL, NULL,
+			test_strtoutf8, NULL);
 
 	return tester_run();
 }
-- 
2.54.0

