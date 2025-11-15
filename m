Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163775809
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763244541; cv=none; b=oW510Z868/ceM3r+oPG4EFQzaIHP9MFRyfOb7dmpkYW1RB2DKl/Aj/zWtZn3xNPxK344OU7RLKWEwnZyz/nGzz0tS0ZxyduDFq6bRbgKniRh5cVnAPZ3a8MmAi3DfzKJMinpdZ35rTg2f+YFiy08vbLm2KZlmSH36WGCA2Tsxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763244541; c=relaxed/simple;
	bh=JPgifZhdxpnpx0amHjpL8ws+h0rmAPk5UYd+S/G7/40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsJc/PUac4XDEWu3+XMckKFbD18vAs7So8xTCRKuHZ/fNbckHkqUKGCiag/fD5xh/Z+n2WJdgBlFLT/fyAZGYPFnXBmBZYhGKB5+HjgbLYaNxzz/DjJTrezblUNCcHi7LoXAM68+jWQykU9HJwNWeuV5f919XqK9pYTFufvM1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA52TP1V; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA52TP1V"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-298039e00c2so39922125ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 14:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763244538; x=1763849338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jfjiEjkwSldNRwmakn3f2q//18+wYeBHCnQ2GQsm6Lc=;
        b=nA52TP1VheQt0HvZAU6slaU1PVdZa3dI+olgJBgGRr/Ezq5yGT4uAGrAzmb96WrK9I
         llF1ZOX1WBKYx9i/fIK/uzGt5rvHNcXBlI4CSsVLHYUiEuQoPZlDf2PgzPwm4ATKrL6V
         ca9jAGgvKGxa5rZ81yJJ22Yec1H/Pi66ZjUaqgo3ESyGBsshtAPx6g3UserRVGqECzv2
         KVI1YZzApC46Gx1y4PwQw8laSiYadFHrvSKr+pNoq2SHRV19XO6cK/Vrz9RECWsTtrCw
         OpGPNDczNhJ+pSb0PdMQI6b585ooJJF9pFZxY9nfi4QvDXDh7/0btYsAn7TIP52AR4RG
         3WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763244538; x=1763849338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfjiEjkwSldNRwmakn3f2q//18+wYeBHCnQ2GQsm6Lc=;
        b=XCrUdJJLzo4qPPHVpVcYM2IxTg0SMYiGC2oR/sFz46tfDuIi+Z4XWY9+FM0meG/GB4
         5CFKPUQjjNDIDdGvKwnRlrxSkoRqnMxofYX684hjTYxsKcXEFcfV/oa157sP7MTGXncS
         oF85NZPeQrX0VgGiQPffiQ9By+nn1koVA3d1ILPncwmcp/qkN8/ErzXGI2fp2BuNRF7H
         6tSS5sHQKAqXaNMi4oWGndVPx3/K+FrbQWLZLMIt2BohJvvwofS/ImClwXRf/DpJoHX5
         oGh+VA1nyzR3eFybPgJ0KmBqhAe7lh9zRC76VSh76Ez7nCRIatR9Sn26YALq2PwGVwzm
         zGbw==
X-Gm-Message-State: AOJu0Yx8UCDTsoo5vPpmlvBqvKLXLH6KEvRUOe0hEzCddLSU396NwYyC
	hBUS9WR/oa+LhqsscYFOz+tBJpqNRogp9yz4THEfyfgjAJLaUNIwZbbBTfcZsq9i/BE=
X-Gm-Gg: ASbGncvzyRkwxPd0hP6mS4xrtzO57yYPomgDW40IHWHv/kaTKvgMtnn/pJSe+uVRMYO
	my5OrPla7g5KILrqvC9aj1fR2Crt5Q0CD4FU8vewgsJjz/4wxu5pU9ll1jkH30wZDW20H/1cQUC
	CsnP05IJuh9m3yfWbArmKpA4RSSViIxNCib9XKqHHDKnJ8PlXeAeYWrwLGgr+QyAL+Eu8De7lj6
	6xHnSDSABGC50avekyoP7nBsPfytJr6yO/ZW5ReoqWwBDRBBvLL0BrY+y3W0z2xxJbQ+po3/5BY
	Vp/L6EzPm77au6sBmXgkJfr/cOyPBYwLFvm0tYiGFrvVm89kzUgMvS36XREZArdLVye/Ugm4+vd
	sFdLqEWnBNDnceyER1W7d/FsGFkfJV5/X1xHTElP6cWmHVgzfBDOI5X8HaMA2Kwo+I6xQvuZm94
	OVHh4ud7SEfpOCastLqpxG3ZeYkCvnMkahUcyJafnC9EfONwZw9uLTNo9o4jXUgQVwnWk7Uq9CA
	CSYOIG2tR+0PcveiCUM82IzNYf9
X-Google-Smtp-Source: AGHT+IH8Y9nup1ALsBIQNE6ZN2/km5vxkPv1zstoOI6vMmCv08ILu6Xdu9AFUf+JrGok1Y7n0jV9mg==
X-Received: by 2002:a17:902:e88d:b0:295:82d0:9ba2 with SMTP id d9443c01a7336-2986a6bd1a8mr89620455ad.1.1763244537942;
        Sat, 15 Nov 2025 14:08:57 -0800 (PST)
Received: from localhost.localdomain ([73.221.165.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf0d8sm94779325ad.85.2025.11.15.14.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 14:08:57 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [BlueZ PATCH] device: Fix the return type of device_irk_cmp()
Date: Sat, 15 Nov 2025 14:08:15 -0800
Message-ID: <20251115220816.98675-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from device_irk_cmp() is returned directly from
device_addr_type_cmp() which implements a memcmp()-like interface, so
we need to return an int() and a zero for equality. Returning bool
will cause false positives since false is 0 and true is 1.

Fixes: f1fb4f95f49e ("core: Fix not resolving addresses")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 src/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 434bdf721..26729512f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5422,24 +5422,24 @@ static bool addr_is_resolvable(const bdaddr_t *bdaddr, uint8_t addr_type)
 	}
 }

-static bool device_irk_cmp(const struct btd_device *device,
+static int device_irk_cmp(const struct btd_device *device,
 				const struct device_addr_type *addr)
 {
 	struct bt_crypto *crypto;
 	uint8_t hash[3];

 	if (!device->irk)
-		return false;
+		return -1;

 	crypto = bt_crypto_new();
 	if (!crypto)
-		return false;
+		return -1;

 	bt_crypto_ah(crypto, device->irk, addr->bdaddr.b + 3, hash);

 	bt_crypto_unref(crypto);

-	return !memcmp(addr, hash, 3);
+	return memcmp(addr, hash, 3);
 }

 int device_addr_type_cmp(gconstpointer a, gconstpointer b)
--
2.43.0
