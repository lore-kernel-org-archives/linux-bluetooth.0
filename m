Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/15] AVCTP: Call callback in case the request timeout
Date: Mon, 10 Jun 2013 13:36:58 +0300
Message-Id: <1370860630-30359-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avctp.c | 19 +++++++++++++++++++
 profiles/audio/avrcp.c | 29 +++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 46c5485..a4d0153 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -155,6 +155,7 @@ struct avctp_pending_req {
 	struct avctp_channel *chan;
 	uint8_t transaction;
 	guint timeout;
+	int err;
 	avctp_process_cb process;
 	void *data;
 	GDestroyNotify destroy;
@@ -658,7 +659,16 @@ static int avctp_browsing_send(struct avctp_channel *browsing,
 static void control_req_destroy(void *data)
 {
 	struct avctp_control_req *req = data;
+	struct avctp_pending_req *p = req->p;
+	struct avctp *session = p->chan->session;
+
+	if (p->err == 0 || req->func == NULL)
+		goto done;
 
+	req->func(session, AVC_CTYPE_REJECTED, req->subunit, NULL, 0,
+							req->user_data);
+
+done:
 	g_free(req->operands);
 	g_free(req);
 }
@@ -666,7 +676,15 @@ static void control_req_destroy(void *data)
 static void browsing_req_destroy(void *data)
 {
 	struct avctp_browsing_req *req = data;
+	struct avctp_pending_req *p = req->p;
+	struct avctp *session = p->chan->session;
+
+	if (p->err == 0 || req->func == NULL)
+		goto done;
 
+	req->func(session, NULL, 0, req->user_data);
+
+done:
 	g_free(req->operands);
 	g_free(req);
 }
@@ -679,6 +697,7 @@ static gboolean req_timeout(gpointer user_data)
 	DBG("transaction %u", p->transaction);
 
 	p->timeout = 0;
+	p->err = -ETIMEDOUT;
 
 	pending_destroy(p, NULL);
 	chan->p = NULL;
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5bddd08..491bb92 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1723,7 +1723,8 @@ static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
 	uint32_t position;
 	uint8_t status;
 
-	if (code == AVC_CTYPE_REJECTED || ntohs(pdu->params_len) != 9)
+	if (pdu == NULL || code == AVC_CTYPE_REJECTED ||
+						ntohs(pdu->params_len) != 9)
 		return FALSE;
 
 	memcpy(&duration, pdu->params, sizeof(uint32_t));
@@ -1786,8 +1787,11 @@ static gboolean avrcp_player_value_rsp(struct avctp *conn,
 	int i;
 
 	if (code == AVC_CTYPE_REJECTED) {
-		media_player_set_setting(mp, "Error",
-					status_to_str(pdu->params[0]));
+		const char *msg;
+
+		msg = pdu != NULL ? status_to_str(pdu->params[0]) : "Timedout";
+
+		media_player_set_setting(mp, "Error", msg);
 		return FALSE;
 	}
 
@@ -2026,7 +2030,8 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 	uint8_t depth, count;
 	size_t i;
 
-	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 13)
+	if (pdu == NULL || pdu->params[0] != AVRCP_STATUS_SUCCESS ||
+							operand_count < 13)
 		return FALSE;
 
 	player->uid_counter = bt_get_be16(&pdu->params[1]);
@@ -2091,6 +2096,11 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 	struct avrcp_browsing_header *pdu = (void *) operands;
 	uint8_t count;
 
+	if (pdu == NULL) {
+		avrcp_get_element_attributes(session);
+		return FALSE;
+	}
+
 	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 4) {
 		if (pdu->params[0] == AVRCP_STATUS_PLAYER_NOT_BROWSABLE)
 			avrcp_get_element_attributes(session);
@@ -2404,7 +2414,8 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 	size_t i;
 	GSList *removed;
 
-	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 5)
+	if (pdu == NULL || pdu->params[0] != AVRCP_STATUS_SUCCESS ||
+							operand_count < 5)
 		return FALSE;
 
 	removed = g_slist_copy(session->players);
@@ -2570,7 +2581,8 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 	struct avrcp_header *pdu = (void *) operands;
 	uint8_t event;
 
-	if (code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)
+	if ((code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED) ||
+								pdu == NULL)
 		return FALSE;
 
 	event = pdu->params[0];
@@ -2641,7 +2653,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 	uint16_t events = 0;
 	uint8_t count;
 
-	if (pdu->params[0] != CAP_EVENTS_SUPPORTED)
+	if (pdu == NULL || pdu->params[0] != CAP_EVENTS_SUPPORTED)
 		return FALSE;
 
 	count = pdu->params[1];
@@ -3187,7 +3199,8 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn,
 	struct avrcp_header *pdu = (void *) operands;
 	uint8_t volume;
 
-	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
+	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED ||
+								pdu == NULL)
 		return FALSE;
 
 	volume = pdu->params[0] & 0x7F;
-- 
1.8.1.4

