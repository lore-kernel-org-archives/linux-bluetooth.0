Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] dbusoob: Set device class in device object
Date: Thu, 15 Nov 2012 18:31:40 +0100
Message-Id: <1353000701-16605-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/dbusoob.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index b59ffa8..e58b353 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -191,7 +191,9 @@ static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
 	return TRUE;
 }
 
-static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
+static gboolean store_data(struct btd_adapter *adapter,
+				struct btd_device *device,
+				struct oob_data *data)
 {
 	bdaddr_t bdaddr;
 
@@ -204,8 +206,7 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 	}
 
 	if (data->class)
-		write_remote_class(adapter_get_address(adapter), &bdaddr,
-								data->class);
+		device_set_class(device, data->class);
 
 	if (data->name)
 		btd_event_remote_name(adapter_get_address(adapter), &bdaddr,
@@ -255,7 +256,7 @@ static DBusMessage *add_remote_data(DBusConnection *conn, DBusMessage *msg,
 	if (!parse_data(&data, &remote_data))
 		return btd_error_invalid_args(msg);
 
-	if (!store_data(adapter, &remote_data))
+	if (!store_data(adapter, device, &remote_data))
 		return btd_error_failed(msg, "Request failed");
 
 	reply = dbus_message_new_method_return(msg);
-- 
1.7.9.5

