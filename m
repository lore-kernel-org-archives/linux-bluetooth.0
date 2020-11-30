Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E70AC63777
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 05:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491D6207F7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 05:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgK3F2v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 00:28:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58656 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3F2v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 00:28:51 -0500
Received: from [223.72.62.229] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1kjbjM-0002V7-1w; Mon, 30 Nov 2020 05:28:09 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: [PATCH] Bluetooth: btusb: Add a parameter to load fw forcibly for Intel BT
Date:   Mon, 30 Nov 2020 13:27:53 +0800
Message-Id: <20201130052753.111742-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On the machines with Intel new BT module, if users run reboot, the BT
driver will not load the firmware from rootfs during boot since it is
already in operational mode. This will confuse the users if users
update the BT firmware and expect the updated firmware to fix some
problems.

Let the driver print a message to tell users the firmware is not
loaded and add a module parameter to let driver forcibly load the
firmware from rootfs. After users read this message, they could set
this parameter to load the firmware forcibly.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/bluetooth/btusb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1005b6e8ff74..d4fceedd354b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -32,6 +32,7 @@ static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
 
 static bool reset = true;
+static bool force_load_fw;
 
 static struct usb_driver btusb_driver;
 
@@ -2589,8 +2590,15 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		return err;
 
 	/* controller is already having an operational firmware */
-	if (ver.fw_variant == 0x23)
+	if (ver.fw_variant == 0x23) {
+		if (force_load_fw) {
+			btintel_reset_to_bootloader(hdev);
+			force_load_fw = false;
+			return -EAGAIN;
+		}
+		bt_dev_info(hdev, "already in operational mode, not load fw. Set force_load_fw=1 to load fw forcibly");
 		goto finish;
+	}
 
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
@@ -4451,6 +4459,9 @@ MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
+module_param(force_load_fw, bool, 0644);
+MODULE_PARM_DESC(force_load_fw, "Let Intel BT module load the fw unconditionally during boot");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Generic Bluetooth USB driver ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
2.25.1

