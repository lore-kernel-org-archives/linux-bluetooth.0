Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F93E6389
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506359; cv=none; b=OxJtIJgqGGPAjmUjF6Og5jMoNILwCOkmx8QL2YyARNsYMN498OIGY9KJmMo9NtJtYPt2edfZLeNEPhOI0qNdd8u4RB8h2IOvDi2Cq8zGY3CvkmivK3KHyRJFATdQg0NaU3SbPW2RcVF4FSLC404r591E+U+Xrl+LRmMwWWYUaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506359; c=relaxed/simple;
	bh=4TuDtuZwiBCq+uKu75OvHZE0VFfpR3cvd6b7paMVqwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agXBkjCrZ0XsVe8IHdruVMYIhw0rB3SbQ9hZbDB8d53YX5kgBXnEgrF0nw4XbcRadfSPOwFadiVsSghrpwiRC920BnL7LHXv8iurlAtgB7IEvnm/HtwJJ8T9/WIW5bD+NJftcZRDoa0xh4vPznKUonXKAzZIZyGgzR6mlCeSKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 27BB75812F2
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:47 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79D613EC3B
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 1/6] all: Remove more unneeded MIN/MAX macro definition
Date: Mon, 11 May 2026 15:18:04 +0200
Message-ID: <20260511132131.1283892-2-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511132131.1283892-1-hadess@hadess.net>
References: <20260511132131.1283892-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFyg4dcWaG5eSKnyQUHRkNw/X4O2fwqTBchSxLtNlc8UZkgYcvmT3qFT99KlQyk19auPdMEZcmgm/Vyr6QiQMZqh5NFE17Zc0wXOtGPQQZRz5XwT9JV83lfqcvUtVp2HNtl2hZC1BgZ9TR7tsTgsJSySwYWZzV5EPUMt6P2DJ1BVLKAGzqYnxDlPqKBHFh4XfMCnpWb3pFBFavNJlLQjO+blTA/peaWNxPspJqGVDx6v0cAbK74vnvh38G7adG+f8OSDFt6Fhdnqo3vTy+0xSBEumrusRanrze1CrRoMShKBmPygTEsg0qM+HlxUOxeeaxDbZ4d+AS9eqXKhVcDycEXBvnNJPPnJmw36ssdKXrAppeN0nOvAg/cd/veBQ4ChDWmiAOwSql5morMuhqDV48HJQqzTOpic6XFzyJCNKmjSqCZGHrSN9SQozRuB+2jdfazX1WMPehyUyLRF6hbaSvOJLUNUvzT0524ledoRm1MnYirJI/MjOUly42Edmg6puDq/PZKXF9wzoVJET7iXvex+aSM0svXq8iOgSEb59Ch8KO7h/MAauG9ADZBUIsZQyeRuZSxFLQJUwHcmCvmXWHBZsAg4yWvXcGFNQu0Is96rXmd7Hs4X9cYIyl633qfhuSV8rs9Vy2NZ3FO7Hs6aswBqwWPoVdiVreESdE0tBTJ7Q
X-GND-State: clean
X-GND-Score: 0

---
 lib/bluetooth/hci.c      | 4 ----
 src/main.c               | 4 ----
 src/shared/gatt-server.c | 8 --------
 3 files changed, 16 deletions(-)

diff --git a/lib/bluetooth/hci.c b/lib/bluetooth/hci.c
index 44eea054b0ac..f50a30c610be 100644
--- a/lib/bluetooth/hci.c
+++ b/lib/bluetooth/hci.c
@@ -33,10 +33,6 @@
 #include "hci.h"
 #include "hci_lib.h"
 
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
-
 typedef struct {
 	char *str;
 	unsigned int val;
diff --git a/src/main.c b/src/main.c
index 9a3d2da25d4d..8aa19a3e3346 100644
--- a/src/main.c
+++ b/src/main.c
@@ -205,10 +205,6 @@ static const struct group_table {
 	{ }
 };
 
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
-
 static int8_t check_sirk_alpha_numeric(char *str)
 {
 	int8_t val = 0;
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 6273899965c0..709a8f94bb6a 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -26,14 +26,6 @@
 #include "src/shared/util.h"
 #include "src/shared/timeout.h"
 
-#ifndef MAX
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
-#endif
-
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 /*
  * TODO: This is an arbitrary limit. Come up with something reasonable or
  * perhaps an API to set this value if there is a use case for it.
-- 
2.54.0

