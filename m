Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH obexd 5/9] Do not set signature and reply in GDBus tables
Date: Fri, 18 May 2012 15:32:04 -0300
Message-Id: <1337365928-18953-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337365928-18953-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337365928-18953-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use GDBUS_* macros, so signature and reply fields are not set in each
method/signal.
---
 client/ftp.c      |   16 ++++++++--------
 client/manager.c  |   12 ++++++------
 client/map.c      |    6 +++---
 client/pbap.c     |   22 +++++++++++-----------
 client/session.c  |    6 +++---
 client/sync.c     |    6 +++---
 client/transfer.c |    4 ++--
 src/manager.c     |   25 +++++++++++--------------
 8 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index d08591a..8585566 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -436,25 +436,25 @@ static DBusMessage *delete(DBusConnection *connection,
 }
 
 static const GDBusMethodTable ftp_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("ChangeFolder", "s", "",
+	{ GDBUS_ASYNC_METHOD("ChangeFolder",
 		GDBUS_ARGS({ "folder", "s" }), NULL, change_folder) },
-	{ _GDBUS_ASYNC_METHOD("CreateFolder", "s", "",
+	{ GDBUS_ASYNC_METHOD("CreateFolder",
 		GDBUS_ARGS({ "folder", "s" }), NULL, create_folder) },
-	{ _GDBUS_ASYNC_METHOD("ListFolder", "", "aa{sv}",
+	{ GDBUS_ASYNC_METHOD("ListFolder",
 		NULL, GDBUS_ARGS({ "folderinfo", "aa{sv}" }), list_folder) },
-	{ _GDBUS_ASYNC_METHOD("GetFile", "ss", "",
+	{ GDBUS_ASYNC_METHOD("GetFile",
 		GDBUS_ARGS({ "targetfile", "s" }, { "sourcefile", "s" }), NULL,
 		get_file) },
-	{ _GDBUS_ASYNC_METHOD("PutFile", "ss", "",
+	{ GDBUS_ASYNC_METHOD("PutFile",
 		GDBUS_ARGS({ "sourcefile", "s" }, { "targetfile", "s" }), NULL,
 		put_file) },
-	{ _GDBUS_ASYNC_METHOD("CopyFile", "ss", "",
+	{ GDBUS_ASYNC_METHOD("CopyFile",
 		GDBUS_ARGS({ "sourcefile", "s" }, { "targetfile", "s" }), NULL,
 		copy_file) },
-	{ _GDBUS_ASYNC_METHOD("MoveFile", "ss", "",
+	{ GDBUS_ASYNC_METHOD("MoveFile",
 		GDBUS_ARGS({ "sourcefile", "s" }, { "targetfile", "s" }), NULL,
 		move_file) },
-	{ _GDBUS_ASYNC_METHOD("Delete", "s", "",
+	{ GDBUS_ASYNC_METHOD("Delete",
 		GDBUS_ARGS({ "file", "s" }), NULL, delete) },
 	{ }
 };
diff --git a/client/manager.c b/client/manager.c
index c2c5ec1..d896ba4 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -582,22 +582,22 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 }
 
 static const GDBusMethodTable client_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("SendFiles", "a{sv}aso", "",
+	{ GDBUS_ASYNC_METHOD("SendFiles",
 			GDBUS_ARGS({ "device", "a{sv}" }, { "files", "as" },
 					{ "agent", "o" }), NULL, send_files) },
-	{ _GDBUS_ASYNC_METHOD("PullBusinessCard", "a{sv}s", "",
+	{ GDBUS_ASYNC_METHOD("PullBusinessCard",
 			GDBUS_ARGS({ "device", "a{sv}" }, { "file", "s" }), NULL,
 			pull_business_card) },
-	{ _GDBUS_ASYNC_METHOD("ExchangeBusinessCards", "a{sv}ss", "",
+	{ GDBUS_ASYNC_METHOD("ExchangeBusinessCards",
 			GDBUS_ARGS({ "device", "a{sv}" },
 					{ "clientfile", "s" }, { "file", "s" }),
 			NULL, exchange_business_cards) },
-	{ _GDBUS_ASYNC_METHOD("CreateSession", "a{sv}", "o",
+	{ GDBUS_ASYNC_METHOD("CreateSession",
 			GDBUS_ARGS({ "devices", "a{sv}" }),
 			GDBUS_ARGS({ "session", "o" }), create_session) },
-	{ _GDBUS_ASYNC_METHOD("RemoveSession", "o", "",
+	{ GDBUS_ASYNC_METHOD("RemoveSession",
 			GDBUS_ARGS({ "session", "o" }), NULL, remove_session) },
-	{ _GDBUS_ASYNC_METHOD("GetCapabilities", "a{sv}", "s",
+	{ GDBUS_ASYNC_METHOD("GetCapabilities",
 			GDBUS_ARGS({ "device", "a{sv}" }),
 			GDBUS_ARGS({ "capabilities", "s" }),
 			get_capabilities) },
diff --git a/client/map.c b/client/map.c
index fce7924..52b7c68 100644
--- a/client/map.c
+++ b/client/map.c
@@ -190,14 +190,14 @@ fail:
 }
 
 static const GDBusMethodTable map_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("SetFolder", "s", "",
+	{ GDBUS_ASYNC_METHOD("SetFolder",
 				GDBUS_ARGS({ "name", "string" }), NULL,
 				map_setpath) },
-	{ _GDBUS_ASYNC_METHOD("GetFolderListing", "a{ss}", "s",
+	{ GDBUS_ASYNC_METHOD("GetFolderListing",
 					GDBUS_ARGS({ "dummy", "a{ss}" }),
 					GDBUS_ARGS({ "content", "s" }),
 					map_get_folder_listing) },
-	{ _GDBUS_ASYNC_METHOD("GetMessageListing", "sa{ss}", "s",
+	{ GDBUS_ASYNC_METHOD("GetMessageListing",
 			GDBUS_ARGS({ "folder", "s" }, { "dummy", "a{ss}" }),
 			GDBUS_ARGS({ "messages", "s" }),
 			map_get_message_listing) },
diff --git a/client/pbap.c b/client/pbap.c
index 36b9a28..3a771ab 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -981,39 +981,39 @@ static DBusMessage *pbap_list_filter_fields(DBusConnection *connection,
 }
 
 static const GDBusMethodTable pbap_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("Select", "ss", "",
+	{ GDBUS_ASYNC_METHOD("Select",
 			GDBUS_ARGS({ "location", "s" }, { "phonebook", "s" }),
 			NULL, pbap_select) },
-	{ _GDBUS_ASYNC_METHOD("PullAll", "", "s",
+	{ GDBUS_ASYNC_METHOD("PullAll",
 				NULL, GDBUS_ARGS({ "phonebook", "s" }),
 				pbap_pull_all) },
-	{ _GDBUS_ASYNC_METHOD("Pull", "s", "s",
+	{ GDBUS_ASYNC_METHOD("Pull",
 				GDBUS_ARGS({ "phonebook_object", "s" }),
 				GDBUS_ARGS({ "vcard", "s" }),
 				pbap_pull_vcard) },
-	{ _GDBUS_ASYNC_METHOD("List", "", "a(ss)",
+	{ GDBUS_ASYNC_METHOD("List",
 				NULL, GDBUS_ARGS({ "vcard_listing", "a(ss)" }),
 				pbap_list) },
-	{ _GDBUS_ASYNC_METHOD("Search", "ss", "a(ss)",
+	{ GDBUS_ASYNC_METHOD("Search",
 				GDBUS_ARGS({ "field", "s" }, { "value", "s" }),
 				GDBUS_ARGS({ "vcard_listing", "a(ss)" }),
 				pbap_search) },
-	{ _GDBUS_ASYNC_METHOD("GetSize", "", "q",
+	{ GDBUS_ASYNC_METHOD("GetSize",
 				NULL, GDBUS_ARGS({ "size", "q" }),
 				pbap_get_size) },
-	{ _GDBUS_METHOD("SetFormat", "s", "",
+	{ GDBUS_METHOD("SetFormat",
 				GDBUS_ARGS({ "format", "s" }), NULL,
 				pbap_set_format) },
-	{ _GDBUS_METHOD("SetOrder", "s", "",
+	{ GDBUS_METHOD("SetOrder",
 				GDBUS_ARGS({ "order", "s" }), NULL,
 				pbap_set_order) },
-	{ _GDBUS_METHOD("SetFilter", "as", "",
+	{ GDBUS_METHOD("SetFilter",
 				GDBUS_ARGS({ "fields", "as" }), NULL,
 				pbap_set_filter) },
-	{ _GDBUS_METHOD("GetFilter", "", "as",
+	{ GDBUS_METHOD("GetFilter",
 				NULL, GDBUS_ARGS({ "fields", "as" }),
 				pbap_get_filter) },
-	{ _GDBUS_METHOD("ListFilterFields", "", "as",
+	{ GDBUS_METHOD("ListFilterFields",
 				NULL, GDBUS_ARGS({ "fields", "as" }),
 				pbap_list_filter_fields) },
 	{ }
diff --git a/client/session.c b/client/session.c
index d528452..d4ec55d 100644
--- a/client/session.c
+++ b/client/session.c
@@ -649,13 +649,13 @@ static DBusMessage *session_get_properties(DBusConnection *connection,
 }
 
 static const GDBusMethodTable session_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				session_get_properties) },
-	{ _GDBUS_METHOD("AssignAgent", "o", "",
+	{ GDBUS_METHOD("AssignAgent",
 				GDBUS_ARGS({ "agent", "o" }), NULL,
 				assign_agent) },
-	{ _GDBUS_METHOD("ReleaseAgent", "o", "",
+	{ GDBUS_METHOD("ReleaseAgent",
 				GDBUS_ARGS({ "agent", "o" }), NULL,
 				release_agent) },
 	{ }
diff --git a/client/sync.c b/client/sync.c
index cd663fb..d56e066 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -193,13 +193,13 @@ fail:
 }
 
 static const GDBusMethodTable sync_methods[] = {
-	{ _GDBUS_METHOD("SetLocation", "s", "",
+	{ GDBUS_METHOD("SetLocation",
 			GDBUS_ARGS({ "location", "s" }), NULL,
 			sync_setlocation) },
-	{ _GDBUS_ASYNC_METHOD("GetPhonebook", "", "s",
+	{ GDBUS_ASYNC_METHOD("GetPhonebook",
 			NULL, GDBUS_ARGS({ "obj", "s" }),
 			sync_getphonebook) },
-	{ _GDBUS_ASYNC_METHOD("PutPhonebook", "s", "",
+	{ GDBUS_ASYNC_METHOD("PutPhonebook",
 			GDBUS_ARGS({ "obj", "s" }), NULL,
 			sync_putphonebook) },
 	{ }
diff --git a/client/transfer.c b/client/transfer.c
index 1991c7d..3065c9c 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -206,10 +206,10 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 }
 
 static const GDBusMethodTable obc_transfer_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				obc_transfer_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("Cancel", "", "", NULL, NULL,
+	{ GDBUS_ASYNC_METHOD("Cancel", NULL, NULL,
 				obc_transfer_cancel) },
 	{ }
 };
diff --git a/src/manager.c b/src/manager.c
index 9f38bf4..f649035 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -311,38 +311,35 @@ static DBusMessage *transfer_cancel(DBusConnection *connection,
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ _GDBUS_METHOD("RegisterAgent", "o", "",
+	{ GDBUS_METHOD("RegisterAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL, register_agent) },
-	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
+	{ GDBUS_METHOD("UnregisterAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL, unregister_agent) },
 	{ }
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ _GDBUS_SIGNAL("TransferStarted", "o",
-					GDBUS_ARGS({ "transfer", "o"})) },
-	{ _GDBUS_SIGNAL("TransferCompleted", "ob",
-			GDBUS_ARGS({ "transfer", "o" }, { "success", "b" })) },
-	{ _GDBUS_SIGNAL("SessionCreated", "o",
-					GDBUS_ARGS({ "session", "o" })) },
-	{ _GDBUS_SIGNAL("SessionRemoved", "o",
-					GDBUS_ARGS({ "session", "o" })) },
+	{ GDBUS_SIGNAL("TransferStarted", GDBUS_ARGS({ "transfer", "o"})) },
+	{ GDBUS_SIGNAL("TransferCompleted", GDBUS_ARGS({ "transfer", "o" },
+							{ "success", "b" })) },
+	{ GDBUS_SIGNAL("SessionCreated", GDBUS_ARGS({ "session", "o" })) },
+	{ GDBUS_SIGNAL("SessionRemoved", GDBUS_ARGS({ "session", "o" })) },
 	{ }
 };
 
 static const GDBusMethodTable transfer_methods[] = {
-	{ _GDBUS_METHOD("Cancel", "", "", NULL, NULL, transfer_cancel) },
+	{ GDBUS_METHOD("Cancel", NULL, NULL, transfer_cancel) },
 	{ }
 };
 
 static const GDBusSignalTable transfer_signals[] = {
-	{ _GDBUS_SIGNAL("Progress", "ii",
-			GDBUS_ARGS({ "total", "i" }, { "transferred", "i" })) },
+	{ GDBUS_SIGNAL("Progress", GDBUS_ARGS({ "total", "i" },
+						{ "transferred", "i" })) },
 	{ }
 };
 
 static const GDBusMethodTable session_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				get_properties) },
 	{ }
-- 
1.7.10.2

