Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC381C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 12:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiDMMyC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiDMMyB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 08:54:01 -0400
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 768EC4E394;
        Wed, 13 Apr 2022 05:51:40 -0700 (PDT)
Received: from localhost (255.red-83-50-200.dynamicip.rima-tde.net [83.50.200.255])
        by iodev.co.uk (Postfix) with ESMTPSA id 7FD0A9DDE8;
        Wed, 13 Apr 2022 14:51:39 +0200 (CEST)
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     Ismael Luceno <ismael@iodev.co.uk>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add 0x0bda:0x8771 Realtek 8761BUV devices
Date:   Wed, 13 Apr 2022 14:54:15 +0200
Message-Id: <20220413125415.20293-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Identifies as just "Realtek Semiconductor Corp."; it's used in many
adapters, e.g.:

- UGREEN CM390
- C-TECH BTD-01
- Orico BTA-508

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2afbd87d77c9..07db720baaa0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -490,6 +490,10 @@ MODULE_DEVICE_TABLE(usb, btusb_table);
 	{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Additional Realtek 8761BUV Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0x8771), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },
-- 
2.35.1

