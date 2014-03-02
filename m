Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/16] android/avrcp: Add handler for GetPlayStatus command
Date: Sun,  2 Mar 2014 20:48:26 +0200
Message-Id: <1393786109-6554-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index bcaa66c..3ac8223 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -37,6 +37,7 @@
 #include "avctp.h"
 #include "avrcp-lib.h"
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "ipc.h"
 #include "bluetooth.h"
 #include "avrcp.h"
@@ -54,18 +55,76 @@ static GSList *devices = NULL;
 static GIOChannel *server = NULL;
 static struct ipc *hal_ipc = NULL;
 
+struct avrcp_request {
+	struct avrcp_device *dev;
+	uint8_t pdu_id;
+	uint8_t transaction;
+};
+
 struct avrcp_device {
 	bdaddr_t	dst;
 	struct avrcp	*session;
 	GIOChannel	*io;
+	GQueue		*queue;
 };
 
+static struct avrcp_request *pop_request(uint8_t pdu_id)
+{
+	GSList *l;
+
+	for (l = devices; l; l = g_slist_next(l)) {
+		struct avrcp_device *dev = l->data;
+		GList *reqs = g_queue_peek_head_link(dev->queue);
+		int i;
+
+		for (i = 0; reqs; reqs = g_list_next(reqs), i++) {
+			struct avrcp_request *req = reqs->data;
+
+			if (req->pdu_id == pdu_id) {
+				g_queue_pop_nth(dev->queue, i);
+				return req;
+			}
+		}
+	}
+
+	return NULL;
+}
+
 static void handle_get_play_status(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_avrcp_get_play_status *cmd = buf;
+	uint8_t status;
+	struct avrcp_request *req;
+	uint8_t pdu[9];
+	int ret;
+
 	DBG("");
 
+	req = pop_request(AVRCP_GET_PLAY_STATUS);
+	if (!req) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	bt_put_be32(cmd->position, &pdu[0]);
+	bt_put_be32(cmd->duration, &pdu[4]);
+	pdu[8] = cmd->status;
+
+	ret = avrcp_send(req->dev->session, req->transaction, AVC_CTYPE_STABLE,
+					AVC_SUBUNIT_PANEL, req->pdu_id,
+					pdu, sizeof(pdu));
+	if (ret < 0) {
+		status = HAL_STATUS_FAILED;
+		g_free(req);
+		goto done;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+	g_free(req);
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
-			HAL_OP_AVRCP_GET_PLAY_STATUS, HAL_STATUS_FAILED);
+				HAL_OP_AVRCP_GET_PLAY_STATUS, status);
 }
 
 static void handle_list_player_attrs(const void *buf, uint16_t len)
@@ -244,6 +303,9 @@ static void avrcp_device_free(void *data)
 {
 	struct avrcp_device *dev = data;
 
+	g_queue_foreach(dev->queue, (GFunc) g_free, NULL);
+	g_queue_free(dev->queue);
+
 	if (dev->session)
 		avrcp_shutdown(dev->session);
 
@@ -373,10 +435,38 @@ static ssize_t handle_get_capabilities(struct avrcp *session,
 	return -EINVAL;
 }
 
+static ssize_t handle_get_play_status_cmd(struct avrcp *session,
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
+{
+	struct avrcp_device *dev = user_data;
+	struct avrcp_request *req;
+
+	if (params_len != 0)
+		return -EINVAL;
+
+	req = g_new0(struct avrcp_request, 1);
+	req->dev = dev;
+	req->pdu_id = AVRCP_GET_CAPABILITIES;
+	req->transaction = transaction;
+
+	g_queue_push_tail(dev->queue, req);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
+					HAL_EV_AVRCP_GET_PLAY_STATUS, 0, NULL);
+
+	return -EAGAIN;
+}
+
 static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					handle_get_capabilities },
+		{ AVRCP_GET_PLAY_STATUS,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					handle_get_play_status_cmd },
 		{ },
 };
 
@@ -433,6 +523,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 									dev);
 	avrcp_set_control_handlers(dev->session, control_handlers, dev);
 
+	dev->queue = g_queue_new();
+
 	/* FIXME: get the real name of the device */
 	avrcp_init_uinput(dev->session, "bluetooth", address);
 
-- 
1.8.5.3

