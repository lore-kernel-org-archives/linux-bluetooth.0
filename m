Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A982951C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869892; cv=none; b=uEBO1UJeJlDxY48r/pNgho4+bFn6a7zOqkNxuxx9cmfxdFznWlcadrnv8Wvgou3gOPgZmMYO8EeBg4+kmtaHn0T+1yGn2CrSLdi28r21mdNb3azvME7nEQG8Wk6BlOhmw7V6JRzd7OaF3bUtawCQE8qTxdOY2IiQvogYd34uGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869892; c=relaxed/simple;
	bh=nE0NWE1fFey8Y44xOvPHfv5x7bC6k6ZAvJZ2ASyd6Ko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9X47os/BKmgI5J+H+EbH2sJ/+EiEwDMNDIidW9GMcrAwP5iDvnJT4qOHPZiQW5x7vylOFurR7RBUH7TW+10/IjNoPCPvtbhJ5+1w9GfJySxu7UqvoGGKtpUt14CAq4qDgW51QHV7aFKyitp1trtakuNpDUMxRLLb3ieUvXoKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwojCkLg; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwojCkLg"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5240b014f47so2213035e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745869889; x=1746474689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB+lsq+QMlgAo5Jf8RjgkOhIMJ6zPfvm2iKuWTRT1bc=;
        b=ZwojCkLgq08WyUa3yD6xllqYmCrTeKgsWlrtwpeGoIHaZlkD8mleLndzogYh+Iwh6h
         LxTr3zHOq88gPVU97rsvmtDz8Hz+DUiZDYvT5ThbBrs4w17eXAzC609p/0CVLKXimT8P
         t7e+hNE5QEY+or0L1kQnetWOz2JE4Q1tI9A2qEPNvrS2S5T0cdk616PkR+E+QXw4qWxR
         QXKFwqZeNhTI9uEb6Nw9im4cDhj5HAI5EjnJ8oNFuHOLHRIcsSKt+6cRu6KyRuLytlfT
         nVBp9drG8LeMR6MIzOY5I0qRHJCvxjyozxnv4th7KZex8eNRzTnecVhMYKd0bbtkXi+/
         BNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745869889; x=1746474689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB+lsq+QMlgAo5Jf8RjgkOhIMJ6zPfvm2iKuWTRT1bc=;
        b=ocv0EdjuUA/WrTEzgLVbZUY9Ow2ZLT3jzpcFIZjcE5HMLuSgLfiWnbEBdmz1gyRt5u
         4nR5xfYswqC57dSyw1UX6XV7BFBlUFzIWE4Q0yaIHHHmC+/mSdxTMz0/ThpQKup3C9MQ
         udVHJ9josoiGsBhhOCFX+B+/xWDjME0S3rfi6Q/tpre0iZ8Rhgqy3o+g4rkPNr56V6J4
         zEg+8IEO5eTAQGEZSUyoO9IGLT7br5xoeINYzSzSg93EU8FNueKvJZO2ay7c89KJK5t+
         QMc95cwmPplMmJGmt9V0bc33j1dOit4+oKg6UbHH+BUBu7x1fQ7NPImxZZXI3232c2kq
         u1LA==
X-Gm-Message-State: AOJu0YxhrPzq0VjqzzIRgfowJyS4q0p7/SUc2ja3jbJNja5I+m8Pacrw
	GEpuaPgB2lPHdb3J+VN+OiBx4vwKg4rJfeu/Xlzq7fUe+R96ynnWUQjv+MSqSKw=
X-Gm-Gg: ASbGncto51qRVDtfJWMVrms7XRo3P7ebe91rYjH2gPm4lBW3nWK6cjuKrK9RmeB/NwJ
	aHbk5mjud0i728XALBgI2MRE8Ee/BcY8yhbRPzmd7DL/sdDImH99ZuwkUh9RGwEh82R7xpHHUOX
	JZo/UmYeLADxbkvmPRiIB8KYcGgo7AQSVJR085v91L+/mrJDMkRipHPj7THcoNf+RnQVRkytjT3
	5xtL6QIBs4nGZkctNgE6JK6fz4p12YI8vz9UmiRmEKGSF0EbA/GX+vyhWzFZ+HU+0+Ev4bsa7AW
	uDikFk6noUVWs4VUY9EQHxyQ2QrKdmpCtJ1dUdfMhTstBSTRoMqfhvE4RfPG8QqmhkEp+tSYHAL
	dcJPPsUql4g==
X-Google-Smtp-Source: AGHT+IFdIDKhnZIZllqpJfff1u77XaPOzQArZAoCFmolLZLYDv8/dKG7cjMWzpLNDgmcCY1BVZ/7Tw==
X-Received: by 2002:a05:6122:1794:b0:523:e9d2:404d with SMTP id 71dfb90a1353d-52a9716cd80mr6120575e0c.11.1745869888995;
        Mon, 28 Apr 2025 12:51:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a99279c2dsm1067669e0c.27.2025.04.28.12.51.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 12:51:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] client/mgmt: Fix comparison of narrow type with wide type in loop condition
Date: Mon, 28 Apr 2025 15:51:19 -0400
Message-ID: <20250428195122.2000808-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428195122.2000808-1-luiz.dentz@gmail.com>
References: <20250428195122.2000808-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In a loop condition, comparison of a value of a narrow type with a
value of a wide type may result in unexpected behavior if the wider
value is sufficiently large (or small).

Fixes: https://github.com/bluez/bluez/issues/1211
---
 client/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index 1946d65d2fe2..86b5879db8b0 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -571,7 +571,7 @@ static void confirm_name_rsp(uint8_t status, uint16_t len,
 
 static char *eir_get_name(const uint8_t *eir, uint16_t eir_len)
 {
-	uint8_t parsed = 0;
+	uint16_t parsed = 0;
 
 	if (eir_len < 2)
 		return NULL;
@@ -599,7 +599,7 @@ static char *eir_get_name(const uint8_t *eir, uint16_t eir_len)
 
 static unsigned int eir_get_flags(const uint8_t *eir, uint16_t eir_len)
 {
-	uint8_t parsed = 0;
+	uint16_t parsed = 0;
 
 	if (eir_len < 2)
 		return 0;
-- 
2.49.0

