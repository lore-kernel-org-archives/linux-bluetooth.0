Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6421CC74
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066907; cv=none; b=Z3Q6WCMRpeEyVHIBOAolj+d1P9nL0tt+gOP/m2q3X0N++eADDk9XtB9nDzOzn/8GhNO+LsJAj46CQuzKzazYs54ASkPBaPYlf1Pd6S5LNEW1dbBaBREkwauS295YfFrGm8wXA7VuAAPbpovRiotHoRtg7G6z0HTDCy7lj5DClog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066907; c=relaxed/simple;
	bh=oFMq0boicICq+Ck+OSWJCOnB6tDIVR7F3e8SRYRb6dA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pVFiwWc2/RBT8Ozy1K3EAc7XionIcDYr2l0egsxZdDfVwdCmXYxs9wQ9Kq7tgIcqDP1qJFjXrLleHLXwIQvMEJ9hZgAUGtkrGhVYfFoorsmfHmRLNia+6uLxxnsoRDN5fXCDiIKCEB/b0tJAXgHNghRQfhnFtTYL9kUvlIrV5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT5yesnW; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT5yesnW"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-531acaddd5eso1660827e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 06:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752066904; x=1752671704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ErRFR6VsPqe1LtNRoOBgaX4BA4HAVRZRsQ1OHLgYgE=;
        b=lT5yesnWtC99yFTwkHjzlmYGgk81M1kPJKHeRxxXSvicFhyU5AfZEru0gnBeTueeP6
         IumQsFe59yBBB6U+1Tgo00Hidpf/DOeQ66d8s58FZn2+iCmlsV0h8ah1RAj6Bm/YgpUN
         BV67cuWQgizzyf5Q6FMmlaB1xmfyYpEmRgjRZbLRqNSk69eQottrp9RT+TIB7ifqZeCG
         N7LJXkNsgPZUrNi+pxhJaLDM7OiP5iIYEdhJsK8oCNRkwjW/wNn5NRdbRID7LHGn7cnT
         oXbf+0xUq8KNii0uEgdpvVOjrZz9R8FzWaLYMa5DS4xZjTnzoIiBjmPgfenw7EzFMUP0
         UlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752066904; x=1752671704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ErRFR6VsPqe1LtNRoOBgaX4BA4HAVRZRsQ1OHLgYgE=;
        b=Zt7Ib4STInfzYiVUgFEqmrpFsEv77ooNAgFfyBTLT7uev+j7v78HfPCJl9PW7jq8zE
         7TcgcEa7Z873QbdDpWka8oXg9Ec67Oh/qAaKOWSzeZ62rM6TI6+NLqhWs5oQs9TbAx4G
         rQqVNvXSKd2ZLbGkObHGWFKIGOM9d+RVlvrXW7OAFEIBoJE/KObd/8142LYAY1y3tCm/
         X0XdLlPNJ3YZbNid9Iv+t8+AoIpr6x3M8CgcE3+jlIOhSg91VIBGFoQCXqf6M1Zk/RHq
         MCu2Seg/162AKDxM87MVCY4eb0PvSCGuhZ3vpF11ODKTxcw9uB7aZhHAc3wxaYfBPF9D
         hSDg==
X-Gm-Message-State: AOJu0Ywtk1l+M4dTMpWiGFqpu9LKQDP2BjhpnT4OGedT5zqvTbsFeMxw
	WflFEDW6PcaASaRmWqlfuBQ47UQYn/u5ZbFPd9U9L23C8CYfor7FcJUywPoOLjGZfto=
X-Gm-Gg: ASbGncsvPbdmSX75axD3VnleKsqibyn2pACqvGLFD8Qeeqe+YR+9otHm+nOURyA0hAg
	x6X0mvHMcLAdBfq93mfJtSiI3c6naTFE/S4+XkVvojY8zzdl/qyP0nsEkbUyHZAcKJQKh3+rX1t
	U9YbjxmASvbZrBtB1Kw6DMSyi0Ne80OgxszUWgovzVLiFsTRGTxVSpabOLotWZR756dq+ZlPuet
	LIFXfyVQSW2vgRxiUPufXyTOpdL1FB5Yaqb8gUGCydb7FzhG4zAaGlm0CiK4334xA0sxYI1Ws1F
	1tKMcg7yUpZCtXeou9N+FQAdrf/vXnVVxaKPQCa8UvD+dGg5EoiwEiM0vP0iUcyuw0yRMeHEAE1
	vqBY3ZeiI/eo3kkFaGDqTlvEjItZx
