Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28731D0797
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937447; cv=none; b=JqBYtU/UOMhWu+oHWfe0849jJZQzGvXlFo9lxj65qunltc3EaJLB8b9ujlIuNZZ76fEhM3gGe4L33iM6WZIGjYAEUqEix0jjqyq5IAw2CLai1tZYlOu4ItTn0UuOzzdzIumgbcQ2gBJstVe5uBr9Q/XtoEcOqXlJC4DrWqU81f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937447; c=relaxed/simple;
	bh=O5p3F1OIxumPqpJZc9gc4XMNE1NRb2y2QLbD4zRdOPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIkCPDNz1qRfYc+nvnEWGenigMrj9xtfWCaGy9dGbN+BHUggd0UZ3TxrqXXgAJJg+a51zMMZWLVsiaBDTraAgehGrUCT9YN72AMX6C5lZAN7UFkvSdAW7oP2s8G467CptuIVvkz0v0JOqxmIyW1Oefx9Jt52vMMoM6NHZdytc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnDQI4d0; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnDQI4d0"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50d3365c29cso1496911e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728937444; x=1729542244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUS24RtZD/E0WCxqOPekOobIh8npUWejjoPCpZ+N4Zw=;
        b=TnDQI4d0LSxIT3zxDtJcc0O7yR2WGD10OY5GODmTPW6M3Rmwr+b62qpSfmdlIhvE0r
         kM2SgNkgapDKnCpFVfVhs60rCfxRGNmLahT+2YpRW9f/HIx5KqxgGDKS+wVcxOCRRAUl
         8lKQ3d3Shq6GYYpt2xLGs/P8Lu6SO6lLEppd4TybOkaDWD23SjjuIuwvVJ2ADIvqk4mp
         K0QIr5/e/5hC5w/a5fnaU4WPGaYUBVtVuyM2+qmRXkD4kTGp70StfZhoMDSivAWQpzXS
         BcsB+obGTSYCe/qFb2vJIlPKMk/IaB1w+ogNtKnDvV6n9zGC4P4p1nFFzh3MXWqOTBea
         RYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937444; x=1729542244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUS24RtZD/E0WCxqOPekOobIh8npUWejjoPCpZ+N4Zw=;
        b=sxauFFqrJm09rODsPZ9BSDxcqIdaHwmzPc9syWaIy7Ia1AjTnyczt4kl337MGU5s0k
         7LmF6UFqMJJnxFFQ350xzairSEcv066QIDzU47dvn2YK3ryE56/YQWRoWItgJXn+CDHa
         7YKUJVDc6kaLMqUa1xMRy3fOmuF0uFgdjW7sV64Giekbfe2eH6wCDKOR984JeKkShk6Z
         Z4rSATlxgXUK6jCZa6B8p05zJsHdbmtbZgdYbVmLZ5fgQ9wouYMnNHbhI3L7Sg3pZtOu
         Hyg02WjLkv/cgj0hCUBtzywlnNjKkgYxwtjMWx736DzCZylrWMv4s35RjDt/I+ygACAO
         NjuQ==
X-Gm-Message-State: AOJu0Yxl/CISg84u6oiOa9OZcwlEespaCSxvBrcJst8uJFAwRY7lyKyn
	WP8NUyOghinFcV+gnbcJKcrYKH+MmyeXvaULgH5KF6T97YnzUCPxKkfh3A==
X-Google-Smtp-Source: AGHT+IEzAKAZK/HA0qevkPgKYySAsiKllnsV3M3g0Dxr0tTjZ5FClQ2FcuZAl9aX1sTZSY1RIvFf2Q==
X-Received: by 2002:a05:6122:2027:b0:50d:34fe:fef0 with SMTP id 71dfb90a1353d-50d34ff01cemr7250652e0c.6.1728937443734;
        Mon, 14 Oct 2024 13:24:03 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50d278e3dfcsm1136492e0c.33.2024.10.14.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:24:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kenneth Crudup <kenny@panix.com>
Subject: [PATCH v1] Bluetooth: btusb: Fix not being able to reconnect after suspend
Date: Mon, 14 Oct 2024 16:23:26 -0400
Message-ID: <20241014202326.381559-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Calls to hci_suspend_dev assumes the system-suspend which doesn't work
well when just the device is being suspended because wakeup flag is only
set for remote devices that can wakeup the system.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Reported-by: Kenneth Crudup <kenny@panix.com>
Fixes: 81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend requests")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d14b941bfde8..c0b6ef8ee5da 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4075,7 +4075,6 @@ static void btusb_disconnect(struct usb_interface *intf)
 static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
-	int err;
 
 	BT_DBG("intf %p", intf);
 
@@ -4088,16 +4087,6 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 	if (data->suspend_count++)
 		return 0;
 
-	/* Notify Host stack to suspend; this has to be done before stopping
-	 * the traffic since the hci_suspend_dev itself may generate some
-	 * traffic.
-	 */
-	err = hci_suspend_dev(data->hdev);
-	if (err) {
-		data->suspend_count--;
-		return err;
-	}
-
 	spin_lock_irq(&data->txlock);
 	if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
 		set_bit(BTUSB_SUSPENDING, &data->flags);
@@ -4105,7 +4094,6 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 	} else {
 		spin_unlock_irq(&data->txlock);
 		data->suspend_count--;
-		hci_resume_dev(data->hdev);
 		return -EBUSY;
 	}
 
@@ -4226,8 +4214,6 @@ static int btusb_resume(struct usb_interface *intf)
 	spin_unlock_irq(&data->txlock);
 	schedule_work(&data->work);
 
-	hci_resume_dev(data->hdev);
-
 	return 0;
 
 failed:
-- 
2.47.0

