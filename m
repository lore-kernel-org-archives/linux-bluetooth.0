Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Alexander Aring <aar@pengutronix.de>
To: linux-bluetooth@vger.kernel.org
Cc: revestflo@gmail.com, Alexander Aring <aar@pengutronix.de>,
        Szymon Janc <szymon.janc@codecoup.pl>
Subject: [BlueZ] tests: example-gatt-server: change GATT_CHRC_IFACE
Date: Wed, 21 Sep 2016 21:32:25 +0200
Message-Id: <20160921193225.23199-1-aar@pengutronix.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes GATT_CHRC_IFACE to GATT_DESC_IFACE. The example
do not test this case and this is the reason why nobody detected it yet.

Cc: Szymon Janc <szymon.janc@codecoup.pl>
Suggested-by: Florent Revest <revestflo@gmail.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
Florent Revest reported this via irc and I put my "send-patches" hat on
to send this fix to mainline.

Review carefully, not tested in any case.

 test/example-gatt-server | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/example-gatt-server b/test/example-gatt-server
index 44ceb70..bac1687 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -234,7 +234,7 @@ class Descriptor(dbus.service.Object):
         if interface != GATT_DESC_IFACE:
             raise InvalidArgsException()
 
-        return self.get_properties()[GATT_CHRC_IFACE]
+        return self.get_properties()[GATT_DESC_IFACE]
 
     @dbus.service.method(GATT_DESC_IFACE,
                         in_signature='a{sv}',
-- 
2.9.3

