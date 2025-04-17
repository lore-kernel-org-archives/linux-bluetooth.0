Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C445208994
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Apr 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744921283; cv=none; b=oNX2ngjeUTgMCRApHH094QoxRVaZr5rzSj3tIftBjvIzfJ+7bq6q/0QkgQfDUytES7QFEGYN6QbV9vwB6CRLFQZmTyzlPE87YOVsyWyciXRlcpRZl/aZpHguJKBMlSFVZdmftUo6ney5Wu38NiPorOIdenQx2pFKDCxmUGZZj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744921283; c=relaxed/simple;
	bh=W3tRjgLIlBbAYrA0alz6bY3VVbnWyiSXnseojb63g48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cahbKq1Qt0xBxUCFazs0g1J04xkvE4aWPJ5y4gq8rbhl0GoWKOJGtZrtwNMpKZA7/bvfzElS6aTeDbpPjbaiK8kE2We6EUORdQ/GCVnhqEIc2ImW2sVYT5LpKaEK+r6Hne/w7oker7utCQH3w7xcoGqQ9m1wbbiKor3/L/TwC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj0nSIQa; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj0nSIQa"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-527b70bd90dso521932e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Apr 2025 13:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744921280; x=1745526080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0po5prhbaCMTNp3gjwrPPTm2sKJN/2C0si9AKUMhZyc=;
        b=cj0nSIQadr6iKz9TYKasz6eH/8bSZe20uQFcAlTttImgw8irUlRdRey6DUzPfP7AEW
         rg3IlRQMiecjiDyHbpPTi2z4gRMx3wlS8oTDCC0vHspRb1vHnXrlB6bGFuhn50Vv3+iV
         SaiHydFAZEoORWnn9BUy7CbOna9rCj2OPAFSqZZWzD1JVR8P8dZs5pHQsVzahc39Pd9X
         7bRAQZpKlyWYqvO2d+trcr3OesMIKT/PxL+wVAIqk2nM0H6ahMickN5hH/PzQmq2yvDP
         S2G8vv5yHfEo/NYMSDOFH0VWWjAsNMPs6N/me3znQrrijrESYjsiRnU/RfJkwxEaspDi
         NEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744921280; x=1745526080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0po5prhbaCMTNp3gjwrPPTm2sKJN/2C0si9AKUMhZyc=;
        b=ACzxf3cs0u01qkbkedoLZtOdLkkFpsR7SMU3DXI51ZkVFAutHqE87+prmjFTTEDfHD
         RfdbloAeR+6BmmYr+F/Bz5u4HTnOmvtVlyJQ1n55JMOU/BHHts6SsjtMuLMKK4h//tew
         yZjoACXRNbEJ8oXEKs/0TvUbdt6V6AH+/FBvGHxYG4H7okYMv8mSVvjg4AC/+cDC1c5V
         NUlzDX1ZyCVL5TFOn7tSSqixNJ4NBr09q8loeNrJLpdNwfnLWrYnV8kOIr81kb/vjn7F
         uwBllcTuzZu9jrYCWGYshr46WskdSUHqDJHa+4pDiYhfdKrTTE+xDRMZrFeLaIHNlIWf
         tMdg==
X-Gm-Message-State: AOJu0YwyJc57ud9LeBGdRE8ugANJEG9gw6K8q/HEU68MPzcmG/qgwVhq
	ofOzuL85FGFMwp3WCwhbX5/rnAmC2PhmwbgwmaZRW2VjurEVRNdtZm1ByQ==
X-Gm-Gg: ASbGncvI8MHDbXLU6X4s7EawAM4Qn1/3f/JKq09iOd3Ud9ol3OrFQwDgky13dXLWfO6
	3eT7W9CdSQgJqrPPq+CukQzr9V+Tnt+LTsaXkY5RtuU27rvqDRaHD81JrXRcyNKoq6emedGxsfW
	eT0dllS9+8lRI6KuOQLd0XSOBKQCuOLDOmyoEePwCvmyo2/wsJeh5fL6Fw07LMwBKmvBaBnHLig
	Af2RE6MqLVjQu+/+n1OtzlQq8XTpByAMpqTwm7CGPov4CbKSJQ09pCq8UjT5Apt6k5/TLLyai+h
	DiOENwOEB7GrkOH9xUSQ2KJg5IRBDSAvOVpGDJjAbsK/Ec1JdmdlXihZbGqxstyO9HMbGEVT0eZ
	wwwXDvm+V6Q==
