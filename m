Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0A325732
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510461; cv=none; b=csE22zpcdG33Uo1BjODtR41AJa3FCqCF7y1vnRA5Fs3IFz4fGpLEIkSZpE9kMody4LiqbRx19uPFaqEVEPwgUCj7FfA8lvkS6ZAO5f5ABZws9ykUb53pGGQOOejcf/DAKEagsmic1HfnczLE1eCWF2LHc1FGjyfY7EglH8ekhM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510461; c=relaxed/simple;
	bh=L+WwTY5ED00gCcnTB2DWnsosy3TB78lvh1tTom6+KnA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G8r7DXC4VXeuQxP3RvBI7T35M7Bo+f6pC+w+OSb/OcMVhRQjcYFgZlZCTFYgH1P7eN+Ze0kqCHDj44mieYkLqmEDtrWg4tXIDzMGLXnGG1R5z7hUZXqqZ/muOoEofgAU8B5f04bsbG22izcbinMaAtE88nBdhX4kMYdl2Qh0dII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAKqDCOc; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAKqDCOc"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5636470c344so993211e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768510458; x=1769115258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VYfrxNZ+rhkRHvhmQxIT9jlWaeuUfbnfa7U9JXNqUO8=;
        b=LAKqDCOckNsmeuycjjGyMCnpBxVJj20AC5XwbukY1b5BLr34YzHg04yg/fY3k55bx7
         M+bFb2Od5rBbRv78+blEGVUXkVQQvO8z7kQ3FecWnLZd2f3bDX/N3EkckD1wOk63ngND
         I9maG3K0IS3ZqmsGqXGxDE7kl25sW/rsh5ftB+gQuw4dYifZPxEGyXhMprQG7yWMrs+0
         Ua7K4+ZMawvHdIkjLD/Esl/8Zxv4xzyWFSVaFg6B8Y8xpw+AUKzpI4YsK1aMCqxfQiKP
         wvlBRHHU6BtKzH7eBAPfOMSzsKyTKv8cT54w6rsKuQBdQin+lnqMN1lEkeT7/GEwSB6R
         YaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768510458; x=1769115258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYfrxNZ+rhkRHvhmQxIT9jlWaeuUfbnfa7U9JXNqUO8=;
        b=J2Q5NqbTpe9DAUmbTQciz47HbPKksWYP++tpVoLhlUMfNbtviIECd0zbaNjSqn+yJ1
         42iIxTlfmH29sejnOGoJHHfxsjA+eZoWxpsTs63nMtcSfsCrD03YZdecEpuic3vf3ZMJ
         3c7pJrsbWPgwDZTKO9lGZ9beNli94P71AKPGL7sJG5H2xQ4o5MHQwStx1h3C6ifACRhn
         n35nZv3UcWaaVSkMdYru6qwtHoabj+/x0i4si667Vgmz9khKzS40oDZJ1kw1qpNGjOmj
         hWDOHaAAk/KLssDJsPncJtmWyjRpKemwhosU6uYNKj+/skUfLEntWzpVYUluFtCNhnEJ
         jvsw==
X-Gm-Message-State: AOJu0YwMkUt0B07Uj47G66ZHa4V0gnysbc8plTCvvXzgtMdDZkSTyeo4
	s6i8IYqIuUz8pmT25zk/mM40d16H5wV5SbtEnQfsYh/x25kdUpYmLEIJaryB4IY0
