Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Christian Fetzer <christian.fetzer@bmw-carit.de>
Subject: [PATCH 5/8] obexd: Fix segfault in parse_filter_read and parse_filter_priority
Date: Fri, 11 Jan 2013 16:55:54 +0100
Message-Id: <1357919757-10334-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Calls to ListMessages with filter 'Read' or 'Priority' caused a segfault
in parse_filter_read / parse_filter_priority. The functions read
D-Bus boolean values (uint32) into uint8.

0  0x00007ffff730332d in ?? () from /usr/lib/libdbus-1.so.3
1  0x00007ffff7304219 in dbus_message_iter_next () from /usr/lib/libdbus-1.so.3
2  0x000000000043ef0f in parse_message_filters (
    apparam=<error reading variable: Cannot access memory at address 0x7ffffeffff08>,
    iter=<error reading variable: Cannot access memory at address 0x7ffffeffff00>)
    at obexd/client/map.c:1246
---
 obexd/client/map.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index cea9369..57ce1e6 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1163,13 +1163,14 @@ static GObexApparam *parse_filter_read(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
 	guint8 status = 0;
+	dbus_bool_t dbus_status = FALSE;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
 		return NULL;
 
-	dbus_message_iter_get_basic(iter, &status);
+	dbus_message_iter_get_basic(iter, &dbus_status);
 
-	status = (status) ? 0x01 : 0x02;
+	status = (dbus_status) ? 0x01 : 0x02;
 
 	return g_obex_apparam_set_uint8(apparam, MAP_AP_FILTERREADSTATUS,
 								status);
@@ -1207,13 +1208,14 @@ static GObexApparam *parse_filter_priority(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
 	guint8 priority;
+	dbus_bool_t dbus_priority = FALSE;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
 		return NULL;
 
-	dbus_message_iter_get_basic(iter, &priority);
+	dbus_message_iter_get_basic(iter, &dbus_priority);
 
-	priority = (priority) ? 0x01 : 0x02;
+	priority = (dbus_priority) ? 0x01 : 0x02;
 
 	return g_obex_apparam_set_uint8(apparam, MAP_AP_FILTERPRIORITY,
 								priority);
-- 
1.8.1

