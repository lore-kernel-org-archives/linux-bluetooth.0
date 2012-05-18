Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH RESEND BlueZ v6 03/13] gdbus: add argument info to methods and signals
Date: Fri, 18 May 2012 00:23:27 -0300
Message-Id: <1337311417-1245-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337311417-1245-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337311417-1245-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index a0583e6..e5e7938 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -85,16 +85,24 @@ typedef enum {
 typedef struct {
 	const char *name;
 	const char *signature;
+} GDBusArgInfo;
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
1.7.10.2

