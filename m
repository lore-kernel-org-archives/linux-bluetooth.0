Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B95274FDC
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 22:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462559; cv=none; b=q7bxVdo9rrE7bb0XQztoH9Y9GaJPlmW5UpWHIsjmYIZTzMlmIfCGOUwqjB8/oQcM9caJh8+R1ZoL8CN1MBS7NYrUb2vCV7Zah7zHJUHXpI8PdLieEQKyJVQdbC0ek7oYUjLgh5pRUUyOa1CIBwyWI1VVIOFSezP5NUinwDU9Doc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462559; c=relaxed/simple;
	bh=Jna8cIWOSvlf9TbA6F2LBHsVm7d7yfJFqfcE7oI6dOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOhzzmR3n12Oef94y3JHSRczDwlNABXqWJNnmjjJcnKaWPtm56J++OWHBP7/wD8bGjpkJSU1cU6x0KHl3BsGmBKula56LiYA8dg5BhYTjk+u3bM1stXnlXrC/K+733XE6BxgkVoYGuv8Ezazcp4ElYI+FlG3XQbbvUQQ8Zd7JZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv3GKS2b; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv3GKS2b"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeae771c49so18835e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 15:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462557; x=1784067357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6ZTmTPyEsELGzd1y0c5ohZzhRivQ2blbr4ERIRWa2Q=;
        b=hv3GKS2bJPH5dMMxky39WGCk2K5H603o63SDJmuEZryyGJih+ZiUEKLr+mJ43J59st
         tuifWqYNB6Hz1g8cTuZgcvU3Z7WmGKF9abOeCRM+eniWdTgxkfdHyDXvHFvwfrJnAFze
         /clg9PzJZhXwADD1Tc8soAF8rOR3HBAL0UTDXqkEBrmj7C8Dvr1gDQI8Hn+Tql2slT/c
         ZVBGUI/oNpQk9U9AhfOOBb1Mit/D1LiylpNZuOZi3RCd64dQfVNE1UyfyY005btVBfmx
         uKLpN2mXVam0gE1KwptsPsFMfosoomv2wnou0IGsG3Y9sUeE3ydXTYeaA+Eek7Yuy68K
         oVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462557; x=1784067357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6ZTmTPyEsELGzd1y0c5ohZzhRivQ2blbr4ERIRWa2Q=;
        b=U/mRQGWxzWZbgKQv9ZuHQRL5dEVAPh359Iye8ZmTtfsSVFOjC7uMUUFcpK4ENfVFmS
         EmUQr1gMCr4fiaq5kvhfMxp0zmLYZcCvy/TPaQlQ1gN7zGQgbk+nUIAPFwz5V2AjwjNX
         rgiuR3X1sE7x7nMPKVGv87vPe/LvtLVv4s451rI3/CGc/jwBsZt4tDSqGE/PAdjoUTat
         Fwvxsmrz15bGhJttIbysuHWdigQFx9mqEeA6yi5Jx9edgV0r/86hghDbe8YM6qXBKQUB
         fX3PdLgEm9qfRm/fietr6hY9AxPem9pt6vjPYlKHG6GYILh8UZit3GOjXj6aFoJ+IViR
         YBKQ==
X-Gm-Message-State: AOJu0YxjtQYnP0sLJRpRt0tbLohZxM59jjxekenCb83QNaBal67f7b9i
	6mQL/6RwV7SfYelFyUWYpfurixyVJ4ku5GWKZEiv6MB74d/IGAm2/Nql
X-Gm-Gg: AfdE7cmXSqcYxx2ray8KGCw/oWugyvzkTMzA8QYSivyDwj6vzf5Ni609t+UoV4Tmb7u
	CLyYMEWvt0ogVHsxdiks8tcg/s4ytuu5snhbFuQXlQlr+vQq3O4jagyWpR4hgcGe7NlnmAa7u79
	7W+PGWcp6/Zx2wQhz82AhvfCo2XxOEVz9hSjjmIKt4+1b9DDcjPfsrXPuaCBBPf4EhbOu2rZ4rg
	DOgbVU40b+/WBqZmrWhivglxek6cdOzUgL0OuyOSfPBnPW9+AdkPR8qnFMHQIREHdVMC+Ertfk4
	TmjbjwEQHXkrPtGDMTMNdU9vKDE35KbqrSXC5E+QWG09zjNfQQJBiLxsS6/M/YaDA+bZhlI8krC
	QZfxAy/gi/IdlXkWnFmH9Cezc71XeOWj4tZrTatA2nNuSxRaLRqfHB/l+kYADs7EtUhdPhLuBGQ
	n9gnJ9Zu+fmi8pvsYCyQ==
X-Received: by 2002:a05:6512:6205:b0:5ae:b357:1d1a with SMTP id 2adb3069b0e04-5b01141c9bemr10650e87.8.1783462556454;
        Tue, 07 Jul 2026 15:15:56 -0700 (PDT)
Received: from zver-mobile.lan ([5.149.159.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed1376ffesm4079092e87.24.2026.07.07.15.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:15:55 -0700 (PDT)
From: Pavel Zverev <playximik29@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Pavel Zverev <playximik29@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add support for 1357:c123 Realtek 8852BE device
Date: Wed,  8 Jul 2026 01:15:49 +0300
Message-ID: <20260707221549.27269-1-playximik29@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wiko Hi MateBook 14 Ryzen 200 laptops (DMI system-product-name
"MNCA-XX", board "M1060") are equipped with an RTL8852BE Wi-Fi/BT
combo chip (rtw89_8852be), whose Bluetooth radio enumerates as
1357:c123 instead of one of the already-supported 1358:c123 / 0bda:c123
identifiers, presumably due to OEM rebranding. Without a matching
entry it only matches the generic USB Bluetooth class fallback, so the
Realtek firmware/config (rtl8852btu_fw.bin / rtl8852btu_config.bin) is
never loaded and the adapter cannot discover or connect to any device,
even though hciconfig reports it as powered and scanning.

Device descriptor:
  idVendor           0x1357
  idProduct          0xc123
  bcdDevice            0.00
  iManufacturer           1 Realtek
  iProduct                2 Bluetooth Radio
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth

Adding the same BTUSB_REALTEK | BTUSB_WIDEBAND_SPEECH quirk already
used for 1358:c123 and 0bda:c123 fixes firmware loading and normal
operation.

Signed-off-by: Pavel Zverev <playximik29@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 08c0a99a6..532493e48 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -882,6 +882,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0xc123), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x1357, 0xc123), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-- 
2.55.0

