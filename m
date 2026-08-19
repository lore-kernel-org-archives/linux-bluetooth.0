Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2637F001
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172028; cv=none; b=PcdZgB8Mg2dwwoKlSFzVwf3xy4/Xlb/tYnr4H815o9V7osLMNPKJM+sgoWK+tI2YjAF6Xa92514X2lO9PPIxKNbNvELzSS22oZZSOWRioC1j3oS9PeyClZem0NgiBwEoZyxwWkUZ+TVcwFvIWV9WppgeAQ78kDwijGX47+QoCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172028; c=relaxed/simple;
	bh=EIR3ceh2QbomtjaCrykjt8CXzQtsSAKostH6+Xno+R0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+Jwj9YbU9WAZy9vMz9qZxMKBIt7ZZnfiGXFozW6pC75jR/n9ieIhJPJdBvZV/7DzJ5uQqUMJePUY6qXShnlzzdR+6EklBKMXzSQGx12pUiDz5O/w33/fKMndIEkpMV7zKf1bYeof0sR+HrUMIMKM6mtBE2RLOGPbhZWZCxHZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6+AFUA1; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6+AFUA1"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c276bfce7eso1287190e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787172024; x=1787776824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D2v9HOgfmyEyulghzA5GwM4apa4ZL6DlrBvXj+54NVE=;
        b=q6+AFUA1R8QPBuyBDfYCazd26CL9y+uxtwllxW78NRzCnQ9VR6erTTkaBnyqUZM6mx
         yABgwCx5SfWIzPzr0wrG1lTGbGXPekCOJVAmpl+e3Qca5oZOcYVfhYQibN76YdZZE3qs
         Hu4wwEumjXcPzVa4sfKZLI3yeJND085lJZsQxMwRTj4Gu1YYAgRxzjzPwl+de8bFn8jM
         gbhC2nUmkXefur83vY0ddN0ieaGaahN8Ss0M3Ef4jvI47yhDNI+QLBt1STO78/QChG+o
         BlRc5Y+oCFvjYMuqklkkkR7Cp95vSIBf6JN5Vc0MykMGatlNx1mrSSHdgWCLacEDG8j4
         PyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172024; x=1787776824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D2v9HOgfmyEyulghzA5GwM4apa4ZL6DlrBvXj+54NVE=;
        b=LMKiZHiv0KT8eC2f5mb/1n1v482Rxza6QJ9L3rKUQkiT2AVsG2BvpCI1PkSPKb1efu
         MF6UCYVtcOzDOVpqdhHU5FQZja0RWgiKAZjFUEQHsbYCt57IXwK1pFGUxsR4SBgoob2e
         3oDloFF0nYHby9DbrZww2oB0rr4zWpO1pXUVlwKQezG8hY2e7iSIAu2iZ+DYEO9L8Kyp
         gc6bacysugai/RjXbrtUGXyf4J0Du5sbgS/KRjCzTQ6i3TEbTNADTATBflMfQZnUiM5z
         vKHPIgq+8heB7CzEpHaBFO+LA3emZ1d3nyS2u8mCIYyMnubRvLKSLZCn3OwTNLrE+NMO
         ZXmg==
X-Gm-Message-State: AOJu0YyHfDsviBdKIstbZvwKnwR+683/IREQaOYMCDI6UdRxHLxGsolS
	+TczZIVNpGqp1iUMhAwaW9Xn4P2lx500ySP5PUJtaMBXXfRAtHtsc0FMUgPJRCrF4m143w==
X-Gm-Gg: AR+sD12JdbkUpMmlF3bv6qQw3atB3Wlg7Mfg1HhqUYrOLic/Z+NmOx9bApA5uyX5Anb
	tUmXFnsksAIYNgBzUbsKKXRWi2e58H1iZPoTxnKYsouyJiJTScgtmUxmmTWaGtk1HtnALRJtMsn
	pnYsWndKzXpaEwbIphjiU60Bcyos4a9KGTcQGaovUyaZgAFVGNmP/S2wE9jmUckbTWONiOiZfXh
	BTYPtbfaKimZG8gnpt4Ue6KN/H2yQwdl3kNj58mt3RT/YDUEnAg/5rdlBCGiTeAUJxnJ1ygtxsS
	Fm2405OTwpGZ1ACjTu54byF13o26b9eZwiUG8Htbfn/tH1+e8KX2xzvQyXyB7rMws4Jf45zY9xl
	d0juBevxnF7pm6hHVNG3SGvc5dId4cR3tgX0H11u+KZ5FW/xyIhzTDZFViBUGPfXvMLWZLI5bO5
	JepSF1X7SHmfzQ5aMlwxp0CH95fkIX4lasVGugPJ3Fw63TGq+4/Ba44Jv6fFvMqMwSbLgfQctwk
	CFMo3v3ktFO/k4xhCy0Neb2HEGZb48SG0lRedt05ni0VKT3iHwYNdQ=
