Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608133B6EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250658; cv=none; b=TsqNFAG75AKz2XSoUsdjXuiktk1efO12HQl+mAipTFQHgXDy6tp/4CqDFcS4XZ2bkGrX7hFf8GTrQT+dBKF3vqxk+Sb4T+RBjEzQ/VhG3Wz9saLkMYijaQ7S1vUNx0WAVd81YoZpr2Fy4+PVORkp7KAXhs+V+GdjrR0bRKNNYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250658; c=relaxed/simple;
	bh=EIR3ceh2QbomtjaCrykjt8CXzQtsSAKostH6+Xno+R0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ai8FbvdrfcaBnKyWHWjihxS6OWIBJiCKwXgoG9RInc5c57ZCtQ6NviHvGs3ZTFJLNe50l4jR2cgCHT/OPOGM0zbCFElMqs3285Tc0UHxo46bHFAaYgztGX3LQNZRmWraOcldnklhwSDy2mWgnM0GyQT6lGrP1+NuqhKERi6lP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBnaw0Lp; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBnaw0Lp"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5c2c96286f0so130833e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250656; x=1787855456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D2v9HOgfmyEyulghzA5GwM4apa4ZL6DlrBvXj+54NVE=;
        b=HBnaw0LpjSW1BC5M7stpNStedjmwc7eu2LAxCPcZx0GN7KwuXfduP+G85EJKGXfZvi
         sLkRD9WWqEWlU5yZabfr8mSyEnB2PO7jGoqjtb0LgEvI+4bcwM9lH9IDP/kJXIoJiymZ
         bqbbVLR0tJ69qaQUD9288b77CqWJRz71LWKH+C1ZyEXQb71HA0CxDcdSEI5kLfdGGhL4
         BDoOaeNqZ26kxED6D9sJp6Ms56fCU5MaLQ+KQ15f5CgJAR7djQqe6MrAlzFrKJDnpJcr
         z0SUm4MiktRYPfkw1wRZxn5IGuK5DxVi0TSX8DFwNcFO2BEgKL8DL7HFq8tk1lQlyyiN
         U1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250656; x=1787855456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D2v9HOgfmyEyulghzA5GwM4apa4ZL6DlrBvXj+54NVE=;
        b=kij99/5Q2dFIbskzh7iqYsnIiP77GIqYVUddwBHVXh7lwYsQH5bHGRJvFOnjWLytxQ
         bcru8xCS2Qj6mk1SLbs9cDzbJVxUAPwN1mo615J072quM6f1J0+YVexo+KsGvhrozD0z
         1ZtdRTd4watPoe94uMuWla2zlnZ679cqy1ZIj508rayu7zAzE6aXbJMO3rVNN9RhWxj+
         EGS9IbXF8M/FESTAsLC/2JvZOJACY4yUgBM9xzggN3gh20TK6JtXGyUpgIaaDE1jBAl6
         jRnVc2yHEboqH7Ce/1BbSVGUenhys3sPbjubZq7Qcq6tN5YPERCBCq4t/guEIMdLNLtK
         JmlQ==
X-Gm-Message-State: AFuF++mukv5eCLeCcjhEEaygbwmolaahR2JeUIfRygfiLyjkKp1bO46e
	8C/515ln3Mod7WAXssr6PzaQrW4TTPnUqY/6EJst2QB847i7/vBBteT35DgGCslm
X-Gm-Gg: AR+sD10BOMFTtk7axbxM/Io3tRLltnUN/G0lso9BsffZYu65FN/EkXna2VoV3uBf8wy
	gbRsatYWu76wGYKzBqSN7vinyLnTvwsujG1Pkz4Ba54rM0LABDrBA91QUq8J1Lc6xx+rfcbuuLl
	UGNvKfI6q32mztbIqFZ873niTrmeW/Ewg03TJvBF26pZW6Hpjot8BD0B88dzonrDzPUNL/iQWEn
	tUmAxaEFrmK/8bE0tmpZAspNs2+U6XMzDaleQVcc+1K8mmidBi7xRJSA4fzlEJLj1ecpyFXdLHs
	kmPzAqOdwCfCD2hZD3CYzFrYaFelTN9ihF/6tmMVd8h7XtJ4+KiYpkkuDlphYqg8NH3B7DSlLnK
	+X+kU8R9NYFAFJRs+84kFWKy2rt+A9k9XsBZCJF60GTecApjTWRDD2WGM7sybYA7mRPVO16HGk9
	OpzYorlK+vC6UBndV0NmrWDb64Y7QrduIHCW0ApjcGJBmZtqP5OCnwr7f9Q2N1hdmGfLXNZaJfp
	wj29t/9pNtntoTih68t4dHwiEI0mbcpAu4JWr/B8u4rzYj9R1MsOIQ=
X-Received: by 2002:a05:6123:2e6:b0:5bf:6bf4:b215 with SMTP id 71dfb90a1353d-5c5ff69aa2fmr382672e0c.2.1787250655994;
        Thu, 20 Aug 2026 11:30:55 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.30.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:30:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/10] shared/util: Add str2utf8
Date: Thu, 20 Aug 2026 14:30:32 -0400
Message-ID: <20260820183037.2713973-6-luiz.dentz@gmail.com>
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

