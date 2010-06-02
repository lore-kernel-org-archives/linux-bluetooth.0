Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 30/32] Add a test that creates a simple health agent
Date: Wed,  2 Jun 2010 15:19:26 +0200
Message-Id: <1275484768-25838-31-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-30-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-21-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-22-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-23-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-24-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-25-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-26-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-27-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-28-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-29-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-30-git-send-email-santoscadenas@gmail.com>
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