X-Google-Smtp-Source: AGHT+IFmPJVjVSg0+IzpJlRUrgidshpz8u2Tvrsw2//0bFTEW+d8uhqz5gYnX7ttopirwbMULbtq+g==
X-Received: by 2002:a05:6122:4202:b0:534:8213:af78 with SMTP id 71dfb90a1353d-535d7404c06mr1285852e0c.8.1752066903538;
        Wed, 09 Jul 2025 06:15:03 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-534790f2a20sm2186569e0c.45.2025.07.09.06.15.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:15:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] shared/util: Introduce strnlenutf8
Date: Wed,  9 Jul 2025 09:14:53 -0400
Message-ID: <20250709131453.3203903-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces strnlenutf8 which works similarly to strnlen but return
only the number of valid bytes of UTF-8 encoded string then replace the
other copies of similar code.
---
 src/shared/util.c | 82 +++++++++++++++++------------------------------
 src/shared/util.h |  2 ++
 2 files changed, 32 insertions(+), 52 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 4780f26b6d59..fa058170e124 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1909,58 +1909,8 @@ char *strstrip(char *str)
 	return str;
 }
 
-bool strisutf8(const char *str, size_t len)
-{
-	size_t i = 0;
+size_t strnlenutf8(const char *str, size_t len)
 
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
-			return false;
-
-		/* Check the following bytes to ensure they have the correct
-		 * format.
-		 */
-		for (size_t j = 1; j < size; ++j) {
-			if (i + j > len || (str[i + j] & 0xC0) != 0x80)
-				/* Invalid UTF-8 sequence */
-				return false;
-		}
-
-		/* Move to the next character */
-		i += size;
-	}
-
-	return true;
-}
-
-bool argsisutf8(int argc, char *argv[])
-{
-	for (int i = 0; i < argc; i++) {
-		if (!strisutf8(argv[i], strlen(argv[i]))) {
-			printf("Invalid character in string: %s\n", argv[i]);
-			return false;
-		}
-	}
-
-	return true;
-}
-
-char *strtoutf8(char *str, size_t len)
 {
 	size_t i = 0;
 
@@ -1987,7 +1937,7 @@ char *strtoutf8(char *str, size_t len)
 		 * format.
 		 */
 		for (size_t j = 1; j < size; ++j) {
-			if (i + j > len || (str[i + j] & 0xC0) != 0x80)
+			if (i + j >= len || (str[i + j] & 0xC0) != 0x80)
 				/* Invalid UTF-8 sequence */
 				goto done;
 		}
@@ -1997,6 +1947,34 @@ char *strtoutf8(char *str, size_t len)
 	}
 
 done:
+	return i;
+}
+
+bool strisutf8(const char *str, size_t len)
+{
+	return strnlenutf8(str, len) == len;
+}
+
+bool argsisutf8(int argc, char *argv[])
+{
+	for (int i = 0; i < argc; i++) {
+		if (!strisutf8(argv[i], strlen(argv[i]))) {
+			printf("Invalid character in string: %s\n", argv[i]);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+char *strtoutf8(char *str, size_t len)
+{
+	size_t i = 0;
+
+	i = strnlenutf8(str, len);
+	if (i == len)
+		return str;
+
 	/* Truncate to the longest valid UTF-8 string */
 	memset(str + i, 0, len - i);
 	return str;
diff --git a/src/shared/util.h b/src/shared/util.h
index 6fc02a9dcb5a..c480351d6e9f 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -90,6 +90,8 @@ do {						\
 char *strdelimit(char *str, char *del, char c);
 int strsuffix(const char *str, const char *suffix);
 char *strstrip(char *str);
+
+size_t strnlenutf8(const char *str, size_t len);
 bool strisutf8(const char *str, size_t length);
 bool argsisutf8(int argc, char *argv[]);
 char *strtoutf8(char *str, size_t len);
-- 
2.50.0