X-Google-Smtp-Source: AGHT+IHRbukQjy6nSNCGKnr3Q4nCfyXbAeLNjRAo53MhricIk04lpZJdcjhi/gn4zpPMWo2oQxsitw==
X-Received: by 2002:a05:6122:3c8e:b0:520:6416:56f8 with SMTP id 71dfb90a1353d-529253ee98amr707772e0c.3.1744921279761;
        Thu, 17 Apr 2025 13:21:19 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8776468ca4csm106271241.15.2025.04.17.13.21.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 13:21:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] mesh: Fix build errors when compiling on fc42
Date: Thu, 17 Apr 2025 16:21:13 -0400
Message-ID: <20250417202113.80496-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417202113.80496-1-luiz.dentz@gmail.com>
References: <20250417202113.80496-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

./mesh/crypto.c: In function ‘mesh_crypto_device_key’:
./mesh/crypto.c:436:33: error: initializer-string for array of ‘unsigned char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
  436 |         const uint8_t prdk[4] = "prdk";
      |                                 ^~~~~~
---
 mesh/crypto.c            | 8 ++++----
 tools/mesh-gatt/crypto.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index b7607bb83794..ab44baee3427 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -371,7 +371,7 @@ bool mesh_crypto_session_key(const uint8_t secret[32],
 					const uint8_t salt[16],
 					uint8_t session_key[16])
 {
-	const uint8_t prsk[4] = "prsk";
+	const uint8_t prsk[4] = { 'p', 'r', 's', 'k' };
 
 	if (!aes_cmac_one(salt, secret, 32, session_key))
 		return false;
@@ -383,7 +383,7 @@ bool mesh_crypto_nonce(const uint8_t secret[32],
 					const uint8_t salt[16],
 					uint8_t nonce[13])
 {
-	const uint8_t prsn[4] = "prsn";
+	const uint8_t prsn[4] = { 'p', 'r', 's', 'n' };
 	uint8_t tmp[16];
 	bool result;
 
@@ -421,7 +421,7 @@ bool mesh_crypto_prov_conf_key(const uint8_t secret[32],
 					const uint8_t salt[16],
 					uint8_t conf_key[16])
 {
-	const uint8_t prck[4] = "prck";
+	const uint8_t prck[4] = { 'p', 'r', 'c', 'k' };
 
 	if (!aes_cmac_one(salt, secret, 32, conf_key))
 		return false;
@@ -433,7 +433,7 @@ bool mesh_crypto_device_key(const uint8_t secret[32],
 						const uint8_t salt[16],
 						uint8_t device_key[16])
 {
-	const uint8_t prdk[4] = "prdk";
+	const uint8_t prdk[4] = { 'p', 'r', 'd', 'k' };
 
 	if (!aes_cmac_one(salt, secret, 32, device_key))
 		return false;
diff --git a/tools/mesh-gatt/crypto.c b/tools/mesh-gatt/crypto.c
index c65974bb02d0..0dc796f004df 100644
--- a/tools/mesh-gatt/crypto.c
+++ b/tools/mesh-gatt/crypto.c
@@ -902,7 +902,7 @@ bool mesh_crypto_session_key(const uint8_t secret[32],
 					const uint8_t salt[16],
 					uint8_t session_key[16])
 {
-	const uint8_t prsk[4] = "prsk";
+	const uint8_t prsk[4] = { 'p', 'r', 's', 'k' };
 
 	if (!aes_cmac_one(salt, secret, 32, session_key))
 		return false;
@@ -914,7 +914,7 @@ bool mesh_crypto_nonce(const uint8_t secret[32],
 					const uint8_t salt[16],
 					uint8_t nonce[13])
 {
-	const uint8_t prsn[4] = "prsn";
+	const uint8_t prsn[4] = { 'p', 'r', 's', 'n' };
 	uint8_t tmp[16];
 	bool result;
 
@@ -955,7 +955,7 @@ bool mesh_crypto_prov_conf_key(const uint8_t secret[32],
 					const uint8_t salt[16],
 					uint8_t conf_key[16])
 {
-	const uint8_t prck[4] = "prck";
+	const uint8_t prck[4] = { 'p', 'r', 'c', 'k' };
 
 	if (!aes_cmac_one(salt, secret, 32, conf_key))
 		return false;
@@ -967,7 +967,7 @@ bool mesh_crypto_device_key(const uint8_t secret[32],
 						const uint8_t salt[16],
 						uint8_t device_key[16])
 {
-	const uint8_t prdk[4] = "prdk";
+	const uint8_t prdk[4] = { 'p', 'r', 'd', 'k' };
 
 	if (!aes_cmac_one(salt, secret, 32, device_key))
 		return false;
-- 
2.49.0

