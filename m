Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] Fix wrong write GATT-subprocedure for Link Loss
Date: Tue,  4 Oct 2011 14:22:42 -0300
Message-Id: <1317748963-13176-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Link Loss Service specification, Write Characteristic
Value sub-procedure should be used to change the Alert Level.
---
 proximity/monitor.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 884e66d..d40d376 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -139,6 +139,23 @@ static uint8_t str2level(const char *level)
 	return ALERT_NONE;
 }
 
+static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	if (status != 0) {
+		error("Link Loss Write Request failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_write_resp(pdu, plen)) {
+		error("Link Loss Write Request: protocol error");
+		return;
+	}
+
+	DBG("Link Loss Alert Level written");
+}
+
 static void char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
@@ -157,8 +174,8 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	chr = characteristics->data;
 	monitor->linklosshandle = chr->value_handle;
 
-	gatt_write_cmd(monitor->attrib, monitor->linklosshandle, &value, 1,
-								NULL, NULL);
+	gatt_write_char(monitor->attrib, monitor->linklosshandle, &value, 1,
+						linkloss_written, NULL);
 }
 
 static int write_alert_level(struct monitor *monitor)
@@ -169,8 +186,8 @@ static int write_alert_level(struct monitor *monitor)
 	if (monitor->linklosshandle) {
 		uint8_t value = str2level(monitor->linklosslevel);
 
-		gatt_write_cmd(monitor->attrib, monitor->linklosshandle,
-							&value, 1, NULL, NULL);
+		gatt_write_char(monitor->attrib, monitor->linklosshandle,
+					&value, 1, linkloss_written, NULL);
 		return 0;
 	}
 
-- 
1.7.7

