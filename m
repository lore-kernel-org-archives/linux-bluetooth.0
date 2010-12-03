Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/5] Check if the remote LE is connectable when creating a device
Date: Fri,  3 Dec 2010 11:28:49 -0300
Message-Id: <1291386532-4985-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before issue Discover All Primary Service the advertising event type
needs to be evaluated to avoid connection attempts to non-connectable
devices. For non-connectable devices CreateDevice the remote object
instance is created however no Services/UUIDs will be exposed.
---
 src/adapter.c |   29 ++++++++++++++++++++++++++++-
 src/adapter.h |    2 +-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4d21d95..04ffd2b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -56,6 +56,9 @@
 #include "agent.h"
 #include "storage.h"
 
+#define ADV_TYPE_IND		0x00
+#define ADV_TYPE_DIRECT_IND	0x01
+
 #define IO_CAPABILITY_DISPLAYONLY	0x00
 #define IO_CAPABILITY_DISPLAYYESNO	0x01
 #define IO_CAPABILITY_KEYBOARDONLY	0x02
@@ -1734,6 +1737,19 @@ static DBusMessage *create_device(DBusConnection *conn,
 	if (!device)
 		return NULL;
 
+	if (type == LE_TYPE && !dev->connectable) {
+		/* Device is not connectable */
+		const char *path = device_get_path(device);
+		DBusMessage *reply;
+
+		reply = dbus_message_new_method_return(msg);
+
+		dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID);
+
+		return reply;
+	}
+
 	err = device_browse(device, conn, msg, NULL, FALSE);
 	if (err < 0)
 		return failed_strerror(msg, -err);
@@ -3082,6 +3098,17 @@ static gboolean extract_eir_flags(uint8_t *flags, uint8_t *eir_data)
 	return TRUE;
 }
 
+static gboolean connectable_event(uint8_t type)
+{
+	switch (type) {
+	case ADV_TYPE_IND:
+	case ADV_TYPE_DIRECT_IND:
+		return TRUE;
+	default:
+		return FALSE;
+	}
+}
+
 void adapter_update_device_from_info(struct btd_adapter *adapter,
 						le_advertising_info *info)
 {
@@ -3097,8 +3124,8 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 
 	if (new_dev) {
 		dev->le = TRUE;
-		dev->evt_type = info->evt_type;
 		dev->type = LE_TYPE;
+		dev->connectable = connectable_event(info->evt_type);
 	} else if (dev->rssi == rssi)
 		return;
 
diff --git a/src/adapter.h b/src/adapter.h
index feeb9c9..2c09546 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -74,7 +74,7 @@ struct remote_dev_info {
 	char **uuids;
 	size_t uuid_count;
 	GSList *services;
-	uint8_t evt_type;
+	gboolean connectable;
 	uint8_t bdaddr_type;
 };
 
-- 
1.7.3.2

