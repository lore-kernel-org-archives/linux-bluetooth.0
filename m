Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] mgmtops: Fix adding UUID when EBUSY error is returned
Date: Sun, 10 Jun 2012 21:50:51 +0200
Message-Id: <1339357852-6326-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MGMT_ADDP_UUID may return EBUSY error (when adding UUID triggered COD
change) and UUID should be send to kernel one more time in such case.
---
 plugins/mgmtops.c |   63 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index a196b1f..ee42de0 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -825,28 +825,16 @@ static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid)
 		memcpy(uuid128, uuid, sizeof(*uuid));
 }
 
-static int mgmt_add_uuid(int index, uuid_t *uuid, uint8_t svc_hint)
+static int send_uuid(int index, uuid_t *uuid, uint8_t svc_hint)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_add_uuid)];
 	struct mgmt_hdr *hdr = (void *) buf;
 	struct mgmt_cp_add_uuid *cp = (void *) &buf[sizeof(*hdr)];
-	struct controller_info *info = &controllers[index];
 	uuid_t uuid128;
 	uint128_t uint128;
 
 	DBG("index %d", index);
 
-	if (info->pending_uuid) {
-		struct pending_uuid *pending = g_new0(struct pending_uuid, 1);
-
-		memcpy(&pending->uuid, uuid, sizeof(*uuid));
-		pending->svc_hint = svc_hint;
-
-		info->pending_uuids = g_slist_append(info->pending_uuids,
-								pending);
-		return 0;
-	}
-
 	uuid_to_uuid128(&uuid128, uuid);
 
 	memset(buf, 0, sizeof(buf));
@@ -859,9 +847,25 @@ static int mgmt_add_uuid(int index, uuid_t *uuid, uint8_t svc_hint)
 
 	cp->svc_hint = svc_hint;
 
-	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
+	return write(mgmt_sock, buf, sizeof(buf));
+}
+
+static int mgmt_add_uuid(int index, uuid_t *uuid, uint8_t svc_hint)
+{
+	struct controller_info *info = &controllers[index];
+	struct pending_uuid *pending;
+
+	DBG("index %d", index);
+
+	if (!info->pending_uuid && send_uuid(index, uuid, svc_hint) < 0)
 		return -errno;
 
+	pending = g_new0(struct pending_uuid, 1);
+
+	memcpy(&pending->uuid, uuid, sizeof(*uuid));
+	pending->svc_hint = svc_hint;
+
+	info->pending_uuids = g_slist_append(info->pending_uuids, pending);
 	info->pending_uuid = TRUE;
 
 	return 0;
@@ -1278,7 +1282,7 @@ static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
 	struct controller_info *info;
 	struct pending_uuid *pending;
 
-	DBG("add_uuid complete");
+	DBG("index %d", index);
 
 	if (index > max_index) {
 		error("Unexpected index %u in add_uuid_complete event", index);
@@ -1287,9 +1291,13 @@ static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
 
 	info = &controllers[index];
 
-	info->pending_uuid = FALSE;
+	pending = info->pending_uuids->data;
+	info->pending_uuids = g_slist_remove(info->pending_uuids, pending);
+	g_free(pending);
 
 	if (g_slist_length(info->pending_uuids) == 0) {
+		info->pending_uuid = FALSE;
+
 		if (info->pending_class) {
 			info->pending_class = FALSE;
 			mgmt_set_dev_class(index, info->major, info->minor);
@@ -1305,10 +1313,7 @@ static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
 
 	pending = info->pending_uuids->data;
 
-	mgmt_add_uuid(index, &pending->uuid, pending->svc_hint);
-
-	info->pending_uuids = g_slist_remove(info->pending_uuids, pending);
-	g_free(pending);
+	send_uuid(index, &pending->uuid, pending->svc_hint);
 }
 
 static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
@@ -1434,6 +1439,20 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	}
 }
 
+static void mgmt_add_uuid_resend(int sk, uint16_t index)
+{
+	struct controller_info *info;
+	struct pending_uuid *pending;
+
+	DBG("index %d", index);
+
+	info = &controllers[index];
+
+	pending = info->pending_uuids->data;
+
+	send_uuid(index, &pending->uuid, pending->svc_hint);
+}
+
 static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_cmd_status *ev = buf;
@@ -1460,6 +1479,10 @@ static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_READ_LOCAL_OOB_DATA:
 		read_local_oob_data_failed(sk, index);
 		break;
+	case MGMT_OP_ADD_UUID:
+		if (ev->status == MGMT_STATUS_BUSY)
+			mgmt_add_uuid_resend(sk, index);
+		break;
 	}
 }
 
-- 
1.7.10.4


