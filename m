Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 05/14] client: Add transfer event-reporting signals
Date: Wed, 30 May 2012 17:50:14 +0200
Message-Id: <1338393023-29941-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

These signals replace the old agent-based notification mechanism.
---
 client/transfer.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 3cc96a7..6bf6591 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -196,6 +196,9 @@ static const GDBusMethodTable obc_transfer_methods[] = {
 static const GDBusSignalTable obc_transfer_signals[] = {
 	{ GDBUS_SIGNAL("PropertyChanged",
 		GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ GDBUS_SIGNAL("Complete", NULL) },
+	{ GDBUS_SIGNAL("Error",
+		GDBUS_ARGS({ "code", "s" }, { "message", "s" })) },
 	{ }
 };
 
@@ -437,12 +440,27 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 		transfer->progress_id = 0;
 	}
 
-	if (err)
-		goto done;
-
-	transfer->size = transfer->transferred;
+	if (err == NULL) {
+		transfer->size = transfer->transferred;
+
+		if (transfer->path != NULL)
+			g_dbus_emit_signal(transfer->conn, transfer->path,
+						TRANSFER_INTERFACE, "Complete",
+						DBUS_TYPE_INVALID);
+	} else if (transfer->path != NULL) {
+		char *code = g_strdup_printf("%d", err->code);
+
+		g_dbus_emit_signal(transfer->conn, transfer->path,
+						TRANSFER_INTERFACE, "Error",
+						DBUS_TYPE_STRING,
+						&code,
+						DBUS_TYPE_STRING,
+						&err->message,
+						DBUS_TYPE_INVALID);
+
+		g_free(code);
+	}
 
-done:
 	if (callback)
 		callback->func(transfer, transfer->size, err, callback->data);
 }
-- 
1.7.7.6

