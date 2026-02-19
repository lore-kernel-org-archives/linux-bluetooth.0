Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5E64
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529578; cv=none; b=k8X5ITPPKQfeS6xAh95Qb3B+gGFeveLaCDkSXoKSnJyDLXA46CWKuiJrrwUTK0Dbgrz4WYorMfzvdzo12XJLSW39YjrV39S9UFygwVP/Cr5YqamfjobVMUsP/DE8NSmrVz6fOWVG7FZwQNhd/Ce6LED+E8DPCVXBYnVSZV7cy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529578; c=relaxed/simple;
	bh=yv60x4Ciaqh8grb9Goq7Ad6qVGRmTpzuj6oQuzeD0U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7GUX8sTx+NivqsM3uSd2fQPFPLsZqGcDYtUYg4cdhjP8yRs3MwGxZ9D2qmdy7odXEdbBTZefpzIc/LM+PTfLZ0+mqb/TsnPeNAHtcnRO71fV80IdmSK14o3AOcHbqFKz7fUNbDeazVMwVSE4jHFFmMrDm5PGn6jn4YxMod7kXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCJ3WQXe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCJ3WQXe"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4362197d174so875262f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 11:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771529576; x=1772134376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SWGz+B8eMT0H/TO7oSEQ8rrfEO9SmYPAxbyblFO9GZo=;
        b=bCJ3WQXeHSD4jWqnZ1NVX7L8bEBB7rBJ3PCZyTTb6P6N+BVmCnB4+J/z9c8r4hReUz
         CYkIHRaVMPmwqTNwFeCqlEsEmvPk89oUUrdM6IFF2LpeJOaSRyA0Sz0m01LInAZY0Gft
         WlX6qYsBkbA9mRz+h/LwG1KBfTag1xb1+EPlPWN7huV0freKOj3BJVxUzoDklZNiAp4w
         4nz1dkWQ2OBLHz6FfOGaP0DsoUBfVrn0FO+4gkV7Aa+GzTcgwJOiIF8jOUH+J344ATUT
         NMd++v00hou7bwkEHpvfIo0ra7rTGh6lPSTishlZ87/rFhnIrHg2vOTq7b2RwnVffqtb
         3N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771529576; x=1772134376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWGz+B8eMT0H/TO7oSEQ8rrfEO9SmYPAxbyblFO9GZo=;
        b=rfHNaRHFqHT+KIp2E/xF4eXPq85bV5J10c6QLmcsmb2mvy8iB5Fwhvnrc+NmCppC4l
         BBxMpVjId5qPF7vvAY7Jj9FR2IG366rO5hMbXoxV+UZ+YYMopnpnkP+Cj4uooE3KCHf8
         uRP0BT2QYBGyjOrOH5n9j2PP9u0FJm8rdDKD4F6pIcLilPkVh0Mq5mZHeBQFViaA0bXE
         DpQVP2HXUQH22ubRB90pB5Zcez/yeym32YpMRnY/jRLwVNW4PeoUvhPAYoAc5OkPWT6s
         ngChv8Syne1kxra+/GfWeSCXRSQ/mq4fjkZG1fN3NV6hdWkNux365tkxMY3voW1sU+B7
         xbMg==
X-Gm-Message-State: AOJu0YydcIis9Y9jOtKT95faQ+JO7yEyvgrlXYFpWZ8HDOkWSXnjRzgG
	ltheNUOvgzJ4XA3A139iMQ6qRsAODTvNG3PepCWzEuKEVaa7QLF+qZMq5WpukFk=
X-Gm-Gg: AZuq6aL3E0wNyGt9ksJG6wdq1Mte6W3h5gP1kTpXsKLYF0MV70+tWQlKvJ8MIP6+SWx
	wMLjpIBrx/apVH1lTjEYl3ithc5vuPXyEZm2S+16YlPCdKzyk7+ERFNBPmjcxjkAY0rSbxNTZUx
	z3mjLQmcvxcnqC9WCg1DXUoUyf7+2g1ABQ3faghexOB/gOlE9i5/mZSIgWgLesrKJ5EHDRfxLAY
	aYe9fWGNGj280bUm+ijrEurbAdHQBsF01TZHicPXa8bh8losW6GwhrRroihVSaUdHmwVkNb4VOC
	FRLI7gX9ej1/2dwCUQ3Wrivm452GkSZrclbGq0I3lq8agDf7TdvVY8L+DCDrOFyoWrm7XL5J7gs
	1QC8/BI2bCziK8i87IY+Vs7VamEJcQmTAYd1mM7guvaFijW9ycyvKWn1KoP5jTSc3bEeW7hb8nh
	VWlkSn8aGvXVFaM1FzzkGrDSM8WrblyBX/utd2Pj2QQkE4MR8vWHcd0PyBGT+wnfR79c8Y3TJYf
	rw=
X-Received: by 2002:a5d:5d8a:0:b0:437:6c07:998f with SMTP id ffacd0b85a97d-43958e4b8e3mr12040212f8f.45.1771529575675;
        Thu, 19 Feb 2026 11:32:55 -0800 (PST)
Received: from archlinux.v.cablecom.net (77-56-128-136.dclient.hispeed.ch. [77.56.128.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm53981412f8f.27.2026.02.19.11.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:32:55 -0800 (PST)
From: Dylan Eray <dylan.eray6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	sean.wang@mediatek.com,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Dylan Eray <dylan.eray6@gmail.com>
Subject: [PATCH v2] Bluetooth: btusb: Add Lite-On 04ca:3807 for MediaTek MT7921
Date: Thu, 19 Feb 2026 20:32:09 +0100
Message-ID: <20260219193209.69937-1-dylan.eray6@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB device ID (04ca:3807) for a Lite-On Wireless_Device containing
a MediaTek MT7921 (MT7920) Bluetooth chipset found in Acer laptops.

Without this entry, btusb binds via the generic USB class-based wildcard
match but never sets the BTUSB_MEDIATEK flag. This means btmtk never
triggers firmware loading, and the driver sends a raw HCI Reset that
the uninitialized chip cannot respond to, resulting in:

  Bluetooth: hci0: Opcode 0x0c03 failed: -110

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below:

T:  Bus=03 Lev=01 Prnt=01 Port=09 Cnt=01 Dev#=5 Spd=480 MxCh=0
P:  Vendor=04ca ProdID=3807 Rev=1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:  #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Dylan Eray <dylan.eray6@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fcec8e5..fd637cf 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -705,6 +705,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3804), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x04ca, 0x3807), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x38e4), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
-- 
2.53.0

