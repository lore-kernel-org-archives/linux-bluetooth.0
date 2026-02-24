Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E52D063E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913649; cv=none; b=MnP3Jy09xbVIHkrM77X0y/E6q6savbbDAtGEKRtgTKjL1BdGHaSNQ3X3C4oR36NfN/HV5vPAT4I6y7oYIROsimXYqxTNWCGumQjSBeT5p2kH9EMchDMR9f5dZIr5Eb4p62zINa1KYEC3pwScLeSDa1odjmDfw9/5Rbbyio8SuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913649; c=relaxed/simple;
	bh=kyIpUiN8XG9F5tbrtyX2TBdcsqSx2d3h1/r/RFgyGHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv5mQYn+q0DMJnHGXWq+IWVHHmTCWcUw1bYA95JqVxS4jNKh18uFuJgIAeo6JlGV7WZbzyJzip+A5uOBvSyAMkiUE9uHD2ZrPDTKKDzQDZVYbxrOd8VluSlYoPM1W9PfFTDLB3SKmwJJiB1foTHvZPP3FqNtQnaCdiZh1Gs04iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-66f3e7d9eccso2823536eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913647; x=1772518447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUF4zYwzw3l5eL7X34yaprIHZ+/TkclTpkQhDDhb93M=;
        b=VkCxAxY7cV1BBjtN3YZDg+iqY0kW9OP6w7v9vHhqzP36HkxmDcHNN3svE3zW9Z9AZy
         x1Rx1gNXH2ygOGVzH8cl6bS7nFjXNW4L3fDc7yxf1FZBWkBUZV9RmHMTFnXrmKyfwnr4
         9bBFI2l+KZ/Mx1L/PXJqMQ6qMK3o9Uuzj/ryTUSs/kJUOll3C/9RVTMbQAMIKAifUqFF
         Iy+2S2JWZGNPn8yAIKWFFTgrfPnhukVct3vH8acZ8k2tFTYbZDbBs3Fj0QGxavBywTgh
         unD2m5ZywuBleGfFtS4/0AY6HXTFC1HHCsmw43xL3mXIGPz9eHEY7IgjYRU4kPtvma1X
         fBMg==
X-Gm-Message-State: AOJu0YxHoctmlZgaMGYk5Jq2HC1tt49nB8NK9rfaRrwPT0A+tSA8tPFO
	54vv+YrFkT7PO8A/2OKE31L46WxhUmako6ADmYjzxw+btFV5aFfI5wkY
X-Gm-Gg: AZuq6aJkzF8fmFpt8gcqh1ZWFqY/lwqdGwqO7MOg1Qw0DITiwfRv0aGY+GgT9LCUexi
	8dF5JEJxbGOucPaaLb9ggsI6sD5W9d2/TinXeAC+MZSXqn4VFM5sMJrpFHWbgMjs4pTKLP8M4gk
	xtZGbv3AMdvcWXz+kKzSalOdkBNC4nEjhy1lsVB8q+C9C79x1KdVPXjDM8/2pJCGssu3q9iA3JY
	JqCLyeQLRC0k9DjAMrpxvldTQ+N6AHiY/Om5qEY/3fANSJDx2qqyDTTc3AVM+ZslJx+Yhxk2aDC
	HBXNfTouG8kK2QLDy0Zi0m4AJVLUVIpB2CBj0OYrr/46UOb+MRvRcjqxcATsMAddQBCK9KTsaun
	wdxxCU+y/SXTIJ/tyj8qETt+8teqFJLRcwXt7frBC1guM/pRH/hDhgr3A9XqsiaspuZGyOUxzYV
	HlvQUW1pQpPtd9S6UDil9tUxlPDVzAj1lGznEPW9s6o2/2W0pVKqg1iJV/Jeg27hc=
X-Received: by 2002:a05:6820:468b:b0:673:fc01:a1d1 with SMTP id 006d021491bc7-679c44a7106mr4590922eaf.16.1771913647001;
        Mon, 23 Feb 2026 22:14:07 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:14:06 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 3/8] Bluetooth: btusb: Add new VID/PID 13d3/3579 for MT7902
Date: Tue, 24 Feb 2026 00:13:20 -0600
Message-ID: <20260224061325.20189-3-sean.wang@kernel.org>
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

Add VID 13d3 & PID 3579 for MediaTek MT7902 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=04 Dev#=  7 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3579 Rev= 1.00
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

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
1. Update the commit message with the correct VID/PID.
2. Add clear comments specifying which device the VID/PID corresponds to.
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d58e7e4557b9..94554097191d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -671,7 +671,9 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
-
+	/* MediaTek MT7902 Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.43.0

