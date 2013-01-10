Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/13 v2] test: Adapt simple-player to the new API of MediaPlayer1
Date: Thu, 10 Jan 2013 15:37:13 +0200
Message-Id: <1357825038-21970-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/simple-player | 62 ++++++++++++++++--------------------------------------
 1 file changed, 18 insertions(+), 44 deletions(-)

diff --git a/test/simple-player b/test/simple-player
index 3bfc485..e331c52 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -22,46 +22,36 @@ class Player(dbus.service.Object):
 						"org.freedesktop.DBus.Properties")
 
 			self.properties = prop.GetAll("org.bluez.MediaPlayer1")
-			self.metadata = mp.GetTrack()
 
 			bus.add_signal_receiver(self.properties_changed,
 				path = obj,
 				dbus_interface = "org.freedesktop.DBus.Properties",
 				signal_name = "PropertiesChanged")
-
-			bus.add_signal_receiver(self.track_changed,
-				path = obj,
-				dbus_interface ="org.bluez.MediaPlayer",
-				signal_name = "TrackChanged")
 		else:
+			track = dbus.Dictionary({
+					"Title" : "Title",
+					"Artist" : "Artist",
+					"Album" : "Album",
+					"Genre" : "Genre",
+					"NumberOfTracks" : dbus.UInt32(10),
+					"TrackNumber" : dbus.UInt32(1),
+					"Duration" : dbus.UInt32(10000) },
+					signature="sv")
+
 			self.properties = dbus.Dictionary({
 					"Equalizer" : "off",
 					"Repeat" : "off",
 					"Shuffle" : "off",
 					"Scan" : "off",
 					"Status" : "playing",
-					"Position" : dbus.UInt32(0) },
+					"Position" : dbus.UInt32(0),
+					"Track" : track },
 					signature="sv")
 
-			self.metadata = dbus.Dictionary({
-					"Title" : "Title",
-					"Artist" : "Artist",
-					"Album" : "Album",
-					"Genre" : "Genre",
-					"NumberOfTracks" : dbus.UInt32(10),
-					"Track" : dbus.UInt32(1),
-					"Duration" : dbus.UInt32(10000) },
-					signature="sv")
 			handler = InputHandler(self)
 			gobject.io_add_watch(sys.stdin, gobject.IO_IN,
 							handler.handle)
 
-	@dbus.service.method("org.bluez.MediaPlayer1",
-					in_signature="", out_signature="")
-	def Release(self):
-		print("Release")
-		mainloop.quit()
-
 	@dbus.service.method("org.freedesktop.DBus.Properties",
 					in_signature="ssv", out_signature="")
 	def Set(self, interface, key, value):
@@ -79,15 +69,6 @@ class Player(dbus.service.Object):
 		"""
 		pass
 
-	@dbus.service.signal("org.bluez.MediaPlayer1", signature="a{sv}")
-	def TrackChanged(self, metadata):
-		"""TrackChanged(metadata)
-
-		Send a TrackChanged signal. 'metadata' parameter is a dictionary,
-		with values as defined in doc/media-api.txt.
-		"""
-		pass
-
 	def help(self, func):
 		help(self.__class__.__dict__[func])
 
@@ -96,14 +77,8 @@ class Player(dbus.service.Object):
 
 		self.PropertiesChanged(interface, properties, invalidated)
 
-	def track_changed(self, metadata):
-		print("track_changed(%s)" % (metadata))
-
-		self.TrackChanged(metadata)
-
 class InputHandler:
-	commands = { 'TrackChanged': '(metadata)',
-			'PropertiesChanged': '(interface, properties)',
+	commands = { 'PropertiesChanged': '(interface, properties)',
 			'help': '(cmd)' }
 	def __init__(self, player):
 		self.player = player
@@ -112,7 +87,8 @@ class InputHandler:
 			print('\t', cmd, self.commands[cmd], sep='')
 
 		print("\nUse python syntax to pass arguments to available methods.\n" \
-                "E.g.: TrackChanged({'Title': 'My title', 'Album': 'my album' })")
+                "E.g.: PropertiesChanged({'Track' : {'Title': 'My title', \
+		'Album': 'my album' }})")
 		self.prompt()
 
 	def prompt(self):
@@ -160,11 +136,9 @@ if __name__ == '__main__':
 	else:
 		player.set_object()
 
-	print('Register media player with:\n\tProperties: %s\n\tMetadata: %s' \
-					% (player.properties, player.metadata))
-
+	print('Register media player with:\n\tProperties: %s' \
+						% (player.properties))
 
-	media.RegisterPlayer(dbus.ObjectPath(path), player.properties,
-							player.metadata)
+	media.RegisterPlayer(dbus.ObjectPath(path), player.properties)
 
 	mainloop.run()
-- 
1.8.0.1

