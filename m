Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9370CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Nov 2021 22:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356373AbhK0Wxe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Nov 2021 17:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356506AbhK0Wvb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Nov 2021 17:51:31 -0500
X-Greylist: delayed 1040 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 Nov 2021 14:45:31 PST
Received: from javispedro.com (javispedro.com [IPv6:2001:41d0:401:3000::34c4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA94AC061756
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Nov 2021 14:45:31 -0800 (PST)
Received: from [2a01:cb15:81cc:2b00:7f27:aac9:234f:ecff] (helo=localhost.localdomain)
        by javispedro.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <dev.git@javispedro.com>)
        id 1mr6At-0007w5-C5; Sat, 27 Nov 2021 23:28:03 +0100
From:   "Javier S. Pedro" <dev.git@javispedro.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Javier de San Pedro" <dev.git@javispedro.com>,
        "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>
Subject: [PATCH] gatt-client: when disconnected return default MTU for GattCharacteristic1.MTU
Date:   Sat, 27 Nov 2021 23:21:36 +0100
Message-Id: <20211127222132.14351-1-dev.git@javispedro.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Javier de San Pedro" <dev.git@javispedro.com>

After the MTU dbus property patches in 5.62 we are seeing bluetoothd
terminate frequently with "Disconnected from D-Bus. Exiting." msgs.
Apparently this is because bluetoothd sent an invalid reply to a D-Bus
Property Get (for GattCharacteristic1's MTU).
Multiple issues in bluez Github.com project reported similar behavior;
at least #235 (see Fixes:), #219, and likely #238.

When the Characteristic1 object is still cached/alive, but the
underlying att connection is not (e.g. someone just called Disconnect),
the property getter (characteristic_get_mtu) right now returns false.
However, gdbus seems to ignore the return value and sends the empty reply
message anyway (rather than a dbus error?), and this seems to cause
the dbus connection to be terminated (due to the ill-formed reply?).
bluetoothd then aborts.

This patch makes the property value BT_ATT_DEFAULT_LE_MTU if the
underlying att object does not exist, rather than returning an invalid
message. This is consistent with the existing PropertyChanged signal
behavior (we will emit a PropertyChange only if a larger MTU is
exchanged), and fixes the issue on my machines.
An alternative could be to change gdbus behavior, but I'm not sure if we
are allowed to return an error here anyway without causing problems in
other dbus libraries/wrappers.

Signed-off-by: Javier de San Pedro <dev.git@javispedro.com>
Fixes: aaa0c4996ae9 ("gatt: Add implementation of GattCharacteristic1.MTU")
Fixes: https://github.com/bluez/bluez/issues/235
---
 src/gatt-client.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index de18bea9708e..6ee984db9410 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -883,10 +883,7 @@ static gboolean characteristic_get_mtu(const GDBusPropertyTable *property,
 	uint16_t mtu;
 
 	att = bt_gatt_client_get_att(gatt);
-	if (!att)
-		return FALSE;
-
-	mtu = bt_att_get_mtu(att);
+	mtu = att ? bt_att_get_mtu(att) : BT_ATT_DEFAULT_LE_MTU;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &mtu);
 
-- 
2.34.0

