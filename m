Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 01/10] doc: Add settings storage documentation
Date: Wed, 10 Oct 2012 18:23:22 +0200
Message-Id: <1349886211-18920-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1349886211-18920-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349886211-18920-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/settings-storage.txt |  102 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 doc/settings-storage.txt

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
new file mode 100644
index 0000000..0a3f90e
--- /dev/null
+++ b/doc/settings-storage.txt
@@ -0,0 +1,102 @@
+Information related to local adapters and remote devices are stored in storage
+directory (default: /var/lib/bluetooth).
+Files are in ini-file format.
+
+There is one directory per adapter, named by its bluetooth address, which
+contains:
+ - a settings file for the local adapter
+ - an attribute_db file containing attributes of supported LE services
+ - names file containing names of all devices already seen
+ - one directory per remote device, named by remote device address, which
+   contains:
+    - a settings file
+    - a key file accessible only by root
+    - an attribute_db file containing attributes of remote LE services
+
+So the directory structure should be:
+    /var/lib/bluetooth/<adapter address>/
+        ./settings
+        ./attribute_db
+        ./names
+        ./<remote device address>/
+            ./settings
+            ./keys
+            ./attribute_db
+        ./<remote device address>/
+            ./settings
+            ./keys
+            ./attribute_db
+        ...
+
+Adapter directory files
+=======================
+
+Settings file contains 1 [General] group with adapter info:
+  [General]
+  Name=
+  Class=0x000000
+  Pairable=<true|false>
+  PairableTimeout=0
+  DiscoverableTimeout=0
+  Mode=<off|connectable|discoverable>
+  OnMode=<connectable|discoverable>
+
+The attribute_db file is a list of handles (group name) with UUID and Value as
+keys, for example:
+  [0x0001]
+  UUID=00002800-0000-1000-8000-00805f9b34fb
+  Value=0018
+
+  [0x0004]
+  UUID=00002803-0000-1000-8000-00805f9b34fb
+  Value=020600002A
+
+  [0x0006]
+  UUID=00002a00-0000-1000-8000-00805f9b34fb
+  Value=4578616D706C6520446576696365
+
+Names file contains 1 [Names] group with device address as key:
+  [Names]
+  <nn:nn:nn:nn:nn:nn>=device name a
+  <mm:mm:mm:mm:mm:mm>=device name b
+
+Device directory files
+======================
+
+Remote device settings file will include a [General] group with device infos
+and a [DeviceID] group with related infos:
+  [General]
+  Alias=
+  Class=0x000000
+  Manufacturer=0
+  LmpVersion=
+  LmpSubversion=
+  Features=0000000000000000
+  SupportedTechnologies=<BR/EDR|LE>;<BR/EDR|LE>
+  AddressType=<static|public>
+  LastSeen=yyyy-mm-dd hh:mm:ss GMT
+  LastUsed=yyyy-mm-dd hh:mm:ss GMT
+  Trusted=<true|false>
+  Profiles=<128 bits UUID of profile 1>;<128 bits UUID of profile 2>;...
+
+  [DeviceID]
+  Assigner=0
+  Vendor=0
+  Product=0
+  Version=0
+
+Keys file includes informations related to link key or long term link key:
+  [LinkKey]
+  Key=
+  Type=0
+  PINLength=0
+
+  [LongTermKey]
+  Key=
+  Authenticated=<true|false>
+  EncSize=0
+  EDiv=0
+  Rand=0
+
+The attribute_db file is a list of handles (group name) with UUID and Value as
+keys (cf. attribute_db in adapter directory).
-- 
1.7.9.5

