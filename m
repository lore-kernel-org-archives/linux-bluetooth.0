Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 03/11] Remove leftover D-Bus message in gatt_service
Date: Tue, 12 Jul 2011 17:28:33 -0300
Message-Id: <1310502521-462-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index f7c78d3..93d0da7 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -58,7 +58,6 @@ struct gatt_service {
 	DBusConnection *conn;
 	GSList *primary;
 	GAttrib *attrib;
-	DBusMessage *msg;
 	int psm;
 	gboolean listen;
 };
@@ -343,12 +342,6 @@ static void connect_cb(GIOChannel *chan, GError *gerr, gpointer user_data)
 	struct gatt_service *gatt = user_data;
 
 	if (gerr) {
-		if (gatt->msg) {
-			DBusMessage *reply = btd_error_failed(gatt->msg,
-							gerr->message);
-			g_dbus_send_message(gatt->conn, reply);
-		}
-
 		error("%s", gerr->message);
 		goto fail;
 	}
-- 
1.7.6

