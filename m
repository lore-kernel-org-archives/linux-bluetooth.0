Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEC30BB85
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765382647; cv=none; b=fw90TPf9WA3JvvNpTLT47M55zIZ7xjaQ5eVS0Ed/hMpwKf518j+IUmRK5bQTgG42161T+LLSkcghthuX8bgk64nV3zCVApRZjZAn8AMJJSbIUJKsrzQIRstHoEYuv/9gbcEriGPVGdHPjfCz74/rAbrd2Un1qEB6PA7n1dcLAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765382647; c=relaxed/simple;
	bh=HVZ1aCNsjLYLwodkEcZua3bcxqg9L0l7n2oXJDjXImI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwnEN6ehEy5A+U840v/I0b6w/C4gX/tw/n6EZqaPC2urPFM8d5CFM/BNqpNjSMeSg1Py/CgV0DY7sONvDSpymBi6VhV1XdlZPPPgckU9aj+sDNrMNl/wjedextlzI9q+4ubvma+0R0tRkJCO6hZhQ17cCD5PpqGy39ENO3qKPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOT36tVK; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOT36tVK"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee1879e6d9so77396941cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 08:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765382645; x=1765987445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzRN3T0fzHK64wqNuQPpObySUCsqmaWYwVU1TjZZ8/Q=;
        b=iOT36tVK9bGJg7rWq5SSXGyf7X8hh5ovnIR5zryvkHLTdLev+xIItaFY2nFR3WeFhh
         kzrh2Zhs22bRXj7DoopkP5mWL+pv4KgIq8r61zsYS4G9eytlYZSqqEGmLWy0wJv1udS2
         85xa/M2pFz3NwFAVguX/7MOa/LBPKgRdXW0Xwe2W6xWfv4u7J8knkHv8qtKuz9u0OtWP
         lc0kiEhq+P/kcG3susletJKjAlxnRKd59ls1htwNPOQrcq0PRs9P42xdFKOfYTd4yvwI
         GAr9mhR5qyDnILNgZuyA5iLfvuzNJjYhKs3Y+vK/Z3kd+lpwvaTi1QOUV0QXILPzE58J
         cZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765382645; x=1765987445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzRN3T0fzHK64wqNuQPpObySUCsqmaWYwVU1TjZZ8/Q=;
        b=ubxbgAGmcLHTigL/Gr0EHFo0AU/WZfQTh9EXpof/5VN1d5I/GIciFsYTtdLrgUjVVf
         uu3EmK2SzlX7sqQ8DepjJ3hUvnAk4KX2T1gw+CB/KWwuihQgrn1ZbZgskhQ4vBNPCgpO
         osM8BkYKK8pmf4bIRuMe2lug5weO+W5BYcMZdUNEGLCpT91zwDe6lC3ZoBxe9EkNeWdH
         l3K3RJn87Ov3lwICYh41bsNaOjJqyzsc+7wQSiUioPGd2Ho5jFq2HJSGbTU/cZe19WpN
         aSj6GEEftZ1kpGzVR1fHqB9dA4ztZoj0n4A9He4+NKakGif2kQ6RZmttZPnb96mXjETR
         emSA==
X-Forwarded-Encrypted: i=1; AJvYcCXbR2WmwDaxjk/9YObWRwNkpfKt/vtDf3hSqBWqJd202rsua9WcmGnO4pgfbjyp3ytEhTuN83VaLyIVR74/6uE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz80ghdJWhdKFv1vVZLyS1vpN3H0pqEQKjWybavVPufxaPrPDrX
	ePwh6pfWETb4N9G6WWfI6qGh+1ByKGWcOOyI+XiLFN7sIhCR3Q8CFMYw
