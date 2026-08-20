Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A94388390
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250666; cv=none; b=ZkF0KkVM3OzpBdIK+jfDKog9TJC/L1rHeH8MJ/mptk0DUSRmVoFBFjshQe5vh3bex5tSuKExrdaFefQrLLb1/cccsHoNbBPQrKH+yC6U4QpTRvefc7h7qOTjEExEhIDZMPo1jUTCsWy3VeBij5rDbrMwHFWNQK2iJZrMN449NgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250666; c=relaxed/simple;
	bh=9hlHPMUSpZfSPV/kKGCmXt8+11ZbWbaMeWmI0IMSJ2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qz5gR8cvcHvV4Wv4kgxm9HFxU92gnYz1OcjPceDGvXK898tLZC0sZqGs8sSCe9EYmJreC8tjPmaaMiuqvr2Y+Wr0UkN3dtGs6eG5Dcgs9cPZMP0zmB156Dk6ywIr4bKkJ3A+s7lqsTNu63lDXKSjYH1x84ofQmPg6t2wBogtirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTMkqVnP; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTMkqVnP"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso125221e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250663; x=1787855463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OeOSMeS6K++zfh8cn0//khtf3rsH7G0Jb/ibEHEW2CE=;
        b=aTMkqVnPLMiwGvzyjluVQi1E1BDP5ykfGwswVODUgOALjkzULZcrCSqHOD6+xKnfXx
         I3vaBSLEFXGwQaNEy85wdO6YWUmArWJz+rHn19w3fEPdtmhL6ShW9PstRyb/zsGeOHUW
         jOSZVUS+I7f7KZfzCsa2pzp0n279mR06SMSCZjP/R4GKa9LKGRfWW2KcePuvPf/pFW3I
         Bwi4KXAtixGIH+WqZPkM5Wgd7V1ebGRA1rehJVKO4os4ymKYJPxnjH7KqcUiqfQ4id+f
         Pkk3p2btu5193vk9Kj29b/K9TJpIAbUpGI14ptccFGa4QZSdJte7tdi7qifv/mLlJzvw
         Pcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250663; x=1787855463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OeOSMeS6K++zfh8cn0//khtf3rsH7G0Jb/ibEHEW2CE=;
        b=Mgx3X5huVZVefEj+DOSffwEv9zvPoEwtL/0qIGPwvmlHUVh2Yi8kS1qx2PUnxvvCJw
         KIKoHWENgbyb1CcfOLtXq4ESiDkQxKkjDI4dIuXpOTawHRJNy4AhnT2anSaHQM3SHFFN
         s26ssGk6JIqYSc4sdf5CU8jx2/uR/iRbxuA/dCju9251S60OiG9foaa3XKLnNXnqwiik
         gSBT0ZeL2cBsb0KMmz79YxcycYE6zvrWniIDysKcBxhvQHtMZNTNWMgY1gSByi11LaZ1
         08hnjb02HaHdS70/zEXCeOoqzNhnx+ktLQOTJ+A8BN6hyG/rEyNqw9NV0hjh0Ntj+Prl
         uD+Q==
X-Gm-Message-State: AFuF++mV5AQZFNnArguG+4LNye1+JlxoAorNTCLdk8WckBNnhy94hZpH
	IsGXtG7iIIw1MuuD3T78cguRE7eremtuze5M8TKOMblWes1mrrmXulG14FLmEf82
X-Gm-Gg: AR+sD10NrDDE6OzirFdhX7urJUTf/oGguJ0Rft5KGq0gIE8QeuzvMLd4fX10PmRKGHI
	HDGsvCC043ecUSFreGYNLk3pslUBGbItIQK9D7W3MbmVtivIUxET3eKXUuk4pdvk5pXUFXqgjjt
	MBhoUhhCjPfvFVsMi/75EZahUw+JPLXYIirrqlVnFWNNIpoVs2jPqkgdmevg0f3XhmvKk/B+UvZ
	G5D+wl4cweJXai7lbBKI6ENqHIh1RZYpLno7FyIyStU3fBsgMjsIfd+vbHxLSBqQlW2DAmyL264
	hQDyzHfn1NXCEySVA0DHsKKOTTzKxSf60UI4pc7Xz+7G9ndxaRWKusJO+f5kSkpX+KnsS0xIk1F
	qyXGa9Eg1GTTOxG65uBbF3D4vppm0iMdfdm1censPkH9URXA014phULRpXnof3mir4S+fodrHeV
	IHrqbQw03og3aVUl3cwrN1rCwa4Z85pstLhSZgz/wduIJM84FfstTpN/tffY+XQh7WoqyoHwFLp
	WP8lnmJ+ufuKGOt/U3TKA5v99A4Uxi1Se3ouah/uNbQLeu3Fnbkb5E=
X-Received: by 2002:a05:6122:c91:b0:5c3:61c2:9ec6 with SMTP id 71dfb90a1353d-5c5ff72d7d8mr352230e0c.7.1787250663236;
        Thu, 20 Aug 2026 11:31:03 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.31.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:31:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/10] unit/test-util: Cover strtoutf8 with the str2utf8 tests
Date: Thu, 20 Aug 2026 14:30:37 -0400
Message-ID: <20260820183037.2713973-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820183037.2713973-1-luiz.dentz@gmail.com>
References: <20260820183037.2713973-1-luiz.dentz@gmail.com>
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

