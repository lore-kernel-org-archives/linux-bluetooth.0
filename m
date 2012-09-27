Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 21/27] alert: Update Alert Status and Ringer Setting characteristic values
Date: Thu, 27 Sep 2012 14:36:30 -0400
Message-Id: <1348770996-12236-22-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now these characteristic values are updated when the agent changes any
PASP alert state or setting.
---
 profiles/alert/server.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 3b74ad8..bde9056 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -339,6 +339,27 @@ static void update_new_alert(gpointer data, gpointer user_data)
 								value[0], NULL);
 }
 
+static void update_phone_alerts(const char *category, const char *description)
+{
+	unsigned int i;
+
+	if (g_str_equal(category, "ringer")) {
+		if (g_str_equal(description, "enabled"))
+			ringer_setting = RINGER_NORMAL;
+		else if (g_str_equal(description, "disabled"))
+			ringer_setting = RINGER_SILENT;
+	}
+
+	for (i = 0; i < G_N_ELEMENTS(pasp_categories); i++) {
+		if (g_str_equal(pasp_categories[i], category)) {
+			if (g_str_equal(description, "active"))
+				alert_status |= (1 << i);
+			else if (g_str_equal(description, "not active"))
+				alert_status &= ~(1 << i);
+		}
+	}
+}
+
 static DBusMessage *new_alert(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -399,6 +420,9 @@ static DBusMessage *new_alert(DBusConnection *conn, DBusMessage *msg,
 		}
 	}
 
+	if (pasp_category(category))
+		update_phone_alerts(category, description);
+
 	DBG("NewAlert(\"%s\", %d, \"%s\")", category, count, description);
 
 	return dbus_message_new_method_return(msg);
-- 
1.7.9.5

