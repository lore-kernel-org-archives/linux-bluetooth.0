Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [BlueZ v4 1/2] doc/settings-storage: describe gatt attributes storage format
Date: Thu,  3 Sep 2015 09:35:24 -0700
Message-Id: <1441298125-613-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/settings-storage.txt | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 6c9f058..aea50a6 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -139,11 +139,15 @@ Cache directory file format
 ============================
 
 Each file, named by remote device address, may includes multiple groups
-(General and ServiceRecords).
+(General, ServiceRecords, Attributes).
 
 In ServiceRecords, SDP records are stored using their handle as key
 (hexadecimal format).
 
+In "Attributes" group GATT database is stored using attribute handle as key
+(hexadecimal format). Value associated with this handle is serialized form of
+all data required to re-create given attribute. ":" is used to separate fields.
+
 [General] group contains:
 
   Name		String		Remote device friendly name
@@ -155,6 +159,37 @@ In ServiceRecords, SDP records are stored using their handle as key
   <0x...>	String		SDP record as hexadecimal encoded
 				string
 
+In [Attributes] group value always starts with attribute type, that determines
+how to interpret rest of value:
+
+  Primary service:
+    2800:end_handle:uuid
+
+  Secondary service:
+    2801:end_handle:uuid
+
+  Included service:
+    2802:start_handle:end_handle:uuid
+
+  Characteristic:
+    2803:value_handle:properties:uuid
+
+  Descriptor:
+    uuid
+
+Sample Attributes section:
+  [Attributes]
+  0001=2800:0005:1801
+  0002=2803:0003:20:2a05
+  0014=2800:001c:1800
+  0015=2803:0016:02:2a00
+  0017=2803:0018:02:2a01
+  0019=2803:001a:02:2aa6
+  0028=2800:ffff:0000180d-0000-1000-8000-00805f9b34fb
+  0029=2803:002a:10:00002a37-0000-1000-8000-00805f9b34fb
+  002b=2803:002c:02:00002a38-0000-1000-8000-00805f9b34fb
+  002d=2803:002e:08:00002a39-0000-1000-8000-00805f9b34fb
+
 
 Info file format
 ================
-- 
2.1.4

