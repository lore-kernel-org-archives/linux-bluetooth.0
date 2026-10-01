Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52E23D7FF
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854658; cv=none; b=ahvrxFpBbnfbQOTykacZE4LssqwaZJEEEdC0YiMK7Oc4ghSzuhd44LREigKLbZSOL983yHlY7B9/sLQuWcfLfz1v5kJYmZS5ieAeioA1WZxVaAe5yGqUSXgs1CTD5OnGNc+FHNL2fdHMIDlBxnoUH+4qVOVCVsE77VKXcoW7K9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854658; c=relaxed/simple;
	bh=TEYM6+PtuYWkXQhTR9QkqiB5KRsMFhizznV9v5/jIEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdcrsUFgL3p+VTdONKkiDXGxmdxZJFS6rqXgiRztM0euhdnxUowKZddOJgi6SXhicTUrKIVY46xlBZZlK1f8pLNvzSLFneoh13O/aBUb+NZD6zld86xHNNx3JTXV2XngfBXIAD4SDexcRPbMNxV0Cf+21blXyqzoFtgFNrnXUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5DR9Kyz; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5DR9Kyz"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba390408cdso2616916e87.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790854652; x=1791459452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wvNfmKZph53jODrD/P4MGU0KRSsBQvOmztzicnnqzbY=;
        b=O5DR9KyzKKOfF+JZEhqf/2DY1fskgwo4T5GPQYXNU6FCf3eEObl0Dg5KZr7Bwcmt7t
         2yogcG0Oin7GXcXmpxQ6tajCqigWzMhhrb2zQZ8hIazo5cyfbiNW38OwHjx6fXQ7RojV
         9jF09dRVyII/F+Zojb6YUqhXSIHvz5ymrKOva3Upb3+X/1ZiwbRrZFR4/sXNRtFbAGY9
         tw0wq3+2Xl0HeBgR76k/gY7ReT3dXhmQ7fOMG1gO1mYi5iU+fq/AFd4itk+TpFmAfUTl
         mrC+nCmKNiUmqhWrq0Xhz80duWZnsVU5LbUgj3q8N8OvdkWyaLAv7dkhnxAC6asR8jn0
         IYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790854652; x=1791459452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvNfmKZph53jODrD/P4MGU0KRSsBQvOmztzicnnqzbY=;
        b=AvQquMDsz9hlfNZ+QifXh5wRTN/NsFb1tvzWOfZze02/rOy3COJtmiHbSg+hRC12E6
         SOZDzVYXp6f793daITDkWia6hfqA8jK554nxvRSDJOcPQANKwOahXLeqTRTlDMG/NHfe
         A7TlFWADYkx46IZeiDeTzK2Fn4JnjMkLsg1EGQ2efye9P8xj88bAlCzWp7WJO9i2u56R
         AmcTEGWEQTYcXCTDGVc1PFbyyjHYQEyhL8dXI6rCFVx0ljXlnvzn8ysQ7Akvgsy8YmmU
         +IUHDFSg5gtIGMK7fCfUoKfyHvF+ds2C/2BDeYQwmIwZ96CZMIbHMJfLDSQ7mT+1USVc
         +JPA==
X-Gm-Message-State: AFq9FYLiQi1omwzT3m6wO6/e1DuxTZ7ssq4lUbgPXDhXqtqhvMqO9ZIa
	eYzq649sdsOH6iAmc0fQ7pvB+vtXzouPKw1qcAgMRk6OjmlVU2obNnTaDqNBvfPDFOYMTg==
X-Gm-Gg: AYBFou26k/dt9Ml7CT6GeAUPsoWWShQ243DXDRAvnUBmoRI9SeeGlnYNfNa90p6bg5I
	zwTLL1SiUQlW911oxths2wcSz3n/VriuzeyiRsfXGTxJfTwIc8AYe7cQwbkDBAgvWpb5ePkG3wv
	XMAeirJlr2QYcy+07EaxNM15XljwtuzwlVtH5+u8g2RjT5fsaWBofOl5RbQWghzu0p93IwN0ppP
	1L7dhv5bu5fvu4Ckeqo+kPUJkwtj+pEHneliVRNQqBN8kG0TBZF7TRe9i1oBitgdHplqZiQVF1m
	xz1vOkmUbOkZ6UGJDqj46+mC7saTUiM3CPVgAaiDL/eQBrjQni/lbOU+fUIkD2Pyrzten48CVKZ
	gF4CSuqI61kEIly32YlMmBzVk6q45NoWJtrm0VNdvosMfLznPtf11tkTyatKn/Qc5/YzE3DY5Oy
	0W1HHMw9VnL1fKwA8loKkIb5XrYZn+dAzdfKBXjooTpLq78k6Df9BvqZVGvtIAKuWaPZ3jlB6L3
	tee/BqIp94yS0N/
X-Received: by 2002:a05:6512:65cd:10b0:5ba:3d16:b440 with SMTP id 2adb3069b0e04-5ba4060f8b0mr1423611e87.66.1790854652043;
        Thu, 01 Oct 2026 04:37:32 -0700 (PDT)
Received: from localhost.localdomain ([95.31.11.153])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb783a6ff0sm226442e87.27.2026.10.01.04.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:37:31 -0700 (PDT)
From: Konstantin Nazarov <qwertyuiopyyy@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Nazarov <qwertyuiopyyy@gmail.com>
Subject: [PATCH v3] Bluetooth: btusb: add ASUS 0b05:1825 to QCA Rome quirks
Date: Thu,  1 Oct 2026 14:35:13 +0300
Message-ID: <20261001113513.1612-1-qwertyuiopyyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Bluetooth controller with USB ID 0b05:1825 found on ASUS
systems uses a Qualcomm QCA Rome chipset, but is currently matched
only by the generic Bluetooth USB entry.

Without BTUSB_QCA_ROME, the driver does not load the QCA rampatch and
NVM firmware. BLE scanning also repeatedly reports:

    Bluetooth: hci0: unexpected event for opcode 0x2005

Mark the device as BTUSB_QCA_ROME with wideband speech support, in
line with the other QCA Rome USB IDs.

Similar issue but with different device id. After patching bluetooth is
working fine, no unexpected events in log.

Link: https://lore.kernel.org/linux-bluetooth/20260928143655.22223-1-qstrydom0@gmail.com

Tested-on: Qualcomm Atheros QCA6174 SoC integrated in motherboard
ASUS Z170I PRO GAMING, USB device id: 0b05:1825

Signed-off-by: Konstantin Nazarov <qwertyuiopyyy@gmail.com>
---
Changes:
v1->v2: Used wrong repository.
v2->v3: Fixed code styling issues.

 drivers/bluetooth/btusb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 3518f92eb..71d8dccb2 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -272,6 +272,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },

 	/* QCA ROME chipset */
+	{ USB_DEVICE(0x0b05, 0x1825), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0b05, 0x1868), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0x535b), .driver_info = BTUSB_QCA_ROME |
--
2.43.0

