Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] audio: Fix interface names
Date: Wed,  5 Dec 2012 20:18:09 -0300
Message-Id: <1354749489-25442-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some places, the old names of the interfaces were still being used.
So we update them to use the new names.
---
Hi,

This patch is more to confirm the intended names, in this patch I am
supposing that the correct names are 'org.bluez.MediaEndpoint1' and
'org.bluez.MediaPlayer1'. As I think that the double numbering would
cause even more confusion.

Cheers,

 src/bluetooth.conf   |  4 ++--
 test/simple-endpoint | 10 +++++-----
 test/simple-player   | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 4d0d504..6111fdb 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -12,8 +12,8 @@
     <allow send_destination="org.bluez"/>
     <allow send_interface="org.bluez.Agent"/>
     <allow send_interface="org.bluez.HandsfreeAgent"/>
-    <allow send_interface="org.bluez.MediaEndpoint"/>
-    <allow send_interface="org.bluez.MediaPlayer"/>
+    <allow send_interface="org.bluez.MediaEndpoint1"/>
+    <allow send_interface="org.bluez.MediaPlayer1"/>
     <allow send_interface="org.bluez.Watcher"/>
     <allow send_interface="org.bluez.ThermometerWatcher"/>
     <allow send_interface="org.bluez.AlertAgent"/>
diff --git a/test/simple-endpoint b/test/simple-endpoint
index b363943..590f83a 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -55,25 +55,25 @@ class Endpoint(dbus.service.Object):
 	def default_configuration(self, configuration):
 		self.configuration = configuration
 
-	@dbus.service.method("org.bluez.MediaEndpoint",
+	@dbus.service.method("org.bluez.MediaEndpoint1",
 					in_signature="", out_signature="")
 	def Release(self):
 		print("Release")
 		if self.exit_on_release:
 			mainloop.quit()
 
-	@dbus.service.method("org.bluez.MediaEndpoint",
+	@dbus.service.method("org.bluez.MediaEndpoint1",
 					in_signature="", out_signature="")
 	def ClearConfiguration(self):
 		print("ClearConfiguration")
 
-	@dbus.service.method("org.bluez.MediaEndpoint",
+	@dbus.service.method("org.bluez.MediaEndpoint1",
 					in_signature="oay", out_signature="")
 	def SetConfiguration(self, transport, config):
 		print("SetConfiguration (%s, %s)" % (transport, config))
 		return
 
-	@dbus.service.method("org.bluez.MediaEndpoint",
+	@dbus.service.method("org.bluez.MediaEndpoint1",
 					in_signature="ay", out_signature="ay")
 	def SelectConfiguration(self, caps):
 		print("SelectConfiguration (%s)" % (caps))
@@ -90,7 +90,7 @@ if __name__ == '__main__':
 		path = bluezutils.find_adapter().object_path
 
 	media = dbus.Interface(bus.get_object("org.bluez", path),
-						"org.bluez.Media")
+						"org.bluez.Media1")
 
 	path = "/test/endpoint"
 	endpoint = Endpoint(bus, path)
diff --git a/test/simple-player b/test/simple-player
index 7eb7d7e..3bfc485 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -17,11 +17,11 @@ class Player(dbus.service.Object):
 		if obj != None:
 			bus = dbus.SystemBus()
 			mp = dbus.Interface(bus.get_object("org.bluez", obj),
-						"org.bluez.MediaPlayer")
+						"org.bluez.MediaPlayer1")
 			prop = dbus.Interface(bus.get_object("org.bluez", obj),
 						"org.freedesktop.DBus.Properties")
 
-			self.properties = prop.GetAll("org.bluez.MediaPlayer")
+			self.properties = prop.GetAll("org.bluez.MediaPlayer1")
 			self.metadata = mp.GetTrack()
 
 			bus.add_signal_receiver(self.properties_changed,
@@ -56,7 +56,7 @@ class Player(dbus.service.Object):
 			gobject.io_add_watch(sys.stdin, gobject.IO_IN,
 							handler.handle)
 
-	@dbus.service.method("org.bluez.MediaPlayer",
+	@dbus.service.method("org.bluez.MediaPlayer1",
 					in_signature="", out_signature="")
 	def Release(self):
 		print("Release")
@@ -79,7 +79,7 @@ class Player(dbus.service.Object):
 		"""
 		pass
 
-	@dbus.service.signal("org.bluez.MediaPlayer", signature="a{sv}")
+	@dbus.service.signal("org.bluez.MediaPlayer1", signature="a{sv}")
 	def TrackChanged(self, metadata):
 		"""TrackChanged(metadata)
 
@@ -149,7 +149,7 @@ if __name__ == '__main__':
 		path = bluezutils.find_adapter().object_path
 
 	media = dbus.Interface(bus.get_object("org.bluez", path),
-						"org.bluez.Media")
+						"org.bluez.Media1")
 
 	path = "/test/player"
 	player = Player(bus, path)
-- 
1.8.0.1

