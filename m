Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 01/15] doc: Add settings storage documentation
Date: Thu, 18 Oct 2012 11:00:44 +0200
Message-Id: <1350550858-12239-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1350550858-12239-1-git-send-email-frederic.danis@linux.intel.com>
References: <1350550858-12239-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/settings-storage.txt |  106 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 doc/settings-storage.txt

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
new file mode 100644
index 0000000..bc9ac66
--- /dev/null
+++ b/doc/settings-storage.txt
@@ -0,0 +1,106 @@
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
+        ./attributes
+        ./cache/
+            ./<remote device address>
+            ./<remote device address>
+            ...
+        ./<remote device address>/
+            ./info
+            ./attributes
+        ./<remote device address>/
+            ./info
+            ./attributes
+        ...
+
+Adapter directory files
+=======================
+
+Settings file contains 1 [General] group with adapter info:
+  [General]
+  Name=
+  Class=0x000000
+  Discoverable=<true|false>
+  Connectable=<true|false>
+  Pairable=<true|false>
+  Powered=<true|false>
+  PairableTimeout=0
+  DiscoverableTimeout=0
+
+The attributes file is a list of handles (group name) with UUID and Value as
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
+Cache directory files
+======================
+
+Each files, named by remote device address, contains 1 [General] group:
+  [General]
+  Name=device name a
+  LastSeen=yyyy-mm-dd hh:mm:ss GMT
+
+Device directory files
+======================
+
+Remote device info file will include a [General] group with device info,
+[DeviceID], [LinkKey] and [LongTermKey] groups with related info:
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
+  Source=0
+  Vendor=0
+  Product=0
+  Version=0
+
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

