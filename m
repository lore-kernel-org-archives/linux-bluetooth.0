Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFB83191AC
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371076; cv=none; b=gW2OC7JOs/9vgXCIHj+w2uhI32uJNWLD8xoYqvHnGp8jvkJm1E5z8UHV5FtqlPLMmdzgy9Wz34noeYzaluwl2BqvdMzOxiZY2WiGkl+LDzoWnqNzD1nF2+BHK2U3BXbWO6V1LSKQuTTZUfM+abhPskTNLFsAEShTU6bRLaQPhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371076; c=relaxed/simple;
	bh=6TJSt3xv2/A7v5854hVI5HwkywLc6Tyjd2khpuHUBnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bl7PMpsH0YXprrs3A62VZU38XCAPn1tMxe0UUBpYrGS6WiITXO/jZaxcOvyliB++sNL+XKLexovBt8VrOc1pRAkSMrKEOPlA6BnTDOBcrn6JjaMOcgmVHQFiJTrfVy1t1kIrt0UUY/69eIuVHhbSZGkdVzXDdTvGIBiiJ+fdc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWMAvfsS; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWMAvfsS"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-880439c5704so1997086d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 11:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762371074; x=1762975874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtdMFqP5e+uOi79bVwRdCIbG6WeQQ2xS83d6a0IHvlE=;
        b=OWMAvfsShUNwMf+KcAn3lhaabEpNjYJU+7+TmUGeDTA66VvENRzAAnAEwj138jzGyy
         iJbIMW/WK1QZS8RDlrnDUjYNlIfZG3/bYEwnx5T6TFaYBQxHImmge7BOw26XO2kb4JOH
         typUU4K2d43o5EsEYttEhTSBb/zTh9w3JPAS9cUMnIIogZYElltcxuqNbk399Y7r1jnp
         DzPqksgDIi5HrK3YZbUub2arwk5rKaU36E9ntO1Z5tK0e47BR4CPqyL37KHlzvSKQYTg
         1NpMEuUrkP+bnVgPqp/vybgqb+K0dD35FLKdQXyYwHSz68LfXbjldqSK6973B8fpeydf
         58Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371074; x=1762975874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtdMFqP5e+uOi79bVwRdCIbG6WeQQ2xS83d6a0IHvlE=;
        b=kVHdc7NcUE8m8fG0nT3cdyG7LQnE5P/UHLc+uSpGL1GrXDVBf/uLzDjBMrak3X9Oak
         gq9BB98u/hXu3EYOjRgDw7B+dh6Wq7aB7boIpoaKek0Gkho6LmZ62rQZskdLYp/1zXY/
         eh6N1uHRBtIyZhWlcrELa/sYI9MstXPYQ8kf3yilH7Sbr+fys1gw02c1L4SWeC7ZXVZh
         Lf5pB3m7Qrho/a9Un79lZtqPJLgVEzg5wmgGc8KwY4dZp5eMz+vPHCloKI/sBd8nPWRq
         pRQglzxOJMRN80q/CmIIDudnjTDfi2CUlaSjPLuTaQBWzGtstTkuwMeYRqkYl4MKmFLa
         y2mw==
X-Gm-Message-State: AOJu0YzM7AwtmYjsx1F9qYegltFMrgBrEontNg71kPYj72GDeKnB7HFx
	OHi3EP980qySEr6sMe3VotSThmxSYjNHY5nLTFKeIjo0JC360KMxC+Xh
