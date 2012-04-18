Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 3/5] gdbus: add decorated DBus signature for methods
Date: Wed, 18 Apr 2012 13:48:00 -0300
Message-Id: <1334767682-27121-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1334767682-27121-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1334767682-27121-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To generate better introspection data we need to keep the name of each
argument in GDBusMethodTable. With decorated signatures we can save
them, while being compatible with the previous format. It is supposed to
be used as following:

s[argname1]o[argname2]

We can't simply change signature to this format because we need to be
able to rapidly check if messages have that same signature when they
arrive: that is a much hotter path than the Introspect call, which
this patch tries to solve.

Therefore, when registering the interface we create the undecorated
signature and save on the same structure, that is used by everybody.
Introspect can later make use of the decorated version, exporting
argument names.
---
 gdbus/gdbus.h  |    7 +++++--
 gdbus/object.c |   34 +++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index a0583e6..0b8a556 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -82,13 +82,16 @@ typedef enum {
 	G_DBUS_SECURITY_FLAG_ALLOW_INTERACTION = (1 << 2),
 } GDBusSecurityFlags;
 
+#define MAX_SIGNATURE_SIZE 32
+
 typedef struct {
 	const char *name;
-	const char *signature;
+	const char *decorated_signature;
 	const char *reply;
 	GDBusMethodFunction function;
 	GDBusMethodFlags flags;
 	unsigned int privilege;
+	char signature[MAX_SIGNATURE_SIZE];
 } GDBusMethodTable;
 
 typedef struct {
@@ -112,7 +115,7 @@ typedef struct {
 
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
-					const GDBusMethodTable *methods,
+					GDBusMethodTable *methods,
 					const GDBusSignalTable *signals,
 					const GDBusPropertyTable *properties,
 					void *user_data,
diff --git a/gdbus/object.c b/gdbus/object.c
index 55b47f2..bfd1873 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <assert.h>
 #include <stdio.h>
 #include <string.h>
 
@@ -501,6 +502,36 @@ static GDBusMethodTable introspect_methods[] = {
 	{ }
 };
 
+static void undecorate_methods(GDBusMethodTable *m)
+{
+	int pushed;
+
+	for (pushed = 0; m->name; m++) {
+		const char *c;
+
+		for (c = m->decorated_signature; pushed < MAX_SIGNATURE_SIZE
+							&& *c != '\0'; c++) {
+			switch (*c) {
+			case '[':
+				while (*c != ']' && *c != '\0')
+					c++;
+
+				/* end of string without matching ']' */
+				assert(*c == ']');
+				break;
+			case ']':
+				/* ']' without '[' */
+				assert(0);
+				break;
+			default:
+				m->signature[pushed++] = *c;
+			}
+		}
+
+		assert(pushed != MAX_SIGNATURE_SIZE);
+	}
+}
+
 static void add_interface(struct generic_data *data, const char *name,
 				const GDBusMethodTable *methods,
 				const GDBusSignalTable *signals,
@@ -676,7 +707,7 @@ fail:
 
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
-					const GDBusMethodTable *methods,
+					GDBusMethodTable *methods,
 					const GDBusSignalTable *signals,
 					const GDBusPropertyTable *properties,
 					void *user_data,
@@ -693,6 +724,7 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 		return FALSE;
 	}
 
+	undecorate_methods(methods);
 	add_interface(data, name, methods, signals,
 			properties, user_data, destroy);
 
-- 
1.7.10

