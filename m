Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5936C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 00:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbiAGAe7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 19:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343832AbiAGAe6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 19:34:58 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61CC061245
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 16:34:58 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t123so3803209pfc.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jan 2022 16:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tdfykp9sW6gzIbq3VaIgiL30a9odb3Ggwj6DXQanYsM=;
        b=UM22p1Qfd6LcHUwrwyP5xR0/oq4TyXZBFxo5g0zFyD8Sh0k3Yz2+72z2Opf+yfw439
         zLs55N246cK62lcOeEf3teXKStX08THPOpb8+6n7RdGKWUlEZE6YA4zoMiG4lt7//MXu
         dGs/JFxRv4zdf3tO/lKzRP6QQMfhCH6geytoPnLQ2J3jEtIG/N10SgevdpRcqxgnNSSy
         rKKPifHldqPERGKCUdVzW8m0aAZ7O8mcOHTUHnd42lgxPk15Hg8dM5ypwA/z2LkKeXHD
         Jb2gem5FRmM1qTA6XtzMMAdlJSZQz+zoxnQmZAbMn68zc65s1dsYRd9tlZtfNnG/EkyA
         EG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tdfykp9sW6gzIbq3VaIgiL30a9odb3Ggwj6DXQanYsM=;
        b=GfkJHgRnfzCdMZLSyKYQ4BCmcz6RMPyPM7VhLiLiDsVnvAcRXcIAoFiz47ZSUeb6uA
         GnfOAOU9iN4gkRqS46hjE0//8iaElWeNul2bRgJTfUXgzv2uLhCMzNwXMM8wZfSyF75f
         ujWhGjykDLEEwX9J9Dbs6rQow4ZUR7V2Sge2xoR57yWyhgTlpm8CUegn/pRf1UXVz2iW
         4nEwLIVZfOwyMfp7c5tFMJ17ZfYr6nZGOFhoDVRv5b/u63JDSFgrnAxKQX2+SAa7amFL
         W0Fi/eYtXmLq+mzihLJKB7ORxXNfvOuLjBMWV7mgbXI0pMmDVmqRIRO0PkvbzVba+zn+
         SKlQ==
X-Gm-Message-State: AOAM530tIPwJ3RzTL1W7cgYO5GtJD5MDsGjDt3SGpXGqTHJ6I5eLE1hI
        PaOmSm1wH9EhSzPfnFRn05UKdenPeGc=
X-Google-Smtp-Source: ABdhPJy3FtbJA/afYz/wl+T3HVktCnALiRKLsHVgdyD28HicUfZZriN18rw8ZYPcl818b//6mOrlOA==
X-Received: by 2002:a05:6a00:847:b0:4ba:f004:e380 with SMTP id q7-20020a056a00084700b004baf004e380mr61966262pfk.42.1641515697968;
        Thu, 06 Jan 2022 16:34:57 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:9ac3:f7f6:8676:cdad])
        by smtp.gmail.com with ESMTPSA id y6sm3840622pfi.154.2022.01.06.16.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:34:57 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] Bluetooth: btintel: Fix broken LED quirk for legacy ROM devices
Date:   Thu,  6 Jan 2022 16:34:54 -0800
Message-Id: <20220107003454.315475-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the broken LED quirk for Intel legacy ROM devices.
To fix the LED issue that doesn't turn off immediately, the host sends
the SW RFKILL command while shutting down the interface and it puts the
devices in SW RFKILL state.

Once the device is in SW RFKILL state, it can only accept HCI_Reset to
exit from the SW RFKILL state. This patch checks the quirk for broken
LED and sends the HCI_Reset before sending the HCI_Intel_Read_Version
command.

The affected legacy ROM devices are
 - 8087:07dc
 - 8087:0a2a
 - 8087:0aa7

fixes: ffcba827c0a1d ("Bluetooth: btintel: Fix the LED is not turning off immediately")

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 20 +++++++++++---------
 drivers/bluetooth/btintel.h |  2 +-
 drivers/bluetooth/btusb.c   | 13 ++++++++++---
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e1f96df847b8..1a4f8b227eac 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2355,8 +2355,15 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	 * As a workaround, send HCI Reset command first which will reset the
 	 * number of completed commands and allow normal command processing
 	 * from now on.
+	 *
+	 * Regarding the INTEL_BROKEN_SHUTDOWN_LED flag, these devices maybe
+	 * in the SW_RFKILL ON state as a workaround of fixing LED issue during
+	 * the shutdown() procedure, and once the device is in SW_RFKILL ON
+	 * state, the only way to exit out of it is sending the HCI_Reset
+	 * command.
 	 */
-	if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD)) {
+	if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD) ||
+	    btintel_test_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED)) {
 		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
 				     HCI_INIT_TIMEOUT);
 		if (IS_ERR(skb)) {
@@ -2428,12 +2435,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 					&hdev->quirks);
 
-			/* These devices have an issue with LED which doesn't
-			 * go off immediately during shutdown. Set the flag
-			 * here to send the LED OFF command during shutdown.
-			 */
-			btintel_set_flag(hdev, INTEL_BROKEN_LED);
-
 			err = btintel_legacy_rom_setup(hdev, &ver);
 			break;
 		case 0x0b:      /* SfP */
@@ -2586,9 +2587,10 @@ static int btintel_shutdown_combined(struct hci_dev *hdev)
 
 	/* Some platforms have an issue with BT LED when the interface is
 	 * down or BT radio is turned off, which takes 5 seconds to BT LED
-	 * goes off. This command turns off the BT LED immediately.
+	 * goes off. As a workaround, sends HCI_Intel_SW_RFKILL to put the
+	 * device in the RFKILL ON state which turns off the BT LED immediately.
 	 */
-	if (btintel_test_flag(hdev, INTEL_BROKEN_LED)) {
+	if (btintel_test_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED)) {
 		skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
 		if (IS_ERR(skb)) {
 			ret = PTR_ERR(skb);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e500c0d7a729..c9b24e9299e2 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -150,7 +150,7 @@ enum {
 	INTEL_FIRMWARE_FAILED,
 	INTEL_BOOTING,
 	INTEL_BROKEN_INITIAL_NCMD,
-	INTEL_BROKEN_LED,
+	INTEL_BROKEN_SHUTDOWN_LED,
 	INTEL_ROM_LEGACY,
 
 	__INTEL_NUM_FLAGS,
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 74ec7ca96b69..d0619a07b069 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_WIDEBAND_SPEECH	0x400000
 #define BTUSB_VALID_LE_STATES   0x800000
 #define BTUSB_QCA_WCN6855	0x1000000
+#define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	0x2000000
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
 
 static const struct usb_device_id btusb_table[] = {
@@ -381,10 +382,13 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_INTEL_BROKEN_INITIAL_NCMD },
-	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
+						     BTUSB_INTEL_BROKEN_INITIAL_NCMD |
+						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
+	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
-	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
 
 	/* Other Intel Bluetooth devices */
@@ -3732,6 +3736,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
 			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
+
+		if (id->driver_info & BTUSB_INTEL_BROKEN_SHUTDOWN_LED)
+			btintel_set_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.25.1

