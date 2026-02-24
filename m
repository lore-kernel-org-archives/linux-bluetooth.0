Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CB27587D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913655; cv=none; b=qO2LJniYBDvDN6OReOjX1h+DhMvfhB/lSqvpxUOxWyS03O+SdXJavtfux29kLoelvtbLONAYsTDvu1TKcXKVuUYS7FTuMNs1Kog0+17r7Ah12hmv0Yf57gaRTz9LkUnblzA6nbMbI00PC6xZRARMFScKu0UFBgqLuC1mtd5zTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913655; c=relaxed/simple;
	bh=/Z4MB5ElOyi+55Sr044CxcrpBM5KDUbk+zjFSrjyJpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+yRW0jY2wR4rIN7QnTewDhhJGKoZ1m+clO6Qe3bYcIOoscCkAnerzqROS4pTmNYPG1Qz9Dh1ja5jBcdFXzswLzjfh5qK8P9SJfUZMelzOIxN/tNjQDoruC8TYtDgtivfUVvQrk7XTfX6Q61DR8bBpRJJkRxNNoaMSVMCzZBpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c3896e32so1996210a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913654; x=1772518454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yF9BrzHSjOCb61spjQQsg4By9fXphtW27Do+4p/DLZc=;
        b=LlOvO4iSsvS+JtpxDxWdPvhJQl/T7SkVDthDoUCN0JTLh/00cHjBCoouhBElJFlqlU
         gTp8Z9pfWkmMdjWQaEz0cZPkeKk9kjZNjx2aK3FHx4WSgeVj1kriuYnhuCOJtxA/QCg3
         TjU4OkCN4LR5WDuqITqsYpMHx4l637HVCnnMXXQJvGyh97iv9UIYBPXSQIEau/D8S6Wx
         xPkqOz1kZJFMQfG4SYNflNuJAUhva+E7OcC7uIe/rJMg39UVVoCjhgw5MepxclbQ3EbG
         mDqvGYdJUDAROd13WEkXR0lgHYWHQ7S+UMit0Zm+8FLo2+TuXIfT4FRYYY36l4izfapz
         EmjA==
X-Gm-Message-State: AOJu0Ywlij0pSva59O6uAyeUuojBarf+3iY43v4H3B4zfxCK5Ov0pMG2
	qE3M1JOFRrOeLqSYiZfGhHrg4X8R9/2YxY2jhQOSAWAnk79fECdOG3Wm
X-Gm-Gg: AZuq6aKSGAXRAo3O4q0TkEthm4BfTMSfdWS0bojvuQ8NLs6IFLG3m0/TfqtUoOqRUlt
	W2zVWCmoNkJi1lrm14IZC35m/gLo06kq1eCtxJaIVJ9kwIzjB5n0bek+aW++9QjSVEzfCOKYtzm
	0P+nDwB/Jfe20oN+b95KsSXX2EIR5qqBdKtX4NcPJnyDD4JPmRdGns+Z9wJ2dyXf6mR+KSkKPA4
	sEb3/iQ9DDijFAs4QPWwx8/dx9RrTmecl+aYYmZHaUd9kK+rGzfcyR8pDAIwfUOxN1NFIuhLHKN
	/4IfcqcYh7OiSS+A4HnlgGG1uPptYxU4WJHmuGMTifSthlz0qOYHeD2/hG3tpZj4XPAZuqq6R+5
	133aE3nFK2fMR+OzckCpF/+hZw6b2ak9hZbLW07vArYzoEM/qT7mvxUCq0BJDo4KFrUWHY/UyHc
	Z9uKwNxhhRa6wHz87hhUSAto7KKsPddh91RRu2GrkGQli8pOXgYyxksO608/19tl8=
X-Received: by 2002:a05:6820:162b:b0:676:7c9d:29ca with SMTP id 006d021491bc7-679c470ed7fmr5824085eaf.56.1771913653634;
        Mon, 23 Feb 2026 22:14:13 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:14:13 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Subject: [PATCH v2 4/8] Bluetooth: btusb: Add new VID/PID 13d3/3580 for MT7902
Date: Tue, 24 Feb 2026 00:13:21 -0600
Message-ID: <20260224061325.20189-4-sean.wang@kernel.org>
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

Add VID 13d3 & PID 3580 for MediaTek MT7902 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3580 Rev= 1.00
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

Co-developed-by: Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Signed-off-by: Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: newly added
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 94554097191d..3a45b16c6b08 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -674,6 +674,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* MediaTek MT7902 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3580), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.43.0

