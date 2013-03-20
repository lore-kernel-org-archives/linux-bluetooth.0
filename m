Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] test: Fix list-devices when there is more than one adapter
Date: Wed, 20 Mar 2013 17:18:24 -0300
Message-Id: <1363810704-21450-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/list-devices | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/test/list-devices b/test/list-devices
index 0aac217..790b358 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -31,9 +31,6 @@ def extract_uuids(uuid_list):
 
 objects = manager.GetManagedObjects()
 
-all_devices = (str(path) for path, interfaces in objects.iteritems() if
-					"org.bluez.Device1" in interfaces.keys())
-
 for path, interfaces in objects.iteritems():
 	if "org.bluez.Adapter1" not in interfaces.keys():
 		continue
@@ -49,6 +46,8 @@ for path, interfaces in objects.iteritems():
 		else:
 			print("    %s = %s" % (key, value))
 
+	all_devices = (str(path) for path, interfaces in objects.iteritems() if
+					"org.bluez.Device1" in interfaces.keys())
 	device_list = [d for d in all_devices if d.startswith(path + "/")]
 
 	for dev_path in device_list:
-- 
1.7.11.7

