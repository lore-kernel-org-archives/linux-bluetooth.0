Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0907EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 18:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGKShD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 14:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKShD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 14:37:03 -0400
X-Greylist: delayed 2285 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 11:36:59 PDT
Received: from nicole.computer-surgery.co.uk (mail.computer-surgery.co.uk [82.69.253.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BCB1704
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 11:36:59 -0700 (PDT)
Received: from [10.94.89.22] (helo=buckle.internal.gammascience.co.uk)
        by nicole.computer-surgery.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rgammans@gammascience.co.uk>)
        id 1qJHdT-0001pq-LP; Tue, 11 Jul 2023 18:58:51 +0100
From:   Roger Gammans <rgammans@gammascience.co.uk>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Roger Gammans <rgammans@gammascience.co.uk>
Subject: [PATCH] Bluetooth: btusb: Add support for another MediaTek 7922 VID/PID
Date:   Tue, 11 Jul 2023 18:57:44 +0100
Message-Id: <20230711175743.20606-1-rgammans@gammascience.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This one is found on the Dell Inspiron 2-in-1 7435

Signed-off-by: Roger Gammans <rgammans@gammascience.co.uk>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2a8e2bb038f5..bda50d84c886 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -622,6 +622,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0e4), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f1), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x0489, 0xe0f2), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
-- 
2.39.2

