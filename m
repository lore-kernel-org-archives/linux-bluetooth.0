Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] test: Convert simple-player to use DBus properties interface
Date: Tue, 27 Nov 2012 14:51:25 +0200
Message-Id: <1354020685-17028-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
References: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/simple-player | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/test/simple-player b/test/simple-player
index 9e72f3e..0037f3a 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -17,14 +17,16 @@ class Player(dbus.service.Object):
 			bus = dbus.SystemBus()
 			mp = dbus.Interface(bus.get_object("org.bluez", obj),
 						"org.bluez.MediaPlayer")
+			prop = dbus.Interface(bus.get_object("org.bluez", obj),
+						"org.freedesktop.DBus.Properties")
 
-			self.properties = mp.GetProperties()
+			self.properties = prop.GetAll("org.bluez.MediaPlayer")
 			self.metadata = mp.GetTrack()
 
-			bus.add_signal_receiver(self.property_changed,
+			bus.add_signal_receiver(self.properties_changed,
 				path = obj,
-				dbus_interface = "org.bluez.MediaPlayer",
-				signal_name = "PropertyChanged")
+				dbus_interface = "org.freedesktop.DBus.Properties",
+				signal_name = "PropertiesChanged")
 
 			bus.add_signal_receiver(self.track_changed,
 				path = obj,
@@ -59,18 +61,20 @@ class Player(dbus.service.Object):
 		print("Release")
 		mainloop.quit()
 
-	@dbus.service.method("org.bluez.MediaPlayer",
-					in_signature="sv", out_signature="")
-	def SetProperty(self, key, value):
-		print("SetProperty (%s, %s)" % (key, value), file=sys.stderr)
+	@dbus.service.method("org.freedesktop.DBus.Properties",
+					in_signature="ssv", out_signature="")
+	def Set(self, interface, key, value):
+		print("Set (%s, %s)" % (key, value), file=sys.stderr)
 		return
 
-	@dbus.service.signal("org.bluez.MediaPlayer", signature="sv")
-	def PropertyChanged(self, setting, value):
-		"""PropertyChanged(setting, value)
+	@dbus.service.signal("org.freedesktop.DBus.Properties",
+							signature="sa{sv}as")
+	def PropertiesChanged(self, interface, properties,
+						invalidated = dbus.Array()):
+		"""PropertiesChanged(interface, properties, invalidated)
 
-		Send a PropertyChanged signal. 'setting' and 'value' are
-		string parameters as specified in doc/media-api.txt.
+		Send a PropertiesChanged signal. 'properties' is a dictionary
+		containing string parameters as specified in doc/media-api.txt.
 		"""
 		pass
 
@@ -86,10 +90,10 @@ class Player(dbus.service.Object):
 	def help(self, func):
 		help(self.__class__.__dict__[func])
 
-	def property_changed(self, setting, value):
-		print("property_changed(%s, %s)" % (setting, value))
+	def properties_changed(self, interface, properties, invalidated):
+		print("properties_changed(%s, %s)" % (properties, invalidated))
 
-		self.PropertyChanged(setting, value)
+		self.PropertiesChanged(interface, properties, invalidated)
 
 	def track_changed(self, metadata):
 		print("track_changed(%s)" % (metadata))
@@ -98,8 +102,8 @@ class Player(dbus.service.Object):
 
 class InputHandler:
 	commands = { 'TrackChanged': '(metadata)',
-					'PropertyChanged': '(key, value)',
-					'help': '(cmd)' }
+			'PropertiesChanged': '(interface, properties)',
+			'help': '(cmd)' }
 	def __init__(self, player):
 		self.player = player
 		print('\n\nAvailable commands:')
-- 
1.7.11.7

