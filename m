Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AF142E98
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850230; cv=none; b=p9HJhzI/Cj++6qXlB+VGfs+azpsTUgq+eIWYToLWhp5qD2HHdbDHFaUuFZ7dsysmkDh/1WnOKvTfC4GFhj2IMYzJ06K9zAaYzzZ/DRo9OppcnOZBhx471sDQCJ6glWu1bjJXwvK8aPKtuKnhx/UXTR6iuSO7mqMLMUZ0Pa3ZIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850230; c=relaxed/simple;
	bh=775yw1FtGK63PePq+QzcMwFpusP36M4cfJGURqF/dsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YScOLhPNtL8USKb3CkNmXVUV/EqZwITfR7Y1jaLdeAXkbCrGIZdsnf4BkcnyWWQWI2jBItNJBj7uh8MRnf9MrvcCsY4asoQY0y7a0klNOhGHPynW/FnAv4NHVSfQQugSh18pokyiw3DqiXw2LgwoCA2yUHmRpUEnyM1ntQ2jTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90A491C0009;
	Thu, 16 May 2024 09:03:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 02/15] shared/ecc: Fix uninitialised variable usage
Date: Thu, 16 May 2024 11:03:06 +0200
Message-ID: <20240516090340.61417-3-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: UNINIT (CWE-457): [#def41] [important]
bluez-5.75/src/shared/ecc.c:869:2: var_decl: Declaring variable "pk" without initializer.
bluez-5.75/src/shared/ecc.c:885:34: uninit_use_in_call: Using uninitialized element of array "pk.x" when calling "ecc_point_is_zero".
883|
884|		ecc_point_mult(&pk, &curve_g, priv, NULL, vli_num_bits(priv));
885|->	} while (ecc_point_is_zero(&pk));
886|
887|	ecc_native2bytes(priv, private_key);

Error: UNINIT (CWE-457): [#def42] [important]
bluez-5.75/src/shared/ecc.c:869:2: var_decl: Declaring variable "pk" without initializer.
bluez-5.75/src/shared/ecc.c:885:34: uninit_use_in_call: Using uninitialized element of array "pk.x" when calling "ecc_point_is_zero".
bluez-5.75/src/shared/ecc.c:885:34: uninit_use_in_call: Using uninitialized element of array "pk.y" when calling "ecc_point_is_zero".
883|
884|		ecc_point_mult(&pk, &curve_g, priv, NULL, vli_num_bits(priv));
885|->	} while (ecc_point_is_zero(&pk));
886|
887|	ecc_native2bytes(priv, private_key);

Error: UNINIT (CWE-457): [#def43] [important]
bluez-5.75/src/shared/ecc.c:869:2: var_decl: Declaring variable "pk" without initializer.
bluez-5.75/src/shared/ecc.c:889:2: uninit_use_in_call: Using uninitialized value "*pk.y" when calling "ecc_native2bytes".
887|	ecc_native2bytes(priv, private_key);
888|	ecc_native2bytes(pk.x, public_key);
889|->	ecc_native2bytes(pk.y, &public_key[32]);
890|
891|	return true;
---
 src/shared/ecc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/ecc.c b/src/shared/ecc.c
index adaae2082e1f..02bccbd430f6 100644
--- a/src/shared/ecc.c
+++ b/src/shared/ecc.c
@@ -870,6 +870,8 @@ bool ecc_make_key(uint8_t public_key[64], uint8_t private_key[32])
 	uint64_t priv[NUM_ECC_DIGITS];
 	unsigned int tries = 0;
 
+	memset(&pk, 0, sizeof(pk));
+
 	do {
 		if (!get_random_number(priv) || (tries++ >= MAX_TRIES))
 			return false;
-- 
2.44.0

