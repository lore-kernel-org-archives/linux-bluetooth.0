Return-Path: <SRS0=rxlX=4P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C47C11D3D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 18:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2B020726
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 18:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ih9QGM2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgB0SaC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:30:02 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45807 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgB0SaC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Feb 2020 13:30:02 -0500
Received: by mail-vs1-f68.google.com with SMTP id m4so246505vsa.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2020 10:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/QIyRz6v+UoGMZU6EYkJIHqTD4uHhyA6XinXW9UAfaY=;
        b=ih9QGM2FIvDGgSPTU0u2UppQVz3ZzgZl6dPLrV6a9V4fAi7rEcrjn7Qg7Z9jnncm/a
         1jyEIbs5hMMJ4FQ+E2YqQGqbjB4cs62gl4E0wzRoL70F7OmfxvS2fkgH7tCmxrIpkBVg
         XZ5l7hBV9R0ltR23qCJXnzH4mkgdsIzaxQvAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/QIyRz6v+UoGMZU6EYkJIHqTD4uHhyA6XinXW9UAfaY=;
        b=iFoAxIgbKanHkwieK2HQzKhJ0yK3QCq2gRG4aERtX5VBgflp6kON5wZab42DpudBaq
         /WJsjYKpOFU5X+8IIghLRX/34zWAulywtb85D/2Q368tJdhSaJJhTEoGOmMn8kkDq7wB
         fjqlxA/jikHeN91ykDOjbsmreeUbHo0Yn30ozALxr0mHhA8qMmfuACrdVhXRqRANHKvU
         qPf8wAlnjRAjlPbuvE4ae+0Ohvm81hM6mYuCF0NoDiUq1GO2TP0TQKt1hnPQCK7n5ZQX
         v/FUOedpcIznu9tByMNO80rNryIOPC+S4Iw3a2d5gnudhNzfEnn3KCUNrxwjVc17/LcE
         jnFQ==
X-Gm-Message-State: ANhLgQ3bCjvV4XFRKd1VSWY1QoFgGwIHlg0B7x7XFHjuT5oedHqg1UpM
        H7bBGkAtp2NfOaYHCnbZsdNKnByV4+Ss5w==
X-Google-Smtp-Source: ADFU+vtwjQSKGLpAAoS9GX2NWttAJT4I1CkFLu4VQNVjK6hdaj13M0rXpB9wBd2l04mu9vnDUuNrvQ==
X-Received: by 2002:a67:31d8:: with SMTP id x207mr429604vsx.192.1582828201070;
        Thu, 27 Feb 2020 10:30:01 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id v21sm2274464vkd.54.2020.02.27.10.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:30:00 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1 1/3] bluetooth: Add flag to define wideband speech capability
Date:   Thu, 27 Feb 2020 18:29:37 +0000
Message-Id: <20200227182938.110670-2-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200227182938.110670-1-alainm@chromium.org>
References: <20200227182938.110670-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds a new flag to define a controller's wideband speech
capability.  This is required since no reliable over HCI mechanism
exists to query the controller and driver's compatibility with
wideband speech.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 drivers/bluetooth/btusb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f5924f3e8b8d..1b175ba3085c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -57,6 +57,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_IFNUM_2		0x80000
 #define BTUSB_CW6622		0x100000
 #define BTUSB_MEDIATEK		0x200000
+#define BTUSB_WIDEBAND_SPEECH	0x400000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -333,15 +334,21 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
 
 	/* Intel Bluetooth devices */
-	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW },
-	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW },
-	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW },
+	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
-	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW },
-	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL },
-	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW },
+	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Other Intel Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
-- 
2.25.1.481.gfbce0eb801-goog

