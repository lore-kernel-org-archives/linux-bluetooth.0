Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 13/15] profile: Rename org.bluez.Profile->ProfileAgent
Date: Fri, 19 Oct 2012 17:39:30 +0200
Message-Id: <1350661172-18125-14-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The interface represents an external component supporting a specific
profile by implementing an agent. Therefore ProfileAgent is a more
accurate name for the D-Bus interface.
---
 doc/manager-api.txt      |  3 ++-
 doc/profile-api.txt      | 53 ------------------------------------------------
 doc/profileagent-api.txt | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/bluetooth.conf       |  2 +-
 src/manager.c            |  2 +-
 src/profile.c            | 11 +++++-----
 test/test-profile        |  8 ++++----
 7 files changed, 67 insertions(+), 65 deletions(-)
 delete mode 100644 doc/profile-api.txt
 create mode 100644 doc/profileagent-api.txt

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index fe50556..16fe4ee 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -29,7 +29,8 @@ Object path	/
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NoSuchAdapter
 
-		void RegisterProfile(object profile, string uuid, dict options)
+		void RegisterProfileAgent(object profile, string uuid,
+								dict options)
 
 			This registers a profile implementation.
 
diff --git a/doc/profile-api.txt b/doc/profile-api.txt
deleted file mode 100644
index 639202f..0000000
--- a/doc/profile-api.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-BlueZ D-Bus Profile API description
-***********************************
-
-Copyright (C) 2012  Intel Corporation. All rights reserved.
-
-
-Profile hierarchy
-=================
-
-Service		unique name
-Interface	org.bluez.Profile
-Object path	freely definable
-
-Methods		void Release()
-
-			This method gets called when the service daemon
-			unregisters the profile. A profile can use it to do
-			cleanup tasks. There is no need to unregister the
-			profile, because when this method gets called it has
-			already been unregistered.
-
-		void NewConnection(object device, fd)
-
-			This method gets called when a new service level
-			connection has been made and authorized.
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-
-		void RequestDisconnection(object device)
-
-			This method gets called when a profile gets
-			disconnected.
-
-			The file descriptor is no longer owned by the service
-			daemon and the profile implementation needs to take
-			care of cleaning up all connections.
-
-			If multiple file descriptors are indicated via
-			NewConnection, it is expected that all of them
-			are disconnected before returning from this
-			method call.
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-
-		void Cancel()
-
-			This method gets called to indicate that the profile
-			request failed before a reply was returned.
-
-			All request are queued and there will be only one
-			pending pequest at a time per profile.
diff --git a/doc/profileagent-api.txt b/doc/profileagent-api.txt
new file mode 100644
index 0000000..8a27a01
--- /dev/null
+++ b/doc/profileagent-api.txt
@@ -0,0 +1,53 @@
+BlueZ D-Bus Profile API description
+***********************************
+
+Copyright (C) 2012  Intel Corporation. All rights reserved.
+
+
+Profile hierarchy
+=================
+
+Service		unique name
+Interface	org.bluez.ProfileAgent
+Object path	freely definable
+
+Methods		void Release()
+
+			This method gets called when the service daemon
+			unregisters the profile. A profile can use it to do
+			cleanup tasks. There is no need to unregister the
+			profile, because when this method gets called it has
+			already been unregistered.
+
+		void NewConnection(object device, fd)
+
+			This method gets called when a new service level
+			connection has been made and authorized.
+
+			Possible errors: org.bluez.Error.Rejected
+			                 org.bluez.Error.Canceled
+
+		void RequestDisconnection(object device)
+
+			This method gets called when a profile gets
+			disconnected.
+
+			The file descriptor is no longer owned by the service
+			daemon and the profile implementation needs to take
+			care of cleaning up all connections.
+
+			If multiple file descriptors are indicated via
+			NewConnection, it is expected that all of them
+			are disconnected before returning from this
+			method call.
+
+			Possible errors: org.bluez.Error.Rejected
+			                 org.bluez.Error.Canceled
+
+		void Cancel()
+
+			This method gets called to indicate that the profile
+			request failed before a reply was returned.
+
+			All request are queued and there will be only one
+			pending pequest at a time per profile.
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 2db43d9..49dafc8 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -17,7 +17,7 @@
     <allow send_interface="org.bluez.Watcher"/>
     <allow send_interface="org.bluez.ThermometerWatcher"/>
     <allow send_interface="org.bluez.AlertAgent"/>
