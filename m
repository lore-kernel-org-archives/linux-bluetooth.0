Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 04/11] gdbus: add and use helpers for table declarations
Date: Wed, 23 May 2012 10:20:01 -0300
Message-Id: <1337779208-3555-5-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
References: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

---
 gdbus/gdbus.h  |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 gdbus/object.c |    3 +-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index e5e7938..8354633 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -118,6 +118,92 @@ typedef struct {
 	GDBusSecurityFunction function;
 } GDBusSecurityTable;
 
+#define GDBUS_ARGS(args...) (const GDBusArgInfo[]) { args, { } }
+
+#define _GDBUS_METHOD(_name, _signature, _reply, _in_args, _out_args, _function) \
+	.name = _name, \
+	.signature = _signature, \
+	.reply = _reply, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function
+
+#define _GDBUS_ASYNC_METHOD(_name, _signature, _reply, _in_args, _out_args, _function) \
+	.name = _name, \
+	.signature = _signature, \
+	.reply = _reply, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_ASYNC
+
+#define _GDBUS_DEPRECATED_METHOD(_name, _signature, _reply, _in_args, _out_args, _function) \
+	.name = _name, \
+	.signature = _signature, \
+	.reply = _reply, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_DEPRECATED
+
+#define _GDBUS_DEPRECATED_ASYNC_METHOD(_name, _signature, _reply, _in_args, _out_args, _function) \
+	.name = _name, \
+	.signature = _signature, \
+	.reply = _reply, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
+
+#define _GDBUS_SIGNAL(_name, _signature, _args) \
+	.name = _name, \
+	.signature = _signature, \
+	.args = _args
+
+#define _GDBUS_DEPRECATED_SIGNAL(_name, _signature, _args) \
+	.name = _name, \
+	.signature = _signature, \
+	.args = _args, \
+	.flags = G_DBUS_SIGNAL_FLAG_DEPRECATED
+
+/* Helpers with no signature and reply */
+
+#define GDBUS_METHOD(_name, _in_args, _out_args, _function) \
+	.name = _name, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function
+
+#define GDBUS_ASYNC_METHOD(_name, _in_args, _out_args, _function) \
+	.name = _name, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_ASYNC
+
+#define GDBUS_DEPRECATED_METHOD(_name, _in_args, _out_args, _function) \
+	.name = _name, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_DEPRECATED
+
+#define GDBUS_DEPRECATED_ASYNC_METHOD(_name, _in_args, _out_args, _function) \
+	.name = _name, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
+
+#define GDBUS_SIGNAL(_name, _args) \
+	.name = _name, \
+	.args = _args
+
+#define GDBUS_DEPRECATED_SIGNAL(_name, _args) \
+	.name = _name, \
+	.args = _args, \
+	.flags = G_DBUS_SIGNAL_FLAG_DEPRECATED
+
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
 					const GDBusMethodTable *methods,
diff --git a/gdbus/object.c b/gdbus/object.c
index 0ef6c80..2ddc574 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -497,7 +497,8 @@ done:
 }
 
 static const GDBusMethodTable introspect_methods[] = {
-	{ "Introspect",	"",	"s", introspect	},
+	{ _GDBUS_METHOD("Introspect", "", "s", NULL,
+			GDBUS_ARGS({ "xml", "s" }), introspect) },
 	{ }
 };
 
-- 
1.7.9.5

