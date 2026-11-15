Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794772452;
	b=rYeR353MWuM4F2ny3WUiCazIAeXOcub500mIO9u3B9glblgoQ7lF4VbXUgE5rts22Thi
	 yYl2DE7AF76ChgowkJ7t8YjSVVO0XYadtIc//m3RMBkaNryhwpVLdUtIA15jwzFEHvd/t
	 W0YTj7/wnr+pjcnJOiM1/skdU22XEuljJRR9IJh0QXCsbhNkgBFFG4b0IgKxbl5TiYxe/
	 peZJrfM1jRWNteKAR15e2RwekP1ebwP3mtllUdGtxN/2d220gENVW6HOzjZ+sgEDN6GjY
	 YbGDSix56dghrb6dIIVD78S3OfDjZYUC40Bm6v2uNqSov1TC+gwGUcgKrs0lyh3++/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794772452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IJ7CYFFRnuMUcOgQJTml1Hz82ZRZNC46Q6AzDn0dn2o=;
	b=3dJCNJ4BkWYnZzstSektZa05QnypDvDkT95es49TkFUjZM3k1eI7BQ8+Mo4cPi4Oqou9
	 QRPpBVqKFT5NwCSSdOmwzcjoMG3Y2KWXuZjmqwXVeGmDlP1+l01tqPcAfpRx/kprL8l7N
	 UeowcpTp3hl/e2JLWFxZVJLxLXzxCGugQO+qmCjwg9z8DwDMpYhCoNNazVZKCl8hSguiq
	 Zu3zlW9iNHRwG91Kh5V7AOVpfbjDJTxfBDvi5yRKTyap2mPy1/A7EFw2NE0/bJRkJXZXY
	 ffndh5XuPanOEqxrSlwiXk3mpGIdL8Dkp4F+OQxIsDaf2GM5UC6zNWlfEZmv7heNuAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UDeMwg09;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35955606A32C
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 19:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35955606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UDeMwg09
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b349d21fd1so16115197b3.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794772451; x=1795377251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJ7CYFFRnuMUcOgQJTml1Hz82ZRZNC46Q6AzDn0dn2o=;
        b=UDeMwg09StS3utRvtN3DD93DuW4CLS3wP/Q8u50maYfKcrbKu2D7P6BsKMO50y/hDH
         NFUEU+djKLuQ6pYk2TkFttNlMYN7iFUt9k6aSuSB+hOuFPfABf35J1C7I26MGlK8qpyz
         eu5dpOaHB7wV3yGhNxPdnTz09XGgxv/6ROJTfFkHuy821g3/Hs2fgn7kaKVAn21dRXUB
         QYcjJbVjgbdQD2xHA4g1kWgXGnYzaqZY7vVfkJr+OyX/LKQ6YhxLZ2IGrQv/L3L/cxNn
         7l2D84n42o+Iat5Tn7Cll3axUDEtinykdKR4eQ+/nGNbWFHAhkkTlJNLLRhgEzkmMrno
         pXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794772451; x=1795377251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IJ7CYFFRnuMUcOgQJTml1Hz82ZRZNC46Q6AzDn0dn2o=;
        b=2Hxy1Ahf+CXE7xmasr+bNf4vYsiMkbCw4bAkI3Bk/GFJX6lQTjiRAUe/t+8D87ehsv
         8QtRXoniot3EbebRiGw548QqNCFOLFGmixmVlbsefk8qYe09D+ibEgvCLjbkdDXRNfU0
         M/0mLKTC/IGlFGqt/4P0p1YC5YRazBCwSX14VWjn9RrkJ+RdQJ1+BxLBLmnQV9nnxIUh
         ZaifocDI/9sULOqMn4qfcoEClXVPhUQcpXIOtL9uZdypLqif//lZo+EdfRGTARgkdCD9
         YCAdUpaHC4F4nSudbXxZStc0x5pZt4kMGae4AcCe/imSPGsEjFAigR0r7tKXJJlULuIr
         hQWw==
X-Forwarded-Encrypted: i=1; AL+hErHpO4/KZliVdmI3sxshVgLvbhcWXWBZ3pUSMOAl5aR3fhQa9EklM8m8oECJRAUip29TE8WjxZyQGY5jRc4hyH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8U6mz36bpKYhDNy9ew+9/O31DxDVK2EUOadkD21rFqaXe2ue24
	+32lNey3QLXfbegL5YWbIYCcAvnfulX37BBsN07IlHLhB6u5418y3TpQ
