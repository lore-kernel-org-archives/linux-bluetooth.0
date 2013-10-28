Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 4/5] android: Cache adapter services in bt_adapter struct
Date: Mon, 28 Oct 2013 13:30:08 +0100
Message-ID: <1382963409-1012-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1382963409-1012-1-git-send-email-marcin.kraglak@tieto.com>
References: <1382963409-1012-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to cache list of sdp records to add/remove uuids
in mgmt interface properly.
---
 android/adapter.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index a14c2a4..b1cb5f8 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -30,6 +30,7 @@
 #include "src/shared/mgmt.h"
 #include "lib/mgmt.h"
 #include "lib/sdp.h"
+#include "lib/sdp_lib.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "ipc.h"
@@ -50,6 +51,8 @@ struct bt_adapter {
 
 	uint32_t supported_settings;
 	uint32_t current_settings;
+
+	sdp_list_t *services;
 };
 
 static struct bt_adapter *adapter;
@@ -529,14 +532,53 @@ error:
 	ipc_send_rsp(io, HAL_SERVICE_ID_BLUETOOTH, status);
 }
 
+static void adapter_service_insert(sdp_record_t *rec)
+{
+	sdp_list_t *browse_list = NULL;
+	uuid_t browse_uuid;
+
+	/* skip record without a browse group */
+	if (sdp_get_browse_groups(rec, &browse_list) < 0) {
+		DBG("skipping record without browse group");
+		return;
+	}
+
+	sdp_uuid16_create(&browse_uuid, PUBLIC_BROWSE_GROUP);
+
+	/* skip record without public browse group */
+	if (!sdp_list_find(browse_list, &browse_uuid, sdp_uuid_cmp))
+		goto done;
+
+	adapter->services = sdp_list_insert_sorted(
+				adapter->services, rec, record_sort);
+
+done:
+	sdp_list_free(browse_list, free);
+}
+
 int bt_adapter_service_add(sdp_record_t *rec)
 {
-	return add_record_to_server(&adapter->bdaddr, rec);
+	int ret;
+
+	ret = add_record_to_server(&adapter->bdaddr, rec);
+	if (ret < 0)
+		return ret;
+
+	adapter_service_insert(rec);
+
+	return ret;
 }
 
 void bt_adapter_service_remove(uint32_t handle)
 {
-	remove_record_from_server(handle);
+	sdp_record_t *rec = sdp_record_find(handle);
+
+	if (!rec)
+		return;
+
+	adapter->services = sdp_list_remove(adapter->services, rec);
+
+	remove_record_from_server(rec->handle);
 }
 
 const bdaddr_t *bt_adapter_get_address(void)
-- 
1.8.2.2

