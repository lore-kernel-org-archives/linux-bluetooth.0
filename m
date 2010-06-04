Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 30/32] Add a test that creates a simple health agent
Date: Fri,  4 Jun 2010 10:30:23 +0200
Message-Id: <1275640225-4186-31-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-30-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-5-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-6-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-8-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-9-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-10-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-11-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-12-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-13-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-14-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-15-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-16-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-17-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-18-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-19-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-20-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-21-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-22-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-23-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-24-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-25-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-26-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-27-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-28-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-29-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-30-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-health |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100755 test/test-health

diff --git a/test/test-health b/test/test-health
new file mode 100755
index 0000000..2129923
--- /dev/null
+++ b/test/test-health
@@ -0,0 +1,61 @@
+#!/usr/bin/python
+# -*- coding: utf-8 -*-
+
+import dbus
+import dbus.service
+import gobject
+from dbus.mainloop.glib import DBusGMainLoop
+
+agent_iface = 'org.bluez.HealthAgent'
+obj_path = "/org/bluez/test/health/agent"
+
+DBusGMainLoop(set_as_default=True)
+loop = gobject.MainLoop()
+
+bus = dbus.SystemBus()
+manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+						"org.bluez.Manager")
+
+hdp = dbus.Interface(bus.get_object("org.bluez", manager.DefaultAdapter()),
+						"org.bluez.HealthAdapter")
+
+class HDP(dbus.service.Object):
+	def __init__(self, bus, obj_path):
+		self.bus = bus
+		dbus.service.Object.__init__(self, self.bus, obj_path)
+	@dbus.service.method(agent_iface, in_signature='o', out_signature='',
+							sender_keyword='sender')
+	def LinkConnected(self, path, sender=None):
+		print "Connected new link %s: (sender %s)" % (path, sender)
+	@dbus.service.method(agent_iface, in_signature='o', out_signature='',
+							sender_keyword='sender')
+	def LinkDisconnected(self, path, sender=None):
+		print "Link %s: disconnected (sender: %s)" % (path, sender)
+
+session_id = hdp.CreateInstance(dbus.ObjectPath(obj_path),
+	{"data_spec": dbus.Byte(1, variant_level=1),
+        "end_points":dbus.Array([{ "role": dbus.String("sink", variant_level=1),
+			 "specs": dbus.Array([{
+				"data_type":
+					dbus.UInt16(4100, variant_level =1),
+				"description":
+					dbus.String("Oximeter",
+							variant_level = 1),
+				},{
+				"data_type":
+					dbus.UInt16(4103, variant_level =1),
+				"description":
+					dbus.String("Blood pressure",
+							variant_level = 1),
+				}
+				], variant_level=1),
+			},
+	], variant_level=1)})
+
+hdp_obj = HDP(bus, obj_path);
+
+try:
+	print "Waiting for connections, push Ctrl+C to stop"
+	loop.run()
+except:
+	print "Loop interrupted, closing session"
-- 
1.6.3.3

