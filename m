Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BDD14AD2D
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312831; cv=none; b=pEXIRqWOH4d7H1GqXfYFvR+H5NRKpGq9kM3r7K0PMDGoeMVeGoVIV4sDeb6AeXLmgHbT0+VlKeCYJZoSJZjYCCSLyF51DyHSetKAVpwk0rs2syf96WSqQjWd0egXK/JWIqVV68F9jOcOIZPilCm3uBNpYc79CqtjXKGmRusG3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312831; c=relaxed/simple;
	bh=N7F5g/xr7crEdGaIs+GkufxKHnN2ZOV9dkWv4n4Tswk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbKk/lop9IyCcEH/sSrub1Ufh6Cm2Q3Fbb9gp848ZLljLnQQA/m+bkXuzd4hVs8lXmhy9onwmiSUlUxASgT8wQvkl44aRG1saLgIOuYtCqZdzQuC3AqNHrqIYGypqYXGyO4US968Xbt054Sg93ICWNHxY6nqOpvCLOXNpdMtcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j//uwjHv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j//uwjHv"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61c22dceb25so8654219a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756312828; x=1756917628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk8Psblt1CWbUncHIx/iWwKH3Did7IkONNai3kmQWr4=;
        b=j//uwjHvmU/nrQKHeunoo3HGO7POUnceE7ZZTlEvCXYJY/q8COAq1jMrxu8lFNKmrQ
         7ZmDz0sMW2u4SA7q8L7jkgq5axtC7W5tdR/ZEPsNrysfvixUV4pRA2Shb7udCbc1HJzc
         klR3iw+gKVpFdzqQQhuqkuy5P1rouJUwjx20pMXK/5JoM1zufxbM1462oC9yZdVva02c
         cVbE5bqSaMGXd54dBLlvtApfXEqyFuTPENjTnctPI5qyNxJTncKOpxPYorXjf8ZdgWOe
         ZtmsjJz5Nw+qez0RaFq226aEFrFcSD9lWeQGrnxIVRrQWuJiUWHYrmeylaa8668A3Ga2
         j3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756312828; x=1756917628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sk8Psblt1CWbUncHIx/iWwKH3Did7IkONNai3kmQWr4=;
        b=Jr6WKBYnSjIPLUyP4kepdv4TZ7Lu3PMepdAzWEsTgTFBT75FTEpIoRdb6EbtVc7DoP
         Zv6h0PAaf2qqbQX1NhGZiNdCQiWCq99BAsP97zYrWRbZrtByvfO3J3DlExy8ABeaPVJG
         ACxFPrsYryJcgcqa6Y8f5P0lvh+O1wMdNc+HVVmNRi71bLCEEg2tu4cuf2Y37dm3T2Dr
         47/TsPpY4KFiGLmSsvTWA0GEPKNbgZEEsgCkJFgAuPsftfqqZQEYaGp9KQogHclBKxMw
         1R66RdqN9o05RtEchi+WaYMtHiF2eEVYFKD06np1ff08dBhbT2Inv+CfRcBZfDcfJ7Wi
         ryvQ==
X-Gm-Message-State: AOJu0Yxl447uG7jO6gf5iVPn2EqoniOtjCxOml8OphrIqL6wMYz4ZCbV
	OxaCMcCmVNWIG9sPI6niJww2HVDq307XQt//qyAeF36YrMeAbfp19hnUDboRRA==
X-Gm-Gg: ASbGncuEkK3ksZOi8GNRau+BDf22SnEoPFLmtCU6GYjMFvLeRIXLFYr6XuqB1WcU1pt
	TleY80DStfeUsc0MO4I0/Vx6X91H+ngmJ6SRLbszlp1Z0PnIY7a3dWOGvKvuujZUgZUbEfcbH4m
	Cl/G2o3Y/Zu5iwGbAEDMo4xwe2WqOA9/UrPuY5a2VbuiFDl9zIUMoDk2UmYX0bZENEwVE0x4aeT
	Egp3h0DoTYZPSqx3BIoacOeLxVYd87+UQe0ryfnsW2eSWKjHkYORx03qlq/VW9eDGRmQGxozMUD
	jFNbUxaGqrdeGriD9d2ER+lF2SEm2tot1FDAXslpPalMYg7e0l2Rc8jUC8K3xzIEezDeAKyD8KM
	7GP1N1zltWBbDMAy7zDb0vgUsALBtL3nZ//kh0d7+yjSO8Lr+RQUcDlVwQ07rXXJmO0sskLLBp4
	wAmjNX6gtNmomIdumhGg==
