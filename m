Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/11] test: Add support for using external player
Date: Thu, 25 Oct 2012 16:59:14 +0300
Message-Id: <1351173554-28039-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
References: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add support for passing a device player object which is then
registered as a local one in a loopback fashion.
---
 test/simple-player | 80 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 19 deletions(-)

diff --git a/test/simple-player b/test/simple-player
index f8751d6..9e72f3e 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -9,6 +9,50 @@ import dbus.mainloop.glib
 import gobject
 
 class Player(dbus.service.Object):
+	properties = None
+	metadata = None
+
+	def set_object(self, obj = None):
+		if obj != None:
+			bus = dbus.SystemBus()
+			mp = dbus.Interface(bus.get_object("org.bluez", obj),
+						"org.bluez.MediaPlayer")
+
+			self.properties = mp.GetProperties()
+			self.metadata = mp.GetTrack()
+
+			bus.add_signal_receiver(self.property_changed,
+				path = obj,
+				dbus_interface = "org.bluez.MediaPlayer",
+				signal_name = "PropertyChanged")
+
+			bus.add_signal_receiver(self.track_changed,
+				path = obj,
+				dbus_interface ="org.bluez.MediaPlayer",
+				signal_name = "TrackChanged")
+		else:
+			self.properties = dbus.Dictionary({
+					"Equalizer" : "off",
+					"Repeat" : "off",
+					"Shuffle" : "off",
+					"Scan" : "off",
+					"Status" : "playing",
+					"Position" : dbus.UInt32(0) },
+					signature="sv")
+
+			self.metadata = dbus.Dictionary({
+					"Title" : "Title",
+					"Artist" : "Artist",
+					"Album" : "Album",
+					"Genre" : "Genre",
+					"NumberOfTracks" : dbus.UInt32(10),
+					"Track" : dbus.UInt32(1),
+					"Duration" : dbus.UInt32(10000) },
+					signature="sv")
+			handler = InputHandler(self)
+			gobject.io_add_watch(sys.stdin, gobject.IO_IN,
+							handler.handle)
+
 	@dbus.service.method("org.bluez.MediaPlayer",
 					in_signature="", out_signature="")
 	def Release(self):
@@ -42,6 +86,16 @@ class Player(dbus.service.Object):
 	def help(self, func):
 		help(self.__class__.__dict__[func])
 
+	def property_changed(self, setting, value):
+		print("property_changed(%s, %s)" % (setting, value))
+
+		self.PropertyChanged(setting, value)
+
+	def track_changed(self, metadata):
+		print("track_changed(%s)" % (metadata))
+
+		self.TrackChanged(metadata)
+
 class InputHandler:
 	commands = { 'TrackChanged': '(metadata)',
 					'PropertyChanged': '(key, value)',
@@ -79,7 +133,6 @@ class InputHandler:
 		return True
 
 
-
 if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
@@ -99,27 +152,16 @@ if __name__ == '__main__':
 	player = Player(bus, path)
 	mainloop = gobject.MainLoop()
 
-	properties = dbus.Dictionary({ "Equalizer" : "off",
-					"Repeat" : "off",
-					"Shuffle" : "off",
-					"Scan" : "off",
-					"Status" : "playing",
-					"Position" : dbus.UInt32(0) }, signature="sv")
-
-	metadata = dbus.Dictionary({ "Title" : "Title",
-					"Artist" : "Artist",
-					"Album" : "Album",
-					"Genre" : "Genre",
-					"NumberOfTracks" : dbus.UInt32(10),
-					"Track" : dbus.UInt32(1),
-					"Duration" : dbus.UInt32(10000) }, signature="sv")
+	if len(sys.argv) > 2:
+		player.set_object(sys.argv[2])
+	else:
+		player.set_object()
 
 	print('Register media player with:\n\tProperties: %s\n\tMetadata: %s' \
-						% (properties, metadata))
+					% (player.properties, player.metadata))
 
-	handler = InputHandler(player)
-	gobject.io_add_watch(sys.stdin, gobject.IO_IN, handler.handle)
 
-	media.RegisterPlayer(dbus.ObjectPath(path), properties, metadata)
+	media.RegisterPlayer(dbus.ObjectPath(path), player.properties,
+							player.metadata)
 
 	mainloop.run()
-- 
1.7.11.7

