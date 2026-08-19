Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B0371D10
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172027; cv=none; b=Y+ZFzfFmnmxhxvKBrO7616WAc3Ad2eUYOBKfRVS1jza6nRAkWvEn3hA/bvsQ7NTnIALFIwK1vamfCR8VvPbk+ayFpLeNgspIYg06ng5RksaSv6eXMcWAeK7L0FZKTVIWGVbVFRbh7rZDOqIsBCVkMln5ZDCgICiaswuKcMGrvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172027; c=relaxed/simple;
	bh=ahObInvrva9aMMKIL/3vn0OQw4JG7dtPhgtBXawcSvU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYskhDE24lhb8qSkIF895H34k80XydfslVB3CzmeasZyTnRc3zAnj1UgvVPtgtRd1FR70vwFgkp3vwJN4Pwbktu7QZaq8PPYurxbXl06FUN46CtdYbAZt5Kqw2H4OCwZCY/0Sg4ITYYbtCrBeIyTg5jupU5Z2FEynGC7QQtqm1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrJITL4u; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrJITL4u"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso640627e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787172022; x=1787776822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cKomyK2HCvuHIER+qlAQRsPVwTMy1kS2PJaoFissxpc=;
        b=WrJITL4uTYnib8YGW0NSgtZbv063uZPxU3elA0q4bDyAwssvQZdtqpiqSiMaTMsS/R
         YMujXHO05WLYCwRY1GwrF0iSSW8eP2lZdLIJPS3GbFOmw5QrfbBzRYi2LLXhJVa/HSrP
         I0X2TKx8fYTYZNr5F1Y1sbceJaOYO7ldxTOy6lU3gaXNRv+NrYuAeSCq8GhPq0TujNVr
         +Q5Q4p9t+dvZ1Vzn6LVRZC6fyatqrNUyWQsH/X5/NN/Ejx1U9yR5h5Ay5YSpYMuAN40u
         24UDRs51kGHv0tgTBXVnmd6bKbIDAPuU64dXEaXIEcy7FH8CRt4VRFj/jCeId4KOQv6F
         0bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172022; x=1787776822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cKomyK2HCvuHIER+qlAQRsPVwTMy1kS2PJaoFissxpc=;
        b=hW0YcLyVmbxOe8LNs39YMu+gwyskYLrlkkANnpMdyV6CuoJVMDDC6Qvnd6g0WBUxva
         VaMwN5mq/N4Pgm3O9QcT3I/4iZSsKX0r5BKnUNnm9jOgkGF8Olnxuitpg6ADAOL1jIKJ
         RmTn3mT8o1bWQ51cHSvR6UaIxSyjIMT5EwRyHA0TRmGsBT1EUwRj8PRsBOyssQi9YkOo
         cZscluELaHqeXIZPhldanjtM+ja6AMA69HhlyMeTl5m47D9mUcxY8IlUyA30ny80fGWi
         m8gHYiIYMxJREO0DAPZ5WxW9r1fWh5idjsO5aXNsrMPQjqHyXJPmlyGjx7eP6OBNBpiD
         U98w==
X-Gm-Message-State: AOJu0YwIrfnQSJyGjfOr1AAP1SRZGQOoXsMafpEqmfs+dDfIRrQqCABj
	f9ZshBmJhJImxN7xgCrw5AN00DC6T2c55p7/1Kxy+ENgP/0h7S5Gi0jq4R+HJZKUHuECjQ==
X-Gm-Gg: AR+sD12IT2kJRkhdEXLc4yvpc7iiZGcwuHqKnyQAdg7eM7cPEUwYBdLMI3IkHaqjoF0
	AOYdAVGWH6BFbtXhu5SOiIWRo05ISwn2l/mYTV6BbBNxg1YqPwhip3VVDGozA/je6duQpHmxQod
	1sYS4AGq+dsLBsCMuYja9AJclaBgYxir3RE2YqEcBqHfU0KNl4XfsPo0Rmw0nb/+YsMdyzpQ7Bh
	I84RjcGm/Rfay8Z9tk2fXrs+br+uTNTO+2YAsKQh1VTRtJNdJYTk4vQRpO2+uzhzgxKip71McHD
	vCw/DI4oEfSKjSCrc3m55jGMShmotaQ0Jo7oe+8PsZKsPu2pNovJZsf8pmP1hFRbXwlJCN+46bv
	8JSauOYhtPK62NbJzxzh6HrrfMRBqQiU4GvxpebenPsq9bLUcOWKvKbygjJ5zS7ZsDXOLaWK5fe
	j5yvFwRa0SjL9Qb94+ZJ8C+cZKbsip2Zq5CU34VOFzZGkiOjl22vVWxmEwvL52qcLpcZ8ht8vPa
	2D4ezWeIxHoYEiUrHqdUlcV2QOaLvsLAODZ4xz7ObUWWGFFkQ1yung=
