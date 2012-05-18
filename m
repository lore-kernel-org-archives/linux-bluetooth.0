Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH obexd 2/9] Convert GDBus methods to use macro helpers
Date: Fri, 18 May 2012 15:32:01 -0300
Message-Id: <1337365928-18953-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337365928-18953-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337365928-18953-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With these macro helpers we can separate in/out arguments and use their
own vector.
---
 client/ftp.c      |   36 ++++++++++++++++++++----------------
 client/manager.c  |   31 +++++++++++++++++++------------
 client/map.c      |   17 +++++++++++------
 client/pbap.c     |   52 +++++++++++++++++++++++++++++++++++-----------------
 client/session.c  |   12 +++++++++---
 client/sync.c     |   16 ++++++++++------
 client/transfer.c |    7 +++++--
 src/manager.c     |   27 ++++++++++++++++++---------
 8 files changed, 127 insertions(+), 71 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 40c85b2..d08591a 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -436,22 +436,26 @@ static DBusMessage *delete(DBusConnection *connection,
 }
 
 static const GDBusMethodTable ftp_methods[] = {
-	{ "ChangeFolder",	"s", "",	change_folder,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "CreateFolder",	"s", "",	create_folder,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ListFolder",		"", "aa{sv}",	list_folder,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetFile",		"ss", "",	get_file,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PutFile",		"ss", "",	put_file,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "CopyFile",		"ss", "",	copy_file,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "MoveFile",		"ss", "",	move_file,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Delete",		"s", "",	delete,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("ChangeFolder", "s", "",
+		GDBUS_ARGS({ "folder", "s" }), NULL, change_folder) },
+	{ _GDBUS_ASYNC_METHOD("CreateFolder", "s", "",
+		GDBUS_ARGS({ "folder", "s" }), NULL, create_folder) },
+	{ _GDBUS_ASYNC_METHOD("ListFolder", "", "aa{sv}",
+		NULL, GDBUS_ARGS({ "folderinfo", "aa{sv}" }), list_folder) },
+	{ _GDBUS_ASYNC_METHOD("GetFile", "ss", "",
+		GDBUS_ARGS({ "targetfile", "s" }, { "sourcefile", "s" }), NULL,
+		get_file) },
+	{ _GDBUS_ASYNC_METHOD("PutFile", "ss", "",
+		GDBUS_ARGS({ "sourcefile", "s" }, { "targetfile", "s" }), NULL,
+		put_file) },
+	{ _GDBUS_ASYNC_METHOD("CopyFile", "ss", "",
+		GDBUS_ARGS({ "sourcefile", "s" }, { "targetfile", "s" }), NULL,
+		copy_file) },
+	{ _GDBUS_ASYNC_METHOD("MoveFile", "ss", "",
+		GDBUS_ARGS({ "sourcefile", "s" }, { "targetfile", "s" }), NULL,
+		move_file) },
+	{ _GDBUS_ASYNC_METHOD("Delete", "s", "",
+		GDBUS_ARGS({ "file", "s" }), NULL, delete) },
 	{ }
 };
 
diff --git a/client/manager.c b/client/manager.c
index 9f26cb0..c2c5ec1 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -582,18 +582,25 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 }
 
 static const GDBusMethodTable client_methods[] = {
-	{ "SendFiles", "a{sv}aso", "", send_files,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PullBusinessCard", "a{sv}s", "", pull_business_card,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ExchangeBusinessCards", "a{sv}ss", "", exchange_business_cards,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "CreateSession", "a{sv}", "o", create_session,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "RemoveSession", "o", "", remove_session,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetCapabilities", "a{sv}", "s", get_capabilities,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("SendFiles", "a{sv}aso", "",
+			GDBUS_ARGS({ "device", "a{sv}" }, { "files", "as" },
+					{ "agent", "o" }), NULL, send_files) },
+	{ _GDBUS_ASYNC_METHOD("PullBusinessCard", "a{sv}s", "",
+			GDBUS_ARGS({ "device", "a{sv}" }, { "file", "s" }), NULL,
+			pull_business_card) },
+	{ _GDBUS_ASYNC_METHOD("ExchangeBusinessCards", "a{sv}ss", "",
+			GDBUS_ARGS({ "device", "a{sv}" },
+					{ "clientfile", "s" }, { "file", "s" }),
+			NULL, exchange_business_cards) },
+	{ _GDBUS_ASYNC_METHOD("CreateSession", "a{sv}", "o",
+			GDBUS_ARGS({ "devices", "a{sv}" }),
+			GDBUS_ARGS({ "session", "o" }), create_session) },
+	{ _GDBUS_ASYNC_METHOD("RemoveSession", "o", "",
+			GDBUS_ARGS({ "session", "o" }), NULL, remove_session) },
+	{ _GDBUS_ASYNC_METHOD("GetCapabilities", "a{sv}", "s",
+			GDBUS_ARGS({ "device", "a{sv}" }),
+			GDBUS_ARGS({ "capabilities", "s" }),
+			get_capabilities) },
 	{ }
 };
 
