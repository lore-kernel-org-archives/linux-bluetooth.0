Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/2] client: Use session path as prefix for transfer path
Date: Thu,  7 Jun 2012 11:31:13 +0300
Message-Id: <1339057873-7874-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339057873-7874-1-git-send-email-luiz.dentz@gmail.com>
References: <1339057873-7874-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This should make it easier to identify to which session the transfer
belongs.
---
 client/session.c  |    4 ++--
 client/transfer.c |    5 ++---
 client/transfer.h |    1 +
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/client/session.c b/client/session.c
index 7014396..7f88a6a 100644
--- a/client/session.c
+++ b/client/session.c
@@ -656,8 +656,8 @@ guint obc_session_queue(struct obc_session *session,
 		return 0;
 	}
 
-	if (!obc_transfer_register(transfer, session->conn, session->owner,
-									err)) {
+	if (!obc_transfer_register(transfer, session->conn, session->path,
+							session->owner, err)) {
 		obc_transfer_unregister(transfer);
 		return 0;
 	}
diff --git a/client/transfer.c b/client/transfer.c
index be61f40..1e7cb46 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -44,7 +44,6 @@
 #include "transfer.h"
 
 #define TRANSFER_INTERFACE "org.bluez.obex.Transfer"
-#define TRANSFER_BASEPATH "/org/bluez/obex"
 
 #define OBC_TRANSFER_ERROR obc_transfer_error_quark()
 
@@ -301,13 +300,13 @@ static struct obc_transfer *obc_transfer_create(guint8 op,
 
 gboolean obc_transfer_register(struct obc_transfer *transfer,
 						DBusConnection *conn,
+						const char *path,
 						const char *owner,
 						GError **err)
 {
 	transfer->owner = g_strdup(owner);
 
-	transfer->path = g_strdup_printf("%s/transfer%ju",
-			TRANSFER_BASEPATH, counter++);
+	transfer->path = g_strdup_printf("%s/transfer%ju", path, counter++);
 
 	transfer->conn = dbus_connection_ref(conn);
 	if (transfer->conn == NULL) {
diff --git a/client/transfer.h b/client/transfer.h
index 071b6d3..968903a 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -36,6 +36,7 @@ struct obc_transfer *obc_transfer_put(const char *type, const char *name,
 
 gboolean obc_transfer_register(struct obc_transfer *transfer,
 					DBusConnection *conn,
+					const char *path,
 					const char *owner,
 					GError **err);
 
-- 
1.7.10.2

