Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1F239567
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388679; cv=none; b=mdmfeT0aS1UXghKLuwBZjTa7QgsddXV0YVWwmYlU6JbeOVdAlMdyA/TGLYuxu0lvaSeR54rGGNkx/IUxrv1uqK03nmutZxnpYLq31HSX7hNAjPkQhvQ6+FGLV4pzAI4dVE/ESn3P4BZ+Xd1qEt1IzEnkZXWJxQlVWvKTNq7GrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388679; c=relaxed/simple;
	bh=daM08XmfpxNUwQhVQvuB11Ui2ZHz2WrFCVfRzHNMOtk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eu6zRksA6++XS4+R78lVZSlsIpV3Qfoi3GnwYVTJs1PhwcuC1+bXzBZSuFYSYrVSkg3Wjidb0QJZR9M8EyIOdVymQbA/EejmxeexL7eG4v6lV9p6urdpGbImaqCQL0wDR1LQMbZr31IWVQHFu5/6fn4KPrIvFh1Jw+OoleVULzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi66zZPX; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi66zZPX"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87f0efa51c0so404580241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753388676; x=1753993476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGaONgRDjpfIlGtEfhl/2JX7fp252PYiRymF8vYYoe8=;
        b=Zi66zZPX1duhwVSzJ+nC23+e+0PgWwWCRUAkkapI8H78jXfdOVSOi1OofXo5hNirYn
         pkGoDLDjUodXpIvIy6xgIJcqIMYXO28idcJ/vxLdVQ3w3gH1kCbzy/x1AqObvlvofDkm
         XK5+o9SsDxryxzz0zjsDl0PFthmEVN1TYAuHvNDyxhOqoaoi/sRN13T0opMwnTGhuHii
         4YrqdQttiw4BpOX7RPbsRE2GwXPigckorH2zLBniNREyeZDYmf4S3Du/VxBXEViHHLR0
         huRihO2o3yWFMcqJRSxt8sQCgqv72Jkp1GpNPikqszomT+zw4X8EOoWIqqlRuRhKHlUX
         DNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388676; x=1753993476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGaONgRDjpfIlGtEfhl/2JX7fp252PYiRymF8vYYoe8=;
        b=fRBugIs9tlsfTqOJfj32bxHYOX/JrHxiwKaciIOc6Y5iJmNYjIiXcU5lEEqrJChDxA
         OINp0YRQWEJ+9y1wwlhjvVOfkaKbxBZ3xXxE7o10IGoPWSE7y5WZPhPNw03BCwqbW9B1
         uZ/MmW63DiZM7OKN54UBzavKs38OtgVY60OZyAzY6iO5MVSXxTW34KAOzZHjolH1jcim
         O1pIGudcAJii7uszTV7OpFBRYB37xu7yQeMuzNmP6b+qb7hyNnC1DBu1ulNRsq8eYqZs
         lS3r4zgS7Us0EPZhesKOTvTxOPHXaapPw4hJ41iKcZYpztvYvXYG7wNUT30HDe94E4jB
         kmQQ==
X-Gm-Message-State: AOJu0YxX0zN6vBdnRoGPzinpZxoh3wFKtJeH7nRmcjv/N+DtyoudtWqO
	dLqfa8S5bRYmyzqGRwBxI3B5whPvQiWLw92IW/VMQXnQHlxNL0Tk5u+MIFxdLA==
X-Gm-Gg: ASbGncuhbTA8gHghOrwUIXzh7AEwxyhdpFheydYzqgEOKcYVIDAFnIyb424cbvABYuF
	1V3Ma1Ju5WdTIR/ZXZy6crcFq/TM9HXyVkK6gNaqkamnkTizeZSEC3Toi6c1WLuR4nydpbEOkGt
	J3+tN0JrrC7H6hyENdfGr2F+GJak8LuroXx2bLMFGvkoRd0JCFYw7zgib17AN6gYvMyj2tL9S5m
	353C64kPjkoCrOTL46GME1jDxoWdV3eM450Uli7ERBkOTPjmuwntPJUVQ3vw+2Z/4I0rwL11v5j
	g6yg/3q9qUzoqkKkpZseMsCL55xFee7v+kPJ+/IHw/8d3Z+UOCWX8L+itLfbwA+w0rxjvl9zUP6
	Am+b2Etee59tgczbzuilQ+9ZZ0crffY4zpMSL/yiX555EszMImEahrA2LWQvH70MN
X-Google-Smtp-Source: AGHT+IHES6SB5VpXNuFUyTlEhDJbkEBwmOa827MkA2nTzq/kYgNrMvXlDq+iCXnyXCJTyGmtsIHiRQ==
X-Received: by 2002:a05:6102:4a8f:b0:4e4:5ed0:19b2 with SMTP id ada2fe7eead31-4fa1503a0ecmr4556238137.9.1753388675406;
        Thu, 24 Jul 2025 13:24:35 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-537bf89e500sm593413e0c.33.2025.07.24.13.24.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:24:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] btio: Fix handling of getpeername
Date: Thu, 24 Jul 2025 16:24:24 -0400
Message-ID: <20250724202424.6978-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724202424.6978-1-luiz.dentz@gmail.com>
References: <20250724202424.6978-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

getpeername can either return an error set in the errno or the
returned size can be invalid but in that case errno is not set so
printing it would generate bogus message.
---
 btio/btio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 30804cab96af..43275cb86e89 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1665,12 +1665,16 @@ static bool get_bc_sid(int sock, uint8_t *sid, GError **err)
 
 	olen = sizeof(addr);
 	memset(&addr, 0, olen);
-	if (getpeername(sock, (void *)&addr, &olen) < 0 ||
-				olen != sizeof(addr)) {
+	if (getpeername(sock, (void *)&addr, &olen) < 0) {
 		ERROR_FAILED(err, "getpeername", errno);
 		return false;
 	}
 
+	if (olen != sizeof(addr)) {
+		ERROR_FAILED(err, "getpeername: size mismatch", EINVAL);
+		return false;
+	}
+
 	*sid = addr.iso.iso_bc->bc_sid;
 
 	return true;
-- 
2.50.1

