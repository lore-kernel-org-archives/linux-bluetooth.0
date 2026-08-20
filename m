Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C192390C90
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250660; cv=none; b=HfrQ/KMC/oqEGKXyGV6838o55epkLey07aP3kBB4uEOotGNw7iM+zAZFGFWFBl3/EDnpUT2+6YEpd18sULXnOUFO7wOV49ntMyn2yG9SEJP4fcjEqooX8xn3x7fBoaUpR85xsLXA2gfIfxjIjnEzqLP6C4myevMtL4vxQHP5V0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250660; c=relaxed/simple;
	bh=UPa7sWgF15wsmiTaWg2YyNk8F69FjAtGeWcoFQWicLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+7zjBWW8fljkBUOI2qA1wDeOiiSxZNRq71OjNGsjuE3OV3NjR5EMXHtmp76Y7n9X85DorIOm+UxcnVp3j+GfRZ5wg9a9p1dsx7Sqip3/V7hSdfbMrM8vhgTU+8uKCINNjpttb7BYV3CPIYSGCo/IcE2GB+2Ox77XpDF/0LETuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgn3JC1o; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgn3JC1o"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c5ac25089bso138777e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250658; x=1787855458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EQhUeHGZS+GWINOrvMwhsFvDuB2bVJ+3Fw7ksN/E/Xg=;
        b=lgn3JC1oBukkuQT95mT1UNyIys4Kn7q6VIfTwPR+cb3cm8X/NyKiF/N2bKLOgxgfOc
         9b802KLHHnWy/sXNc0roRMXLTpNVdyN2dEV7OwOKYaBpY0mvm1hzeM9NLdBplfpnZcJf
         T5n3DxyYIrXnvr7Ob+a/Eege6x+Lo1bz7lWYqnqmU49Xrj5lNrXIgXVb94HIm+86r4Ke
         1Z5ZbAULNd45EJCWBCdvmqlS4CULMjy9uXG7ZSmI5ql0usUg15JqfZMk+hjCjWYzJodT
         MoRDIhKHuAIsh8LK8wI/t6D5cJ0XmypYF3SjN6ofGkX9baWGdH0h/sFBggGHobRJvDIU
         EyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250658; x=1787855458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EQhUeHGZS+GWINOrvMwhsFvDuB2bVJ+3Fw7ksN/E/Xg=;
        b=A5gqYVqPhH0nbzS8mpGM1L5HHLdylYcpDx8Q0mkkR7V0GiiuKh0lWNqUAIl2Yg/l5Z
         ibfuDtmRMwG5/DAIZV5o0Cr+WPUDcyk0Ddq6qzcE44rjv+59ce/ejNGv9n9znp3Ffvsw
         SX4Cb70sV8gJV/BUGR/UZRgh8+XuE3R3OZCiVr6AWGrcWEkuuyvV63jq5VP6q6A5WN97
         5Tfnw5qqLXeaQ2mjJny2fFAn9benuyZtBtOMakLl4Lz3Zdf7CCVNBCHKjqDoij3KcU9e
         ie9ZdYoKIF90vH9w0/UBkL69jX8xmo4ioX0Ly+6CLvImNzuHlYE1Q01AXueLtzlblXra
         PU6Q==
X-Gm-Message-State: AFuF++lHgNPN3wOHsuldSV/obU7UYf6mH1rA4veqklVjVGvewMePu6wD
	6fagHlml8qlBtaBfTtvBBlzlUmwIAdXJ0AC1zW1lkvWQePTDmTYpPw2WKvFAcZv1
X-Gm-Gg: AR+sD10ljjiwhxXlwADQ3GT7dxCcp1WX4+sL2jhvkmTwI0hw4QXX8noC7NwrmblH/Fh
	WEzICuPnse6BMVy3YIdTv+ZhoN8q8n7lf4go3LKAVEeksyo5ghn2bt1PGvRrKiUH9JQk8UkHORi
	gPuzz37LF/Sj9oEATGCWCBKKfFTefYrs4ZrR2Kf8Zn4YN0nnQaz75txQ1/0tmQmO/GpkntEyHMV
	zBzewldIupDhXWc6m6TINQqWwQnzRzdoZ5gGOKrAL5z4QUqugstun1gBrgqjCAfaQYaK3xLvfSs
	5p5wBvuonrCzFMi3PM+e8c70wkYs8na5J4QH8qxVKupL2OUP8uy4pFEUaw9HqaALbKydflbsO6g
	ajSnnUPjSzKxbq7uchdM9Oi1mbZzs5Kv1QGWmTenNUabM3ZVznMktYlew3o+snc7Rx1eOyY2+IS
	8n2HzWmX1OHP7e+3gKdXO7Da7OPaizDZ/C3MN8tX/yauiHb1kBEn8xqDaUfaIJWxmqminv7JOFt
	ZK7ufXI/iXu4FQubA/UjmmN2Leski6OrfXi6/2Yf+/m9aKA30Ki3gg9OASDLfLdvv+m9qBcC99d
	5g==
X-Received: by 2002:a05:6122:1310:b0:5c5:731b:11d2 with SMTP id 71dfb90a1353d-5c5ff877797mr347971e0c.8.1787250657767;
        Thu, 20 Aug 2026 11:30:57 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.30.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:30:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/10] unit/test-util: Add str2utf8 tests
Date: Thu, 20 Aug 2026 14:30:33 -0400
Message-ID: <20260820183037.2713973-7-luiz.dentz@gmail.com>
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

