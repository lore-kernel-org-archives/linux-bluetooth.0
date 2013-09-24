Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] obexd: Fix emitting Type property changed signals for messages
Date: Tue, 24 Sep 2013 13:27:08 +0200
Message-Id: <1380022028-31031-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

In order to determine if the message Type property has changed,
the stored type needs to be compared with the parsed type and not with
the raw value received from the MSE.

This fixes the issue that the property changed signal for the Type
property is emitted for every message on every ListMessage call.
---
 obexd/client/map.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 9fe872d..d349ef7 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -920,21 +920,22 @@ static void parse_recipient_address(struct map_msg *msg, const char *value)
 
 static void parse_type(struct map_msg *msg, const char *value)
 {
-	if (g_strcmp0(msg->type, value) == 0)
-		return;
-
-	g_free(msg->type);
+	const char *type = NULL;
 
 	if (strcasecmp(value, "SMS_GSM") == 0)
-		msg->type = g_strdup("sms-gsm");
+		type = "sms-gsm";
 	else if (strcasecmp(value, "SMS_CDMA") == 0)
-		msg->type = g_strdup("sms-cdma");
+		type = "sms-cdma";
 	else if (strcasecmp(value, "EMAIL") == 0)
-		msg->type = g_strdup("email");
+		type = "email";
 	else if (strcasecmp(value, "MMS") == 0)
-		msg->type = g_strdup("mms");
-	else
-		msg->type = NULL;
+		type = "mms";
+
+	if (g_strcmp0(msg->type, type) == 0)
+		return;
+
+	g_free(msg->type);
+	msg->type = g_strdup(type);
 
 	g_dbus_emit_property_changed(conn, msg->path,
 						MAP_MSG_INTERFACE, "Type");
-- 
1.8.3.4