X-Gm-Gg: ASbGncsOBR2tAvxVjuLeRF4dtTD5vR34pX3TUfkMNmhnBfID1yMsRoyz8w/VHEkJI5B
	gtuzh5ILJoli7wK9rj/LQ1DyuTD1nmEVAC3tUQd2XxBqgWTU+tNVipdi6+kK5LYd9k4vo6A0IWq
	apP9V0lFsf7zgDhYgda7kAK3+wQeSDPzTkiewanqGrBbImALg0Tbdlkph4FEmZTPk72jjX1QwCw
	komvsUhMPoA7jbftkLBCME23NvKYM0jAYnv4VBlAexxDKz2+kxNZxdTsp34jW15envBSFLnSeY4
	/WlQo3v9YE9MgjXuSJZ44GMOFPTwaCqXFN1foxYNF2OnC7whXMWgfMKwhoVgHb11QkIQzIg8tfj
	xNxKvUDIrw4/CiKpyqXtZxbMBHKxez6P4oPoX/lvdwR5W1+HSvNfEbOuYTvWhZJEKzKk6Q1Gg9/
	2AePbgCnH4BFNzQSnZ7j6baa+DCcGGB6w=
X-Google-Smtp-Source: AGHT+IHc7indLQCjf50rKdUATwE4kVeAI57GIjuzuPj0yTQiOXotrYORM/sLEfTILNh5KkoxopmYUg==
X-Received: by 2002:a05:622a:5595:b0:4ed:2164:5018 with SMTP id d75a77b69052e-4f1b1aebd58mr34161321cf.80.1765382643935;
        Wed, 10 Dec 2025 08:04:03 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f0276dd360sm127046301cf.15.2025.12.10.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:04:03 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: oliver@neukum.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Subject: [PATCH] Bluetooth: btusb: revert use of devm_kzalloc in btusb
Date: Wed, 10 Dec 2025 11:02:28 -0500
Message-ID: <20251210160228.29074-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 98921dbd00c4e ("Bluetooth: Use devm_kzalloc in
btusb.c file").

In btusb_probe(), we use devm_kzalloc() to allocate the btusb data. This
ties the lifetime of all the btusb data to the binding of a driver to
one interface, INTF. In a driver that binds to other interfaces, ISOC
and DIAG, this is an accident waiting to happen.

The issue is revealed in btusb_disconnect(), where calling
usb_driver_release_interface(&btusb_driver, data->intf) will have devm
free the data that is also being used by the other interfaces of the
driver that may not be released yet.

To fix this, revert the use of devm and go back to freeing memory
explicitly.

Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
Syzbot reported this UAF already and my commit 23d22f2f7176
("Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF")
provided a fix that rearranged the
usb_driver_release_interface() calls so INTF was released last because
I (wrongly) assumed using devm like this was intentional.

This patch is motivated by a discussion prompted by Oliver Neukum:
https://lore.kernel.org/linux-bluetooth/aee37797-a280-47ea-91ac-487ddc124ac7@neukum.org/

link to patch for 23d22f2f7176:
https://lore.kernel.org/linux-bluetooth/20251105192839.895418-3-rpthibeault@gmail.com/

 drivers/bluetooth/btusb.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8ed3883ab8ee..ded09e94d296 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4052,7 +4052,7 @@ static int btusb_probe(struct usb_interface *intf,
 			return -ENODEV;
 	}
 
-	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -4075,8 +4075,10 @@ static int btusb_probe(struct usb_interface *intf,
 		}
 	}
 
-	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep)
+	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep) {
+		kfree(data);
 		return -ENODEV;
+	}
 
 	if (id->driver_info & BTUSB_AMP) {
 		data->cmdreq_type = USB_TYPE_CLASS | 0x01;
@@ -4131,8 +4133,10 @@ static int btusb_probe(struct usb_interface *intf,
 	data->recv_acl = hci_recv_frame;
 
 	hdev = hci_alloc_dev_priv(priv_size);
-	if (!hdev)
+	if (!hdev) {
+		kfree(data);
 		return -ENOMEM;
+	}
 
 	hdev->bus = HCI_USB;
 	hci_set_drvdata(hdev, data);
@@ -4406,6 +4410,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
 	hci_free_dev(hdev);
+	kfree(data);
 	return err;
 }
 
@@ -4454,6 +4459,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 	}
 
 	hci_free_dev(hdev);
+	kfree(data);
 }
 
 #ifdef CONFIG_PM

base-commit: 9d588a1140b9ae211581a7a154d0b806d8cd8238
-- 
2.43.0

