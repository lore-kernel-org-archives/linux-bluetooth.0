Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0B27587D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913668; cv=none; b=RAA9i2pVtVkvzLc8yf+qD+MzI3sZev7bFWLFF+9wIJG5lym03orYbX5WQnZTlhJifSY4PrApcg6jqIn0V8moJwgjaJ1Z7UAnEH5De8K8pO7wb4ImNgMO/TE2j6XMR90JG8yq/LjPaDO/s6SBdhnn9ymN7sno88iqyQd5LEXdBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913668; c=relaxed/simple;
	bh=vDPWlV5gtxuO5oJKhYB4XQH9mg3cnQ2FJ3iMv7tlfBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4j5ME6DvOK6HyfRvfMcz/CKHK7vmjSVjACo/wqr4rAGri7Fe/pTU3t55jIsE9zAyl03QmgwBoLn/1KNIlC8ZU38HxaGidSo/+biCr1+aAYSTb/vrR3KSkWmqPXBHP+mpy1nJOBbKOoBSaKCCjsU/gx/uy4fiQHoyiioDmO8REM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4ba9abbecso5193944a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913666; x=1772518466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jc+Zbpdps3NV1O+TlQTpIhdV1pVsPxYo95sUPq5BXkI=;
        b=BX7HyxnqcKIY/Vz7ol8jBRUEoz12N8VYyaGtZK26piyNAoZPKyyYgfpWMIgGnYd+Af
         JEe+vlBgR8WKV6bq2F71lyCjcCYivJ91Cl8sPaeU1aOThb7Vu3ieVJ+oJpxYQbXjwm2Z
         wR4jb50RZVJSSrMRzZuoFeXxDH9oha614WY5L7XqqomsTEGJhiPTDnwhuou3d1tp9LBq
         DS0p9vJhdZy2ugq51vePKzbucmXRqrYNMKgW5ZDvNCV5e7DPjdFQVdD6aiSyw0M2G2GV
         kXu+jKXAwCvZsawoF5rNFfTFs5ludQsytKjjw2c+Tt082OxMB8IV685t8jYGB+nH6PEO
         4oRg==
X-Gm-Message-State: AOJu0Yz4ACVpiGy+owN1P8+tFTe0XPeRRsbwCpokxDTRYvw6av//NEeW
	CMDn1jJTprIxpvIRkqB6/2BsI6KdTp3ZjdPt0/9ls1txBlipx0GVedGFlplm5w==
X-Gm-Gg: AZuq6aKBw94kh1XSpxa7FMNCiWFv2VCuzWKO/PdrUvZDM/wZfCZ+o5avfgcUB9YsU1x
	6ghj2aH90KkonUbBSL4jwSBq2kiXNfLh8mz7FojhWS0G/pmFz/BgRgdO1sDXRywMMp9IogpZmWa
	zjljqsTX5S2WTi5eBLanlf61mRjG5iKdKJzN1DzwxzujmfeD/MHV/5a8P+XTi4Mb+fLgVI79Fqa
	s7QKu7eAdrMNiCAkCCpvBSITO7mBz3EZsIoo7S0NKmD19NyU5xJAyXAUr5Apt9jf8WBOkV0ZbXX
	18CJWxdVD24Mrih1aI2VM6GB+wNJ6c8DmBpfZpVdA4HVIDBuX46FKw3xRGN3QzFtHOU+fSckN/7
	hGJ4MPNSz46mEaSXRV+qjAcvwKO44fGKidiiVQ7V98sgNJPp+YoTqfn5TPRVpm0aCbXHX1yDtLg
	E7yUHGOBY9QuIj4w+JOXfF1VqSbKfBlr2wFoXl0bCPhqczWa6RfUxeKrPuSD62qlj/Urqh37/BA
	g==
X-Received: by 2002:a4a:ee88:0:b0:679:9844:698a with SMTP id 006d021491bc7-679c46e947fmr5857920eaf.55.1771913666519;
        Mon, 23 Feb 2026 22:14:26 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:14:26 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Subject: [PATCH v2 6/8] Bluetooth: btusb: Add new VID/PID 13d3/3596 for MT7902
Date: Tue, 24 Feb 2026 00:13:23 -0600
Message-ID: <20260224061325.20189-6-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224061325.20189-1-sean.wang@kernel.org>
References: <20260224061325.20189-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add VID 13d3 & PID 3596 for MediaTek MT7902 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=07 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3596 Rev= 1.00
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
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Co-developed-by: Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Signed-off-by: Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: newly added
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0f1bd9b5d296..4e8bf032d35e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -678,6 +678,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3594), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3596), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.43.0

