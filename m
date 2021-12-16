Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5F6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Dec 2021 21:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbhLPVKE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhLPVKB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Dec 2021 16:10:01 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B697EC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Dec 2021 13:10:01 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id o4so391218pfp.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Dec 2021 13:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Rd5ms9VA7V8O9YMkrdKm7pKS0l7CkzSVHVXoVsLmX8=;
        b=N68084ZnDGLdjfBQfEKC0cxTFgyzHD7FBNFBcGj+7hlOlbOrk0Epx3fcJ+wnZlSgQz
         QoNFM/H2/Pdj4gcf23DDy3j3gbaUL7O+HAZ0q3TPv2kaCHuco4gc/AUdXSE7Ulguag/a
         zMIXsdBLMXUpmQmKfU4yYFyLEDdmcdqTbhUkX/viWAW0oXDlbw/WiRrlWs3e57rsEO5S
         atEfR5Fj1tXCtuKnlQkw75AGP4oSeOEoaHuUEPy31QySq2qu3tWFWanxz5mCesrGDqTx
         DAFSCzS5sOo1qBR9XcmaLWM4FYc+XXPPKl3YST6p281qPo0oZL6swz6fInDBIgoT+RUF
         tUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Rd5ms9VA7V8O9YMkrdKm7pKS0l7CkzSVHVXoVsLmX8=;
        b=tPhkMTOt83ascb2JlF9AHbpciLL2GNXM7hdKflFQLd7hSBe5unwBX7D1gOgSO2z3Mi
         cGieyzG77Uv16Fwyw3n+he+o5KQkMTtDJREa2rXuiJRLTO3/kPPsQnaDWq/G9HrfQvWO
         VJGuFcRCu+VUKiDlFpDMzx7fzebUs72fYiEDLuWlJoQMbP3FOxC/C/oD3d21exqCKZp4
         wer4L79MplcknOJ5VEyTh5X6T361wehHhAhFppH3kpKYYYtfLj/3ovmEg6mdAv/66GQq
         GMK2uXHn4eIHMANneih00AG5WZt7PWgYUnz9lfHBc/KJ2fVGu5e8JM9PzsDEtoIEiDM7
         QxHg==
X-Gm-Message-State: AOAM530NQgZ7lOBIEcs5wG5KyS0zioBjmrcY2yu5RzU+hJDwUyVS44H0
        PyhRgKEARo9HkspSRKtFVKn4bwU43js=
X-Google-Smtp-Source: ABdhPJxHvKnqhxtqbffWz/n8DqkTvtATMkxe6oeSKn4iFFxe0u6ZVEA06iYZ9tL5SyKSLNSrRKxH4A==
X-Received: by 2002:a63:784:: with SMTP id 126mr13995870pgh.530.1639689000952;
        Thu, 16 Dec 2021 13:10:00 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6d63:f74:75a0:361e])
        by smtp.gmail.com with ESMTPSA id a23sm6161239pgh.35.2021.12.16.13.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:10:00 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for legacy ROM devices
Date:   Thu, 16 Dec 2021 13:09:58 -0800
Message-Id: <20211216210958.62129-1-hj.tedd.an@gmail.com>
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
devices in an asserted state.

Once the device is in SW RFKILL state, it can only accept HCI_Reset to
exit from the SW RFKILL state. This patch checks the quirk and sends the
HCI_Reset before sending the HCI_Intel_Read_Version command.

The affected legacy ROM devices are
 - 8087:0a2a
 - 8087:0aa7

fixes: ffcba827c0a1d ("Bluetooth: btintel: Fix the LED is not turning off immediately")

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 13 ++++++-------
 drivers/bluetooth/btusb.c   | 10 ++++++++--
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e1f96df847b8..75f8d7aceb35 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2355,8 +2355,13 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	 * As a workaround, send HCI Reset command first which will reset the
 	 * number of completed commands and allow normal command processing
 	 * from now on.
+	 *
+	 * For INTEL_BROKEN_LED, these devices have an issue with LED which
+	 * doesn't go off immediately during shutdown. Set the flag here to send
+	 * the LED OFF command during shutdown.
 	 */
-	if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD)) {
+	if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD) ||
+				btintel_test_flag(hdev, INTEL_BROKEN_LED)) {
 		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
 				     HCI_INIT_TIMEOUT);
 		if (IS_ERR(skb)) {
@@ -2428,12 +2433,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
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
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d1bd9ee0a6ab..c6a070d5284f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_WIDEBAND_SPEECH	0x400000
 #define BTUSB_VALID_LE_STATES   0x800000
 #define BTUSB_QCA_WCN6855	0x1000000
+#define BTUSB_INTEL_BROKEN_LED	0x2000000
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
 
 static const struct usb_device_id btusb_table[] = {
@@ -382,9 +383,11 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_INTEL_BROKEN_INITIAL_NCMD },
-	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_BROKEN_LED },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
-	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_BROKEN_LED },
 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
 
 	/* Other Intel Bluetooth devices */
@@ -3724,6 +3727,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
 			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
+
+		if (id->driver_info & BTUSB_INTEL_BROKEN_LED)
+			btintel_set_flag(hdev, INTEL_BROKEN_LED);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.25.1

