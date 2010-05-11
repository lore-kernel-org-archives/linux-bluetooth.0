Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 7/9] Adds an HDP record browser
Date: Tue, 11 May 2010 12:38:21 -0300
Message-Id: <1273592303-18234-7-git-send-email-epx@signove.com>
In-Reply-To: <1273592303-18234-1-git-send-email-epx@signove.com>
References: <1273592303-18234-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This script 'scans' known devices and interprets every HDP record
that it can find. The output is the raw dictionary format which
hdp_record module understands/delivers upon parsing.
---
 test/hdp/hdp_record_scan.py |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100755 test/hdp/hdp_record_scan.py

diff --git a/test/hdp/hdp_record_scan.py b/test/hdp/hdp_record_scan.py
new file mode 100755
index 0000000..d8a6a2c
--- /dev/null
+++ b/test/hdp/hdp_record_scan.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python
+
+import hdp_record
+import dbus
+
+bus = dbus.SystemBus()
+
+manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+						"org.bluez.Manager")
+
+adapter_list = manager.ListAdapters()
+
+for i in adapter_list:
+	adapter = dbus.Interface(bus.get_object("org.bluez", i),
+							"org.bluez.Adapter")
+	properties  = adapter.GetProperties()
+	try:
+		device_list = properties["Devices"]
+	except:
+		device_list = []
+
+	for n in device_list:
+		device = dbus.Interface(bus.get_object("org.bluez", n),
+							"org.bluez.Device")
+		p = device.GetProperties()
+		print "Discovering device", p['Address'], p['Name']
+		try:
+			services = device.DiscoverServices("")
+		except:
+			services = {}
+
+		for handle in services.keys():
+			hdp = hdp_record.parse_xml(services[handle])
+			if hdp:
+				print "Handle %08x:" % handle
+				print hdp_record.parse_xml(services[handle])
-- 
1.7.0.4

