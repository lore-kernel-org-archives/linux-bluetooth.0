Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E2F3A7E10
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427397; cv=none; b=EJWOioTnl3ayvdw5QnCcFgBwwkQ7Hq5ZnI+bZDsgpNjfFysEmRvZEe1P7H3IXjX8j+N9f6ATEIwQsG4gaqdK3aOiAMEIgAGzkPo5GZ4SUJwqYP8slSGMMbsJA0kXUsOorAcc0xrqFdjRopf1e/Y2RkmlNZYd822vEX2Wnxr3Euo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427397; c=relaxed/simple;
	bh=JiyQTzShsanCdMhCFOuQu+3W2LB1zeTWbqEgrAt798E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OA/o3ZDrn744jjVpqJvLXET8bhqLwHrFQ5jp1+RgWWV7ilmOqnk7vdJNXclK6OSOeosW2zN+kWYCLKjgr+/4GypRpV3Pk5XPAdJvY3T8mg8aO7QWNJZCJCUSS5N8OJ1W9bFSZa9/5F6lJsSK06OTuA9ni5m7C33kb8dsY/18Njc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIJRDOf7; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIJRDOf7"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5636784884eso104798e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 13:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427389; x=1769032189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkF2VJJSDXUFFwr4555CnnMv7t7G2rRcFAEe6VI96ys=;
        b=iIJRDOf777RayB6ZD3zMc20Pg3VtFL2iqQBiU+bsRH1VU2mIoj9hBiFJntDxQgx6ie
         nY5R2orbgTiKaGFt/vAD1eFJbgwE9U6G/19F/0I/mfWuHj/RNYm8alLykMcys/KtecAd
         j/2wvu/q6vguhGTGlzcUE3I1ttUs939wAgxIGdnyvV8qU8KUyRu3r+XAwszbcc7QeIjN
         DrvluYBmIDuvwQnPfWw92i54hD4RO2FYQJIIEszfUtx99WJnsenzt/PV0J6wz9pE/Bdm
         yPJGhhmxvSzG8AY2tmMZsKwt9NBJaFsPv0Ich+vH9gFzdVNMUFzpYutgdC/95e5zKmWA
         Ddsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427389; x=1769032189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vkF2VJJSDXUFFwr4555CnnMv7t7G2rRcFAEe6VI96ys=;
        b=pUBzWvbYBRvK0SlJVnpTV8h2G2h/7ykxcc801sXna4jeVsPPE4WcPjTXBq9FeuWqwH
         7MFsvkzdBfjZvbKW4iI57g6OCHNHhUOef8RtUAbSZwKPGKcqNwEbENBjeGR+kNzIlAl0
         RgJpgGkOdjFbNvLOeuPizsCkSboij/94AWYj63JU1DPFtZTbwr4uewNoKJM6C2BbC/x8
         MzneqHy6FOk+/d+T8uHNwbnFF2WJ0YSoK131Y8Z8qkPx9ALZ9UU3duhMcPryuoBs+VRc
         Bd5WdCMpfWtOZ9FgkZ2m22EDAKjH6ToqCjcMwgwUiCJjglmo8+ZaJRCHlu4lxcmSaCOJ
         Afeg==
X-Gm-Message-State: AOJu0YxUWA2H90a9bLSecD1fAko5czSvKeeE6k542yQ5rM4MbKmY81rb
	XyvsFAhOvwzN8Y+Gt9xCOBFMd1Xzp1u0b5KnsqUOcXNP5oOy6SDpA3MYSDd0Mg==
X-Gm-Gg: AY/fxX7edMmxo/EygxH9bYOJ2PWLqoK8ZiwIopt8SAv+pWCmQ1/RsQHc7ji/owH3shh
	Uotj8/eyG8lOHjL1uuzUmZXitOp4jF2HnLTNeScJyy++vVPplZYPdm/lpFVtAbf2acODFWrmyKO
	q7Ti+hT+ubJRegfJfP8I/fSycAQfz4NYYMPIRqvQogGcWgXFQMFmcq2etEbH2AHrbpMqLDTbIjg
	25fD8g8FAQf2FcLv6OirOMUY49nt98Dx1JfsSVM9gIWe9OzOD8i8L9JpdaaG+jXjA5uMwZXWumY
	7FEZhMhMV13nzLC6kRsABjTkY0Ck4k1Odl26IHJVVn241sRUPiZ44f7gq6pVQY57LBB97lh59l0
	T54EnRkuaNlyqIwfQsuLahnpIfA3aoWuZmCGt2XzBJqIaNlKS/eeW69cpxyHrUfHgxaJwgDj5HE
	hg+zHRsCmHtjZ1ox63vyeiOajjVdFbUtVTG62PhtWoGO4ZOZiGyrc54jAjJ2OV+mBZYwXcy/ngS
	y01PA==
X-Received: by 2002:a05:6102:a4a:b0:5df:b5d4:e46e with SMTP id ada2fe7eead31-5f17f6544demr1745322137.32.1768427389448;
        Wed, 14 Jan 2026 13:49:49 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec772af325sm24985649137.10.2026.01.14.13.49.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:49:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/6] advertising: Use bt_crypto_rsi to generate RSI
Date: Wed, 14 Jan 2026 16:49:33 -0500
Message-ID: <20260114214938.1417430-2-luiz.dentz@gmail.com>
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
 src/advertising.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index ebdefcdb0586..5dc33c004f93 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -526,11 +526,7 @@ static bool set_rsi(struct btd_adv_client *client)
 	if (!crypto)
 		return false;
 
-	ret = bt_crypto_random_bytes(crypto, data + 3, sizeof(data) - 3);
-	if (!ret)
-		goto done;
-
-	ret = bt_crypto_sih(crypto, btd_opts.csis.sirk, data + 3, data);
+	ret = bt_crypto_rsi(crypto, btd_opts.csis.sirk, data);
 	if (!ret)
 		goto done;
 
-- 
2.52.0

