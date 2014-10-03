Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/19] android/avrcp-lib: Add ListPlayerAttributes structs
Date: Fri,  3 Oct 2014 15:32:42 +0300
Message-Id: <1412339579-8292-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index d93addd..587c6ee 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -93,6 +93,11 @@ struct get_capabilities_rsp {
 	uint8_t params[0];
 } __attribute__ ((packed));
 
+struct list_attributes_rsp {
+	uint8_t number;
+	uint8_t params[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -1566,6 +1571,7 @@ static gboolean list_attributes_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu = (void *) operands;
+	struct list_attributes_rsp *rsp;
 	uint8_t number = 0;
 	uint8_t *attrs = NULL;
 	int err;
@@ -1586,6 +1592,13 @@ static gboolean list_attributes_rsp(struct avctp *conn,
 		goto done;
 	}
 
+	rsp = (void *) pdu->params;
+
+	if (pdu->params_len < sizeof(*rsp)) {
+		err = -EPROTO;
+		goto done;
+	}
+
 	number = pdu->params[0];
 	if (number > 0)
 		attrs = &pdu->params[1];
@@ -2722,12 +2735,15 @@ int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs)
 {
 	struct iovec iov[2];
+	struct list_attributes_rsp rsp;
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
 		return -EINVAL;
 
-	iov[0].iov_base = &number;
-	iov[0].iov_len = sizeof(number);
+	rsp.number = number;
+
+	iov[0].iov_base = &rsp;
+	iov[0].iov_len = sizeof(rsp);
 
 	if (!number)
 		return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
-- 
1.9.3

