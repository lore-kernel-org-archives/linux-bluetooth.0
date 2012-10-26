Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 3/5] dbusoob: Set device name in device object
Date: Fri, 26 Oct 2012 11:25:03 +0200
Message-Id: <1351243505-20702-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351243505-20702-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351243505-20702-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/dbusoob.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 5c5b6ef..82cd304 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -191,9 +191,11 @@ static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
 	return TRUE;
 }
 
-static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
+static gboolean store_data(struct btd_adapter *adapter, const char *address,
+				struct oob_data *data)
 {
 	bdaddr_t bdaddr;
+	struct btd_device *device;
 
 	str2ba(data->addr, &bdaddr);
 
@@ -203,13 +205,14 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 			return FALSE;
 	}
 
+	device = adapter_get_device(adapter, address);
+
 	if (data->class)
 		write_remote_class(adapter_get_address(adapter), &bdaddr,
 								data->class);
 
 	if (data->name)
-		write_device_name(adapter_get_address(adapter), &bdaddr, 0,
-								data->name);
+		device_set_name(device, data->name);
 
 	return TRUE;
 }
@@ -245,7 +248,7 @@ static DBusMessage *add_remote_data(DBusConnection *conn, DBusMessage *msg,
 	if (!parse_data(&data, &remote_data))
 		return btd_error_invalid_args(msg);
 
-	if (!store_data(adapter, &remote_data))
+	if (!store_data(adapter, remote_data.addr, &remote_data))
 		return btd_error_failed(msg, "Request failed");
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-- 
1.7.9.5

