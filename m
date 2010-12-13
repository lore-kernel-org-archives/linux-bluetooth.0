Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] attrib: use btd_error_failed()
Date: Mon, 13 Dec 2010 19:33:02 -0200
Message-Id: <1292275987-13799-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292275987-13799-5-git-send-email-padovan@profusion.mobi>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-3-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-4-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 0805492..8e96af4 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -457,11 +457,8 @@ static DBusMessage *register_watcher(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	if (l2cap_connect(prim->gatt, &gerr, TRUE) < 0) {
-		DBusMessage *reply;
-		reply = g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", gerr->message);
+		DBusMessage *reply = btd_error_failed(msg, gerr->message);
 		g_error_free(gerr);
-
 		return reply;
 	}
 
@@ -533,11 +530,8 @@ static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 	dbus_message_iter_get_fixed_array(&sub, &value, &len);
 
 	if (l2cap_connect(gatt, &gerr, FALSE) < 0) {
-		DBusMessage *reply;
-		reply = g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", gerr->message);
+		DBusMessage *reply = btd_error_failed(msg, gerr->message);
 		g_error_free(gerr);
-
 		return reply;
 	}
 
-- 
1.7.3.2

