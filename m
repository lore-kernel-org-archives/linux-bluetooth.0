Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/13] dbusoob: Append version to OutOfBand interface
Date: Fri, 14 Dec 2012 11:13:03 +0200
Message-Id: <1355476387-2165-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/oob-api.txt   |  2 +-
 plugins/dbusoob.c |  2 +-
 test/test-oob     | 11 +++++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index d54f612..a196442 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -11,7 +11,7 @@ Out Of Band hierarchy
 =====================
 
 Service		org.bluez
-Interface	org.bluez.OutOfBand
+Interface	org.bluez.OutOfBand1
 Object path	[variable prefix]/{hci0,hci1,...}
 
 Methods		dict ReadLocalData()
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 77563f1..887a610 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -45,7 +45,7 @@
 #include "error.h"
 #include "storage.h"
 
-#define OOB_INTERFACE	"org.bluez.OutOfBand"
+#define OOB_INTERFACE	"org.bluez.OutOfBand1"
 
 struct oob_data {
 	char *addr;
diff --git a/test/test-oob b/test/test-oob
index 87c558f..681540b 100755
--- a/test/test-oob
+++ b/test/test-oob
@@ -7,6 +7,9 @@ import gobject
 import dbus.mainloop.glib
 import bluezutils
 
+BUS_NAME = 'org.bluez'
+OOB_INTERFACE = 'org.bluez.OutOfBand1'
+
 def create_device_reply(device):
 	print("Pairing succeed!")
 	mainloop.quit()
@@ -61,10 +64,10 @@ if __name__ == '__main__':
 	print()
 	print("Reading local Out of Band data...")
 
-	oob_adapter0 = dbus.Interface(bus.get_object("org.bluez",
-					adapter0_path), "org.bluez.OutOfBand")
-	oob_adapter1 = dbus.Interface(bus.get_object("org.bluez",
-					adapter1_path), "org.bluez.OutOfBand")
+	oob_adapter0 = dbus.Interface(bus.get_object(BUS_NAME,
+					adapter0_path), OOB_INTERFACE)
+	oob_adapter1 = dbus.Interface(bus.get_object(BUS_NAME,
+					adapter1_path), OOB_INTERFACE)
 
 	oob0 = oob_adapter0.ReadLocalData()
 	oob1 = oob_adapter1.ReadLocalData()
-- 
1.7.11.7

