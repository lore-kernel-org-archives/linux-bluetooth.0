Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D818288F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833990; cv=none; b=QtM0mXjra1cHylZ7wFSCtuBXsrPlX0ePy4RNav2LK9fM8pTAhzo+kQhBF6LBECnBhYFQSfy6t8sGL/LMr6P64kbYCFeN5mBvq3mNO+lcJo9JRRc5qUmdteYUOIjPY/OurYn9rOoa7hQ+ErpxDJ57LP1ZUsFqMYW+EwcP46Vmtt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833990; c=relaxed/simple;
	bh=i+SfHuxrQCw8A/k+QyiOgepiYEFB+8Z7hYB6Pjdvx8I=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=dRyPH0KMZS5QCBzeUUW12zL/gmPHJLAbXG/UyjzlWrkxSCvRAZQxPEpHtyU58hHKeNvEYMRNoG+AxBxJIeeId8puQDaP+0r6HPkYneDxnMPbkorsGhTtyR7Wwj8ANwGio/CDhvv34Ooa/9YCbqv8jaaSABF7cmF+6Bt6M88NdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb9wskW8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb9wskW8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2020ac89cabso59717455ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724833988; x=1725438788; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EtfI9OdHmnQga/rERzT9p/UDuuyUObUsTKB20E2RlAU=;
        b=Xb9wskW8X0E5DYDbOAmtIwh4YIhL0mnyC73x3eUv0h6AYF+I3B9no7v9r1PWDY/gly
         nRTAbs+YonnCLvvbslyIc40KBwKvAQ6XlLSkk4rgTLW/b7TI2ZgcbLaGqRNCtltJX6i3
         ymPugXSK74wRxXYQFKvC/ATb8cp5mKExftayujdfAt9yyZfL65X8ii18TYKoSK1t3u1R
         p6rQWvWAvWfeDdc49wyj2BmJCl37P84b5hdLocHeKppq/+BGJ+qvEWSarHSIDgr/m4kO
         WxmqbPKtWj47eFBiD92BOvv//Xz2SBBN82C7gOcInsXlE0dXlLm10SxeWZB+UmoPaues
         ZV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724833988; x=1725438788;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtfI9OdHmnQga/rERzT9p/UDuuyUObUsTKB20E2RlAU=;
        b=osBluhqKVJbuG7I/t7L5UMw9TgS5SLDu48AOuTopwvt95Nc9vkSkUa5f7FLOD0xdj4
         Qo5ucBLDj1p8sWRY0Ul+E4ZguXAvt/VQyWaXL8q7ouZX0pgiMF7u2P4JrtA7H0PvB82H
         7fdMy4goZdFr82BEsqmGY9dn1Vu2cizLodWzhUevR3YzIo7TjFnUUBpjSOMTlvgJweKM
         SCbX3Q9R9dJHoe5aduaLMltUFAO3ReWOxIkqbPcWbQBOT8D/xJfhcH3NSdMcbbXBmw5W
         TcCnVfjyCkfxw5qTTtKJVQh3WKxIAqaFElTCIdWRwe+vEoNz3S8QDYFiVGPPDEaEa/3U
         p+Sg==
X-Gm-Message-State: AOJu0YwRS7y5A3bayTorLIJ9pjeq+hGJg2CdP2I7Czz/0TZACn7/Kxky
	y0AJICaZT6xrAM0+mXwM+I5GZetHIg0iwCi5RpoC6TjusDnXGkoat5S4yw==
X-Google-Smtp-Source: AGHT+IG+Mwa4VwnmSfzPZ6PJJFJw2/Pc0xHaw3jaSW4AFwEXgd5txMrRNvfo+JwxEuMI3gSTbloHzg==
X-Received: by 2002:a17:902:e80d:b0:202:4666:f031 with SMTP id d9443c01a7336-2039e4ab21dmr151118765ad.29.1724833988158;
        Wed, 28 Aug 2024 01:33:08 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855e1826sm94309785ad.122.2024.08.28.01.33.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:33:07 -0700 (PDT)
Message-ID: <66cee0c3.170a0220.a7c52.44a7@mx.google.com>
X-Google-Original-Message-ID: <Zs7gwUMkDX9a29IT@JUNHO-NEOSTACK.>
Date: Wed, 28 Aug 2024 17:33:05 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2 v2 BlueZ] mesh: Remove duplicated initialization
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This removes duplicate initialization code, as ProvTimeout and
Algorithms are already initialized when the data structure is created.

Signed-off-by: Junho Lee <tot0roprog@gmail.com>
---
 mesh/mesh.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 7b670e40a..49d252e5e 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -266,9 +266,6 @@ bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
 	mesh_model_init();
 	mesh_agent_init();
 
-	mesh.prov_timeout = DEFAULT_PROV_TIMEOUT;
-	mesh.algorithms = DEFAULT_ALGORITHMS;
-
 	storage_dir = config_dir ? config_dir : MESH_STORAGEDIR;
 
 	l_info("Loading node configuration from %s", storage_dir);
-- 
2.34.1

