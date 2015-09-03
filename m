Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 2/2] test: Add test-gatt-profile
Date: Thu,  3 Sep 2015 15:22:52 +0300
Message-Id: <1441282972-22182-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1441282972-22182-1-git-send-email-luiz.dentz@gmail.com>
References: <1441282972-22182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

test-gatt-profile can be used to register a GATT based profile using
GattManager1 interface.
---
 test/test-gatt-profile | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100755 test/test-gatt-profile

diff --git a/test/test-gatt-profile b/test/test-gatt-profile
new file mode 100755
index 0000000..ad320b1
--- /dev/null
+++ b/test/test-gatt-profile
@@ -0,0 +1,60 @@
+#!/usr/bin/python
+
+from __future__ import absolute_import, print_function, unicode_literals
+
+from optparse import OptionParser, make_option
+import os
+import sys
+import uuid
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
+import bluezutils
+
+class GattProfile(dbus.service.Object):
+	@dbus.service.method("org.bluez.GattProfile1",
+					in_signature="", out_signature="")
+	def Release(self):
+		print("Release")
+		mainloop.quit()
+
+if __name__ == '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	bus = dbus.SystemBus()
+
+	path = bluezutils.find_adapter().object_path
+
+	manager = dbus.Interface(bus.get_object("org.bluez", path),
+				"org.bluez.GattManager1")
+
+	option_list = [
+			make_option("-u", "--uuid", action="store",
+					type="string", dest="uuid",
+					default=None),
+			make_option("-p", "--path", action="store",
+					type="string", dest="path",
+					default="/foo/bar/profile"),
+			]
+
+	opts = dbus.Dictionary({ }, signature='sv')
+
+	parser = OptionParser(option_list=option_list)
+
+	(options, args) = parser.parse_args()
+
+	profile = GattProfile(bus, options.path)
+
+	mainloop = GObject.MainLoop()
+
+	if not options.uuid:
+		options.uuid = str(uuid.uuid4())
+
+	uuids = { options.uuid }
+	manager.RegisterProfile(options.path, uuids, opts)
+
+	mainloop.run()
-- 
2.4.3

