Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/19] android/avrcp-lib: Add SetAbsoluteVolume structs
Date: Fri,  3 Oct 2014 15:32:51 +0300
Message-Id: <1412339579-8292-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 72cb087..4a4b1d8 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -189,6 +189,14 @@ struct register_notification_rsp {
 	uint8_t data[0];
 } __attribute__ ((packed));
 
+struct set_volume_req {
+	uint8_t value;
+} __attribute__ ((packed));
+
+struct set_volume_rsp {
+	uint8_t value;
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -893,6 +901,7 @@ static ssize_t set_volume(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
+	struct set_volume_req *req;
 	uint8_t volume;
 
 	DBG("");
@@ -903,7 +912,9 @@ static ssize_t set_volume(struct avrcp *session, uint8_t transaction,
 	if (!params || params_len != sizeof(volume))
 		return -EINVAL;
 
-	volume = params[0] & 0x7f;
+	req = (void *) params;
+
+	volume = req->value & 0x7f;
 
 	return player->ind->set_volume(session, transaction, volume,
 							player->user_data);
@@ -2199,6 +2210,7 @@ static gboolean set_volume_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu;
+	struct set_volume_rsp *rsp;
 	uint8_t value = 0;
 	int err;
 
@@ -2218,12 +2230,14 @@ static gboolean set_volume_rsp(struct avctp *conn,
 		goto done;
 	}
 
-	if (pdu->params_len < 1) {
+	if (pdu->params_len < sizeof(*rsp)) {
 		err = -EPROTO;
 		goto done;
 	}
 
-	value = pdu->params[0] & 0x7f;
+	rsp = (void *) pdu->params;
+
+	value = rsp->value & 0x7f;
 	err = 0;
 
 done:
-- 
1.9.3

