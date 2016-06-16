Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tobias Svehagen <tobias.svehagen@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tobias Svehagen <tobias.svehagen@gmail.com>
Subject: [PATCH BlueZ 2/2] tools/gatt-service: Do not call parse_options on reply message
Date: Thu, 16 Jun 2016 15:29:13 +0200
Message-Id: <20160616132913.13138-3-tobias.svehagen@gmail.com>
In-Reply-To: <20160616132913.13138-1-tobias.svehagen@gmail.com>
References: <20160616132913.13138-1-tobias.svehagen@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A call to dbus_message_iter_get_arg_type will cause an assertion
since it is called on the wrong type of iterator.
---
 tools/gatt-service.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 1cf8b3c..6bd5576 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -515,10 +515,6 @@ static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
 
 	dbus_message_iter_init_append(reply, &iter);
 
-	if (parse_options(&iter, &device))
-		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
-							"Invalid arguments");
-
 	desc_read(desc, &iter);
 
 	return reply;
-- 
2.8.3

