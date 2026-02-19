Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7A2EA749
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771528291; cv=none; b=hk/JQTUF+v8LsnTkJGIKTsZybMpFbeJgexHiMVFJb5pPY2yi5j0wFWCM78ptHpDGSZa4WZDQeGPnJzymKQnvtypjylJJaqqBcpgOPxSyy3j+OY61ARPHcPiHFyDA/Ab7/Z3F6hMIryOZnfjkAQ7Fz7IHz7xawfp6HSyLn7/qfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771528291; c=relaxed/simple;
	bh=L3fCGqlTBGRP9RGewx/NJ7E27mZbLjkR+8j8vgXOUvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iySqEv09s3gKct2H4Stfq8W+N7EkKOLpWuBS9KYCrCzEcu1vGN1zBYHWma8Khtn2FNmQFT7kvLD2D5LT2HHtBmxkbxEat8tAK9rCuJelaIFnSncpXEDgrDDkptzkay5LZ/OTrcZjVQbYp7pfcSROwP0h3YJDQmy74q6v98XS+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llrMkuUq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llrMkuUq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-435a11957f6so1084728f8f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 11:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771528288; x=1772133088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=La+aWbMATMluSKFWFaMvl61r2uBPiwHLmJhaoS4H630=;
        b=llrMkuUqcnLG2ZX0pK8pP6lUG5G4xJPIumBdnjllt2ijQFlTFN7MqOTu4o3Cjm74Z2
         WflhdbwrsoqSBIdUlr+jXmZgr79YxGI5BUnTzP78wi1d2p7jjlnFGasQ8uMvC1OfSovp
         vVEVaSSB3wfphymlg2ONnq3ATZZSiowJHfeqxlH845QU8N3F2bKPsK5EuQOkBCiIUKHd
         SF5Yb3hWtRhoakit9OxFMmcPMFPFdt4HF5DzpWwsImK5KKMhAcUIygky+k2s5YiRAHtC
         +G6bwuWGR1EaH1ekd+EEXtOO8aLKVi8VA4lhHgKkbcO5MUxTPXPJNPtw4blU+jnE+Z1c
         hEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771528288; x=1772133088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La+aWbMATMluSKFWFaMvl61r2uBPiwHLmJhaoS4H630=;
        b=jeXbU8d3nv7iAsLL3XMoEUR0zCs1qyzp3XaGmSWPnnOeLsRsM9nJR8pWR9/PfDT9/d
         yMBaDFayT66jhbskjrymgPltlPsEjp7PlSclP2S0/oy9MkQdqXr2riYmsXuaXCoax9D7
         Bt7NhzfJ7cyYTSWbHWImA6MDvKTt6iSfGAGQe0iSJ5lWwxHCDRsR9WTtdX6+8rGjNp+2
         yEAP1xGbtdhrjPlAOtAc7VqUJ10oVjEpIsVkVXjE64J1rUpPGj57Jae2okMkAmhX2br8
         /9mZH7hmeOaenfQ7IwYpIDTub99mG2nQXSws5awyxD0AZQrCTnBQOSZGlvbQm1xADq8e
         NSiA==
X-Gm-Message-State: AOJu0YxdfQM3RHgtxRWx2Qdv5nON+m86F8BYzaJJRnYaKV3Vvmd7c/6f
	sSODp5Gw/PHu+klS2cGe4AoXNYClZPGYwM/EwwyAnoSZZwzMS9jXJhFmGMZIeKs=
X-Gm-Gg: AZuq6aLBw+07OXs5y+2WlVD6NZTP8Eiws4ufazdmdATmMxsRUL2Ab3f63pavnpU/NPe
	7FspC8QpZjU1/llLN9YoPU/tZ6K0r3NiMWQDJ76QYEVmppWqGAxVBmsHgAoEPTNCsGVAs88p9SI
	KQF0f/bqYGfTyaE35j8NDRs7z4UoMiMLRQumbMfEld9efB09OKKzb7aZhA32dsuB2hlPaHT+z6R
	o1ZSBM4OJN/yYS9d3hdXR3Jx3EZOqiT4kW6HyKPC7WuQ8JeWA6Ei2Jou6L0OCN7z5HdkuxkkTIw
	dtWhL2Sn0R5ZjVpAa+24B7MMNvD2IjNnYAocr/QVV1J8B3UcH7fBvyprMoRQrK3IW9Rbi5dzKsG
	RcybNFfpwsfdFLQkXsb9i0/Lnp+rvQtzsIkJW/ArujJbIneVri2W4oHrPQ82rohrFHKESPdusMX
	EF8VSfgbwXuXaru3kDQkM9G81QNAiiF+0lPAQYmYHhdfWnggOxnp067FhZ/linVvR0J9fLxWaE9
	P4=
X-Received: by 2002:a05:6000:2307:b0:437:75c1:5793 with SMTP id ffacd0b85a97d-437978c99fbmr37483846f8f.3.1771528287521;
        Thu, 19 Feb 2026 11:11:27 -0800 (PST)
Received: from archlinux.v.cablecom.net (77-56-128-136.dclient.hispeed.ch. [77.56.128.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad0166sm51696809f8f.35.2026.02.19.11.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:11:27 -0800 (PST)
From: Dylan Eray <dylan.eray6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	sean.wang@mediatek.com,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dylan Eray <dylan.eray6@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add Lite-On 04ca:3807 for MediaTek MT7921
Date: Thu, 19 Feb 2026 20:11:02 +0100
Message-ID: <20260219191102.64722-1-dylan.eray6@gmail.com>
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

