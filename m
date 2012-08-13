Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 7/8] dbusoob: Reply with error if SSP is not supported
Date: Mon, 13 Aug 2012 12:46:39 +0200
Message-ID: <1344854800-20972-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
References: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reply with org.bluez.Error.NotSupported if methods were called on
adapter without SSP enabled.

---
 plugins/dbusoob.c |    9 +++++++++
 src/adapter.c     |    5 +++++
 src/adapter.h     |    2 ++
 src/mgmt.c        |    7 +++++++
 src/mgmt.h        |    2 ++
 5 files changed, 25 insertions(+)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 0e0eeca..885f247 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -137,6 +137,9 @@ static DBusMessage *read_local_data(DBusConnection *conn, DBusMessage *msg,
 	struct btd_adapter *adapter = data;
 	struct oob_request *oob_request;
 
+	if (!btd_adapter_ssp_enabled(adapter))
+		return btd_error_not_supported(msg);
+
 	if (find_oob_request(adapter))
 		return btd_error_in_progress(msg);
 
@@ -258,6 +261,9 @@ static DBusMessage *add_remote_data(DBusConnection *conn, DBusMessage *msg,
 	struct oob_data remote_data;
 	struct btd_device *device;
 
+	if (!btd_adapter_ssp_enabled(adapter))
+		return btd_error_not_supported(msg);
+
 	memset(&remote_data, 0, sizeof(remote_data));
 
 	dbus_message_iter_init(msg, &args);
@@ -290,6 +296,9 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 	const char *addr;
 	bdaddr_t bdaddr;
 
+	if (!btd_adapter_ssp_enabled(adapter))
+		return btd_error_not_supported(msg);
+
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &addr,
 			DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
diff --git a/src/adapter.c b/src/adapter.c
index b7691d0..e6b5559 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3498,3 +3498,8 @@ int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 {
 	return mgmt_remove_remote_oob_data(adapter->dev_id, bdaddr);
 }
+
+int btd_adapter_ssp_enabled(struct btd_adapter *adapter)
+{
+	return mgmt_ssp_enabled(adapter->dev_id);
+}
diff --git a/src/adapter.h b/src/adapter.h
index d8a1bb1..5a0247e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -230,3 +230,5 @@ int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 
 int btd_adapter_gatt_server_start(struct btd_adapter *adapter);
 void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
+
+int btd_adapter_ssp_enabled(struct btd_adapter *adapter);
diff --git a/src/mgmt.c b/src/mgmt.c
index c893972..b3ae776 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -2474,3 +2474,10 @@ int mgmt_load_ltks(int index, GSList *keys)
 
 	return err;
 }
+
+int mgmt_ssp_enabled(int index)
+{
+	struct controller_info *info = &controllers[index];
+
+	return mgmt_ssp(info->current_settings);
+}
diff --git a/src/mgmt.h b/src/mgmt.h
index 0658198..95245d2 100644
--- a/src/mgmt.h
+++ b/src/mgmt.h
@@ -78,3 +78,5 @@ int mgmt_remove_remote_oob_data(int index, bdaddr_t *bdaddr);
 
 int mgmt_confirm_name(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean name_known);
+
+int mgmt_ssp_enabled(int index);
-- 
1.7.9.5

