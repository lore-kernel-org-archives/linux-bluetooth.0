Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CD7C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 09:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiFBJ2i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 05:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiFBJ2h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 05:28:37 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660213F71
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 02:28:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [222.129.35.96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 06F1B3FC16;
        Thu,  2 Jun 2022 09:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654162114;
        bh=v50vX/qMJwlgnnJNbxs2FONfuRb0sn2pPyZzAtsnvKI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=cgx+2Mx48GJ5uR8bYtB0qzowE2H9ILmq4GEiEy+kqXrUW5xj0JnoZ+2CMAsFv1z2j
         guNRxp6/qrE6BE+IzCtl4Ou7XoiIJkxvtGNbVS2wY+L06q5K6uZeKuZYpcjbNYCrMg
         r/73meoM3JdB2pMrb8rzD9+Ka4wfkUiYze8W9oqnoT0QKMoRgMk0qVICLQN7MlvPEZ
         Jgxv1wMEZ3ClpYLQwvweq2qGrzWzvrt3oqSjgPKXLXH6rQyHFj3qHrcQSoC6pDJxHC
         vPUL+84NmkNQ2FkPQfSk6Rv915/0uhbzmjm+5r9c79t4CFTUf7i6nYLvbR9Gj6KPsQ
         30zGhwjdQYz3w==
From:   Aaron Ma <aaron.ma@canonical.com>
To:     linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        luiz.dentz@gmail.com, johan.hedberg@gmail.com, marcel@holtmann.org
Subject: [PATCH] Bluetooth: btusb: Add support of IMC Networks PID 0x3568
Date:   Thu,  2 Jun 2022 17:28:22 +0800
Message-Id: <20220602092822.953521-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is 13d3:3568 for MediaTek MT7922 USB Bluetooth chip.

T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3568 Rev=01.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=...
C:  #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e25fcd49db70..fb1a67189412 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -477,6 +477,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d9), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.36.1

