Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v3 01/15] gdbus: Move typedefs up
Date: Sat, 18 Aug 2012 03:50:48 -0300
Message-Id: <1345272662-2850-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move the typedefs up so they can be used by functions and callbacks.
---
 gdbus/gdbus.h | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 0a8a27c..34e3cb3 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -31,6 +31,17 @@ extern "C" {
 #include <dbus/dbus.h>
 #include <glib.h>
 
+typedef enum GDBusMethodFlags GDBusMethodFlags;
+typedef enum GDBusSignalFlags GDBusSignalFlags;
+typedef enum GDBusPropertyFlags GDBusPropertyFlags;
+typedef enum GDBusSecurityFlags GDBusSecurityFlags;
+
+typedef struct GDBusArgInfo GDBusArgInfo;
+typedef struct GDBusMethodTable GDBusMethodTable;
+typedef struct GDBusSignalTable GDBusSignalTable;
+typedef struct GDBusPropertyTable GDBusPropertyTable;
+typedef struct GDBusSecurityTable GDBusSecurityTable;
+
 typedef void (* GDBusWatchFunction) (DBusConnection *connection,
 							void *user_data);
 
@@ -62,58 +73,58 @@ typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
 						gboolean interaction,
 						GDBusPendingReply pending);
 
-typedef enum {
+enum GDBusMethodFlags {
 	G_DBUS_METHOD_FLAG_DEPRECATED = (1 << 0),
 	G_DBUS_METHOD_FLAG_NOREPLY    = (1 << 1),
 	G_DBUS_METHOD_FLAG_ASYNC      = (1 << 2),
-} GDBusMethodFlags;
+};
 
-typedef enum {
+enum GDBusSignalFlags {
 	G_DBUS_SIGNAL_FLAG_DEPRECATED = (1 << 0),
-} GDBusSignalFlags;
+};
 
-typedef enum {
+enum GDBusPropertyFlags {
 	G_DBUS_PROPERTY_FLAG_DEPRECATED = (1 << 0),
-} GDBusPropertyFlags;
+};
 
-typedef enum {
+enum GDBusSecurityFlags {
 	G_DBUS_SECURITY_FLAG_DEPRECATED        = (1 << 0),
 	G_DBUS_SECURITY_FLAG_BUILTIN           = (1 << 1),
 	G_DBUS_SECURITY_FLAG_ALLOW_INTERACTION = (1 << 2),
-} GDBusSecurityFlags;
+};
 
-typedef struct {
+struct GDBusArgInfo {
 	const char *name;
 	const char *signature;
-} GDBusArgInfo;
+};
 
-typedef struct {
+struct GDBusMethodTable {
 	const char *name;
 	GDBusMethodFunction function;
 	GDBusMethodFlags flags;
 	unsigned int privilege;
 	const GDBusArgInfo *in_args;
 	const GDBusArgInfo *out_args;
-} GDBusMethodTable;
+};
 
-typedef struct {
+struct GDBusSignalTable {
 	const char *name;
 	GDBusSignalFlags flags;
 	const GDBusArgInfo *args;
-} GDBusSignalTable;
+};
 
-typedef struct {
+struct GDBusPropertyTable {
 	const char *name;
 	const char *type;
 	GDBusPropertyFlags flags;
-} GDBusPropertyTable;
+};
 
-typedef struct {
+struct GDBusSecurityTable {
 	unsigned int privilege;
 	const char *action;
 	GDBusSecurityFlags flags;
 	GDBusSecurityFunction function;
-} GDBusSecurityTable;
+};
 
 #define GDBUS_ARGS(args...) (const GDBusArgInfo[]) { args, { } }
 
-- 
1.7.11.5

