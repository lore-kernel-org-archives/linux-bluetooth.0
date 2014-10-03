Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/19] android/avrcp-lib: Add GetPlayStatus structs
Date: Fri,  3 Oct 2014 15:32:49 +0300
Message-Id: <1412339579-8292-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 3a7a81f..371294a 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -173,6 +173,12 @@ struct get_element_attributes_rsp {
 	struct media_item items[0];
 } __attribute__ ((packed));
 
+struct get_play_status_rsp {
+	uint32_t duration;
+	uint32_t position;
+	uint8_t status;
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -2122,6 +2128,7 @@ static gboolean get_play_status_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu;
+	struct get_play_status_rsp *rsp;
 	uint8_t status = 0;
 	uint32_t position = 0;
 	uint32_t duration = 0;
@@ -2143,14 +2150,16 @@ static gboolean get_play_status_rsp(struct avctp *conn,
 		goto done;
 	}
 
-	if (pdu->params_len < 5) {
+	if (pdu->params_len != sizeof(*rsp)) {
 		err = -EPROTO;
 		goto done;
 	}
 
-	duration = get_be32(&pdu->params[0]);
-	position = get_be32(&pdu->params[4]);
-	status = pdu->params[8];
+	rsp = (void *) pdu->params;
+
+	duration = get_be32(&rsp->duration);
+	position = get_be32(&rsp->position);
+	status = rsp->status;
 	err = 0;
 
 done:
@@ -2947,14 +2956,14 @@ int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint8_t status)
 {
 	struct iovec iov;
-	uint8_t pdu[9];
+	struct get_play_status_rsp rsp;
 
-	put_be32(duration, &pdu[0]);
-	put_be32(position, &pdu[4]);
-	pdu[8] = status;
+	put_be32(duration, &rsp.duration);
+	put_be32(position, &rsp.position);
+	rsp.status = status;
 
-	iov.iov_base = &pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &rsp;
+	iov.iov_len = sizeof(rsp);
 
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
 				AVC_SUBUNIT_PANEL, AVRCP_GET_PLAY_STATUS,
-- 
1.9.3