diff --git a/client/map.c b/client/map.c
index c4afe0e..fce7924 100644
--- a/client/map.c
+++ b/client/map.c
@@ -190,12 +190,17 @@ fail:
 }
 
 static const GDBusMethodTable map_methods[] = {
-	{ "SetFolder",		"s", "",	map_setpath,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetFolderListing",	"a{ss}", "s",	map_get_folder_listing,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetMessageListing",	"sa{ss}", "s",	map_get_message_listing,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("SetFolder", "s", "",
+				GDBUS_ARGS({ "name", "string" }), NULL,
+				map_setpath) },
+	{ _GDBUS_ASYNC_METHOD("GetFolderListing", "a{ss}", "s",
+					GDBUS_ARGS({ "dummy", "a{ss}" }),
+					GDBUS_ARGS({ "content", "s" }),
+					map_get_folder_listing) },
+	{ _GDBUS_ASYNC_METHOD("GetMessageListing", "sa{ss}", "s",
+			GDBUS_ARGS({ "folder", "s" }, { "dummy", "a{ss}" }),
+			GDBUS_ARGS({ "messages", "s" }),
+			map_get_message_listing) },
 	{ }
 };
 
diff --git a/client/pbap.c b/client/pbap.c
index add9057..36b9a28 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -981,23 +981,41 @@ static DBusMessage *pbap_list_filter_fields(DBusConnection *connection,
 }
 
 static const GDBusMethodTable pbap_methods[] = {
-	{ "Select",	"ss",	"",	pbap_select,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PullAll",	"",	"s",	pbap_pull_all,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Pull",	"s",	"s",	pbap_pull_vcard,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "List",	"",	"a(ss)",	pbap_list,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Search",	"ss",	"a(ss)",	pbap_search,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetSize",	"",	"q",	pbap_get_size,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SetFormat",	"s",	"",	pbap_set_format },
-	{ "SetOrder",	"s",	"",	pbap_set_order },
-	{ "SetFilter",	"as",	"",	pbap_set_filter },
-	{ "GetFilter",	"",	"as",	pbap_get_filter },
-	{ "ListFilterFields", "",	"as",	pbap_list_filter_fields },
+	{ _GDBUS_ASYNC_METHOD("Select", "ss", "",
+			GDBUS_ARGS({ "location", "s" }, { "phonebook", "s" }),
+			NULL, pbap_select) },
+	{ _GDBUS_ASYNC_METHOD("PullAll", "", "s",
+				NULL, GDBUS_ARGS({ "phonebook", "s" }),
+				pbap_pull_all) },
+	{ _GDBUS_ASYNC_METHOD("Pull", "s", "s",
+				GDBUS_ARGS({ "phonebook_object", "s" }),
+				GDBUS_ARGS({ "vcard", "s" }),
+				pbap_pull_vcard) },
+	{ _GDBUS_ASYNC_METHOD("List", "", "a(ss)",
+				NULL, GDBUS_ARGS({ "vcard_listing", "a(ss)" }),
+				pbap_list) },
+	{ _GDBUS_ASYNC_METHOD("Search", "ss", "a(ss)",
+				GDBUS_ARGS({ "field", "s" }, { "value", "s" }),
+				GDBUS_ARGS({ "vcard_listing", "a(ss)" }),
+				pbap_search) },
+	{ _GDBUS_ASYNC_METHOD("GetSize", "", "q",
+				NULL, GDBUS_ARGS({ "size", "q" }),
+				pbap_get_size) },
+	{ _GDBUS_METHOD("SetFormat", "s", "",
+				GDBUS_ARGS({ "format", "s" }), NULL,
+				pbap_set_format) },
+	{ _GDBUS_METHOD("SetOrder", "s", "",
+				GDBUS_ARGS({ "order", "s" }), NULL,
+				pbap_set_order) },
+	{ _GDBUS_METHOD("SetFilter", "as", "",
+				GDBUS_ARGS({ "fields", "as" }), NULL,
+				pbap_set_filter) },
+	{ _GDBUS_METHOD("GetFilter", "", "as",
+				NULL, GDBUS_ARGS({ "fields", "as" }),
+				pbap_get_filter) },
+	{ _GDBUS_METHOD("ListFilterFields", "", "as",
+				NULL, GDBUS_ARGS({ "fields", "as" }),
+				pbap_list_filter_fields) },
 	{ }
 };
 
diff --git a/client/session.c b/client/session.c
index 5e49f23..d528452 100644
--- a/client/session.c
+++ b/client/session.c
@@ -649,9 +649,15 @@ static DBusMessage *session_get_properties(DBusConnection *connection,
 }
 
 static const GDBusMethodTable session_methods[] = {
-	{ "GetProperties",	"", "a{sv}",	session_get_properties	},
-	{ "AssignAgent",	"o", "",	assign_agent	},
-	{ "ReleaseAgent",	"o", "",	release_agent	},
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				session_get_properties) },
+	{ _GDBUS_METHOD("AssignAgent", "o", "",
+				GDBUS_ARGS({ "agent", "o" }), NULL,
+				assign_agent) },
+	{ _GDBUS_METHOD("ReleaseAgent", "o", "",
+				GDBUS_ARGS({ "agent", "o" }), NULL,
+				release_agent) },
 	{ }
 };
 
