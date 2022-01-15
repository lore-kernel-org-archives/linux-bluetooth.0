Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Jan 2022 21:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiAOVfX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Jan 2022 16:35:23 -0500
Received: from newmail.c0rporation.com ([82.165.56.171]:44548 "EHLO
        newmail.c0rporation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiAOVfV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Jan 2022 16:35:21 -0500
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Jan 2022 16:35:21 EST
Received: from authenticated-user (newmail.c0rporation.com [82.165.56.171])
        by newmail.c0rporation.com (Postfix) with ESMTPA id 7872840214
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Jan 2022 21:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0rporation.com;
        s=dkim; t=1642282206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DSa0uDlAGtGTha0teEMPQkJKcfkzBOaNIjwVV4Cw7pI=;
        b=A7e2/rmNI/4FD/nmUR2djKsf01RXUEt1ElGSRCWBU+dYZmvQpF3TyqhdMBh2ZyRQQRqoVq
        eOg5xrE7Epd+44cvaHybKhFRrNso38gWHrmHVPSTuH2+fM+kSbxdSmLiDtxjXc2pMUAtAT
        aIRdTNpW8ipEbqhMs0cp9e+AlinLJaehpujx6teuevQfJeV3W6/H2TFlQ2QHscdMk6Oj6O
        wQ1pQim/QhB/5EiLQRf/CbSage6DgvHy3z3s4bW0RIQqC6duaZ5Ry8+6Uf/ha7j9dy2iCs
        jfsElwE9CngXrrnwo09SksrfDnVS6ZAM9jCdnaoYm/mNHpekKLRsFv3HeKv3cw==
Message-ID: <a96af59d-089f-1018-74fc-355e96fcf0c3@c0rporation.com>
Date:   Sat, 15 Jan 2022 21:30:05 +0000
MIME-Version: 1.0
Content-Language: en-GB
To:     linux-bluetooth@vger.kernel.org
From:   Jack Murray <kernel@c0rporation.com>
Subject: [PATCH] bluetooth: Add support for EP-B3536 USB Bluetooth adapter
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: newmail.c0rporation.com;
        auth=pass smtp.auth=jack@c0rporation.com smtp.mailfrom=kernel@c0rporation.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jack Murray <kernel@c0rporation.com>

This patch adds support for the EP-B3536 USB bluetooth 5.1 adapter based
on the 8761B chipset. The existing driver and firmware work fine for this
device from what I can tell, so this patch just adds the vendor/product IDs
for it to the supported device list.

Signed-off-by: Jack Murray <kernel@c0rporation.com>
---
  drivers/bluetooth/btusb.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 60d2fce59a71..207c8289c5c2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -436,6 +436,8 @@ static const struct usb_device_id blacklist_table[] = {
         /* Additional Realtek 8761BU Bluetooth devices */
         { USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
BTUSB_WIDEBAND_SPEECH },
+       { USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
+ BTUSB_WIDEBAND_SPEECH },

         /* Additional Realtek 8821AE Bluetooth devices */
         { USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },


