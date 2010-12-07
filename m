Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 2/5] Check if the remote LE is connectable when creating a device
Date: Tue,  7 Dec 2010 18:31:53 -0300
Message-Id: <1291757513-15261-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1291386532-4985-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1291386532-4985-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before issue Discover All Primary Service the advertising event type
needs to be evaluated to avoid connection attempts to non-connectable
devices. For non-connectable devices, CreateDevice creates the device
instance however no Services/UUIDs will be exposed.
---
 src/adapter.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b3270ce..102aad7 100644
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
@@ -1706,6 +1709,17 @@ static device_type_t flags2type(uint8_t flags)
 		return DEVICE_TYPE_DUALMODE;
 }
 
+static gboolean event_is_connectable(uint8_t type)
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
 static DBusMessage *create_device(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1741,6 +1755,20 @@ static DBusMessage *create_device(DBusConnection *conn,
 	if (!device)
 		return NULL;
 
+	if (type == DEVICE_TYPE_LE && !event_is_connectable(dev->evt_type)) {
+		/* Device is not connectable */
+		const char *path = device_get_path(device);
+		DBusMessage *reply;
+
+		reply = dbus_message_new_method_return(msg);
+
+		dbus_message_append_args(reply,
+					DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID);
+
+		return reply;
+	}
+
 	err = device_browse(device, conn, msg, NULL, FALSE);
 	if (err < 0)
 		return failed_strerror(msg, -err);
-- 
1.7.3.2

