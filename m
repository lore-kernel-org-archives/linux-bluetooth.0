Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 04/13] test: Show human-friendly UUIDs in list-devices
Date: Mon,  6 May 2013 10:43:21 +0200
Message-Id: <1367829810-8262-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Instead of showing the hexadecimal UUID, convert it to a human-friendly
alias as defined in the internal translation table in bluezutils.py.
---
 test/list-devices | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/test/list-devices b/test/list-devices
index 0aac217..57f9ba1 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -3,6 +3,7 @@
 from __future__ import absolute_import, print_function, unicode_literals
 
 import dbus
+import bluezutils
 
 bus = dbus.SystemBus()
 
@@ -19,7 +20,10 @@ def extract_objects(object_list):
 def extract_uuids(uuid_list):
 	list = ""
 	for uuid in uuid_list:
-		if (uuid.endswith("-0000-1000-8000-00805f9b34fb")):
+		alias = bluezutils.get_uuid_alias(uuid)
+		if alias:
+			val = alias
+		elif (uuid.endswith("-0000-1000-8000-00805f9b34fb")):
 			if (uuid.startswith("0000")):
 				val = "0x" + uuid[4:8]
 			else:
-- 
1.8.1.4

