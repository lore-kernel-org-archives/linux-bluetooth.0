Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] client: Add missing duplicated string free
Date: Wed,  9 May 2018 13:05:49 +0200
Message-Id: <20180509110553.28989-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch free duplicated strings in read, write attribute callbacks.
---
 client/gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index d59d1ba1e..c8267a75f 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1598,6 +1598,7 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 
 		bt_shell_prompt_input("gatt", str, authorize_read_response,
 									aad);
+		g_free(str);
 
 		pending_message = dbus_message_ref(msg);
 
@@ -1700,6 +1701,7 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 
 		bt_shell_prompt_input("gatt", str, authorize_write_response,
 									aad);
+		g_free(str);
 
 		pending_message = dbus_message_ref(msg);
 
-- 
2.13.6

