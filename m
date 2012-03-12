Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] input: Remove unneeded alias
Date: Mon, 12 Mar 2012 17:05:27 -0300
Message-Id: <1331582727-924-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1331582727-924-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1331582727-924-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/device.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/input/device.c b/input/device.c
index e4e0b21..743699f 100644
--- a/input/device.c
+++ b/input/device.c
@@ -68,7 +68,6 @@ struct input_conn {
 	struct fake_input	*fake;
 	DBusMessage		*pending_connect;
 	char			*uuid;
-	char			*alias;
 	GIOChannel		*ctrl_io;
 	GIOChannel		*intr_io;
 	guint			ctrl_watch;
@@ -110,9 +109,6 @@ static struct input_conn *find_connection(GSList *list, const char *pattern)
 
 		if (!strcasecmp(iconn->uuid, pattern))
 			return iconn;
-
-		if (!strcasecmp(iconn->alias, pattern))
-			return iconn;
 	}
 
 	return NULL;
@@ -136,7 +132,6 @@ static void input_conn_free(struct input_conn *iconn)
 		g_io_channel_unref(iconn->ctrl_io);
 
 	g_free(iconn->uuid);
-	g_free(iconn->alias);
 	g_free(iconn->fake);
 	g_free(iconn);
 }
@@ -915,7 +910,7 @@ static DBusMessage *input_device_connect(DBusConnection *conn,
 	DBusMessage *reply;
 	GError *err = NULL;
 
-	iconn = find_connection(idev->connections, "HID");
+	iconn = find_connection(idev->connections, HID_UUID);
 	if (!iconn)
 		return btd_error_not_supported(msg);
 
@@ -1068,15 +1063,13 @@ static struct input_device *input_device_new(DBusConnection *conn,
 }
 
 static struct input_conn *input_conn_new(struct input_device *idev,
-					const char *uuid, const char *alias,
-					int timeout)
+					const char *uuid, int timeout)
 {
 	struct input_conn *iconn;
 
 	iconn = g_new0(struct input_conn, 1);
 	iconn->timeout = timeout;
 	iconn->uuid = g_strdup(uuid);
-	iconn->alias = g_strdup(alias);
 	iconn->idev = idev;
 
 	return iconn;
@@ -1097,7 +1090,7 @@ int input_device_register(DBusConnection *conn, struct btd_device *device,
 		devices = g_slist_append(devices, idev);
 	}
 
-	iconn = input_conn_new(idev, uuid, "hid", timeout);
+	iconn = input_conn_new(idev, uuid, timeout);
 	if (!iconn)
 		return -EINVAL;
 
@@ -1120,7 +1113,7 @@ int fake_input_register(DBusConnection *conn, struct btd_device *device,
 		devices = g_slist_append(devices, idev);
 	}
 
-	iconn = input_conn_new(idev, uuid, "hsp", 0);
+	iconn = input_conn_new(idev, uuid, 0);
 	if (!iconn)
 		return -EINVAL;
 
@@ -1212,7 +1205,7 @@ int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 	if (!idev)
 		return -ENOENT;
 
-	iconn = find_connection(idev->connections, "hid");
+	iconn = find_connection(idev->connections, HID_UUID);
 	if (!iconn)
 		return -ENOENT;
 
@@ -1243,7 +1236,7 @@ int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst)
 	if (!idev)
 		return -ENOENT;
 
-	iconn = find_connection(idev->connections, "hid");
+	iconn = find_connection(idev->connections, HID_UUID);
 	if (!iconn)
 		return -ENOENT;
 
-- 
1.7.8.5