X-Google-Smtp-Source: AGHT+IHJrshSw4W9lWsjQxEmFzAE4/EGLr4cq7SmwHpMElwpDgd2+UTdOJ+dDrkiO+/oSnvgCBG8lQ==
X-Received: by 2002:a05:6402:2790:b0:61c:96a1:da11 with SMTP id 4fb4d7f45d1cf-61c96a1e080mr5583707a12.27.1756312827643;
        Wed, 27 Aug 2025 09:40:27 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c90ffd657sm3771982a12.44.2025.08.27.09.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:40:27 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH v3] Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames
Date: Wed, 27 Aug 2025 18:40:16 +0200
Message-ID: <20250827164016.363640-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CABBYNZ+6OJRi2LTdk7huQ+i3ysFenY0==umR0YFLz=1_WdmAqA@mail.gmail.com>
References: <CABBYNZ+6OJRi2LTdk7huQ+i3ysFenY0==umR0YFLz=1_WdmAqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Barrot based USB Bluetooth dongles erroneously send one extra
random byte for the HCI_OP_READ_LOCAL_EXT_FEATURES command. The
consequence of that is that the next HCI transfer is misaligned by one
byte causing undefined behavior. In most cases the response event for
the next command fails with random error code.

Since the HCI_OP_READ_LOCAL_EXT_FEATURES command is used during HCI
controller initialization, the initialization fails rendering the USB
dongle not usable.

> [59.464099] usb 1-1.3: new full-speed USB device number 11 using xhci_hcd
> [59.561617] usb 1-1.3: New USB device found, idVendor=33fa, idProduct=0012, bcdDevice=88.91
> [59.561642] usb 1-1.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [59.561656] usb 1-1.3: Product: UGREEN BT6.0 Adapter
> [61.720116] Bluetooth: hci1: command 0x1005 tx timeout
> [61.720167] Bluetooth: hci1: Opcode 0x1005 failed: -110

This patch was tested with the 33fa:0012 device. The info from the
/sys/kernel/debug/usb/devices is shown below:

T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#= 12 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=33fa ProdID=0012 Rev=88.91
S:  Product=UGREEN BT6.0 Adapter
C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Now the device is initialized properly:

> [43.329852] usb 1-1.4: new full-speed USB device number 4 using dwc_otg
> [43.446790] usb 1-1.4: New USB device found, idVendor=33fa, idProduct=0012, bcdDevice=88.91
> [43.446813] usb 1-1.4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [43.446821] usb 1-1.4: Product: UGREEN BT6.0 Adapter
> [43.582024] Bluetooth: hci1: Unexpected continuation: 1 bytes
> [43.703025] Bluetooth: hci1: Unexpected continuation: 1 bytes
> [43.750141] Bluetooth: MGMT ver 1.23

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Tested-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
---
 drivers/bluetooth/btusb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8085fabad..eaf88dda6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -66,6 +66,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
+#define BTUSB_BARROT			BIT(28)
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -810,6 +811,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Barrot Technology Bluetooth devices */
+	{ USB_DEVICE(0x33fa, 0x0010), .driver_info = BTUSB_BARROT },
+	{ USB_DEVICE(0x33fa, 0x0012), .driver_info = BTUSB_BARROT },
+
 	/* Actions Semiconductor ATS2851 based devices */
 	{ USB_DEVICE(0x10d7, 0xb012), .driver_info = BTUSB_ACTIONS_SEMI },
 
@@ -1192,6 +1197,18 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 		}
 
 		if (!hci_skb_expect(skb)) {
+			/* Each chunk should correct to at least 1 or more
+			 * events so if there are still bytes left that doesn't
+			 * constitute a new event this is likely a bug in the
+			 * controller.
+			 */
+			if (count && count < HCI_EVENT_HDR_SIZE) {
+				bt_dev_warn(data->hdev,
+					"Unexpected continuation: %d bytes",
+					count);
+				count = 0;
+			}
+
 			/* Complete frame */
 			btusb_recv_event(data, skb);
 			skb = NULL;
-- 
2.47.2

