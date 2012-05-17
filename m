Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v6 11/15] gdbus: remove signature and reply from tables
Date: Thu, 17 May 2012 15:20:08 -0300
Message-Id: <1337278812-4837-12-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h  |   51 ---------------------------------------------------
 gdbus/object.c |    2 +-
 2 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 8354633..e2e160d 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -89,8 +89,6 @@ typedef struct {
 
 typedef struct {
 	const char *name;
-	const char *signature;
-	const char *reply;
 	GDBusMethodFunction function;
 	GDBusMethodFlags flags;
 	unsigned int privilege;
@@ -100,7 +98,6 @@ typedef struct {
 
 typedef struct {
 	const char *name;
-	const char *signature;
 	GDBusSignalFlags flags;
 	const GDBusArgInfo *args;
 } GDBusSignalTable;
@@ -120,54 +117,6 @@ typedef struct {
 
 #define GDBUS_ARGS(args...) (const GDBusArgInfo[]) { args, { } }
 
-#define _GDBUS_METHOD(_name, _signature, _reply, _in_args, _out_args, _function) \
-	.name = _name, \
-	.signature = _signature, \
-	.reply = _reply, \
-	.in_args = _in_args, \
-	.out_args = _out_args, \
-	.function = _function
-
-#define _GDBUS_ASYNC_METHOD(_name, _signature, _reply, _in_args, _out_args, _function) \
-	.name = _name, \
-	.signature = _signature, \
-	.reply = _reply, \
-	.in_args = _in_args, \
-	.out_args = _out_args, \
-	.function = _function, \
-	.flags = G_DBUS_METHOD_FLAG_ASYNC
-
-#define _GDBUS_DEPRECATED_METHOD(_name, _signature, _reply, _in_args, _out_args, _function) \
-	.name = _name, \
-	.signature = _signature, \
-	.reply = _reply, \
-	.in_args = _in_args, \
-	.out_args = _out_args, \
-	.function = _function, \
-	.flags = G_DBUS_METHOD_FLAG_DEPRECATED
-
-#define _GDBUS_DEPRECATED_ASYNC_METHOD(_name, _signature, _reply, _in_args, _out_args, _function) \
-	.name = _name, \
-	.signature = _signature, \
-	.reply = _reply, \
-	.in_args = _in_args, \
-	.out_args = _out_args, \
-	.function = _function, \
-	.flags = G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
-
-#define _GDBUS_SIGNAL(_name, _signature, _args) \
-	.name = _name, \
-	.signature = _signature, \
-	.args = _args
-
-#define _GDBUS_DEPRECATED_SIGNAL(_name, _signature, _args) \
-	.name = _name, \
-	.signature = _signature, \
-	.args = _args, \
-	.flags = G_DBUS_SIGNAL_FLAG_DEPRECATED
-
-/* Helpers with no signature and reply */
-
 #define GDBUS_METHOD(_name, _in_args, _out_args, _function) \
 	.name = _name, \
 	.in_args = _in_args, \
diff --git a/gdbus/object.c b/gdbus/object.c
index b187bb5..fcdd6ec 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -471,7 +471,7 @@ done:
 }
 
 static const GDBusMethodTable introspect_methods[] = {
-	{ _GDBUS_METHOD("Introspect", "", "s", NULL,
+	{ GDBUS_METHOD("Introspect", NULL,
 			GDBUS_ARGS({ "xml", "s" }), introspect) },
 	{ }
 };
-- 
1.7.10.2

