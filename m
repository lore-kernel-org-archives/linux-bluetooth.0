Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH RFC BlueZ 4/5] Add support for sending notifications for current time
Date: Fri,  2 Dec 2011 14:34:09 -0400
Message-Id: <1322850850-18019-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Now, we are able to send notifications when the time gets updated,
this should occur when, for example, the user changes the system's
timezone.
---
 time/server.c |  117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 time/server.h |    2 +
 2 files changed, 118 insertions(+), 1 deletions(-)

diff --git a/time/server.c b/time/server.c
index 56eecb1..df70d2f 100644
--- a/time/server.c
+++ b/time/server.c
@@ -29,10 +29,17 @@
 #include <glib.h>
 #include <time.h>
 #include <errno.h>
+#include <stdlib.h>
 #include <bluetooth/uuid.h>
 
+#include "adapter.h"
+#include "manager.h"
+
 #include "att.h"
 #include "gattrib.h"
+#include "attio.h"
+#include "textfile.h"
+#include "storage.h"
 #include "attrib-server.h"
 #include "gatt-service.h"
 #include "log.h"
@@ -46,6 +53,21 @@
 #define TIME_UPDATE_STAT_CHR_UUID	0x2A17
 #define CT_TIME_CHR_UUID		0x2A2B
 
+struct adapter_ccc {
+	struct btd_adapter *adapter;
+	uint16_t handle;
+};
+
+struct notify_callback {
+	struct btd_device *device;
+	guint id;
+};
+
+static GSList *devices_notify;
+
+static uint16_t current_time_ccc_handle;
+static uint16_t current_time_value_handle;
+
 static int encode_current_time(uint8_t value[10])
 {
 	struct timespec tp;
@@ -92,6 +114,94 @@ static uint8_t current_time_read(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
+static void filter_devices_notify(char *key, char *value, void *user_data)
+{
+	struct adapter_ccc *ccc = user_data;
+	struct btd_adapter *adapter = ccc->adapter;
+	struct btd_device *device;
+	char addr[18];
+	uint16_t handle, ccc_val;
+
+	sscanf(key, "%17s#%04hX", addr, &handle);
+
+	if (ccc->handle != handle)
+		return;
+
+	ccc_val = strtol(value, NULL, 16);
+	if (!(ccc_val & 0x0001))
+		return;
+
+	device = adapter_find_device(adapter, addr);
+	if (device == NULL)
+		return;
+
+	if (g_slist_find(devices_notify, device))
+		return;
+
+	devices_notify = g_slist_append(devices_notify, device);
+}
+
+static GSList *devices_to_notify(struct btd_adapter *adapter, uint16_t ccc_hnd)
+{
+	struct adapter_ccc ccc_list = { adapter, ccc_hnd };
+	char filename[PATH_MAX + 1];
+	char srcaddr[18];
+	bdaddr_t src;
+
+	adapter_get_address(adapter, &src);
+	ba2str(&src, srcaddr);
+
+	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "ccc");
+
+	textfile_foreach(filename, filter_devices_notify, &ccc_list);
+
+	return devices_notify;
+}
+
+static void send_notification(GAttrib *attrib, gpointer user_data)
+{
+	struct notify_callback *callback = user_data;
+	uint8_t value[10], pdu[ATT_MAX_MTU];
+	int err, len;
+
+	err = encode_current_time(value);
+	if (err)
+		goto done;
+
+	len = enc_notification(current_time_value_handle, value, sizeof(value),
+							pdu, sizeof(pdu));
+	g_attrib_send(attrib, 0, ATT_OP_HANDLE_NOTIFY, pdu, len,
+							NULL, NULL, NULL);
+
+done:
+	btd_device_remove_attio_callback(callback->device, callback->id);
+	devices_notify = g_slist_remove(devices_notify, callback->device);
+	g_free(callback);
+}
+
+void current_time_updated(void)
+{
+	struct btd_adapter *adapter;
+	GSList *devices, *l;
+
+	adapter = manager_get_default_adapter();
+	if (adapter == NULL)
+		return;
+
+	devices = devices_to_notify(adapter, current_time_ccc_handle);
+
+	for (l = devices; l; l = l->next) {
+		struct btd_device *device = l->data;
+		struct notify_callback *callback;
+
+		callback = g_new0(struct notify_callback, 1);
+		callback->device = device;
+
+		callback->id = btd_device_add_attio_callback(device,
+					send_notification, NULL, callback);
+	}
+}
+
 static uint8_t local_time_info_read(struct attribute *a, gpointer user_data)
 {
 	uint8_t value[2];
@@ -123,7 +233,10 @@ static void register_current_time_service(void)
 							ATT_CHAR_PROPER_NOTIFY,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 							current_time_read,
-
+				GATT_OPT_CCC_GET_HANDLE,
+						&current_time_ccc_handle,
+				GATT_OPT_CHR_VALUE_GET_HANDLE,
+						&current_time_value_handle,
 				/* Local Time Information characteristic */
 				GATT_OPT_CHR_UUID, LOCAL_TIME_INFO_CHR_UUID,
 				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
@@ -193,4 +306,6 @@ int time_server_init(void)
 void time_server_exit(void)
 {
 	time_provider_exit();
+
+	g_slist_free(devices_notify);
 }
diff --git a/time/server.h b/time/server.h
index 0e1f858..91be6e8 100644
--- a/time/server.h
+++ b/time/server.h
@@ -51,3 +51,5 @@ void time_provider_exit(void);
 /* Time provider control and status routines. Implemented by provider-*.c */
 void time_provider_status(uint8_t *state, uint8_t *result);
 uint8_t time_provider_control(int op);
+
+void current_time_updated(void);
-- 
1.7.0.4

