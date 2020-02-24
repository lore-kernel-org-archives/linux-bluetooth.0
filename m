Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917F1C11D35
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 15:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633D12072D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 15:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="drOoGbfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgBXPDh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:03:37 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34314 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgBXPDh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 10:03:37 -0500
Received: by mail-vs1-f68.google.com with SMTP id g15so5866458vsf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 07:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IhuLNDGwoKgrvPUZvUf8DMDDTULaPbolEr88As6QCM=;
        b=drOoGbfx7LjeY0zeTvERqAtJxYgUaL9W1mr9q+ky8h3fG2Yof1CZwsn19lPpU/3e4f
         FIEGyUEkozD+JeIR7hJirZJwQz5+PAEd9YJDF9pVQlpXxTqjU6okbog2Bw6cpl9Z2niq
         cKFBC/YJGSU+9c+2h4CrUDHmXgeYdICLyjHNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IhuLNDGwoKgrvPUZvUf8DMDDTULaPbolEr88As6QCM=;
        b=WviysogHme6zP79GTFnauqXsIqaKc4FQ8+n4jMqEC7AaPMBi1Gj3QA6QBuFu2sq1p5
         HG/35945W2MQCf+RcP9h9OWmSGmISvStlWy0vx83j8Myfs4ClAY0HDSo1CEb2Gw6TvS6
         6BsTiWjqkeuCN8Ek/6lz3r1rzYct9o5Z8IxMRTwHiRb80PczGlsRSQ03NryonIRL1zCK
         AZgt2wsFJjd0b9/8EIVq/ugpNz6e62W2sU8JTVXooEcks4vmdXbXXlNPbcMlFeE8mdEd
         vwpTEjaI49VO8kitMi93KWBXMDzO3M7bJnT/mw+hJBXusrEoasflhVGa81Qo3cUv3h8a
         mC8Q==
X-Gm-Message-State: APjAAAXfMy0lbmLy6AxeaNsmmzAOMlmaYXs41MZLnZypixWl9qWLAnaW
        yBjy6YJzNyKMcaN0hW4jJ4naGbeFO3k=
X-Google-Smtp-Source: APXvYqy2kn79IniwrSlZJton+kxWBQyMWCsk8xkC0p/bmdskSMJ6FJZZe8nKCDPfIweFOxkdckkXbw==
X-Received: by 2002:a67:ee02:: with SMTP id f2mr26297733vsp.165.1582556615805;
        Mon, 24 Feb 2020 07:03:35 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id s123sm2816241vss.12.2020.02.24.07.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:03:34 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] bluetooth: Add flag to define wideband speech capability
Date:   Mon, 24 Feb 2020 15:03:29 +0000
Message-Id: <20200224150329.166662-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
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
2.25.0.265.gbab2e86ba0-goog

