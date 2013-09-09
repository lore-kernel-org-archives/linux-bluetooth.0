Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] obexd: Use documented values in org.bluez.obex.Message1 Type property
Date: Mon,  9 Sep 2013 18:30:57 +0200
Message-Id: <1378744257-648-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This updates the values that are presented in the Type property to use
the values from the documentation ("email", "sms-gsm", "sms-cdma", "mms").
The existing code directly used the values as received in the messages
listing object ("EMAIL", "SMS_GSM", "SMS_CDMA", "MMS").
---
 obexd/client/map.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index f0dcf72..95f0334 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -894,7 +894,17 @@ static void parse_type(struct map_msg *msg, const char *value)
 		return;
 
 	g_free(msg->type);
-	msg->type = g_strdup(value);
+
+	if (strcasecmp(value, "SMS_GSM") == 0)
+		msg->type = g_strdup("sms-gsm");
+	else if (strcasecmp(value, "SMS_CDMA") == 0)
+		msg->type = g_strdup("sms-cdma");
+	else if (strcasecmp(value, "EMAIL") == 0)
+		msg->type = g_strdup("email");
+	else if (strcasecmp(value, "MMS") == 0)
+		msg->type = g_strdup("mms");
+	else
+		msg->type = NULL;
 
 	g_dbus_emit_property_changed(conn, msg->path,
 						MAP_MSG_INTERFACE, "Type");
-- 
1.8.3.4

