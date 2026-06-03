Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90193A383B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780459106; cv=none; b=YPMqX1vbVUwb1ac5pX9g57SYuSOopVQz/IlZTnrg6iYutPCAjK6EdOCXD6mfEqB/fFuvR6l9oDqznCUzaWHJlpFRQr7RslTyEim/s3/JZnukS4JzTM5xn4mMxtv4Tld2kQ5TnmevVKwj654TZLFs8sJQMcpco42tP5Cg9uBYMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780459106; c=relaxed/simple;
	bh=6RPH5rtDXtkK4yUyqEM5Au1jbwxSqjpgyXKuxFi6dss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SI+vyvaGTGG7Y1Ejhj+iWdYOQtJZ/HEfN1Y+Yc+m1jC9Pbkyd+jWeaITR79U+9CNBqCUXcyAeQNkmFVtMRvXuXDLBTNMAEDZpRr6yBQQJaMRmn/yQpXN0xWLr5HvIzHPa1kgoxJ5UASvXAwIHVh+2A3+kqFtxVLtveW/iRhdwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n7rblj1w; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7rblj1w"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8571db044eso3232683a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 20:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780459103; x=1781063903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psoPn1Kp1CWc+ZhuoSVYjwdtwLY21M9el76WqXa5Jtc=;
        b=n7rblj1w9vq0+kL0rQvhmBC8FVCahY0KuHBLwuLp+dMRngvqBbxSu8cOdMeBMx+rWG
         L1PmGXa9HZBHxLN8gRavYfe9BC4j9fWHF89Y3uBm1HvtziKHlxxhKzoarnOg3vxWEMTx
         8YpCZDxx8thg3rvv3alYKoj6m+ANHkO0XPGKRef7C9T3EZhji/6KWiaxuIHYh6Z5wRZ8
         B3278LGhQscXHNl5FdflOpxh42kL4Ne09+fpJ+LPjBeCovFSoY/iFq0VOq090L1/xpJZ
         9JEL/s9ya8mZqLvcT+xAdijvl5udf8rT9GKdHbLEw4Z4ej36qgMUymHksDRqEbJ91PI3
         vfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780459103; x=1781063903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=psoPn1Kp1CWc+ZhuoSVYjwdtwLY21M9el76WqXa5Jtc=;
        b=YgeSZ/tEzpBs7GjBlGy5K/tnw3gTU37gxTBDVgpDy15QpI1Wr6qPA47VvMm3X2r68R
         A2Ob5/s5pacbaQwOtrF3Y8UHNwJMYSyhRsq7pAKlqzCIdlOh0ezWgd+92m05M973hSKz
         9DoVdX2dhefUG0eKY6JsQ62P1QbSO2rtody1Lxhq/eXmEMJsk+qYolNwHXqz8JsZPJ8G
         2sTxeoWHOmZWxyJvVuCZ6jAYum3ok8M2my/CJTSKGOqGT8o36gfqYo0uRIQ1TvzBi9YW
         R4giL1wc+t3Ac3VMtsiEYUeYny9DpF4gSIuMgT9PbJjN4Wou3lgk2Tu/DN1qANeySKtU
         plHg==
X-Gm-Message-State: AOJu0YylOM93F/RerG/L22DwVSIrxAWPH6ag65xSR8dt8mbDWKXrwOie
	NLElzwpdT0MwsaapTMXFWPcN/mBhpNFN7tu4FkluX41Gwno22Fq/sYEa4Wi/iX4VYgfhLw==
X-Gm-Gg: Acq92OFT0aW5ah2FRUIjGKbSjpQGFpnE5G601WLM9dxRaAxXivkZxlVOkjkSBFNj+sr
	wA/Dr6NcLFZaUHbT0O3v8dbHrrL/3mbQeGGLT5RzhH6Ym+JPfOn4AAdi2KACV//DSKS1cCFa3rF
	Gs5CxGQC6Eqm0IJ8rm9SJc9lSkXscY/PnUq5izez2qiWqsJWgUPDKQSe2L93QI8ztkCg2omqO4F
	ni2zgtr9GCnF+n2nIdl/7ZfzEjBnq7GN9z68GoXZfo5YimqfUk9SYIr+HWbJLPRzEMkPJibPJyS
	XirTpnXNmRcdGtv5UX07jivkZq4p7RdOtaYPyxoIjjhTRORuDniBc14zvmb+kWMCufuy4E2m3fs
	5Li53y+ORS5Lg6saVJISpkfN3ul7PCXso3Hp86OpjZAxImqpzE51vTSBS687cg5bWbciz8jh676
	YMqXAo4shkCiTMzBm0qBI0PONnx9mOOb3cxN0G7TjPoF/bdr2jp37NapQ+te5Mag==
X-Received: by 2002:a05:6a21:4582:b0:39c:a78e:dba9 with SMTP id adf61e73a8af0-3b4978d6459mr1913708637.40.1780459102917;
        Tue, 02 Jun 2026 20:58:22 -0700 (PDT)
Received: from CrisStation.. ([103.220.9.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85deeb2bdesm759754a12.0.2026.06.02.20.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:58:22 -0700 (PDT)
From: Cris <cxs1494089474@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Cris <cxs1494089474@gmail.com>
Subject: [PATCH v2] Bluetooth: btusb: Add support for TP-Link TL-UB250
Date: Wed,  3 Jun 2026 11:58:18 +0800
Message-Id: <20260603035818.926654-1-cxs1494089474@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602135419.3092500-1-cxs1494089474@gmail.com>
References: <20260602135419.3092500-1-cxs1494089474@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB ID 2357:0607 for TP-Link TL-UB250.

This is a Realtek RTL8761BUV based Bluetooth adapter.

Without this entry the device is picked up by the generic Bluetooth USB
class match and exposes hci0, but the Realtek setup path is not used and
rtl8761bu firmware/config are not loaded.

The controller reports Realtek Semiconductor Corporation as the
manufacturer and LMP subversion 0x8761. With this entry added, btusb
loads rtl_bt/rtl8761bu_fw.bin and rtl_bt/rtl8761bu_config.bin
successfully.

Relevant part of /sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=02 Prnt=06 Port=00 Cnt=01 Dev#=  9 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2357 ProdID=0607 Rev= 2.00
S:  Product=TP-Link TL-UB250 Adapter
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Use the same flags as the existing TP-Link 2357:0604 entry.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Cris <cxs1494089474@gmail.com>
---
Changes in v2:
- Add the relevant /sys/kernel/debug/usb/devices excerpt.
- Drop Cc stable to avoid the checkpatch warning without a Fixes tag.
- Add Reviewed-by from Paul Menzel.

 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3aef21d4c..3cbb3c22e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -831,6 +831,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2357, 0x0607), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
-- 
2.34.1
