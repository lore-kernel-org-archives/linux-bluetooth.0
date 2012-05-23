Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH 08/11] Do not set signature and reply in GDBus tables
Date: Wed, 23 May 2012 10:20:05 -0300
Message-Id: <1337779208-3555-9-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
References: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use GDBUS_* macros, so signature and reply fields are not set in each
method/signal.
---
 src/adapter.c |   14 +++++++-------
 src/device.c  |    8 ++++----
 src/manager.c |   12 +++++-------
 src/ndef.c    |    2 +-
 src/tag.c     |   11 +++++------
 5 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5cbafa1..bea2fcf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -463,22 +463,22 @@ static void tag_present_cb(uint32_t adapter_idx, uint32_t target_idx,
 }
 
 static const GDBusMethodTable adapter_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
 				get_properties) },
-	{ _GDBUS_METHOD("SetProperty", "sv", "",
+	{ GDBUS_METHOD("SetProperty",
 				GDBUS_ARGS({"name", "s"}, {"value", "v"}),
 				NULL, set_property) },
-	{ _GDBUS_METHOD("StartPoll", "", "", NULL, NULL, start_poll) },
-	{ _GDBUS_METHOD("StopPoll", "", "", NULL, NULL, stop_poll) },
+	{ GDBUS_METHOD("StartPoll", NULL, NULL, start_poll) },
+	{ GDBUS_METHOD("StopPoll", NULL, NULL, stop_poll) },
 	{ },
 };
 
 static const GDBusSignalTable adapter_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 				GDBUS_ARGS({"name", "s"}, {"value", "v"})) },
-	{ _GDBUS_SIGNAL("TagFound", "o", GDBUS_ARGS({"address", "o"})) },
-	{ _GDBUS_SIGNAL("TagLost", "o", GDBUS_ARGS({"address", "o"})) },
+	{ GDBUS_SIGNAL("TagFound", GDBUS_ARGS({"address", "o"})) },
+	{ GDBUS_SIGNAL("TagLost", GDBUS_ARGS({"address", "o"})) },
 	{ }
 };
 
diff --git a/src/device.c b/src/device.c
index 2b1527d..a873fb1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -234,20 +234,20 @@ error:
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
 				get_properties) },
-	{ _GDBUS_METHOD("SetProperty", "sv", "",
+	{ GDBUS_METHOD("SetProperty",
 				GDBUS_ARGS({"name", "s"}, {"value", "v"}),
 				NULL, set_property) },
-	{ _GDBUS_METHOD("Push", "a{sv}", "",
+	{ GDBUS_METHOD("Push",
 					GDBUS_ARGS({"attributes", "a{sv}"}),
 					NULL, push_ndef) },
 	{ },
 };
 
 static const GDBusSignalTable device_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 				GDBUS_ARGS({"name", "s"}, {"value", "v"})) },
 	{ }
 };
diff --git a/src/manager.c b/src/manager.c
index f1ac5ea..cb62260 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -134,22 +134,20 @@ void __near_manager_adapter_remove(uint32_t idx)
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
 				get_properties) },
-	{ _GDBUS_METHOD("SetProperty", "sv", "",
+	{ GDBUS_METHOD("SetProperty",
 				GDBUS_ARGS({"name", "s"}, {"value", "v"}),
 				NULL, set_property) },
 	{ },
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 				GDBUS_ARGS({"name", "s"}, {"value", "v"})) },
-	{ _GDBUS_SIGNAL("AdapterAdded", "o",
-					GDBUS_ARGS({"adapter", "o" })) },
-	{ _GDBUS_SIGNAL("AdapterRemoved", "o",
-					GDBUS_ARGS({"adapter", "o" })) },
+	{ GDBUS_SIGNAL("AdapterAdded", GDBUS_ARGS({"adapter", "o" })) },
+	{ GDBUS_SIGNAL("AdapterRemoved", GDBUS_ARGS({"adapter", "o" })) },
 	{ }
 };
 
diff --git a/src/ndef.c b/src/ndef.c
index a23c508..9a0a4cf 100644
--- a/src/ndef.c
+++ b/src/ndef.c
@@ -419,7 +419,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable record_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
 				get_properties) },
 	{ },
diff --git a/src/tag.c b/src/tag.c
index f3ab092..6a21d39 100644
--- a/src/tag.c
+++ b/src/tag.c
@@ -323,20 +323,19 @@ fail:
 }
 
 static const GDBusMethodTable tag_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
 				get_properties) },
-	{ _GDBUS_METHOD("SetProperty", "sv", "",
+	{ GDBUS_METHOD("SetProperty",
 				GDBUS_ARGS({"name", "s"}, {"value", "v"}),
 				NULL, set_property) },
-	{ _GDBUS_METHOD("Write", "a{sv}", "",
-					GDBUS_ARGS({"attributes", "a{sv}"}),
-					NULL, write_ndef) },
+	{ GDBUS_METHOD("Write", GDBUS_ARGS({"attributes", "a{sv}"}),
+							NULL, write_ndef) },
 	{ },
 };
 
 static const GDBusSignalTable tag_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 				GDBUS_ARGS({"name", "s"}, {"value", "v"})) },
 	{ }
 };
-- 
1.7.9.5

