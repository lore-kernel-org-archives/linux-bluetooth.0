Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] client: Update read callbacks with invalid offset error handlers
Date: Fri,  9 Mar 2018 16:29:07 +0100
Message-Id: <20180309152907.16347-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180309152907.16347-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180309152907.16347-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds invalid offset handlers to read callbacks of attributes.
---
 client/gatt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 7a6035ac1..4eff38af6 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1473,6 +1473,10 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 
 	parse_offset(&iter, &offset);
 
+	if (offset >= chrc->value_len)
+		return g_dbus_create_error(msg, "org.bluez.Error.InvalidOffset",
+									NULL);
+
 	return read_value(msg, &chrc->value[offset], chrc->value_len - offset);
 }
 
@@ -1831,6 +1835,10 @@ static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
 
 	parse_offset(&iter, &offset);
 
+	if (offset >= desc->value_len)
+		return g_dbus_create_error(msg, "org.bluez.Error.InvalidOffset",
+									NULL);
+
 	return read_value(msg, &desc->value[offset], desc->value_len - offset);
 }
 
-- 
2.13.6

