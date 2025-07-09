Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648128724C
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054065; cv=none; b=N3/zer39V6fYYbKaEEhs8i1U958BF87v2/Im2gITOcHUU89hA5HvXQzIiFwN00X2RhviIoPjJFMYcyamQwSByuyaxP2OwLe5fkWOjSLvL8aX1tlQVpETR9hVjTXcm6hmz8gW/r3GlBMzrAgblpWpqU6lrWro4FVEpNzricfi6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054065; c=relaxed/simple;
	bh=GIAe9ZDxgrMImV9AayOEUbxOaPanPlCS13k+JYJfKfU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kQToXooITndp3ykW8co+ATU3QciKwmhSWlb/fiOo5XGhmPPiXELnIN3jsLji0uQembjxDxLul7tgiLwWZ7H6bjJSC3OK4zs7MdXPWVw1FmDD1odmbeClTWG+fDNQOKyEciXHiLG20BxTXUCVXLLSEaJfx5McTcMIoYBkRz7N4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cgTtiu4t; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cgTtiu4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752054061;
	bh=GIAe9ZDxgrMImV9AayOEUbxOaPanPlCS13k+JYJfKfU=;
	h=From:To:Subject:Date:From;
	b=cgTtiu4t6Szby3rtG8B0OT5GZp/RUKLc6lFfYKu27PX3g56qbMAzg8AgyjktMiYAX
	 0SaEymz5cye8w1c76ecG9PU88hr+4n8HGXv9RhyCDME/g29DHHnjh2PHhCxBPqkX3p
	 XT3qSPCqzco3FM3ljWFw90tldyUj9hybY9IKf42R2YanZBFzfUiLl6pPTTuqQqgxrp
	 bZT396sjUlSpOqKV3qr+N2WHLIB4+qzKqiK3oe6LWweOL9MrBwl9VhidHXyR9KTUeC
	 iqa9rwqrbPlRcU5d5oCwHJrOl10cjtwVws2x5FWiM1IFeqjhEOik45FzvuRrpBOnRJ
	 Q0al0rokB3FsA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-DC1D-D4Ab-8E71-B570.rev.sfr.net [IPv6:2a02:8428:af44:1001:dc1d:d4ab:8e71:b570])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A06D17E04AA
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 11:41:01 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/util: Refactor code from strisutf8 and strtoutf8
Date: Wed,  9 Jul 2025 11:40:55 +0200
Message-ID: <20250709094055.516584-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Move duplicate code to static validateutf8() and fix boundary access
on multi-byte character check.
---
 src/shared/util.c | 56 +++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 4780f26b6..36c06188f 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1909,7 +1909,7 @@ char *strstrip(char *str)
 	return str;
 }
 
-bool strisutf8(const char *str, size_t len)
+static bool validateutf8(const char *str, size_t len, size_t *invalid_index)
 {
 	size_t i = 0;
 
@@ -1928,17 +1928,23 @@ bool strisutf8(const char *str, size_t len)
 			size = 3;
 		else if ((c & 0xF8) == 0xF0)
 			size = 4;
-		else
+		else {
 			/* Invalid UTF-8 sequence */
+			if (invalid_index)
+				*invalid_index = i;
 			return false;
+		}
 
 		/* Check the following bytes to ensure they have the correct
 		 * format.
 		 */
 		for (size_t j = 1; j < size; ++j) {
-			if (i + j > len || (str[i + j] & 0xC0) != 0x80)
+			if (i + j >= len || (str[i + j] & 0xC0) != 0x80) {
 				/* Invalid UTF-8 sequence */
+				if (invalid_index)
+					*invalid_index = i;
 				return false;
+			}
 		}
 
 		/* Move to the next character */
@@ -1948,6 +1954,11 @@ bool strisutf8(const char *str, size_t len)
 	return true;
 }
 
+bool strisutf8(const char *str, size_t len)
+{
+	return validateutf8(str, len, NULL);
+}
+
 bool argsisutf8(int argc, char *argv[])
 {
 	for (int i = 0; i < argc; i++) {
@@ -1962,42 +1973,11 @@ bool argsisutf8(int argc, char *argv[])
 
 char *strtoutf8(char *str, size_t len)
 {
-	size_t i = 0;
-
-	while (i < len) {
-		unsigned char c = str[i];
-		size_t size = 0;
-
-		/* Check the first byte to determine the number of bytes in the
-		 * UTF-8 character.
-		 */
-		if ((c & 0x80) == 0x00)
-			size = 1;
-		else if ((c & 0xE0) == 0xC0)
-			size = 2;
-		else if ((c & 0xF0) == 0xE0)
-			size = 3;
-		else if ((c & 0xF8) == 0xF0)
-			size = 4;
-		else
-			/* Invalid UTF-8 sequence */
-			goto done;
-
-		/* Check the following bytes to ensure they have the correct
-		 * format.
-		 */
-		for (size_t j = 1; j < size; ++j) {
-			if (i + j > len || (str[i + j] & 0xC0) != 0x80)
-				/* Invalid UTF-8 sequence */
-				goto done;
-		}
+	size_t invalid_index = 0;
 
-		/* Move to the next character */
-		i += size;
-	}
+	if (!validateutf8(str, len, &invalid_index))
+		/* Truncate to the longest valid UTF-8 string */
+		memset(str + invalid_index, 0, len - invalid_index);
 
-done:
-	/* Truncate to the longest valid UTF-8 string */
-	memset(str + i, 0, len - i);
 	return str;
 }
-- 
2.43.0

