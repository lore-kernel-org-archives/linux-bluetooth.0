Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5B39060B
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250657; cv=none; b=s9tTWSzra1Nh7aSYE+AZvZdr6jDj2FT19QV97aTFghMP8S53yWY0bfC1PKaH2SXo596/wCR8K2vMXlM4V4q+x/5z20uhejEgO8LHF4VlG1nK7b0RqpbdODxZkKgoVVSKKyITYbgczJZmiifu/GjnOO8EBe6yUixpwyzazL5yGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250657; c=relaxed/simple;
	bh=ahObInvrva9aMMKIL/3vn0OQw4JG7dtPhgtBXawcSvU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4N8pWXgf6VVvLxt1mY3EnrDLRv2Yju3lEvMIhA7vgMf8d+NaO2UHXGB2dE+DEZJ0dYw6VBosaE4aI2F4bBLUvALdKtjrZwQ7tsMVK+Z1oaoKVZB4rQy/G9SyQ2R7i2G8An2Bh7GmycPGQ2e+bK8C5irOTmjX0WqM2HkzSPBJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDv9cTLN; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDv9cTLN"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-74ace427b29so83944137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250654; x=1787855454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cKomyK2HCvuHIER+qlAQRsPVwTMy1kS2PJaoFissxpc=;
        b=NDv9cTLNdET/reEYEWt9uhWWnKAP4HZOo2gfcJ62+D1gsD+UbSLleYEE+Gp+qe6FJu
         3H+MbEpTKepUwI/XgnSDMdsXygWR9lBTda1WNcTMW+np0hpXm5+KJ6XOO37QGFr4Exr4
         FYpmbm0wkr6WJGZo+/hjpmMWROTh2hJHVjxBh+ZLfJ5dSx1hEA9t69y2QSMT1cGau0eN
         ey/0ZcmxLDPukSX78nE75+tM1sVY56gUj5Gdh+7TBWAKdH5MfhwmBqOSVDQmRHxDvroY
         ynrTnGlwmEknHVY+bKyUWBEa+IhOAHP5FVnx19Pi2obS+w66pPTsWkWK6YXX2/M4aePO
         VmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250654; x=1787855454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cKomyK2HCvuHIER+qlAQRsPVwTMy1kS2PJaoFissxpc=;
        b=bz+BQv90qxzkqmDCRaX8XTfwfTfIBvu4DiaccofwXu3mJACEakRyCy45bDRZwNUEG/
         TE3X1Wzg2Miijnd6FGtMn7RK5qf0D6YiYs5uU+EoEOA09Ru38FbDb5BYEjEE++opCSOA
         9kQycft1dzxW85WbZMdl1dNp5jzGj0A5U93S+TwK7O2xnnbXbme9QaecuodIhNfRKUVO
         xKwdGLKY8ofBpIwxDrEdaE2F/nQRlhyFDz3vYyNT3OCb40FmbbIw0rfjSEpgW55rR6Ak
         0rhD4JjR8lHxFNj1bKymxD9ye31qHwRTVwcKoPQT5eBJER7qsKVwFU4PqoMeCLoEUhKV
         K2Wg==
X-Gm-Message-State: AFuF++kvWLOROdVZld4H6WIHK1JlsNuyyaC0WV6lC8t5ekY07RVDw9AN
	pXdFHOclIJKwm/sIb0y+Gyva1+w/gdE5iRnW+f86Z7Jk+lundW4AkPCnhOpSk45X
X-Gm-Gg: AR+sD13E3E4HUj2wYSlkmB2GSxAjFN4kLo4DtkF670eG/uKMByFyx9ulvTTkUfujo9u
	kyMUAF8FGYOFQe+rlyYQndHv3GwGkaZGvBMqjrKFmZ05ktBwO/Zg5P19P7tS9Oy6M/4fyzlFBHH
	ING7jX9jqJNTxu85fajxFeJPIj7ulyK+iuvEUia195HRUdAI0BU9TRU4Z5J+UPqeoYdefGjf9y3
	G6FseYbKCx9qNQDWX8o48fjMey2uY9r0BUKhbhwTED4/nmt7+aL0HzkbLkATT8dqCaPkaGuqVRh
	S7H7EGC4t4UunYtZXj8SrLix31nwGogkDhHAO+mNgIFba/Ksn8ei8XmWpqrxQ3OBNf0rJyjHfNb
	m+h+UWmZH8tPCHBGKKLqVFyhCFpMrtUoEma3tZm4tmEeTL/MxF1xx2RZbxaYxVaaD1j1I63F9tk
	H42o/fcfcaKzMI4GJl0vFbJyjRT4ofx35rqQEPRPaIXsLJv3t0hjbOHphIS0AVspn6t6abPyC+U
	C0Yj8Tl/wQZoMtvyJrpgBbD3s9fEmYrgtlaeVOPzp3npsYZJMP6P0R3BFTm
X-Received: by 2002:a05:6102:950:b0:76f:1eb7:9944 with SMTP id ada2fe7eead31-77a62634037mr405778137.3.1787250654137;
        Thu, 20 Aug 2026 11:30:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.30.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:30:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 04/10] shared/util: Make strnlenutf8 reject ill-formed sequences
Date: Thu, 20 Aug 2026 14:30:31 -0400
Message-ID: <20260820183037.2713973-5-luiz.dentz@gmail.com>
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

