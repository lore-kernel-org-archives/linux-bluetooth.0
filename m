Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736234404B
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933051; cv=none; b=LN6ye4odFeihdkqPB8gOgTNG+/+q94kBVOpY9LuUYiGGY1oWikDVKVA3/J6mkzLfHyJ5dYJTQO5b+UTEtjc7WSdhRav9fJD26+oABSdhvtpVPDZ1tqHJCgH+itWKGTSmgm2hWtQtw8hqivBMkX8x3nM8OVr0zbOEutbryF9DYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933051; c=relaxed/simple;
	bh=scKh6R9EUSlQ4lKA0Rk4N72H3a0RDd5kYfxeKb3C5BM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BeUxx1jDgblkm2j395cfTdWEMFrdSbb6Yl0pcVNPkGac0F3u6QqFi3Fp2HyqhZHJ+XOfOvxXui5BMq5C4gWoADrCCghfSg41sgsEuDVWQe0FD6ZpIjDjGAuAV5VjKWiMRA1cvSY24Tch6XMx9Jkb87Oxjx9yeOR9ntqXrNxfF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL+VLZ+8; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL+VLZ+8"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56365984503so3678499e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 10:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933048; x=1769537848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2N6YjdmiR1qKUM0fCUHaKgmHm/+5o3h2coxD74n6fqw=;
        b=VL+VLZ+8OYlnKGpUOTivvTpiJwbmPry634HBgiiB0ZRgxEPuXbdeBFBE2EOmqNbfD5
         4YbVd3tZeyzmL53Eyjot+Oc7Zh77Lb8uLLQOdAPlnB2quYyYUlrvr7pdAe1gaIaXgIXX
         xHOMkDtVe4OIu8KU3ArZTHBAqNAbcIpSKsM1wAd6i2zp3Zrn3RC9SydlClpSRYYKrbPj
         5Xoo0jVaOKBfTqpVByO5pbc99OwfsncX3BoFOH4OUHahYIBCSnBTjzGQdt8rsufOc+ay
         Tii+MxHs/+UA2W21vnXKZbg/xeIMOpWuKDhhlAuASUOzhmqU31e3hIRUFynqTHUobhYa
         4eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933048; x=1769537848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N6YjdmiR1qKUM0fCUHaKgmHm/+5o3h2coxD74n6fqw=;
        b=pPLy3IBLCnN83842NulSxpylRX4Mm8v5EeeGEf3AvTJEful51TnYB31aQOsGp0gYtO
         dYkVlUTxsusWSe1VrCXCE1yeNMXzyNSVS77eLdwY2jNKbvsSXJcbMDMZb32xpYBl3DKU
         YZ2Ztrwc8fNY3odBya6yeGjRNIBJMGxRrstiGTHXWT3CnoybaTD0k76ug5Tp/+6R5byF
         oEcZ8xRUbpkkbc65hqdjiE0lYPbgG30mwHz77tOGMJZrQPIOWB3xgEZuU/w7aa80lZOe
         yuUzxg3zyKh18u6+CtMW6yPIZpgF8Wc0RI6Mpwro634uacZubP/gbqIHOgQwUNYp33CW
         7lyw==
X-Gm-Message-State: AOJu0YwNHHGDbj/4x1vkUCRNGvCRmsgQ956y6qbLYPz6QYRZAxBA7/ZQ
	2735FuL1jlzFEcRSSSik7BKYfVVjYN1wwUM45+EAw+EVSeRfs9SqtgiOSk7yzK2c
X-Gm-Gg: AZuq6aKs5fZ5YfRjQKPpvYExZIZl/64iSypk2PEL7YodGeBZDQRrd0MBm/BzcYEPFVx
	oiA9/JfFrtfom5Jro+60dboyrxOhmxnqP3QtYZgdgUrIRblxNAuSue9cSp0ivzI/2pahs4C3wXb
	wVKtbWV2wOs+f8A5jSc4kpb0y8rhCFaLrTZCtzPH0CHYdmhyTimELrDOS5omV0HSnORt4ZkadHf
	IQ5yI+JOp6+E8OUBeeg/MKznB3+z7aZ1JrRcepxnsIGqkJO4CknuUYKdtg0Th/ENA+MvSG5eR1x
	nSPkFxNmCBr8IOmuMiGL/TNv/Hid5Ana8BNbAfUKR2rB7E9hi58QT3WjkoAKlgEMP6VBsH+OOyB
	tjMVQdEZnK4X2WfvGsCyrWZtiDRRY7d+zRtwv1IsJOUnuRGc1H4+rkkv+l74QfNOH40E1Lz+z/2
	HC0q1ogkObblvW5aZ9kmrEbFJQmpsUaqtBwVZsaJgsZIG7J0cRAjDCOVjy7ds83ILhUA1dVaRsp
	MsHjg==
X-Received: by 2002:a05:6102:6cf:b0:5ec:c528:4df8 with SMTP id ada2fe7eead31-5f1a7129a0bmr5323070137.28.1768933046692;
        Tue, 20 Jan 2026 10:17:26 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a694494asm4574957137.8.2026.01.20.10.17.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:17:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] fixup! Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Tue, 20 Jan 2026 13:17:17 -0500
Message-ID: <20260120181717.2321998-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 drivers/bluetooth/btusb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 759def260ed0..f9fba78f0a4a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4468,7 +4468,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	kfree(data);
 }
 
-static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
+static int __maybe_unused btusb_suspend(struct usb_interface *intf,
+					pm_message_t message)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 
@@ -4557,7 +4558,7 @@ static void play_deferred(struct btusb_data *data)
 	}
 }
 
-static int btusb_resume(struct usb_interface *intf)
+static int __maybe_unused btusb_resume(struct usb_interface *intf)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 	struct hci_dev *hdev = data->hdev;
-- 
2.52.0