X-Gm-Gg: ASbGncs2VdvX64FriSN+yVZrR8l8s1EWGIwPMAAKDo3nssTBAq2P8BADhqtG7ZQKwED
	WwrW1gNOihwYJQVxpLoJNpsZ7054JYArKmU0MC3ciE4PuL7BXqhztYCBJeseHOq2nNbJvHih9Wy
	EbJK/z0Zf7ZiFf+uLEpIkLVaOhXfg5mJe2fcGxadrNccbt7FgjCAzloCgprzbQoYlC5klLY4f3L
	GaT8yYpifUDoTtuH79CVw19D5jp6/e9hp1TUcQMeiZwI2G8infmgC8e/U8EZJMBnyULYsffTjvw
	AOt1YznWkKWVqrLELiLUUz6pyfvdXyvgWZTGiLJeRhvqGmdF6r+QUM6rj5pz+le4CDyI28J0rF6
	9qInZzgxA/ffDmX+T98mlwvcz7z26mIbk6Fp+Os3qmW6N5fxL6p2Mf0u2gnwytpYg1Ko1XMvKC5
	F8aLjYRB2j9SdKDjaHNqry52sQg6TTquE=
X-Google-Smtp-Source: AGHT+IGTQtwZl6sL+8gi5DnCDG03CnMRgliitzD0zn5JCJuTQDzTT1J9RmyVcxbUgojmqhn5RXv1cg==
X-Received: by 2002:ad4:5ae7:0:b0:880:4f55:4af0 with SMTP id 6a1803df08f44-880710be2d5mr47019406d6.20.1762371073669;
        Wed, 05 Nov 2025 11:31:13 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c4faasm3348326d6.12.2025.11.05.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:31:13 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	syzbot+2fc81b50a4f8263a159b@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Subject: [PATCH] Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF
Date: Wed,  5 Nov 2025 14:28:41 -0500
Message-ID: <20251105192839.895418-3-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a KASAN: slab-use-after-free read in btusb_disconnect().
Calling "usb_driver_release_interface(&btusb_driver, data->intf)" will
free the btusb data associated with the interface. The same data is
then used later in the function, hence the UAF.

Fix by moving the accesses to btusb data to before the data is free'd.

Reported-by: syzbot+2fc81b50a4f8263a159b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2fc81b50a4f8263a159b
Tested-by: syzbot+2fc81b50a4f8263a159b@syzkaller.appspotmail.com
Fixes: fd913ef7ce619 ("Bluetooth: btusb: Add out-of-band wakeup support")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
Syzbot opens a usb device with out of order interface descriptors:
Interface 3 (ISOC) in position 0, Interface 2 (DIAG) in position 1,
Interface 1 (INTF) in position 2.
So, ISOC is the first interface to get disconnected by usb_disconnect()
-> usb_disable_device() -> ... -> btusb_disconnect().

I don't think this is a problem on hardware, where the bInterfaceNumber 
matches the position in the dev->actconfig->interface list; and in 
btusb_disconnect() it would only ever go into the first if 
statement: "if (intf == data->intf)" and not into any of the others.

 drivers/bluetooth/btusb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9ab661d2d1e6..1f8d4af184de 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4269,6 +4269,11 @@ static void btusb_disconnect(struct usb_interface *intf)
 
 	hci_unregister_dev(hdev);
 
+	if (data->oob_wake_irq)
+		device_init_wakeup(&data->udev->dev, false);
+	if (data->reset_gpio)
+		gpiod_put(data->reset_gpio);
+
 	if (intf == data->intf) {
 		if (data->isoc)
 			usb_driver_release_interface(&btusb_driver, data->isoc);
@@ -4279,17 +4284,11 @@ static void btusb_disconnect(struct usb_interface *intf)
 			usb_driver_release_interface(&btusb_driver, data->diag);
 		usb_driver_release_interface(&btusb_driver, data->intf);
 	} else if (intf == data->diag) {
-		usb_driver_release_interface(&btusb_driver, data->intf);
 		if (data->isoc)
 			usb_driver_release_interface(&btusb_driver, data->isoc);
+		usb_driver_release_interface(&btusb_driver, data->intf);
 	}
 
-	if (data->oob_wake_irq)
-		device_init_wakeup(&data->udev->dev, false);
-
-	if (data->reset_gpio)
-		gpiod_put(data->reset_gpio);
-
 	hci_free_dev(hdev);
 }
 
-- 
2.43.0

