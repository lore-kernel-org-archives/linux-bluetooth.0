Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/2] client: Fix not using connection passed to obc_transfer_register
Date: Thu,  7 Jun 2012 11:31:12 +0300
Message-Id: <1339057873-7874-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make use of the connection parameter instead of assuming the connection
will always be to the session bus.
---
 client/transfer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/transfer.c b/client/transfer.c
index 000a510..be61f40 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -309,7 +309,7 @@ gboolean obc_transfer_register(struct obc_transfer *transfer,
 	transfer->path = g_strdup_printf("%s/transfer%ju",
 			TRANSFER_BASEPATH, counter++);
 
-	transfer->conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	transfer->conn = dbus_connection_ref(conn);
 	if (transfer->conn == NULL) {
 		g_set_error(err, OBC_TRANSFER_ERROR, -EFAULT,
 						"Unable to connect to D-Bus");
-- 
1.7.10.2

