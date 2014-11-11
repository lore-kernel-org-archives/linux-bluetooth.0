Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 8/8] shared/gatt-client: Watch CCC while registering Service Changed handler.
Date: Tue, 11 Nov 2014 13:39:47 -0800
Message-Id: <1415741987-22272-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1415741987-22272-1-git-send-email-armansito@chromium.org>
References: <1415741987-22272-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If gatt-client discovers the "Service Changed" characteristic but
doesn't discover a Client Characteristic Configuration descriptor for it
then it should just invoke the ready callback instead of attempting to
register a handler and failing. This patch addresses that.
---
 src/shared/gatt-client.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 6016b06..30b271e 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -116,6 +116,7 @@ struct bt_gatt_client {
 	 */
 	uint16_t gatt_svc_handle;
 	uint16_t svc_chngd_val_handle;
+	uint16_t svc_chngd_ccc_handle;
 	unsigned int svc_chngd_ind_id;
 	struct queue *svc_chngd_queue;  /* Queued service changed events */
 	bool in_svc_chngd;
@@ -577,9 +578,14 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 						"handle: 0x%04x, uuid: %s",
 						descs[i].handle, uuid_str);
 
-		if (uuid_cmp(descs[i].uuid, GATT_CLIENT_CHARAC_CFG_UUID) == 0)
+		if (uuid_cmp(descs[i].uuid, GATT_CLIENT_CHARAC_CFG_UUID) == 0) {
 			op->cur_chrc->ccc_handle = descs[i].handle;
 
+			if (uuid_cmp(op->cur_chrc->chrc_external.uuid,
+							SVC_CHNGD_UUID) == 0)
+				client->svc_chngd_ccc_handle = descs[i].handle;
+		}
+
 		i++;
 	}
 
@@ -1153,7 +1159,7 @@ static void init_complete(struct discovery_op *op, bool success,
 	op->result_head = NULL;
 	op->result_tail = NULL;
 
-	if (!client->svc_chngd_val_handle) {
+	if (!client->svc_chngd_val_handle || !client->svc_chngd_ccc_handle) {
 		client->ready = true;
 		goto done;
 	}
-- 
2.1.0.rc2.206.gedb03e5

