Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72875C43214
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1E961103
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhHDElH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbhHDElE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:41:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483EC0617B1
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e21so1676907pla.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jgkyvn/e35xIjJq7x5D09L647KQxJqhhDFthQQfv0s8=;
        b=E0znywbV1Tq6ubvXaOaKkTfydVv9QsoiDGuD71SrDZl6iNT4b33TbNZQPwDbvXeJZp
         2h5BlU8pYr5mbAM4BJa0Shf/7mIZTBUvJT+Zp/Xqj1/sHkGT121zhD17lxWmeyDYhYdq
         b01eb3hGKnk/HYsvTUc5MiJFOig+kfmqo0TNR0rRYnLsEu0sfnATWE44QIsR87IGZdxN
         V5rMQx9cz64fgbw4tF8QYNjC6gb3Eq4a6adxrn/dksNAxzZPZ+PZE8V9UYMrDa3pGm+J
         eEiRyVKlxrd8icFfXMMRs/q+obfvURGZYWzcnmhjBfxI7iTDwfJiR4jodcGSuOWaPdyV
         aoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jgkyvn/e35xIjJq7x5D09L647KQxJqhhDFthQQfv0s8=;
        b=jos9RzSOqJJyV+GDVvJcyCq8+1fEnL6dYlCYMZiZyJSdu473ma+Sl3oV5ir4orvbQI
         sVcILrDGRc1gtG2NfWeshrVikpQ/BmQzYmij90VBSGHO14kC6v28j4/k5IP0L7vKMW6r
         7f19bTzv0jP2MeGyPHanRfpLN/X55GfwIFnjWB4WMTnfbKos3RIXQ63bkjRFi8magNx2
         o0TxqI9nZjSHPHUqZVLc9c2pWeANCh4i5LZhTpghqIsEUpXrlkSBrW0GlIPd5nEXnTL6
         bRwei5FjST5venu5FKKcPggqS8OvkOxjXvEzVCz09Kp+4TFcH3kMeyW3MVC9SP9x4QP3
         Br1g==
X-Gm-Message-State: AOAM5330eKYGYllKiFkDMVMFF6iB1H5Q31uRpeWYZ/9527MR8RP5BIVl
        W591xpenNb9XSlM3gVL3tFC+lSVweQo=
X-Google-Smtp-Source: ABdhPJzp/RaZUyv34VxK9wOVJ3IT9G6YbDG9jBFmqZlc59HRT4ntxv/XKRRNXd0k3Deq2tCOV1LVOA==
X-Received: by 2002:a63:f501:: with SMTP id w1mr230802pgh.57.1628052050224;
        Tue, 03 Aug 2021 21:40:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:49 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 09/12] Bluetooth: btintel: Move hci quirks to setup routine
Date:   Tue,  3 Aug 2021 21:40:29 -0700
Message-Id: <20210804044032.59729-10-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch moves the hci quirks for Intel devices into the setup
routines and cleaned up the driver flags.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btusb.c   | 31 ++++++++-----------------------
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5acf3c8e703b..41eabdf6a30f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2222,6 +2222,11 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		return -EIO;
 	}
 
+	/* Apply the common HCI quirks for Intel device */
+	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+	set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+
 	/* For Legacy device, check the HW platform value and size */
 	if (skb->len == sizeof(ver) && skb->data[1] == 0x37) {
 		bt_dev_dbg(hdev, "Read the legacy Intel version information");
@@ -2244,6 +2249,15 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			/* Legacy ROM product */
 			btintel_set_flag(hdev, INTEL_ROM_LEGACY);
 
+			/* Apply the device specific HCI quirks
+			 *
+			 * WBS for SdP - SdP and Stp have a same hw_varaint but
+			 * different fw_variant
+			 */
+			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
+				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
+					&hdev->quirks);
+
 			/* These devices have an issue with LED which doesn't
 			 * go off immediately during shutdown. Set the flag
 			 * here to send the LED OFF command during shutdown.
@@ -2258,6 +2272,18 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x12:      /* ThP */
 		case 0x13:      /* HrP */
 		case 0x14:      /* CcP */
+			/* Apply the device specific HCI quirks
+			 *
+			 * All Legacy bootloader devices support WBS
+			 */
+			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
+				&hdev->quirks);
+
+			/* Valid LE States quirk for JfP/ThP familiy */
+			if (ver.hw_variant == 0x11 || ver.hw_variant == 0x12)
+				set_bit(HCI_QUIRK_VALID_LE_STATES,
+					&hdev->quirks);
+
 			err = btintel_bootloader_setup(hdev, &ver);
 			break;
 		default:
@@ -2296,6 +2322,16 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x17:
 	case 0x18:
 	case 0x19:
+		/* Apply the device specific HCI quirks for TLV based devices
+		 *
+		 * All TLV based devices support WBS
+		 */
+		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+
+		/* Valid LE States quirk for GfP */
+		if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
+			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
 		break;
 	default:
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e9434c04c566..9275b39c016d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -358,29 +358,18 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
 
 	/* Intel Bluetooth devices */
-	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
-	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH},
-	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_INTEL_BROKEN_INITIAL_NCMD },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
-	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
 
 	/* Other Intel Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
@@ -3667,10 +3656,6 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->send = btusb_send_frame_intel;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
 
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-
 		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
 			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
 	}
-- 
2.25.1

