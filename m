Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5B7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Dec 2021 03:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhLPDe5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Dec 2021 22:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhLPDe4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Dec 2021 22:34:56 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E46C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 19:34:56 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g19so22454139pfb.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 19:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GrOJ70tITiXAgUqLRhT9DPJQJybtwdzVPYgXh4rRxM8=;
        b=I8ZO8Uj2yLC2nICObFlJJNHCOfsGqG1/dnFcWdEmsYabw8hC7M7kZmbnbhbGry1VZY
         2rQY2dAwvIzCZMKUm4kjIeQcgJGbenyF6qOYkvwL39JVjCW58H/X0LsZaOabT7b1gCwG
         UTdfO6kU848KBRibfydk2c5pFq8z/ewZcVV0+8cM44le0I6eVfECEjWGp8vqazBJHKHB
         TWw6P1kLai7E8trZ1ATJMkFLOEWyKtP0B6WeK7TEuBQvrA3zhxI1IYtCepMuXjCSTBgw
         TCNL9VMgkKTSAMQ2ePmXgiunNxeNqE/WRz7F1/SHibnQCjeUKekgVi5a+UQIMLQuitiB
         r2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GrOJ70tITiXAgUqLRhT9DPJQJybtwdzVPYgXh4rRxM8=;
        b=shdSqh6tbymyorNnIwkYCQUA+ULrMjy6s/aZUrqGUvXfulr4tk/aq+5+M9+QPkgc9n
         wfsF85Z0jeb5mNg/f/MWZR/bZl2wgIYQwF1fDsHN/nrHU07SMoHafHycDb97mn8urnnp
         vIE9++G/zQN4JtMvrtybndy1s/ouUpjL1Erh8w5tTBjn0Cgi4GtzfIKjxi2gVx/USjFV
         FvfXumSwhrRT9kbN30fTPt8N9ab1tf6F1ntg3KAZaux0YDvTCosIqb56YcMf9iMhijCK
         WR/0jMjKgjB5avcYZpnHko8wrRWel+pTCyUsoOL3URPIKJ80DFZYfqLl9yAL2iQ2YQij
         nYXA==
X-Gm-Message-State: AOAM5334UmpLGkaPMK0zfUc7o7rh3/QzCHYetjSdhdfWfR3eWotQ+pw/
        zYLghJGEBjtHKHwSafouA1amHvrncok=
X-Google-Smtp-Source: ABdhPJyWJGKVNmWitOtvlqvFuS6LFxWLhEI6LhJKRsvSwpoEMOxzIDpNB0cPmNlaLUbV9PRekdtJvg==
X-Received: by 2002:a05:6a00:2349:b0:4a8:d87:e8ad with SMTP id j9-20020a056a00234900b004a80d87e8admr11893720pfj.15.1639625696064;
        Wed, 15 Dec 2021 19:34:56 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6d63:f74:75a0:361e])
        by smtp.gmail.com with ESMTPSA id cx5sm3426592pjb.22.2021.12.15.19.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 19:34:55 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH] Bluetooth: btintel: Fix broken LED quirk for legacy ROM device
Date:   Wed, 15 Dec 2021 19:34:53 -0800
Message-Id: <20211216033453.9806-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fix the broken LED quirk for Intel legacy ROM devices.
Legacy device sends the SW RFKILL while shutting down the device (like
HCI interface down) to turn off the LED by putting the device in assert.

Once the SW RFKILL is on, it needs the HCI_Reset to exit from the SW
RFKILL state. This patch checks the quirk and send the HCI_Reset before
sending the HCI_Intel_Read_Version command.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 13 ++++++-------
 drivers/bluetooth/btusb.c   | 10 ++++++++--
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 8f9109b40961..0a5aa637bf6f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2355,8 +2355,13 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	 * As a workaround, send HCI Reset command first which will reset the
 	 * number of completed commands and allow normal command processing
 	 * from now on.
+	 *
+	 * For INTEL_BROKEN_LED, these devices have an issue with LED which
+	 * doesn't go off immediately during shutdown. Set the flag
+	 * here to send the LED OFF command during shutdown.
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

