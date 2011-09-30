Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] Add simple-player test script
Date: Fri, 30 Sep 2011 16:10:41 +0300
Message-Id: <1317388243-26240-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1317388243-26240-1-git-send-email-luiz.dentz@gmail.com>
References: <1317388243-26240-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/simple-player |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100755 test/simple-player

diff --git a/test/simple-player b/test/simple-player
new file mode 100755
index 0000000..f483897
--- /dev/null
+++ b/test/simple-player
@@ -0,0 +1,56 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+import gobject
+
+class Player(dbus.service.Object):
+	@dbus.service.method("org.bluez.MediaPlayer",
+					in_signature="sv", out_signature="")
+	def SetProperty(self, key, value):
+		print "SetProperty (%s, %s)" % (key, value)
+		return
+
+if __name__ == '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	bus = dbus.SystemBus()
+	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+						"org.bluez.Manager")
+
+	if len(sys.argv) > 1:
+		path = manager.FindAdapter(sys.argv[1])
+	else:
+		path = manager.DefaultAdapter()
+
+	media = dbus.Interface(bus.get_object("org.bluez", path),
+						"org.bluez.Media")
+
+	path = "/test/player"
+	player = Player(bus, path)
+	mainloop = gobject.MainLoop()
+
+	properties = dbus.Dictionary({ "Equalizer" : "off",
+					"Repeat" : "off",
+					"Shuffle" : "off",
+					"Scan" : "off",
+					"Status" : "playing",
+					"Position" : dbus.UInt32(0) })
+
+	print properties
+
+	metadata = dbus.Dictionary({ "Title" : "Title",
+					"Artist" : "Artist",
+					"Album" : "Album",
+					"Genre" : "Genre",
+					"NumberOfTracks" : dbus.UInt32(10),
+					"Number" : dbus.UInt32(1),
+					"Duration" : dbus.UInt32(10000) })
+
+	print metadata
+
+	media.RegisterPlayer(path, properties, metadata)
+
+	mainloop.run()
-- 
1.7.6.2

