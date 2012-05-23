Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 05/16] client: Add transfer event-reporting signals
Date: Wed, 23 May 2012 17:00:07 +0200
Message-Id: <1337785218-8661-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

These signals replace the old agent-based notification mechanism.
---
 client/transfer.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 2c6e1ed..09abe50 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -191,6 +191,8 @@ static const GDBusMethodTable obc_transfer_methods[] = {
 static const GDBusSignalTable obc_transfer_signals[] = {
 	{ GDBUS_SIGNAL("PropertyChanged",
 		GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ GDBUS_SIGNAL("Complete", NULL) },
+	{ GDBUS_SIGNAL("Error", GDBUS_ARGS({ "message", "s" })) },
 	{ }
 };
 
@@ -451,12 +453,20 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 
 	transfer->xfer = 0;
 
-	if (err)
-		goto done;
+	if (err == NULL) {
+		transfer->size = transfer->transferred;
 
-	transfer->size = transfer->transferred;
+		if (transfer->path != NULL)
+			g_dbus_emit_signal(transfer->conn, transfer->path,
+						TRANSFER_INTERFACE, "Complete",
+						DBUS_TYPE_INVALID);
+	} else if (transfer->path != NULL)
+		g_dbus_emit_signal(transfer->conn, transfer->path,
+						TRANSFER_INTERFACE, "Error",
+						DBUS_TYPE_STRING,
+						&err->message,
+						DBUS_TYPE_INVALID);
 
-done:
 	if (callback)
 		callback->func(transfer, transfer->size, err, callback->data);
 }
-- 
1.7.7.6