-    <allow send_interface="org.bluez.Profile"/>
+    <allow send_interface="org.bluez.ProfileAgent"/>
     <allow send_interface="org.bluez.HeartRateWatcher"/>
   </policy>
 
diff --git a/src/manager.c b/src/manager.c
index a96115b..1dc1c54 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -163,7 +163,7 @@ static const GDBusMethodTable manager_methods[] = {
 			GDBUS_ARGS({ "pattern", "s" }),
 			GDBUS_ARGS({ "adapter", "o" }),
 			find_adapter) },
-	{ GDBUS_METHOD("RegisterProfile",
+	{ GDBUS_METHOD("RegisterProfileAgent",
 			GDBUS_ARGS({ "profile", "o"}, { "UUID", "s" },
 						{ "options", "a{sv}" }),
 			NULL, btd_profile_reg_ext) },
diff --git a/src/profile.c b/src/profile.c
index eb63e1e..7e7c945 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -157,7 +157,8 @@ static void ext_cancel(struct ext_profile *ext)
 	DBusMessage *msg;
 
 	msg = dbus_message_new_method_call(ext->owner, ext->path,
-						"org.bluez.Profile", "Cancel");
+						"org.bluez.ProfileAgent",
+						"Cancel");
 	if (msg)
 		g_dbus_send_message(btd_get_dbus_connection(), msg);
 }
@@ -274,8 +275,8 @@ static bool send_new_connection(struct ext_profile *ext, struct ext_io *conn,
 	int fd;
 
 	msg = dbus_message_new_method_call(ext->owner, ext->path,
-							"org.bluez.Profile",
-							"NewConnection");
+						"org.bluez.ProfileAgent",
+						"NewConnection");
 	if (!msg) {
 		error("Unable to create NewConnection call for %s", ext->name);
 		return false;
@@ -1108,8 +1109,8 @@ void btd_profile_cleanup(void)
 		ext->conns = NULL;
 
 		msg = dbus_message_new_method_call(ext->owner, ext->path,
-							"org.bluez.Profile",
-							"Release");
+						"org.bluez.ProfileAgent",
+						"Release");
 		if (msg)
 			g_dbus_send_message(conn, msg);
 
diff --git a/test/test-profile b/test/test-profile
index 2d66444..cfc9331 100755
--- a/test/test-profile
+++ b/test/test-profile
@@ -12,18 +12,18 @@ import dbus.mainloop.glib
 from optparse import OptionParser, make_option
 
 class Profile(dbus.service.Object):
-	@dbus.service.method("org.bluez.Profile",
+	@dbus.service.method("org.bluez.ProfileAgent",
 					in_signature="", out_signature="")
 	def Release(self):
 		print("Release")
 		mainloop.quit()
 
-	@dbus.service.method("org.bluez.Profile",
+	@dbus.service.method("org.bluez.ProfileAgent",
 					in_signature="", out_signature="")
 	def Cancel(self):
 		print("Cancel")
 
-	@dbus.service.method("org.bluez.Profile",
+	@dbus.service.method("org.bluez.ProfileAgent",
 					in_signature="oh", out_signature="")
 	def NewConnection(self, path, fd):
 		fd = fd.take()
@@ -84,6 +84,6 @@ if __name__ == '__main__':
 	if (options.channel):
 		opts["Channel"] = dbus.UInt16(options.channel)
 
-	manager.RegisterProfile(options.path, options.uuid, opts)
+	manager.RegisterProfileAgent(options.path, options.uuid, opts)
 
 	mainloop.run()
-- 
1.7.11.7

