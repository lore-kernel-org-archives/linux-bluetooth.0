Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 6/9] Adds HDP record adder script
Date: Tue, 11 May 2010 12:38:20 -0300
Message-Id: <1273592303-18234-6-git-send-email-epx@signove.com>
In-Reply-To: <1273592303-18234-1-git-send-email-epx@signove.com>
References: <1273592303-18234-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This script creates an HDP profile from a service dictionary
(in a format that hdp_record module understands), generates
the XML and adds the service in SDP using D-BUS.
---
 test/hdp/hdp_record_add.py |   49 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100755 test/hdp/hdp_record_add.py

diff --git a/test/hdp/hdp_record_add.py b/test/hdp/hdp_record_add.py
new file mode 100755
index 0000000..2574570
--- /dev/null
+++ b/test/hdp/hdp_record_add.py
@@ -0,0 +1,49 @@
+#!/usr/bin/env python
+
+import hdp_record
+import sys
+import time
+import dbus
+
+feature1 = {'mdep_id': 0x01, 'role': 'source',
+		'data_type': 0x1004, 'description': "Fake oximeter"}
+# feature2 = {'mdep_id': 0x01, 'role': 'source', 'data_type': 0x4005}
+# feature3 = {'mdep_id': 0x02, 'role': 'sink', 'data_type': 0x4006}
+# feature4 = {'mdep_id': 0x04, 'role': 'sink', 'data_type': 0x4007}
+# features = [feature1, feature2, feature3, feature4]
+features = [feature1]
+hdp = {'features': features}
+hdp['mcap_control_psm'] = 0x1001
+hdp['mcap_data_psm'] = 0x1003
+hdp['name'] = "Fake oximeter"
+hdp['description'] = "A fake HDP record"
+hdp['provider'] = "Epx Inc."
+hdp['mcap_procedures'] = ('csp', 'csp_master', 'reconnect_init', \
+				'reconnect_accept')
+xml = hdp_record.gen_xml(hdp)
+
+bus = dbus.SystemBus()
+manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+						"org.bluez.Manager")
+
+if len(sys.argv) > 1:
+	path = manager.FindAdapter(sys.argv[1])
+else:
+	path = manager.DefaultAdapter()
+
+service = dbus.Interface(bus.get_object("org.bluez", path),
+						"org.bluez.Service")
+
+handle = service.AddRecord(xml)
+
+print "Service record with handle 0x%04x added" % (handle)
+
+print "Press CTRL-C to remove service record"
+
+try:
+	time.sleep(1000)
+	print "Terminating session"
+except:
+	pass
+
+service.RemoveRecord(dbus.UInt32(handle))
-- 
1.7.0.4

