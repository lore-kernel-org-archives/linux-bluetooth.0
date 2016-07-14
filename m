Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test/example-gatt-server: Fix error on Property.GetAll
Date: Thu, 14 Jul 2016 15:45:45 +0300
Message-Id: <1468500345-5833-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

get_properties is a method not a dictionary which cause the following
error:
  TypeError: 'method' object is not subscriptable
---
 test/example-gatt-server | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/example-gatt-server b/test/example-gatt-server
index 71aeb1b..84905f3 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -117,7 +117,7 @@ class Service(dbus.service.Object):
         if interface != GATT_SERVICE_IFACE:
             raise InvalidArgsException()
 
-        return self.get_properties[GATT_SERVICE_IFACE]
+        return self.get_properties()[GATT_SERVICE_IFACE]
 
 
 class Characteristic(dbus.service.Object):
@@ -164,7 +164,7 @@ class Characteristic(dbus.service.Object):
         if interface != GATT_CHRC_IFACE:
             raise InvalidArgsException()
 
-        return self.get_properties[GATT_CHRC_IFACE]
+        return self.get_properties()[GATT_CHRC_IFACE]
 
     @dbus.service.method(GATT_CHRC_IFACE,
                         in_signature='a{sv}',
@@ -222,7 +222,7 @@ class Descriptor(dbus.service.Object):
         if interface != GATT_DESC_IFACE:
             raise InvalidArgsException()
 
-        return self.get_properties[GATT_CHRC_IFACE]
+        return self.get_properties()[GATT_CHRC_IFACE]
 
     @dbus.service.method(GATT_DESC_IFACE,
                         in_signature='a{sv}',
-- 
2.7.4

