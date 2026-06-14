Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289233321A7
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781446389; cv=none; b=H8tj2xhK7RmKioQB5ch5fCkNPJSjr2Ck7i1KsOeqodsrBaeZ42QYXE8TrhdZPexuFFhnWfzmchCmesDj6XOvF9Nk7tnu4bbClsGt1s8eRACgOVgE00HYOazm2YNEwZ5NzzMb5ofvENjT/b7Sqx7r3IAT5I6584FlMG7gPHuo7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781446389; c=relaxed/simple;
	bh=cS8rxgS+ABT3vKTCF/2H0O0G6pYY712LxVAO20ZKcKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UesVtfOZ1GXQnNQP5IAf6aGYoxCOPrrykfU2TqZ9KoLJSmppaXHarSwMRwFNlL6hxwEsG4tseJyx0Z9hTLxSAAo/3NpWXS4EIDlKCC91Kn1a8qvOe84+m0kOWMeGZNLOvKDRKgM9woPq2KoVJQuphhItk4PBsr2ZHzpNJp3kvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omUkkoVy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omUkkoVy"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso460827866b.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781446386; x=1782051186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VF5JvBVv/f2k00WYR7qhvysu0ETf5EAfbIzLFMSsbxA=;
        b=omUkkoVyNnOA7wZFcww8MDPSO4YhwCpIz4ZkQ5Atzj/QWWd0TW8R5Cj+S4vNYfory9
         vFP/U0UP2B7oGC6SSIbuTeYrkzrWd0weIti7Ogb7GN1stp3/mB5YdHGADG/9YSKgAz9b
         uEYJpNPeB8SFbN7rgJ2/f7x+pdHTH0yPLNYgaC8h3vwOmNv5c5h1dOadgdeefBZMFyJd
         fF96/o6G/2lwr+L/CvCGeMl8b0QVsSoxRctaSN+IAcpRa5MJfqDzh6dvjkeK5HqekIHe
         YEhE32n9iluvv8VEnH2xD8SDxYCJCeOF8pFV+zW29gowz2yXFHGF4bOgnkIjQBEGpN/9
         jVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781446386; x=1782051186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF5JvBVv/f2k00WYR7qhvysu0ETf5EAfbIzLFMSsbxA=;
        b=guJZXgroKHvBMKjetKdSshnz0rgY91fZEAd1Ah52yCG04V5l/EVE5TeTH/n6Nad/G8
         o1LCqAZec9wrcSEGjcI7WrGNEbYaYYuE3osgw7MZVx0deVKKm0J5QvaNyom7n67Q+N7C
         hpobApnOO+RJ4k7mvKwThv0x0K75T0zJY7pLZW6JIGDWu5+HkEt8Rr7H9yRU2hgBAyBP
         dAhHqWFWI2Iv/nvHAe7Q8KEdJCMc/amOwu+LCBggLFdrxpBHvvlziYUkj0gaPybNfHOi
         /bWBzEHxmiwkxuAPTCeV+FMSavpWN/pnu69yyrxWVdh6eSkEpPvR9KkKjU8lK3XpVfCA
         9ZqQ==
X-Gm-Message-State: AOJu0YwWxFEQmV7uwmQAMeyblM6vTg/YPP26ZLjJCZrYq/21hsVDoJhZ
	MM592YU0/+JM/wD0WHMoriBfRXBsKObWsuafSVPamoPozTvGyT2c1voH+9Bj9VKt
X-Gm-Gg: Acq92OGPi1VzuV4lKLwR//KXJMfBOnH0xAoWnZcn5vHwDF01/utn6l1Prl6k1m7zhJg
	ZD5SqDUqdOrJX4imZ4Sl2LnUWtgSmMG4mNyrUo7eVS6NGw+BD16wY/2jxcjz5MUm41dV5bhy97v
	3KcZ1qyyR5jFbUC/i+GmJHR9HSRjhPTFMWp5O4b555tTXSLGhLABJAqzBt+huCi8Rkumikp6L7w
	IjOp75kXSzEcKdC0ScuwBBi550Wy4pY7f+3i02NIFv/TfJjqH8fZGqr4hKCPliK/oEnRYWrCwmV
	Il7wlOQ1GcCAbBYnnh7hu80T6dJn6V8Ni+kK6sDIWV/BsCQs/yWXlMOBi3EPMkcLphiT2mH2OiX
	GyYv4EtRatVrDGvAW17akAGYVlq1TaTt3j6atnasKvglCJu782vAABurvvaAwmqMU5Rg5scwWZ6
	X6qwNFp9TPYYFNK46AGH49vWEW0UFzmaOhUunx
X-Received: by 2002:a17:907:3f04:b0:bec:52f4:28f3 with SMTP id a640c23a62f3a-bfe2aef6ee0mr526862766b.44.1781446386268;
        Sun, 14 Jun 2026 07:13:06 -0700 (PDT)
Received: from home-pc.localdomain ([185.77.216.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c01ee8286c9sm37474066b.5.2026.06.14.07.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 07:13:05 -0700 (PDT)
From: Kirill Shubin <kirill.kz.902@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Sean Wang <sean.wang@kernel.org>,
	Kirill Shubin <kirill.kz.902@gmail.com>
Subject: [PATCH RESEND] Bluetooth: btusb: Add new VID/PID 0x0489/0xe156 for MT7902
Date: Sun, 14 Jun 2026 17:12:58 +0300
Message-ID: <20260614141258.1011-1-kirill.kz.902@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add VID 0489 & PID e156 for MediaTek MT7902 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=05 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e156 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Co-developed-by: Kirill Shubin <kirill.kz.902@gmail.com>
Signed-off-by: Kirill Shubin <kirill.kz.902@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
Resend of the patch originally posted on 2026-05-04 [1], which has
received no maintainer feedback for ~6 weeks. No functional changes;
only rebased onto the current bluetooth-next (the quirks_table layout
shifted in the meantime). CI passed on the original posting
(CheckPatch/BuildKernel/Sparse, patchwork series 1089463).

[1] https://lore.kernel.org/linux-bluetooth/20260504190353.9358-1-sean.wang@kernel.org/
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 08c0a99..7f14ce9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -679,6 +679,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7902 Bluetooth devices */
+	{ USB_DEVICE(0x0489, 0xe156), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0e8d, 0x1ede), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
-- 
2.39.5

