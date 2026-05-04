Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B883EE1CB
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921502; cv=none; b=p4jlfzB174ovzZj7nD30ur29YX/MXPUh1cBxebIC/Kc/pkqTABSqz9wdR+tjhJcW14cVY8V7MdBXft8zktJ0U2m8/oTGWZy45jRMhOr1s3YHGOxHtDFcY8xYGLwFBLh31JrThC6J0q4Fjv8WaYkpf/O1TmUbSgP8VCCjnMR4uRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921502; c=relaxed/simple;
	bh=TkTETB8FcuH37Uk23eNwtrGHgZT+XB61FHNKHQI7Qww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADVMxBoa6mj/t+OmENAqj3K8Hd+g95a/3wwcxyXxcXLhp21AmizOrweK22e8qIG26AEqB9K+Pd7IxLi3aYTUd2/p/BylY4KgHlUdedlwuxKH1+8mWeQqKhR71bbJf2Y7inseRfjhiX1iDTsoFm1TpZz3093gX7u7SYygv6FpSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7df05fc49e5so1023568a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 12:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777921497; x=1778526297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kg55pUc+YqgDvvLMINRJfFAwlkmL6dsD2oqNH5ePEw=;
        b=CB7pEJAvQ6w9KW1ybgPFYABBI03iXK0vabMCLqRW0SL1MrgCvts8lGAh7jnc+CSe8C
         2CM8BfCFNoHdsZeKC578wyXhos3ehfG5TEYbP3Q4cVK0j1EhXjHZh1dOOgjdqy3TY2b1
         VgdZysDVZOm8tjPWfyXhVmTDM91bq+MzL6ett2TbYMFH9sjjAs8FliQAglWI/WFFVduh
         ymloI2aED+T5G0R54fR4arzLCkM4GsWo9ycP21X/egH24uKehnFIf1OjpqMGwK+WUhGM
         Bzp0NNQrVu0u3iI7X7qk/Wn6L2SKp6U7PWgvYHOyRwR9La9kMvytYrVYGVgjU/HNr36W
         KtsA==
X-Gm-Message-State: AOJu0YxncXFx8suCHXSRz4O0vckgwYRbU8ovCCuLMCvTveerSxmcszZ7
	KFZ8ghcDN2nFO2r3hIp2xqp80Jq6g4Gi8/vcTdeE5H58VlxLTaKsD/st
X-Gm-Gg: AeBDievNJEZ+zZUeNfUmrZZ4yUYzGE2Jfv8yv9hc9kQnOx9skEl5+vKvS7P147cIqBR
	fgXqKUD+48/Z+1FakmFwB9qSZfIiIMqbjqEiOcuq60vWLf+1IxSMpSLbfe1Yi49MEDBGQMs/mql
	izoYVyFe2TZBsDdXx4EmU2MVBCEeqcsohnROaeCxsPY5BD6sONnX7YVedYPyvs9++7JHW21Oh5i
	YW5HV462qDNjtl2fwNWe1RuVwVb+MyRJhnvnmrwWgjl1Zn3tDGb/LnedAIAjwPJMXiC2J64T9gN
	WzsVMrXU3tWRq6lFU3d+FGpgPGXxnfmYegJ6APrDrBsUDj1DttfYztf6rog9JG50Tzxw0bcxFp/
	jLKFYp+pvERu6SSxz4dMkpCoOZeKKLJx92nF0mqXhmP4bCgRXkGgZkN4IyhiCgMwzXz11rpgiJd
	NB8urybV8LAEvC8KxQuz2xBdfLOtQpGqwBXhEAa182ohsq/gSYzzlU8LdzSJrcFyZG62mA3qbYe
	4hZPEkMiLao6+UmHA==
X-Received: by 2002:a05:6830:63ca:b0:7dc:de0f:b640 with SMTP id 46e09a7af769-7dee12afa83mr6320108a34.6.1777921497138;
        Mon, 04 May 2026 12:04:57 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded51a9612sm7524229a34.26.2026.05.04.12.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:04:56 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Kirill Shubin <kirill.kz.902@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 0x0489/0xe156 for MT7902
Date: Mon,  4 May 2026 14:03:53 -0500
Message-ID: <20260504190353.9358-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
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
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 572091e601f9..f1a225fe94e4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -676,6 +676,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7902 Bluetooth devices */
+	{ USB_DEVICE(0x0489, 0xe156), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0e8d, 0x1ede), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
-- 
2.43.0

