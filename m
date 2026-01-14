Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE63A35D2
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427412; cv=none; b=jm+ku1xpeuKqAdcea3THbldznKzcmMRCyLfT2FrjX5rOd/sBw6AIsNTOQrgMZWUmP+cnAFjEe+HEnXHkVSYP619v3uvC0jdcZMwH/Oqtbp3FkJt6tCxaBg4Z/yd1OMSa37vmhRzXsSF8Aipm67wrfOcPFyho5fges/G0UuMTrv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427412; c=relaxed/simple;
	bh=L+WwTY5ED00gCcnTB2DWnsosy3TB78lvh1tTom6+KnA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PzNGd0+wuNUvCUqPsAtG24iS0HCN9LqHwY27UJze4riPih+WdauWM3QPDPxnl+L1YNGEwXJHmENcPG7wa95AhOPQVU2cpqz7lgFqD60qSEfiwRrOpzmzJ64+De8CLu3y3Bp/ohkdMgXb/5fUZKboW1y2A+r0qbSMEcPqjn+ZBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3+OATGL; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3+OATGL"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5ebb6392f58so104142137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 13:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427388; x=1769032188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VYfrxNZ+rhkRHvhmQxIT9jlWaeuUfbnfa7U9JXNqUO8=;
        b=G3+OATGLhZK9k8HGCl1+2etTu8M4m+ret/LO6tWBjbCrxuse4tICmNy8EOIoKKNhM/
         ir3bHM3sHSua+Srleu8pKBPsLvO5tzJbm5Mc332Wuok9tIWgtltbdUbBHYifpy147y2S
         x+y5O79Au/C7WLj8QM6KLt5fT4UYh/nWq6ziapNphqgcORuwGXAjFq/Xk7bJTtN2Kyya
         cnpbUL34Ec6LVkuIm0Bcp0hy7XOQFD/qyR5Nd+6qAbONnsEWUo2thmUaGUVOpaK0Q2au
         Lx2Nx30uyMLhC4tJOghdskpCdCFEhgFISHxkkaBLQDLZX1BcoATJ1NsreJMmix+2GOs8
         68tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427388; x=1769032188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYfrxNZ+rhkRHvhmQxIT9jlWaeuUfbnfa7U9JXNqUO8=;
        b=h9/BvXqKCrPc3TLHsiCx71H6Oz7S2j7ogaDHk7l7GY8IVbJpUce6vxbTFprTbkuPGD
         PsIxSd/I5Blb5aotmNxWugq8PX4Te6v2BbHt9HBo7gNPmsorTkVP1KzCcyjHozLxFCrV
         OB1q+PHmMCLANJ1vHjk5speoErRoNc8+xdPjXyZkaLgw+GMjhLWSXKvfoWL2+9g13XhN
         oNHT1jpsHWKSB4ND5d/PHY4yW97E8+OkKnZcLDiA9+EyBv4ph75G03ANmpCbv5IPXBiB
         spuRd1A5aN/At93YgBtXnxC1jFOxfphVByj/SHJCqUihDG4LM/qDj5MIEH3PTv9RK8vi
         ZYCg==
X-Gm-Message-State: AOJu0YwuD5C7joteUljwIjoJT+TE9XAxyeSF6ykZBH5pPXQfh9PfjqEH
	0mdnILFjHxF03tqRPjaxqCJocjuHEO72hRTx0twxfVolp1sedKl9ahdGOeH+Zw==
X-Gm-Gg: AY/fxX7DX/lNtIjJrIODAcZGkXwbw0QVFLpoiRIQXZPRz5xOJfdUjFW1+6/1D6hYTs6
	zht1Kwas1/9Zc29jYHqQzxpC5sjKKfMDJwia9AQXciUWrg58KhGlp97RiqwIJl+wPyNJGT8dObM
	5fHhVPVpLrussUSMQmSiBySW1D4SHQ81lybcRCpaaI5FmQH3hJPQCEvzCfdvmQBfm9J/ZJ6FDqO
	tZny05gi9UTwM3pEgtCkFW8Xaoq8ykIPoGqT0uDGKbfnufUbW0+xwczjZeesqFlIjoZ4zQXkzxL
	vMY3AjKEoHlC42qijlU+6NypXAytuUFYdIkEe2wvAYB0oRwQrj0bzsvcJYIVdzTztO+R+/e5fBK
	W8t0eDvZCYM02zgzBmE2qpzYZ3ru5ZYreG+Kcw/aQkLP3nY+nPI5fharvCXaBHrVTS0hLN0r7bY
	sjlZ2+hMb+1BLoN+lAousn0ttbw2Bc7oeNlxJD4U118MpxbsQGsG8KjVkaSk19pNlwbaPhL0qeg
	wo6AA==
X-Received: by 2002:a05:6102:dcc:b0:5ee:9e4b:a81c with SMTP id ada2fe7eead31-5f17f58e155mr1815386137.22.1768427387603;
        Wed, 14 Jan 2026 13:49:47 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec772af325sm24985649137.10.2026.01.14.13.49.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:49:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/6] shared/crypto: Add bt_crypto_rsi
Date: Wed, 14 Jan 2026 16:49:32 -0500
Message-ID: <20260114214938.1417430-1-luiz.dentz@gmail.com>
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

