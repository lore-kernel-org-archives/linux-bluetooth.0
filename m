Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF918C920
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093627; cv=none; b=IuZ1w2Hfkq5p7Txo1jpES6Sc7CgIDf4XmpIU/sjzLakl9B65DLYB8eMwIBt61Yc8Q7dTH60ywtPL7TevtpxgnQoi4IwDrG/U/yh0JkdyztUaQAm5UKQ7uKEPL+HSCTLYGrzCACymsr3fIIv5jjHriguvmpgzDbH9PC5W5tc0OEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093627; c=relaxed/simple;
	bh=JPUoPAc8tCGBwmB1y5HNjmqB7ZQqVWoghRhNvJ7iT20=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VaH+vHKlxZJNOtBODOwYuI98Uw0ejEFYsuX1oX0gOYd+wEgpY5o4ymSLUO1Q3ncwxnsR7NRS8rFYErST5LRAVGhYa/C4Fd1POFITwtOfiesYyyHbFSCpm7UxvjOHIX0DiiDrnaSXNqO6qWGy4VZ0sMwnfSn8Cp5oHS9SkiHNL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaivMX3k; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaivMX3k"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fd059e49dso3984241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729093625; x=1729698425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4X1SqLTp82e1yz2YCg2bjLbpItw05z2iSjy+qugWads=;
        b=OaivMX3k9XoyU6ovhJSxrV+GwhYPa+LBMuaeB/6y/Y75siWtCv9bRyT6aZBMmd2Mx2
         viPTYo129kN1rxUs1QUbIIy7HfRSIC/DUeY9ctjSlSx0GTWbihcCfh1giex1muHVn2Il
         0zY8J21oSVD5e/QtcBbuWLFkcVKeRCfid1wksuUKd6lyce9iw0nWIB/TY1FZVxqxdYLM
         BbuiUqOcgcNja2IzC5DGolcKqatbP4dKydIflYBMyUBWbwwvwPLbj/MML0jD9hbzyClJ
         8cDphc6RI8dhVIgL0W3SGIUJ/MYvdhbK18Je/AaVmkFi6lYEJ1CTMuY8Akpfnxwc5zf1
         5tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729093625; x=1729698425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4X1SqLTp82e1yz2YCg2bjLbpItw05z2iSjy+qugWads=;
        b=hxoEEpq7nD8yHHj0bGgG2NQDumBIv/OMe4UxT7A4SrxQocJy/dY2+NbPka5xZoDKQI
         Oqxs8KNjAGfhhR76ouwnPCVbUmsXmwrqmTR2tkROe7NqFloYGuo9rki9ge8j+hIywcFp
         GXiJi+KNVaRbsQLx2fs9foMdawd6YLR+Fml65Y+uG7TaL5fbp7pWntwbowh6q8I3XeJt
         F1TBnc4XkyPY6lPr8aZR/yt/nVy+dSffQAHIpWV7I/3YHUcf8e6XHTLOz0mDJlEnDZcb
         mbEc8Ml/k3dmTP2jNnPfTtlf7Dgla0XXS4kGsM5MJDRnHI5IiKmYR3QQ6Z/KNowyiqdD
         3kkw==
X-Gm-Message-State: AOJu0Yw9WlQbo8cS1j23/sYmaF0/zBD2/g0gWT/+iB6T9gBSmoWKV6tw
	8LEhBkGesbBBYZ3OMC3g1ducQkel0anOnkiUBOBCn2yubsgWPoMtj4fR/kk6
X-Google-Smtp-Source: AGHT+IFhi8QNYLwilkSpf6juXVmoN4imgrboedUrNRAfITnY7D1SQSTI8/d7Kyqrmi7yuPvwVAN/qQ==
X-Received: by 2002:a05:6122:168d:b0:507:9096:423a with SMTP id 71dfb90a1353d-50d37745a42mr9369742e0c.12.1729093624684;
        Wed, 16 Oct 2024 08:47:04 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50d7b2a57d0sm533950e0c.39.2024.10.16.08.47.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:47:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001
Date: Wed, 16 Oct 2024 11:47:00 -0400
Message-ID: <20241016154700.682621-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fake CSR controllers don't seem to handle short-transfer properly which
cause command to time out:

kernel: usb 1-1: new full-speed USB device number 19 using xhci_hcd
kernel: usb 1-1: New USB device found, idVendor=0a12, idProduct=0001, bcdDevice=88.91
kernel: usb 1-1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
kernel: usb 1-1: Product: BT DONGLE10
...
Bluetooth: hci1: Opcode 0x1004 failed: -110
kernel: Bluetooth: hci1: command 0x1004 tx timeout

According to USB Spec 2.0 Section 5.7.3 Interrupt Transfer Packet Size
Constraints a interrupt transfer is considered complete when the size is 0
(ZPL) or < wMaxPacketSize:

 'When an interrupt transfer involves more data than can fit in one
 data payload of the currently established maximum size, all data
 payloads are required to be maximum-sized except for the last data
 payload, which will contain the remaining data. An interrupt transfer
 is complete when the endpoint does one of the following:

 • Has transferred exactly the amount of data expected
 • Transfers a packet with a payload size less than wMaxPacketSize or
 transfers a zero-length packet'

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219365
Fixes: 7b05933340f4 ("Bluetooth: btusb: Fix not handling ZPL/short-transfer")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c0b6ef8ee5da..f72218c1037e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1366,10 +1366,15 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (!urb)
 		return -ENOMEM;
 
-	/* Use maximum HCI Event size so the USB stack handles
-	 * ZPL/short-transfer automatically.
-	 */
-	size = HCI_MAX_EVENT_SIZE;
+	if (le16_to_cpu(data->udev->descriptor.idVendor)  == 0x0a12 &&
+	    le16_to_cpu(data->udev->descriptor.idProduct) == 0x0001)
+		/* Fake CSR devices don't seem to support sort-transter */
+		size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
+	else
+		/* Use maximum HCI Event size so the USB stack handles
+		 * ZPL/short-transfer automatically.
+		 */
+		size = HCI_MAX_EVENT_SIZE;
 
 	buf = kmalloc(size, mem_flags);
 	if (!buf) {
-- 
2.47.0

