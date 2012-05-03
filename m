Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 05/13] gdbus: add argument info to methods and signals
Date: Thu,  3 May 2012 09:28:54 -0300
Message-Id: <1336048142-1194-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index a0583e6..610cb19 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -85,16 +85,26 @@ typedef enum {
 typedef struct {
 	const char *name;
 	const char *signature;
+} GDBusArgInfo;
+
+#define GDBUS_ARGS_INFO(args...) (const GDBusArgInfo[]) { args, { } }
+
+typedef struct {
+	const char *name;
+	const char *signature;
 	const char *reply;
 	GDBusMethodFunction function;
 	GDBusMethodFlags flags;
 	unsigned int privilege;
+	const GDBusArgInfo *in_args;
+	const GDBusArgInfo *out_args;
 } GDBusMethodTable;
 
 typedef struct {
 	const char *name;
 	const char *signature;
 	GDBusSignalFlags flags;
+	const GDBusArgInfo *args;
 } GDBusSignalTable;
 
 typedef struct {
-- 
1.7.10