X-Gm-Gg: AY/fxX6Fr8geU13BPF+6dtYCa8QtbDhx+PaUMhMnYSVGvF6aQaQ7LoU6sHsw2v7UGNI
	Z0zA4q2sby9De3Jm1cYMc2uhEmRkMWIip2mcmpkvnpsTntsELvL5GPsqpx6CU7NVKYpJ1XmuPvC
	Br1AvbbPh5CjSOOu5ZrUWTlzRVYrHmWmCSgvpxfocyGajw2GDPMwGioLRSIGGMFlxGF9lgkbdLj
	cGFwhdnr54M2S08h/LinXKJBYHQ9sXGARgX7BuSqFiEZD7WlTs4SZ/I/BzUHB39eEUp+7duyrwx
	JDUFdK0l5BUgbQDIG1YgTzIKjFukfHyhOcufyVAXo5edKDcqTlqwcZ4QRQca0UhXKV1yfXB2OPZ
	LgoP/oRJ56eVzIJ4zmkVhZHU5FP7ZZB4GksjafV4bnuHtR/Bucj5YEs4WbxGZBm0qG8VDO3WQ9g
	86Yjk8jPBysWX5Unf90UIBeKuGlLDdzMBH7htdjYEaaWH9qkEY8eKL5ntaCQGRpmqVbzJz9x5Jc
	uHpow==
X-Received: by 2002:a05:6122:3a15:b0:55b:305b:51b7 with SMTP id 71dfb90a1353d-563b5cedb84mr509616e0c.20.1768510458442;
        Thu, 15 Jan 2026 12:54:18 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b6ffda3csm167159e0c.7.2026.01.15.12.54.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 12:54:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/6] shared/crypto: Add bt_crypto_rsi
Date: Thu, 15 Jan 2026 15:54:02 -0500
Message-ID: <20260115205408.1554101-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_cryptor_rsi which can be used to generate a Resolvable Set
Identifier as per CSIS spec:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/28085-CSIS-html5/out/en/index-en.html#UUID-4dc0c19a-2900-d43e-6ea5-e651151d3c3e
---
 src/shared/crypto.c | 39 +++++++++++++++++++++++++++++++++++++++
 src/shared/crypto.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index 43d7f7c5c4b7..cb9911682c81 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -788,6 +788,45 @@ bool bt_crypto_sih(struct bt_crypto *crypto, const uint8_t k[16],
 	return bt_crypto_ah(crypto, k, r, hash);
 }
 
+/*
+ * The hash is generated by using the RSI hash function sih, with the input
+ * parameter k set to the device’s SIRK, and the input parameter r set to
+ * prand:
+ *
+ * hash = sih(SIRK, prand)
+ *
+ * The prand and hash are concatenated to generate the RSI
+ * resolvableSetIdentifier in the following manner:
+ *
+ * resolvableSetIdentifier = hash || prand
+ */
+bool bt_crypto_rsi(struct bt_crypto *crypto, const uint8_t sirk[16],
+					uint8_t rsi[6])
+{
+	uint8_t prand[3];
+	uint8_t hash[3];
+
+	/* The random number prand shall meet the following requirements:
+	 *
+	 * - The two most significant bits (MSBs) of prand shall be equal to 0
+	 * - At least one bit of the random part of prand shall be 0.
+	 * - At least one bit of the random part of prand shall be 1.
+	 */
+	if (!bt_crypto_random_bytes(crypto, prand, 3))
+		return false;
+
+	prand[2] &= 0x3f;
+	prand[2] |= 0x40;
+
+	if (!bt_crypto_sih(crypto, sirk, prand, hash))
+		return false;
+
+	memcpy(rsi, hash, 3);
+	memcpy(rsi + 3, prand, 3);
+
+	return true;
+}
+
 static bool aes_cmac_zero(struct bt_crypto *crypto, const uint8_t *msg,
 					size_t msg_len, uint8_t res[16])
 {
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index d45308abf90a..d85f807fe468 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -60,3 +60,5 @@ bool bt_crypto_sih(struct bt_crypto *crypto, const uint8_t k[16],
 bool bt_crypto_sirk(struct bt_crypto *crypto, const char *str, uint16_t vendor,
 			uint16_t product, uint16_t version, uint16_t source,
 			uint8_t sirk[16]);
+bool bt_crypto_rsi(struct bt_crypto *crypto, const uint8_t sirk[16],
+					uint8_t rsi[6]);
-- 
2.52.0

