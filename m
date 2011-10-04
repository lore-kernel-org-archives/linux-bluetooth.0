Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] Emit LinkLossAlertLevel after writing the alert
Date: Tue,  4 Oct 2011 14:22:43 -0300
Message-Id: <1317748963-13176-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317748963-13176-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317748963-13176-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/monitor.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index d40d376..29ae425 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -142,6 +142,10 @@ static uint8_t str2level(const char *level)
 static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
+	struct monitor *monitor = user_data;
+	struct btd_device *device = monitor->device;
+	const char *path = device_get_path(device);
+
 	if (status != 0) {
 		error("Link Loss Write Request failed: %s",
 							att_ecode2str(status));
@@ -154,6 +158,10 @@ static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	DBG("Link Loss Alert Level written");
+
+	emit_property_changed(monitor->conn, path,
+				PROXIMITY_INTERFACE, "LinkLossAlertLevel",
+				DBUS_TYPE_STRING, &monitor->linklosslevel);
 }
 
 static void char_discovered_cb(GSList *characteristics, guint8 status,
@@ -175,7 +183,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	monitor->linklosshandle = chr->value_handle;
 
 	gatt_write_char(monitor->attrib, monitor->linklosshandle, &value, 1,
-						linkloss_written, NULL);
+						linkloss_written, monitor);
 }
 
 static int write_alert_level(struct monitor *monitor)
@@ -187,7 +195,7 @@ static int write_alert_level(struct monitor *monitor)
 		uint8_t value = str2level(monitor->linklosslevel);
 
 		gatt_write_char(monitor->attrib, monitor->linklosshandle,
-					&value, 1, linkloss_written, NULL);
+					&value, 1, linkloss_written, monitor);
 		return 0;
 	}
 
@@ -397,7 +405,6 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 {
 	struct monitor *monitor = data;
 	struct btd_device *device = monitor->device;
-	const char *path = device_get_path(device);
 	bdaddr_t sba, dba;
 
 	if (!level_is_valid(level))
@@ -414,10 +421,6 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 
 	write_proximity_config(&sba, &dba, "LinkLossAlertLevel", level);
 
-	emit_property_changed(conn, path,
-				PROXIMITY_INTERFACE, "LinkLossAlertLevel",
-				DBUS_TYPE_STRING, &monitor->linklosslevel);
-
 	if (monitor->attrib)
 		write_alert_level(monitor);
 
-- 
1.7.7