X-Received: by 2002:a05:6122:32d5:b0:5bb:d233:70bd with SMTP id 71dfb90a1353d-5c5e3b67087mr3280257e0c.2.1787172023897;
        Wed, 19 Aug 2026 13:40:23 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2486864sm3496404e0c.0.2026.08.19.13.40.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:40:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/8] shared/util: Add str2utf8
Date: Wed, 19 Aug 2026 16:40:03 -0400
Message-ID: <20260819204008.2292225-4-luiz.dentz@gmail.com>
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

There are five near copies of the same "turn a remote name into a UTF-8
string" helper, in monitor/att.c, profiles/audio/mcp.c, profiles/gap/gas.c,
src/eir.c and src/shared/ad.c, and they do not agree with each other.

Most truncate at the first ill-formed sequence, which throws away the
rest of the name, while the monitor replaces every non-ASCII byte with a
space, which mangles perfectly valid UTF-8 names as soon as one bad byte
appears. Most also copy into a fixed size stack buffer first, which is
what made the missing clamp in src/eir.c a buffer overflow.

Add a single helper they can share. It allocates the result, so there is
no truncation to a buffer size, and replaces each ill-formed sequence
with U+FFFD REPLACEMENT CHARACTER rather than dropping the rest of the
string, matching what g_utf8_make_valid() and the WHATWG Encoding
Standard do.

The result has been checked byte for byte against Python's
bytes.decode('utf-8', errors='replace') over all one and two byte
sequences, a sample of the three byte ones and 200000 random inputs.

Assisted-by: Claude:claude-opus-5
---
 src/shared/util.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h |  7 +++++++
 2 files changed, 53 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index e946214edbb9..8ec9b52e6401 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -2315,3 +2315,49 @@ char *strtoutf8(char *str, size_t len)
 	memset(str + i, 0, len - i);
 	return str;
 }
+
+char *str2utf8(const uint8_t *str, size_t len)
+{
+	char *utf8, *out, *stripped;
+	size_t i = 0;
+
+	if (!str)
+		return NULL;
+
+	/*
+	 * Invalid bytes are replaced with U+FFFD REPLACEMENT CHARACTER, which
+	 * is 3 bytes long, so that is the worst case size of the result.
+	 */
+	utf8 = malloc(len * 3 + 1);
+	if (!utf8)
+		return NULL;
+
+	out = utf8;
+
+	while (i < len) {
+		size_t sublen;
+		size_t size = utf8_seqlen(str + i, len - i, &sublen);
+
+		if (size) {
+			memcpy(out, str + i, size);
+			out += size;
+			i += size;
+			continue;
+		}
+
+		/* Replace the maximal subpart with U+FFFD */
+		*out++ = 0xef;
+		*out++ = 0xbf;
+		*out++ = 0xbd;
+		i += sublen;
+	}
+
+	*out = '\0';
+
+	/* Remove leading and trailing whitespace characters */
+	stripped = strstrip(utf8);
+	if (stripped != utf8)
+		memmove(utf8, stripped, strlen(stripped) + 1);
+
+	return utf8;
+}
diff --git a/src/shared/util.h b/src/shared/util.h
index 562a5af31751..1984fb75f09e 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -143,6 +143,13 @@ bool strisutf8(const char *str, size_t length);
 bool argsisutf8(int argc, char *argv[]);
 char *strtoutf8(char *str, size_t len);
 
+/*
+ * Return a newly allocated, NUL terminated and whitespace stripped UTF-8
+ * copy of the first len bytes of str, with each ill-formed sequence replaced
+ * by U+FFFD REPLACEMENT CHARACTER. The result must be freed with free().
+ */
+char *str2utf8(const uint8_t *str, size_t len);
+
 void *util_malloc(size_t size);
 void *util_memdup(const void *src, size_t size);
 
-- 
2.54.0