X-Gm-Gg: AYBFou29jV8ayyXj1REN7y85my2Hp9zJ8FV28I9zR4rdItNRYeL8x30CCVKbCdCkwME
	BYlR9x21RYjcFNEgndkL63u77HkLrD2LJvBBVfjbe0pTrzAI+0ARg5GDQ6cRCoQuTMBhFPg04gP
	/EVQjFyQkafNp83oWTxIdpq7vIQDhWuAoTpeje+vaWJL9tUx0yojQksLYqWI02iiQ2TSNaiUBvR
	/hUeLA28+O4CjwC9TMt0LUkGX7ScEy0xr0KdqdtsQ41u6JROvAj8bZSgguGmtQbMucAK1aP+5ar
	joQw5rSgu+3RXGjOEX2ovY84TYPLXQMi3v9d92442HrlAbwcUQqsb7l98CYv71+BX54iimMShUH
	xFPFgVlU3M3uo7GURA+O9O+gjy8PsLH7KIGKaERSwVddk1Kss41/86MiYb64Mg41mj09I7h7cny
	vMWCwXLk7oFbh0NkKKs6SODMyDqlyJjqjjz43tHyQfu5k7Dc00bJu4SX9tZ2trXl3/mAjKlIEwx
	A/MYRmPrcjTnD96tKPnAV86bJpQhD+HiA9WQun0UTjiDKehk8bvaoDIn2O9PUIWUupozl7uCPJR
	SAeMM63nksZpTGd1NmFBNQd0XbqJj8ZX3AyUdQ8HpBvvURSvxCedF3G6IGGz41PLZtsm3Livkrd
	c8Kgsmw/YmzBVzSJHXfXC1cfXj/g=
X-Received: by 2002:a05:690c:6e81:b0:8b4:d8c6:4d9a with SMTP id 00721157ae682-8b4d8c6507cmr4656127b3.48.1794772451152;
        Sun, 15 Nov 2026 11:54:11 -0800 (PST)
Received: from localhost.localdomain (179-252-148-65.user3p.v-tal.net.br. [179.252.148.65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa9da90bsm69816367b3.37.2026.11.15.11.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 11:54:10 -0800 (PST)
From: Artur <arturfaleiros1254@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Max Chou <max.chou@realtek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur <arturfaleiros1254@gmail.com>
Subject: [PATCH 1/2] Bluetooth: btrtl: Return an error when reading the key id fails
Date: Sun, 15 Nov 2026 19:53:12 +0000
Message-ID: <20261115195313.20809-2-arturfaleiros1254@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115195313.20809-1-arturfaleiros1254@gmail.com>
References: <20261115195313.20809-1-arturfaleiros1254@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrtl_initialize() stores the result of reading the RTL_SEC_PROJ
register in the local variable 'rc', but its error path returns
ERR_PTR(ret). At that point 'ret' still holds 0 from an earlier
successful call, so a failed read makes btrtl_initialize() return
ERR_PTR(0), which is NULL.

Both callers, btrtl_setup_realtek() and h5_btrtl_setup(), only check
the result with IS_ERR(). They then pass the NULL pointer to
btrtl_download_firmware() and btrtl_get_uart_settings(), which
dereference it right away. The register is read with a vendor HCI
command, so this happens whenever the controller times out or replies
with an unexpected status or length during setup.

The read used to live in rtlbt_parse_firmware_v2(), which returned
-EIO on failure. Commit cd8dbd9ef600 ("Bluetooth: btrtl: Avoid loading
the config file on security chips") moved it into btrtl_initialize()
but kept the separate 'rc' variable.

Store the result in 'ret' so that the error reaches the caller, and
drop the now unused 'rc' variable.

The problem was found with smatch:

  drivers/bluetooth/btrtl.c:1253 btrtl_initialize() warn: passing zero to 'ERR_PTR'

The analysis, the fix and this description were prepared with the help
of an AI coding assistant (Claude Opus 5.5).

Fixes: cd8dbd9ef600 ("Bluetooth: btrtl: Avoid loading the config file on security chips")
Cc: Max Chou <max.chou@realtek.com>
Signed-off-by: Artur <arturfaleiros1254@gmail.com>
---

Notes:
    Compile tested only (x86_64, W=1, sparse, smatch). The error path has
    not been exercised at runtime: no Realtek Bluetooth controller was
    available and no reproducer was written.

 drivers/bluetooth/btrtl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index d29813331603..d2c2e79800fc 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1073,7 +1073,6 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver, lmp_ver, chip_type = 0;
 	int ret;
-	int rc;
 	u8 key_id;
 	u8 reg_val[2];
 
@@ -1185,8 +1184,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		goto err_free;
 	}
 
-	rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
-	if (rc < 0)
+	ret = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
+	if (ret < 0)
 		goto err_free;
 
 	key_id = reg_val[0];
-- 
2.43.0

