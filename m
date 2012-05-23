Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH 05/11] Convert GDBus methods and signals to use macro helpers
Date: Wed, 23 May 2012 10:20:02 -0300
Message-Id: <1337779208-3555-6-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
References: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With these macro helpers we can separate in/out arguments and use their
own vector.
---
 src/adapter.c |   19 ++++++++++++-------
 src/device.c  |   15 +++++++++++----
 src/manager.c |   17 ++++++++++++-----
 src/ndef.c    |    4 +++-
 src/tag.c     |   15 +++++++++++----
 5 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8574d52..5cbafa1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -463,17 +463,22 @@ static void tag_present_cb(uint32_t adapter_idx, uint32_t target_idx,
 }
 
 static const GDBusMethodTable adapter_methods[] = {
-	{ "GetProperties",     "",      "a{sv}", get_properties     },
-	{ "SetProperty",       "sv",    "",      set_property       },
-	{ "StartPoll",         "",      "",      start_poll         },
-	{ "StopPoll",          "",      "",      stop_poll          },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
+				get_properties) },
+	{ _GDBUS_METHOD("SetProperty", "sv", "",
+				GDBUS_ARGS({"name", "s"}, {"value", "v"}),
+				NULL, set_property) },
+	{ _GDBUS_METHOD("StartPoll", "", "", NULL, NULL, start_poll) },
+	{ _GDBUS_METHOD("StopPoll", "", "", NULL, NULL, stop_poll) },
 	{ },
 };
 
 static const GDBusSignalTable adapter_signals[] = {
-	{ "PropertyChanged",		"sv"	},
-	{ "TagFound",		        "o"	},
-	{ "TagLost",			"o"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+				GDBUS_ARGS({"name", "s"}, {"value", "v"})) },
+	{ _GDBUS_SIGNAL("TagFound", "o", GDBUS_ARGS({"address", "o"})) },
+	{ _GDBUS_SIGNAL("TagLost", "o", GDBUS_ARGS({"address", "o"})) },
 	{ }
 };
 
diff --git a/src/device.c b/src/device.c
index b53e24d..2b1527d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -234,14 +234,21 @@ error:
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ "GetProperties",     "",      "a{sv}", get_properties     },
-	{ "SetProperty",       "sv",    "",      set_property       },
-	{ "Push",             "a{sv}",  "",      push_ndef          },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
+				get_properties) },
+	{ _GDBUS_METHOD("SetProperty", "sv", "",
+				GDBUS_ARGS({"name", "s"}, {"value", "v"}),
+				NULL, set_property) },
+	{ _GDBUS_METHOD("Push", "a{sv}", "",
+					GDBUS_ARGS({"attributes", "a{sv}"}),
+					NULL, push_ndef) },
 	{ },
 };
 
 static const GDBusSignalTable device_signals[] = {
-	{ "PropertyChanged",		"sv"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+				GDBUS_ARGS({"name", "s"}, {"value", "v"})) },
 	{ }
 };
 
diff --git a/src/manager.c b/src/manager.c
index 241c472..f1ac5ea 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -134,15 +134,22 @@ void __near_manager_adapter_remove(uint32_t idx)
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ "GetProperties",     "",      "a{sv}", get_properties     },
-	{ "SetProperty",       "sv",    "",      set_property       },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
+				get_properties) },
+	{ _GDBUS_METHOD("SetProperty", "sv", "",
+				GDBUS_ARGS({"name", "s"}, {"value", "v"}),
+				NULL, set_property) },
 	{ },
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ "PropertyChanged",		"sv"	},
-	{ "AdapterAdded",		"o"	},
-	{ "AdapterRemoved",		"o"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+				GDBUS_ARGS({"name", "s"}, {"value", "v"})) },
+	{ _GDBUS_SIGNAL("AdapterAdded", "o",
+					GDBUS_ARGS({"adapter", "o" })) },
+	{ _GDBUS_SIGNAL("AdapterRemoved", "o",
+					GDBUS_ARGS({"adapter", "o" })) },
 	{ }
 };
 
diff --git a/src/ndef.c b/src/ndef.c
index 029941a..a23c508 100644
--- a/src/ndef.c
+++ b/src/ndef.c
@@ -419,7 +419,9 @@ static DBusMessage *get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable record_methods[] = {
-	{ "GetProperties",     "",      "a{sv}", get_properties     },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
+				get_properties) },
 	{ },
 };
 
diff --git a/src/tag.c b/src/tag.c
index d660749..f3ab092 100644
--- a/src/tag.c
+++ b/src/tag.c
@@ -323,14 +323,21 @@ fail:
 }
 
 static const GDBusMethodTable tag_methods[] = {
-	{ "GetProperties",     "",      "a{sv}", get_properties     },
-	{ "SetProperty",       "sv",    "",      set_property       },
-	{ "Write",             "a{sv}", "",      write_ndef         },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
+				get_properties) },
+	{ _GDBUS_METHOD("SetProperty", "sv", "",
+				GDBUS_ARGS({"name", "s"}, {"value", "v"}),
+				NULL, set_property) },
+	{ _GDBUS_METHOD("Write", "a{sv}", "",
+					GDBUS_ARGS({"attributes", "a{sv}"}),
+					NULL, write_ndef) },
 	{ },
 };
 
 static const GDBusSignalTable tag_signals[] = {
-	{ "PropertyChanged",		"sv"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+				GDBUS_ARGS({"name", "s"}, {"value", "v"})) },
 	{ }
 };
 
-- 
1.7.9.5

