Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2789389DED
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427410; cv=none; b=KUt677pcHunACWHQ43tOjD9KN6M4otMX0j5+cepEuWcKsQjxdtwvCHxRPJx3Nk9yJ+U3X/BlajK7WWiJubx3gyhhsUkoGLfv1pjXpWZvfbjcQ8sxMsS6Wr97bIKnuD3hKXecTyYExsbWY5TCalP4tlkP0NHzLvwjmKSRa2bPe00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427410; c=relaxed/simple;
	bh=oAR1URnNPH2eS2RtIFe4En7Jbii/zW1IdRoqDtLGjco=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiE0QR+vGQ2upyWZsCyrom6YDUzWTf6YTbgnSdbfTJrV1vi95Ire8DSv+Mn5OUOEYtNYKGyINtpL/a9CRN788hZFwqdXxLZYOkZ/TeBF37NFlYRRoO07U6oVyScjm6UAo8lyeZml0kf5x1zj/Y/wBXPce215/Hf1kWGQ9aaRUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6oAO1bh; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6oAO1bh"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-93f5905e698so120548241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 13:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427390; x=1769032190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEtkl6IBgGOcg/HNydCp7KRkS0Gnvn1l7q8KFElfSwQ=;
        b=c6oAO1bhyLVsa0dS3VQ0wKDPLKeFuRwsUPewFz2cquC57TT85j6r3e60I768zpsOSA
         +E53D597ZyjFWoiHcIeWFIQkT5h4Kafdb4Vx8iLT6xrbnIEh2uji7pm8K9Qoz9xkSQkR
         WH7/OsPnuz3vsOD5nPUff3gTWl2WTIw7tVzB6qciWrrl6OgX2dh6z7ppxyvNimi2XtT1
         YykOm/kvxuJehCJ1nTcX0wt+Ck604X3eIfPHK5Di6sgtNx5gWYiNOZNKFBFLr3jNK153
         TUw+fm+oDT1Aln7gUUPl11hzLCgFUXAq/HjNBgs//+5xLlprwpoaXogVwYcSYgJrPSAq
         QlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427390; x=1769032190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KEtkl6IBgGOcg/HNydCp7KRkS0Gnvn1l7q8KFElfSwQ=;
        b=OL+H+aAi9OcmOAaMl6uXmFGioq8rZLE1xClPUFzGbPNv/UXxEqZ5Qw+VBcKzESZ3dX
         J7bTArmncvAcMO9FRNubm2pssGRvabV3QRk4Dif1NYO4tUxrOY+e/jNqePEwuuxyQGlG
         h8GAemDzQb2tX4f2jLmMXFH8EVRiWoMdPd7jRT69HOoS7GWhI686kgY150V1DW6Y3NyK
         0AwbECDaRNk7PBYKJGXSyE/umMwttZ9ZRL+Jb2nTvpXqydMD3Bd4a0ofWxPuRYeYWbIR
         A0SqB8u5wO5vXBfxMiBj+1DM/ON/LX1oa8wkGpqD8nMcLGfuf563Fc2rRj/hWQiLlCVj
         mwsQ==
X-Gm-Message-State: AOJu0Yw+3ip9LjSoFtEHATqWaNho/hg67di+zn1GYBO1a61dlgf8nitU
	FampGsZnqWMxaPo1npeKKhGwyzp97bHYUUMkme3+TjdMhYz5TDiBDz7s5zgRkg==
X-Gm-Gg: AY/fxX6vLjK52BNwtfpjgkNW1By7H0gaAhJqzxf1vmZGX4uthQX/1/3/xzsGtqXP1FR
	ynxxXxb1LyVFhkO44aZodhDk5f4TObDdgrK/qlj1XknmwNOZpvgKfTrQNEPe+/KV586M4XcyLhT
	1raba33yIDxm/W/jl2SW6GWrHY3GyBRiw4H6WoyP1TuhY0+BMG3atO/cZSty+N7m0pfOcQrUEBd
	MEhnPIg3gJ043oltihPF+yLflL6rBfaLSb8mYA6gXMZiAqUk9HdUxAM/nxPEG8APJRAHwubADMW
	pWqtBZoTp1ZfrQe3+MHKesqrERt2WWiGpXVug4vRenNv0JTHpnNUWGMsQaV1UIoILfD4TvYaIQl
	o/lgmyQ4RTubcakWFHLfglksgdjoWBfJMd6ctLbRqB5sFRPPadVOMubuQEci1DJSUz+EyUKWAtZ
	R0rjZ0vn+nmAI/KjQXjSxDyTGKNJ+kPzA1s51J3IN99o8+fQlwjBuLayTs+F2DtTXDMV2Ly4r49
	Zfq0A==
X-Received: by 2002:a05:6102:54ab:b0:5ed:f26:5615 with SMTP id ada2fe7eead31-5f1838c5470mr1318451137.18.1768427390414;
        Wed, 14 Jan 2026 13:49:50 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec772af325sm24985649137.10.2026.01.14.13.49.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:49:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/6] advtest: Use bt_crypto_rsi to generate RSI
Date: Wed, 14 Jan 2026 16:49:34 -0500
Message-ID: <20260114214938.1417430-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114214938.1417430-1-luiz.dentz@gmail.com>
References: <20260114214938.1417430-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_crypto_rsi to generate a valid RSI.
---
 tools/advtest.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/tools/advtest.c b/tools/advtest.c
index 8df6923d2f2e..706b2503b74c 100644
--- a/tools/advtest.c
+++ b/tools/advtest.c
@@ -75,37 +75,13 @@ static size_t hex2bin(const char *hexstr, uint8_t *buf, size_t buflen)
 	return len;
 }
 
-static bool get_random_bytes(void *buf, size_t num_bytes)
-{
-	ssize_t len;
-	int fd;
-
-	fd = open("/dev/urandom", O_RDONLY);
-	if (fd < 0)
-		return false;
-
-	len = read(fd, buf, num_bytes);
-
-	close(fd);
-
-	if (len < 0)
-		return false;
-
-	return true;
-}
-
 static void generate_rsi(char *val)
 {
-	uint8_t sirk[16], hash[3];
+	uint8_t sirk[16];
 	uint8_t  rsi[6] = {0};
 
 	hex2bin(val, sirk, sizeof(sirk));
 
-	get_random_bytes(&rsi[3], 3);
-
-	rsi[5] &= 0x3f; /* Clear 2 msb */
-	rsi[5] |= 0x40; /* Set 2nd msb */
-
 	crypto = bt_crypto_new();
 	if (!crypto) {
 		fprintf(stderr, "Failed to open crypto interface\n");
@@ -113,8 +89,7 @@ static void generate_rsi(char *val)
 		return;
 	}
 
-	bt_crypto_ah(crypto, sirk, rsi + 3, hash);
-	memcpy(rsi, hash, 3);
+	bt_crypto_rsi(crypto, sirk, rsi);
 
 	print_rpa(rsi);
 }
-- 
2.52.0

