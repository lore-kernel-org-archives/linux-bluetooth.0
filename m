Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE5328B7C
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766547102; cv=none; b=Lng4/0H83ACIbLCASIogucz3tDupZFheWrMWviUnGHKyqDkEnKgdWQ9uO0aPWkc3NNVPwRr4i2oEYybAqke5FnRnLCE3C8YLWDTeAn6y1GE+eAtvO3YkE87Ngd/rebezahgfBINVQm1B/z/ypPY6w2RBvvOn7Jl/MyugJhQ2t/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766547102; c=relaxed/simple;
	bh=deVnyPIVydF0fZhrRLElybEz8ABtjDTI4lsglJE4JqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNTowPjLkGhC/XQRJl2EoYy9mI8/tBrQIwG+Dvpko2DOFrdALUi/VeSzSqkeTPYquxEVIDS/rpOsu9A94+Trtd655Gl4WTekjj6ma/Bh3ptdaOTgEDCEB0P9YNrRfDdrNx+IjyAE08aJaANqqCa3V9cn7g/n8cm85s3DYUMgze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehB3Ohsx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehB3Ohsx"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so5980188b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 19:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766547100; x=1767151900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYiMf3+z0Jg8bkyG4dAD6VPBbKx2Mvr0dfYj3BEYY1s=;
        b=ehB3OhsxEhGeJE/uRqCCnc4Dp7fSBVqa45yKICCG/IvkUDkT2+W50cNT7k9hwjLzZZ
         FqKgohcwYtv1ePrwY9t+Zba908YaO+La3o34i3XyTz5tuucC8/7pxZLJQ7Kw3hmQbEfb
         ehzhuwNuzHzZlUco7+Chk52HupuMTFPfsQ8KlB9AXxnCiwAXHgOYjWG1QuIhgAlnKijQ
         rZ6YtyY7tHCBcwf9BNU7E9qCL3BMfVPUKQo1YMahX9CQo+Ig3ZT3zGnZAm0MVjhqp159
         L1MusJiXuZf2u39TNicOWOAK4jH1LY3zKy3jdEDnWauLGzVUOJCMAEsQeqhfGAc2v87T
         vF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766547100; x=1767151900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYiMf3+z0Jg8bkyG4dAD6VPBbKx2Mvr0dfYj3BEYY1s=;
        b=HCsV8b0LJX3bdAAhRywfg2h0nU4eXi5JlpXdToQr+ScvGHh0svNl6E1OB5IY9gdEUN
         /50t/f0lNwdzlHU/w+W6loix7OQrNSGfUDmjdD+vp3+sOUwB7h9nUax/pDdCmneaO3l7
         eP/TINTMEFBJg6BTB1ofz38aYM/qMutqEGKOKqvxg33spyo+hUQvOSZlVRdIwKNrJUUK
         n6SFrDEBX1k7skAgeWQAOHfWzrKytXrACpuopFy34np5fa7TxzA55BYs2UdhFK54cWwi
         2eksoPvTpJ5YXwp1nk/VEfs+m2k6UZjuK4cJPXHOCYQUtAHgzd5+tSng9R03yHYwdgEe
         S+3Q==
X-Gm-Message-State: AOJu0YwlpBMTwkQfpAJeE8iew98ReGfCJiKgYEKZdGGC/p1Q9fCLSTQr
	XUhLV7en6TH08YmuCcWoR8ceWzm8XqszywcmueoKQ/s/o3ZGwIgCZ4ca+AvvQQ==
X-Gm-Gg: AY/fxX7PMc9A/wo8SkcmtFETXq6jM0UY63Qrvyl5ehqBjjqomMee/8bDFShTnHPb6jY
	zdiluRxDGWTfZLA3rrvQJKbiitBKtTOMNSVCV57XlYKsjIzb5t8B7VkeYho8xiYjFhtz4/u46Md
	0+0i/tPNTFZwwOsEUg2ApQz0svYZ2hDVgXwxHF2wZOqev7fAjuFf+iPxKDQ9/bO2HNIeVx51rPi
	haYqr5+MBu0zNdJVTcWAxkJiRki6ZIAknQNHMYnLhrG++IuVjrlFkAQobtg/ZnwDjEG+0ZwH43g
	ETEmDvyWk/MAYhUMddQS6nuwh6JcLNPBHy04COL7IMg6NomOdQNSqxhpsXv/jMlsVOzmgaHaJvo
	xc7wwM+Q/WE6VVOspJPYKEfBEmIPU26LXnqNwGGgroDy60yMq2QaEPEXaRg9KtcGtXTjJ4cClyy
	A6ynf8xYWN5hSm
X-Google-Smtp-Source: AGHT+IE98dbnTP+rvifLWlbwFDLsfu8ID5bCfnyiDQrpzfnOkEG8JGBzRgbgUzFmBKMWEGI+TEHY1w==
X-Received: by 2002:a05:6a20:3d21:b0:334:912f:acea with SMTP id adf61e73a8af0-376aa8f39a6mr15858922637.59.1766547100203;
        Tue, 23 Dec 2025 19:31:40 -0800 (PST)
Received: from techieernie ([222.164.16.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7961b4d0sm12945032a12.5.2025.12.23.19.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 19:31:39 -0800 (PST)
From: techieernie@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Techie Ernie <techieernie@gmail.com>
Subject: [PATCH v3 1/1] Bluetooth: btusb: Add USB ID 0489:e112 for Realtek 8851BE
Date: Wed, 24 Dec 2025 11:31:29 +0800
Message-ID: <20251224033129.62262-1-techieernie@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Techie Ernie <techieernie@gmail.com>

Add USB ID 0489:e112 for the Realtek 8851BE Bluetooth adapter.
Without this entry, the device is not handled correctly by btusb and Bluetooth fails to initialise.
Adding the ID enables proper Realtek initialization for Bluetooth to work on various motherboards using this Bluetooth adapter.

The device identifies as:
  Bus 001 Device XXX: ID 0489:e112 Foxconn / Hon Hai Bluetooth Radio

Tested on Realtek 8851BE. Bluetooth works after this change is made.

Signed-off-by: Techie Ernie <techieernie@gmail.com>
---

v2: removed unnecessary whitespace
v3: updated to apply to current upstream HEAD

 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8ed3883ab8ee..68f9ca2ad67c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -521,6 +521,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3601), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
+                                                     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8851BU Bluetooth devices */
 	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
-- 
2.52.0

