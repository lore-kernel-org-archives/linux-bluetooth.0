Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] test/example-gatt-client: Add more comments
Date: Tue,  2 Aug 2016 14:33:56 +0300
Message-Id: <1470137637-6189-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1470137637-6189-1-git-send-email-luiz.dentz@gmail.com>
References: <1470137637-6189-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds more comments what the example is doing.
---
 test/example-gatt-client | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/example-gatt-client b/test/example-gatt-client
index 4d1df2f..b4bbaa9 100755
--- a/test/example-gatt-client
+++ b/test/example-gatt-client
@@ -193,14 +193,17 @@ def main():
     om = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, '/'), DBUS_OM_IFACE)
     om.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)
 
+    print('Getting objects...')
     objects = om.GetManagedObjects()
     chrcs = []
 
+    # List characteristics found
     for path, interfaces in objects.items():
         if GATT_CHRC_IFACE not in interfaces.keys():
             continue
         chrcs.append(path)
 
+    # List sevices found
     for path, interfaces in objects.items():
         if GATT_SERVICE_IFACE not in interfaces.keys():
             continue
-- 
2.7.4

