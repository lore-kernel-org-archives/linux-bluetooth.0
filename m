Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE139C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 07:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbiATHuK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jan 2022 02:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbiATHuJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jan 2022 02:50:09 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D364FC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jan 2022 23:50:08 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g2so4898395pgo.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jan 2022 23:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uk34SFw34uv6BwDh7SCGcO7224Uv8FXC5wEljDO+yGo=;
        b=dYG2mGy0DlawMT68uORHMO0Fcbj75EuwejsumbAsgZSsHhpsoyJiHpnYrlgYSxdoI4
         n/HWzAJnED0lHiMJLt1Q6CgS3DUbPZ2mA2q7RSkgicMGIYyO+HV34cBHP1jcghE9vG8K
         1jVgM+Qqwom1aBTtfb1v2tivAZiJCrJSp79y2okN65lfbemiaA8PkZ5vcogJOBgkagqu
         GTNCHwV+vJEoOrqC03RVZFoQF9WwLkcCWEiX4H3+4YkPAcfwWRC1B6Q+ajLtYcNnF2fN
         vVQK9bDG+fxgIvRjfppYshCwVbLSul1/uuX7EqLoh26sTEAx88N54XUjm+bBMabnGrA3
         DP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uk34SFw34uv6BwDh7SCGcO7224Uv8FXC5wEljDO+yGo=;
        b=SlRzARmEd5quY0QYQH6aFwNqver+ZeHZfYc4KgEd2B5gnL5Be3YNsZrVgZYCdbnIVx
         PDbl13skxQtwDNn4ca4Bz9EdKOSlZdSGIuaL6Rmjbi9gy6DmyLCOG4X4LgC2uEd/hRH8
         UBiVN3Q8P8ot3pGicTFYV1Hhiqt9lgvHEjGN6DWb4Rpxy6wLI1Ny48N9LLKH/EWuTHld
         OxjFbdnBnTrcDWAy/zrjNjvSOOmLNfgvZ7z8M2xGH+xLy7DZjJGAt7TjPSolzkAZDpe2
         +7K8p4ZiANnk9Get9AbSgbQBUB0zKnwPyLVG0kLX451lOdU9p8hzvC02TzHOH+sRWL/t
         kS9w==
X-Gm-Message-State: AOAM530oVjqPa+A+PUiskOwu9+cog+E2nJ17xjah3fctb5j/fl9qRQUk
        inkUJ0uCKeRdbExYzXPTvmRxroDMtFk=
X-Google-Smtp-Source: ABdhPJw9DMGbQaTkDlTqHIeKSgLpvFRidG1eCtP7vMpkKrzvaymRNWr7kpPAlJDYU7vyZ8J4/qp2KQ==
X-Received: by 2002:a63:9d8a:: with SMTP id i132mr30050088pgd.329.1642665007633;
        Wed, 19 Jan 2022 23:50:07 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6e28:6472:c5bd:5307])
        by smtp.gmail.com with ESMTPSA id g4sm2119049pfv.8.2022.01.19.23.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 23:50:07 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] Bluetooth: btintel: Fix WBS setting for Intel legacy ROM products
Date:   Wed, 19 Jan 2022 23:50:04 -0800
Message-Id: <20220120075004.293700-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds the flag to identify the Intel legacy ROM products that
don't support WBS like WP and StP.

Fixes: 3df4dfbec0f29 ("Bluetooth: btintel: Move hci quirks to setup routine")
Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 10 +++++++---
 drivers/bluetooth/btintel.h |  1 +
 drivers/bluetooth/btusb.c   |  6 ++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 1a4f8b227eac..225ed0373e9d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2428,10 +2428,14 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 
 			/* Apply the device specific HCI quirks
 			 *
-			 * WBS for SdP - SdP and Stp have a same hw_varaint but
-			 * different fw_variant
+			 * WBS for SdP - For the Legacy ROM products, only SdP
+			 * supports the WBS. But the version information is not
+			 * enough to use here because the StP2 and SdP have same
+			 * hw_variant and fw_variant. So, this flag is set by
+			 * the transport driver(btusb) based on the HW info
+			 * (idProduct)
 			 */
-			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
+			if (!btintel_test_flag(hdev, INTEL_NO_WBS_SUPPORT))
 				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 					&hdev->quirks);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index c9b24e9299e2..084a5e8dce39 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -152,6 +152,7 @@ enum {
 	INTEL_BROKEN_INITIAL_NCMD,
 	INTEL_BROKEN_SHUTDOWN_LED,
 	INTEL_ROM_LEGACY,
+	INTEL_NO_WBS_SUPPORT,
 
 	__INTEL_NUM_FLAGS,
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c30d131da784..566501e64c5a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -62,6 +62,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_QCA_WCN6855	0x1000000
 #define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	0x2000000
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
+#define BTUSB_INTEL_NO_WBS_SUPPORT	0x8000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -385,9 +386,11 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_NO_WBS_SUPPORT |
 						     BTUSB_INTEL_BROKEN_INITIAL_NCMD |
 						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_NO_WBS_SUPPORT |
 						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
@@ -3737,6 +3740,9 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->send = btusb_send_frame_intel;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
 
+		if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
+			btintel_set_flag(hdev, INTEL_NO_WBS_SUPPORT);
+
 		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
 			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
 
-- 
2.25.1