X-Received: by 2002:a05:6122:2094:b0:5bc:42be:f758 with SMTP id 71dfb90a1353d-5c5e3bbbf9amr3147366e0c.3.1787172022194;
        Wed, 19 Aug 2026 13:40:22 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2486864sm3496404e0c.0.2026.08.19.13.40.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:40:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/8] shared/util: Make strnlenutf8 reject ill-formed sequences
Date: Wed, 19 Aug 2026 16:40:02 -0400
Message-ID: <20260819204008.2292225-3-luiz.dentz@gmail.com>
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

strnlenutf8() only checks the shape of the lead byte and that the
following bytes are continuation bytes, so it accepts sequences that are
not well-formed UTF-8:

  C0 80        overlong encoding of U+0000
  C0 AF        overlong encoding of '/'
  ED A0 80     UTF-16 surrogate U+D800
  F5 80 80 80  past the U+10FFFF limit

strisutf8() and strtoutf8() are built on it, so a remote name containing
any of those is considered valid and passed on unchanged, for instance
to D-Bus, which does validate UTF-8 strictly and rejects them.

Validate the sequences as defined by table 3-7 of the Unicode Standard
instead, which constrains the range of the second byte for the E0, ED,
F0 and F4 lead bytes and rejects the C0, C1 and F5 to FF ones outright.

The decoding is split out into a helper that also reports the size of
the maximal subpart of an ill-formed sequence, so that callers can skip
over it, as recommended by section 3.9 of the Unicode Standard.

Assisted-by: Claude:claude-opus-5
---
 src/shared/util.c | 90 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 28 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 62dd1369b70d..e946214edbb9 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -2211,44 +2211,78 @@ char *strstrip(char *str)
 	return str;
 }
 
-size_t strnlenutf8(const char *str, size_t len)
+/*
+ * Decode the UTF-8 sequence at str, as defined by table 3-7 of the Unicode
+ * Standard, and return its size, or 0 if it is ill-formed.
+ *
+ * sublen is set to the size of the maximal subpart of the sequence, that is
+ * the number of leading bytes that could still have formed a well-formed
+ * sequence, which is what the caller needs to skip over.
+ */
+static size_t utf8_seqlen(const unsigned char *str, size_t len, size_t *sublen)
+{
+	unsigned char lo = 0x80, hi = 0xbf;
+	size_t size, i;
 
+	if (str[0] <= 0x7f) {
+		*sublen = 1;
+		return 1;
+	}
+
+	if (str[0] >= 0xc2 && str[0] <= 0xdf) {
+		size = 2;
+	} else if (str[0] >= 0xe0 && str[0] <= 0xef) {
+		size = 3;
+		/* Reject the overlong encodings and the UTF-16 surrogates */
+		if (str[0] == 0xe0)
+			lo = 0xa0;
+		else if (str[0] == 0xed)
+			hi = 0x9f;
+	} else if (str[0] >= 0xf0 && str[0] <= 0xf4) {
+		size = 4;
+		/* Reject the overlong encodings and anything past U+10FFFF */
+		if (str[0] == 0xf0)
+			lo = 0x90;
+		else if (str[0] == 0xf4)
+			hi = 0x8f;
+	} else {
+		/* C0 and C1 are overlong, F5 to FF are out of range, and a
+		 * continuation byte cannot start a sequence.
+		 */
+		*sublen = 1;
+		return 0;
+	}
+
+	for (i = 1; i < size; i++) {
+		if (i >= len || str[i] < lo || str[i] > hi) {
+			*sublen = i;
+			return 0;
+		}
+
+		/* Only the second byte has a restricted range */
+		lo = 0x80;
+		hi = 0xbf;
+	}
+
+	*sublen = size;
+	return size;
+}
+
+size_t strnlenutf8(const char *str, size_t len)
 {
 	size_t i = 0;
 
 	while (i < len) {
-		unsigned char c = str[i];
-		size_t size = 0;
+		size_t sublen;
 
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
-			if (i + j >= len || (str[i + j] & 0xC0) != 0x80)
-				/* Invalid UTF-8 sequence */
-				goto done;
-		}
+		if (!utf8_seqlen((const unsigned char *) str + i, len - i,
+								&sublen))
+			break;
 
 		/* Move to the next character */
-		i += size;
+		i += sublen;
 	}
 
-done:
 	return i;
 }
 
-- 
2.54.0

