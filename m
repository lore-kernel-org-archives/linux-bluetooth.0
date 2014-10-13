Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 2/5] shared/att: Respond with ERROR_REQUEST_NOT_SUPPORTED for unhandled requests.
Date: Mon, 13 Oct 2014 14:09:59 -0700
Message-Id: <1413234602-20566-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1413234602-20566-1-git-send-email-armansito@chromium.org>
References: <1413234602-20566-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch bt_att automatically responds with ERROR_REQUEST_NOT_SUPPORTED
to an incoming request for which no handler has been registered via
bt_att_register.
---
 src/shared/att.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 96f34a3..d086ca8 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -562,6 +562,7 @@ struct notify_data {
 	uint8_t opcode;
 	uint8_t *pdu;
 	ssize_t pdu_len;
+	bool handler_found;
 };
 
 static void notify_handler(void *data, void *user_data)
@@ -575,11 +576,27 @@ static void notify_handler(void *data, void *user_data)
 	if (notify->opcode != not_data->opcode)
 		return;
 
+	not_data->handler_found = true;
+
 	if (notify->callback)
 		notify->callback(not_data->opcode, not_data->pdu,
 					not_data->pdu_len, notify->user_data);
 }
 
+static void respond_not_supported(struct bt_att *att, uint8_t opcode)
+{
+	uint8_t pdu[4];
+
+	memset(pdu, 0, sizeof(pdu));
+	pdu[0] = opcode;
+	pdu[1] = 0;
+	pdu[2] = 0;
+	pdu[3] = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+
+	bt_att_send(att, BT_ATT_OP_ERROR_RSP, pdu, sizeof(pdu), NULL, NULL,
+									NULL);
+}
+
 static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -607,6 +624,12 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	}
 
 	bt_att_unref(att);
+
+	/* If this was a request and no handler was registered for it, respond
+	 * with "Not Supported"
+	 */
+	if (!data.handler_found && get_op_type(opcode) == ATT_OP_TYPE_REQ)
+		respond_not_supported(att, opcode);
 }
 
 static void disconn_handler(void *data, void *user_data)
-- 
2.1.0.rc2.206.gedb03e5

