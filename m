Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 4/5] android: Initial implementation of get_remote_services
Date: Thu, 31 Oct 2013 16:25:51 +0100
Message-ID: <1383233152-15040-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383233152-15040-1-git-send-email-szymon.janc@tieto.com>
References: <1383233152-15040-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

Change-Id: I9dffb4d59be5d41c0c26d619b30289c0e52f3a2e
---
 android/Android.mk  |  1 +
 android/Makefile.am |  1 +
 android/adapter.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index b953554..993f6d6 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -34,6 +34,7 @@ LOCAL_SRC_FILES := \
 	../src/sdpd-server.c \
 	../src/glib-helper.c \
 	../src/eir.c \
+	../src/sdp-client.c \
 	../lib/sdp.c \
 	../lib/bluetooth.c \
 	../lib/hci.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 17165e2..acaece2 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -9,6 +9,7 @@ android_bluetoothd_SOURCES =	android/main.c \
 				src/sdpd-service.c src/sdpd-request.c \
 				src/glib-helper.h src/glib-helper.c \
 				src/eir.h src/eir.c \
+				src/sdp-client.c src/sdp-client.h \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				android/adapter.h android/adapter.c \
diff --git a/android/adapter.c b/android/adapter.c
index 6ee4a21..48e5e95 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -31,6 +31,10 @@
 #include "src/shared/mgmt.h"
 #include "src/glib-helper.h"
 #include "src/eir.h"
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "lib/uuid.h"
+#include "src/sdp-client.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "ipc.h"
@@ -41,6 +45,8 @@
 #define DEFAULT_IO_CAPABILITY 0x01
 
 static GIOChannel *notification_io = NULL;
+/* This list contains addresses which are asked for records */
+static GList *sdp_req_list;
 
 struct bt_adapter {
 	uint16_t index;
@@ -59,6 +65,20 @@ struct bt_adapter {
 	bool discovering;
 };
 
+struct browse_req {
+	bdaddr_t *bdaddr;
+	GSList *uuids;
+	int search_uuid;
+	int reconnect_attempt;
+};
+
+static const uint16_t uuid_list[] = {
+	L2CAP_UUID,
+	PNP_INFO_SVCLASS_ID,
+	PUBLIC_BROWSE_GROUP,
+	0
+};
+
 static struct bt_adapter *adapter;
 static GSList *found_devices = NULL;
 
@@ -1215,9 +1235,80 @@ static uint8_t ssp_reply(void *buf, uint16_t len)
 	return status;
 }
 
+static void browse_req_free(struct browse_req *req)
+{
+	g_free(req->bdaddr);
+	g_slist_free_full(req->uuids, g_free);
+	g_free(req);
+}
+
+static void update_records(struct browse_req *req, sdp_list_t *recs)
+{
+	/* TODO cache found uuids */
+}
+
+static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
+{
+	struct browse_req *req = user_data;
+	uuid_t uuid;
+
+	/* If we have a valid response and req->search_uuid == 2, then L2CAP
+	 * UUID & PNP searching was successful -- we are done */
+	if (err < 0 || req->search_uuid == 2) {
+		if (err == -ECONNRESET && req->reconnect_attempt < 1) {
+			req->search_uuid--;
+			req->reconnect_attempt++;
+		} else {
+			goto done;
+		}
+	}
+
+	update_records(req, recs);
+
+	/* Search for mandatory uuids */
+	if (uuid_list[req->search_uuid]) {
+		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
+		bt_search_service(&adapter->bdaddr, req->bdaddr, &uuid,
+						browse_cb, user_data, NULL);
+		return;
+	}
+
+done:
+	sdp_req_list = g_list_remove(sdp_req_list, req->bdaddr);
+	browse_req_free(req);
+}
+
 static uint8_t get_remote_services(void *buf, uint16_t len)
 {
-	return HAL_STATUS_UNSUPPORTED;
+	struct hal_cmd_get_remote_services *cmd = buf;
+	struct browse_req *req;
+	bdaddr_t *addr;
+	uuid_t uuid;
+	int err;
+
+	addr = g_new0(bdaddr_t, 1);
+	android2bdaddr(&cmd->bdaddr, addr);
+
+	if (g_list_find_custom(sdp_req_list, addr, bdaddr_cmp)) {
+		g_free(addr);
+		return HAL_STATUS_DONE;
+	}
+
+	sdp_req_list = g_list_append(sdp_req_list, addr);
+
+	req = g_new0(struct browse_req, 1);
+	req->bdaddr = addr;
+	sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
+
+	err = bt_search_service(&adapter->bdaddr,
+			req->bdaddr, &uuid, browse_cb, req, NULL);
+	if (err) {
+		sdp_req_list = g_list_remove(sdp_req_list, req->bdaddr);
+		browse_req_free(req);
+		return HAL_STATUS_FAILED;
+	}
+
+	return HAL_STATUS_SUCCESS;
 }
 
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-- 
1.8.4.1

