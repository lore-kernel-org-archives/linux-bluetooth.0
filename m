Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE4212F86;
	Tue, 24 Dec 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735072943; cv=none; b=pjQMKkww3rksX4L+9nrZnDvZQZ2y3Z1HB7T83MYC+kqMbNx4qLFm7yJIy5dkFMvJ2N1V4MWGPDmRmThqkYzRvNeqktYe68b6HF77hZcVUnfNp6ivrO6jiXlOZ0uazMzEedrUNpTrBEbpwDSRpTLg5C30ujBJPCz+KUGVlitN7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735072943; c=relaxed/simple;
	bh=g5Km3OcvjJxDyHORjOO+tVDo6t4LXkH8E+uAnVqB/nI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BR61/+LJ3yKygiPKI1S1w0CwXLod6SbN2fl+Vz6L13cRqRTQ6grn65v7pWsQAdfgbzOxTH5nWq8IJA+JiElFZ7kMmNIi9MOb5Dj6RjU4uTxgx7PeresUSC9tGChj6aUZeIxWvzlHSNNIt1BH+3bCzkCWdWrdOANRrVypShPpzeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvHuZ4Dg; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvHuZ4Dg"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e39f43344c5so5065183276.1;
        Tue, 24 Dec 2024 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735072940; x=1735677740; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXnwfLpkhYYxYPhM72Gwoblk8EAA9RKQzbpLJtQuu9k=;
        b=jvHuZ4DgL3fJnD7Fj0sMs0+igrUn23436G046IEbVvepmrvHghsk96JbaJVzmrAxd1
         zZpHgbItMBbqAyTN7FhRvQMu78vQ1tAT1xR2MG6LFpKxYUP/cRPhFzpu9qQFkaBZg3HY
         xakJ41R4vyptfqYVSOVp3KyYDnNmYBfFSUVvvrIvbXypcqBUcnspoA1C18JAuIFf24Dc
         8R2tWgutbpjbedD7r0/EJySqDJMQb9Mmlu9gUruMBegPYczxBtWZ/7eo3zlhnkaTuUJT
         KUiIX/Zyf6K2as3zS6Y3BevjOQY1HZGXiqauSUTeGg2EUeBrFOusQ36pSMeeuIacGhOW
         FQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735072940; x=1735677740;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXnwfLpkhYYxYPhM72Gwoblk8EAA9RKQzbpLJtQuu9k=;
        b=sS/l3RnE3TP26cD4NLsIaeBxbW2x2kxqO22KYxkhW3C2XpMJopiJP0ewa2pxQE+qPl
         LE4eFR7O/xZFnXWNmxv6ju8iNSq3MR+JfmDjMzgWbKtNzuFeOOjk9Fisnhq5XXfYInbq
         vMfjTW4/cOSRb8AYZGbUDl8UKg49hK6w66tkvhcPvma77x1NLXY6IwXs6VsSQYPTEdBg
         bZoK5eSO9jFZw8fqFZCQnv0tvl4rLVthC82sZf1jYmvCjEv1g0mWYcBgmrA+BtAODYRJ
         huNdSS/0eiKUg1kv6NKN3v+m1wZQZueyYE639ptNIjgCYA3BXEhCdmsTOHsD2pZHRLBn
         n07A==
X-Forwarded-Encrypted: i=1; AJvYcCVGaMpI9Ts9xRSwrEHD5eKGslz/fZUkO9exSLTkgfStbzUoTWyu7kwuO+/AUVXovTJ5Tm23CTedkgGL1Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOiflHSNu8kwiQF3Ur6TYHEhLfymDIsCn1uQ3RDB333cvhcJG
	C/S7KxsPEDbp51GJH+Oo5SKdKND5Ut7RFNSbly6G8uZ9uyF9uSC0XpYuEU/U
