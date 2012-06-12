Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] mgmtops: Use cod_busy to track events that may change CoD
Date: Tue, 12 Jun 2012 12:00:09 +0200
Message-ID: <1339495209-17701-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1339495209-17701-1-git-send-email-szymon.janc@tieto.com>
References: <1339495209-17701-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Both MGMT_OP_ADD_UUID and MGMT_OP_SET_DEV_CLASS commands may result in
change of CoD. Make sure that only one command is send at time. This
is to avoid EBUSY error when adding UUIDs while setting new CoD.
---
 plugins/mgmtops.c |   55 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 8229da1..68f1da9 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -997,6 +997,8 @@ static int mgmt_set_dev_class(int index, uint8_t major, uint8_t minor)
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
 		return -errno;
 
+	info->cod_busy = TRUE;
+
 	return 0;
 }
 
@@ -1271,23 +1273,13 @@ static void read_local_oob_data_failed(int sk, uint16_t index)
 		oob_read_local_data_complete(adapter, NULL, NULL);
 }
 
-static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
-								size_t len)
+static void handle_pending_uuids(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct controller_info *info;
 	struct pending_uuid *pending;
 
-	DBG("add_uuid complete");
-
-	if (index > max_index) {
-		error("Unexpected index %u in add_uuid_complete event", index);
-		return;
-	}
-
 	info = &controllers[index];
 
-	info->cod_busy = FALSE;
-
 	if (g_slist_length(info->pending_uuids) == 0) {
 		if (info->pending_class) {
 			info->pending_class = FALSE;
@@ -1310,6 +1302,45 @@ static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
 	g_free(pending);
 }
 
+static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
+								size_t len)
+{
+	struct controller_info *info;
+
+	DBG("index %d", index);
+
+	if (index > max_index) {
+		error("Unexpected index %u in add_uuid_complete event", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	info->cod_busy = FALSE;
+
+	handle_pending_uuids(sk, index, buf, len);
+}
+
+static void mgmt_set_dev_class_complete(int sk, uint16_t index, void *buf,
+								size_t len)
+{
+	struct controller_info *info;
+
+	DBG("index %d", index);
+
+	if (index > max_index) {
+		error("Unexpected index %u in mgmt_set_dev_class_complete "
+								"event", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	info->cod_busy = FALSE;
+
+	handle_pending_uuids(sk, index, buf, len);
+}
+
 static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_cmd_complete *ev = buf;
@@ -1361,7 +1392,7 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 		DBG("remove_uuid complete");
 		break;
 	case MGMT_OP_SET_DEV_CLASS:
-		DBG("set_dev_class complete");
+		mgmt_set_dev_class_complete(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_LOAD_LINK_KEYS:
 		DBG("load_link_keys complete");
-- 
on behalf of ST-Ericsson

