Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 9/9] Changes HDP record example from source to sink
Date: Tue, 11 May 2010 12:38:23 -0300
Message-Id: <1273592303-18234-9-git-send-email-epx@signove.com>
In-Reply-To: <1273592303-18234-1-git-send-email-epx@signove.com>
References: <1273592303-18234-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes example from source to sink, adds hint about Nonin
oximeters and a canned pnpinfo.xml to satisfy device identification.
---
 test/hdp/hdp_record_add.py |   22 ++++++++++++++++++++--
 test/hdp/pnpinfo.xml       |   29 +++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 test/hdp/pnpinfo.xml

diff --git a/test/hdp/hdp_record_add.py b/test/hdp/hdp_record_add.py
index 2574570..cc0ed26 100755
--- a/test/hdp/hdp_record_add.py
+++ b/test/hdp/hdp_record_add.py
@@ -5,8 +5,8 @@ import sys
 import time
 import dbus
 
-feature1 = {'mdep_id': 0x01, 'role': 'source',
-		'data_type': 0x1004, 'description': "Fake oximeter"}
+feature1 = {'mdep_id': 0x01, 'role': 'sink',
+		'data_type': 0x1004, 'description': "Oximeter sink"}
 # feature2 = {'mdep_id': 0x01, 'role': 'source', 'data_type': 0x4005}
 # feature3 = {'mdep_id': 0x02, 'role': 'sink', 'data_type': 0x4006}
 # feature4 = {'mdep_id': 0x04, 'role': 'sink', 'data_type': 0x4007}
@@ -35,8 +35,12 @@ service = dbus.Interface(bus.get_object("org.bluez", path),
 						"org.bluez.Service")
 
 handle = service.AddRecord(xml)
+# handle2 = service.AddRecord(open("pnpinfo.xml").read())
+handle2 = None
 
 print "Service record with handle 0x%04x added" % (handle)
+if handle2:
+	print "Service record with handle 0x%04x added" % (handle2)
 
 print "Press CTRL-C to remove service record"
 
@@ -47,3 +51,17 @@ except:
 	pass
 
 service.RemoveRecord(dbus.UInt32(handle))
+if handle2:
+	service.RemoveRecord(dbus.UInt32(handle2))
+
+# Hints for testing w/ Nonin 9650 oximeter:
+
+# Listen CSM channel with l2test -P 4097 -X ertm -O 48 -r
+
+# Nonin only searches PC SDP records right after cells disconnected (!),
+# if it can't connect to CSM at first time, it seems not to try again,
+# and cells must be removed for it to happen. (Thanks to Libresoft guys
+# about this issue.)
+
+# The Device Identification (PNPINFO) record is mandatory accordingly
+# to HDP spec, but seems not to make a difference.
diff --git a/test/hdp/pnpinfo.xml b/test/hdp/pnpinfo.xml
new file mode 100644
index 0000000..d04559b
--- /dev/null
+++ b/test/hdp/pnpinfo.xml
@@ -0,0 +1,29 @@
+<?xml version="1.0" encoding="UTF-8" ?>
+<!-- Fake device identification (PNPINFO)
+     Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+-->
+<record>
+	<attribute id="0x0001">
+		<sequence>
+			<uuid value="0x1200" />
+		</sequence>
+	</attribute>
+	<attribute id="0x0200">
+		<uint16 value="0x0103" />
+	</attribute>
+	<attribute id="0x0201">
+		<uint16 value="0x2000" />
+	</attribute>
+	<attribute id="0x0202">
+		<uint16 value="0x1234" />
+	</attribute>
+	<attribute id="0x0203">
+		<uint16 value="0x0200" />
+	</attribute>
+	<attribute id="0x0204">
+		<boolean value="true" />
+	</attribute>
+	<attribute id="0x0205">
+		<uint16 value="0x0002" />
+	</attribute>
+</record>
-- 
1.7.0.4