diff --git a/client/sync.c b/client/sync.c
index 1d71667..cd663fb 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -193,12 +193,16 @@ fail:
 }
 
 static const GDBusMethodTable sync_methods[] = {
-	{ "SetLocation", "s", "", sync_setlocation },
-	{ "GetPhonebook", "", "s", sync_getphonebook,
-			G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PutPhonebook", "s", "", sync_putphonebook,
-			G_DBUS_METHOD_FLAG_ASYNC },
-	{}
+	{ _GDBUS_METHOD("SetLocation", "s", "",
+			GDBUS_ARGS({ "location", "s" }), NULL,
+			sync_setlocation) },
+	{ _GDBUS_ASYNC_METHOD("GetPhonebook", "", "s",
+			NULL, GDBUS_ARGS({ "obj", "s" }),
+			sync_getphonebook) },
+	{ _GDBUS_ASYNC_METHOD("PutPhonebook", "s", "",
+			GDBUS_ARGS({ "obj", "s" }), NULL,
+			sync_putphonebook) },
+	{ }
 };
 
 static void sync_free(void *data)
diff --git a/client/transfer.c b/client/transfer.c
index 932010c..1991c7d 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -206,8 +206,11 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 }
 
 static const GDBusMethodTable obc_transfer_methods[] = {
-	{ "GetProperties", "", "a{sv}", obc_transfer_get_properties },
-	{ "Cancel", "", "", obc_transfer_cancel, G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				obc_transfer_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("Cancel", "", "", NULL, NULL,
+				obc_transfer_cancel) },
 	{ }
 };
 
diff --git a/src/manager.c b/src/manager.c
index 46c8884..9f38bf4 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -311,31 +311,40 @@ static DBusMessage *transfer_cancel(DBusConnection *connection,
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ "RegisterAgent",	"o",	"",	register_agent		},
-	{ "UnregisterAgent",	"o",	"",	unregister_agent	},
+	{ _GDBUS_METHOD("RegisterAgent", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL, register_agent) },
+	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL, unregister_agent) },
 	{ }
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ "TransferStarted",	"o"	},
-	{ "TransferCompleted",	"ob"	},
-	{ "SessionCreated",	"o"	},
-	{ "SessionRemoved",	"o"	},
+	{ _GDBUS_SIGNAL("TransferStarted", "o",
+					GDBUS_ARGS({ "transfer", "o"})) },
+	{ _GDBUS_SIGNAL("TransferCompleted", "ob",
+			GDBUS_ARGS({ "transfer", "o" }, { "success", "b" })) },
+	{ _GDBUS_SIGNAL("SessionCreated", "o",
+					GDBUS_ARGS({ "session", "o" })) },
+	{ _GDBUS_SIGNAL("SessionRemoved", "o",
+					GDBUS_ARGS({ "session", "o" })) },
 	{ }
 };
 
 static const GDBusMethodTable transfer_methods[] = {
-	{ "Cancel",	"",	"",	transfer_cancel	},
+	{ _GDBUS_METHOD("Cancel", "", "", NULL, NULL, transfer_cancel) },
 	{ }
 };
 
 static const GDBusSignalTable transfer_signals[] = {
-	{ "Progress",	"ii"	},
+	{ _GDBUS_SIGNAL("Progress", "ii",
+			GDBUS_ARGS({ "total", "i" }, { "transferred", "i" })) },
 	{ }
 };
 
 static const GDBusMethodTable session_methods[] = {
-	{ "GetProperties",	"",	"{sv}",	get_properties	},
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				get_properties) },
 	{ }
 };
 
-- 
1.7.10.2

