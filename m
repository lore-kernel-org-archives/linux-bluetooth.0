Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 03/11] gdbus: add argument info to methods and signals
Date: Wed, 23 May 2012 10:20:00 -0300
Message-Id: <1337779208-3555-4-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
References: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

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
1.7.9.5

