Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Christian Fetzer <christian.fetzer@bmw-carit.de>
Subject: [PATCH 6/8] obexd: Use defines for values in parse_filter_read parse_filter_priority
Date: Fri, 11 Jan 2013 16:55:55 +0100
Message-Id: <1357919757-10334-7-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 obexd/client/map.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 57ce1e6..3e4cde9 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -77,6 +77,14 @@ static const char * const filter_list[] = {
 #define FILTER_BIT_MAX	15
 #define FILTER_ALL	0x0000FFFF
 
+#define FILTER_READ_STATUS_NONE		0
+#define FILTER_READ_STATUS_ONLY_UNREAD	1
+#define FILTER_READ_STATUS_ONLY_READ	2
+
+#define FILTER_PRIORITY_NONE		0
+#define FILTER_PRIORITY_ONLY_HIGH	1
+#define FILTER_PRIORITY_ONLY_NONHIGH	2
+
 #define STATUS_READ 0
 #define STATUS_DELETE 1
 #define FILLER_BYTE 0x30
@@ -1162,7 +1170,7 @@ static GObexApparam *parse_period_end(GObexApparam *apparam,
 static GObexApparam *parse_filter_read(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
-	guint8 status = 0;
+	guint8 status = FILTER_READ_STATUS_NONE;
 	dbus_bool_t dbus_status = FALSE;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
@@ -1170,7 +1178,10 @@ static GObexApparam *parse_filter_read(GObexApparam *apparam,
 
 	dbus_message_iter_get_basic(iter, &dbus_status);
 
-	status = (dbus_status) ? 0x01 : 0x02;
+	if (dbus_status)
+		status = FILTER_READ_STATUS_ONLY_UNREAD;
+	else
+		status = FILTER_READ_STATUS_ONLY_READ;
 
 	return g_obex_apparam_set_uint8(apparam, MAP_AP_FILTERREADSTATUS,
 								status);
@@ -1207,7 +1218,7 @@ static GObexApparam *parse_filter_sender(GObexApparam *apparam,
 static GObexApparam *parse_filter_priority(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
-	guint8 priority;
+	guint8 priority = FILTER_PRIORITY_NONE;
 	dbus_bool_t dbus_priority = FALSE;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
@@ -1215,7 +1226,10 @@ static GObexApparam *parse_filter_priority(GObexApparam *apparam,
 
 	dbus_message_iter_get_basic(iter, &dbus_priority);
 
-	priority = (dbus_priority) ? 0x01 : 0x02;
+	if (dbus_priority)
+		priority = FILTER_PRIORITY_ONLY_HIGH;
+	else
+		priority = FILTER_PRIORITY_ONLY_NONHIGH;
 
 	return g_obex_apparam_set_uint8(apparam, MAP_AP_FILTERPRIORITY,
 								priority);
-- 
1.8.1

