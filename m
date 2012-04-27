Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 5/9] sap: Fix tab misuse
Date: Fri, 27 Apr 2012 10:36:48 -0400
Message-Id: <1335537412-26478-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/server.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index eaf9d86..945d599 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1265,7 +1265,7 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 		return message_failed(msg, "Client already disconnected");
 
 	if (disconnect_req(server->conn, SAP_DISCONNECTION_TYPE_GRACEFUL) < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE	".Failed",
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
 					"There is no active connection");
 
 	return dbus_message_new_method_return(msg);
-- 
1.7.5.4