X-Gm-Gg: ASbGncsiZQTP3vwhlZDDtTzEdMVhZFZEITdLxIXJLQyD9vp7gEQuU4ctxOCmoiUCbaE
	mKXC7eH9c+61Xs6QA1GgVWbTN7LgPuvFX34qqhy4AOaZbGk+hTAwb9DVFLBjfRPQ9hf3+HA7yXV
	ynB2iRq+F89rveM/po3JCEg/5+s7qtISHmoWHARBnT5JIu+DCOSjFqzZku5407onMN8wHQ/aXMl
	kd88mG8Yg5NmpkRhU8OYBOcuvSpglD+oJzCYw9iNMGRw2U=
X-Google-Smtp-Source: AGHT+IHV+iw7nhCOruiNhoeu7PopZ4UMC1hvScgq+hQwsnjeEN9dXcF9T8WqbdodvVb+Z8wPCw+Grw==
X-Received: by 2002:a05:690c:688d:b0:6ea:8d6f:b1bf with SMTP id 00721157ae682-6f3f7f2743fmr140672607b3.0.1735072939698;
        Tue, 24 Dec 2024 12:42:19 -0800 (PST)
Received: from halaneyt14s.local ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e73e785dsm30493877b3.1.2024.12.24.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 12:42:18 -0800 (PST)
From: Andrew Halaney <ajhalaney@gmail.com>
Date: Tue, 24 Dec 2024 14:42:11 -0600
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3610 for MT7922
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-tx55e-bluetooth-v1-1-e83ebc81507a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKIca2cC/x3MSwqAIBRA0a3IGyf4JWgr0aDPKx+EhloI4d6Th
 mdw7wsJI2GCgb0Q8aFEwTfIjsHqZn8gp60ZlFBGKmV4LtYiX84bcwjZcT1ra4xYhBY9tOqKuFP
 5j+NU6wcfO2lZYQAAAA==
X-Change-ID: 20241224-tx55e-bluetooth-3a35440b0307
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Andrew Halaney <ajhalaney@gmail.com>
X-Mailer: b4 0.14.2

A new machine has a Archer AX3000 / TX55e in it,
and out the box reported issues resetting hci0. It looks like
this is a MT7922 from the lspci output, so treat it as a MediaTek
device and use the proper callbacks. With that in place an xbox
controller can be used without issue as seen below:

    [    7.047388] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106163512
    [    9.583883] Bluetooth: hci0: Device setup in 2582842 usecs
    [    9.583895] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
    [    9.644780] Bluetooth: hci0: AOSP extensions version v1.00
    [    9.644784] Bluetooth: hci0: AOSP quality report is supported
    [  876.379876] input: Xbox Wireless Controller as /devices/virtual/misc/uhid/0005:045E:0B13.0006/input/input27
    [  876.380215] hid-generic 0005:045E:0B13.0006: input,hidraw3: BLUETOOTH HID v5.15 Gamepad [Xbox Wireless Controller] on c0:bf:be:27:de:f7
    [  876.429368] input: Xbox Wireless Controller as /devices/virtual/misc/uhid/0005:045E:0B13.0006/input/input28
    [  876.429423] microsoft 0005:045E:0B13.0006: input,hidraw3: BLUETOOTH HID v5.15 Gamepad [Xbox Wireless Controller] on c0:bf:be:27:de:f7

lspci output:

    root@livingroom:/home/ajhalaney/git# lspci
    ...
    05:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter

and USB device:

    root@livingroom:/home/ajhalaney/git# cat /sys/kernel/debug/usb/devices
    ...
    T:  Bus=01 Lev=01 Prnt=01 Port=10 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
    D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=13d3 ProdID=3610 Rev= 1.00
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

Signed-off-by: Andrew Halaney <ajhalaney@gmail.com>
---
I'm mostly following similar patterns here to set this up, and
am not sure how to validate the WIDEBAND setting is appropriate
(but based on the other entry it seems it should be).

Thanks,
Andrew
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fac51dd941eee2d496392917e083cd..ce534c212431157a382fce75f2b6657b6c9c6c96 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -610,6 +610,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3610), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* MediaTek MT7922A Bluetooth devices */
 	{ USB_DEVICE(0x0489, 0xe0d8), .driver_info = BTUSB_MEDIATEK |

---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20241224-tx55e-bluetooth-3a35440b0307

Best regards,
-- 
Andrew Halaney <ajhalaney@gmail.com>

