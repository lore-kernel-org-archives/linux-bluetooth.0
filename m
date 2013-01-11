Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 08/11] avrcp: Notify remote of volume changes
Date: Fri, 11 Jan 2013 17:25:31 -0300
Message-Id: <1357935934-20033-9-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avrcp.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b1016df..d715177 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2540,7 +2540,7 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
-	uint8_t buf[AVRCP_HEADER_LENGTH + 1];
+	uint8_t buf[AVRCP_HEADER_LENGTH + 2];
 	struct avrcp_header *pdu = (void *) buf;
 
 	server = find_server(servers, device_get_adapter(dev->btd_dev));
@@ -2555,13 +2555,27 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
 
 	set_company_id(pdu->company_id, IEEEID_BTSIG);
 
-	pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
-	pdu->params[0] = volume;
-	pdu->params_len = htons(1);
-
 	DBG("volume=%u", volume);
 
-	return avctp_send_vendordep_req(session->conn, AVC_CTYPE_CONTROL,
-					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+	if (session->target) {
+		pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
+		pdu->params[0] = volume;
+		pdu->params_len = htons(1);
+
+		return avctp_send_vendordep_req(session->conn,
+					AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
+					buf, sizeof(buf),
 					avrcp_handle_set_volume, session);
+	} else {
+		uint8_t id = AVRCP_EVENT_VOLUME_CHANGED;
+		pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
+		pdu->params[0] = AVRCP_EVENT_VOLUME_CHANGED;
+		pdu->params[1] = volume;
+		pdu->params_len = htons(2);
+
+		return avctp_send_vendordep(session->conn,
+					session->transaction_events[id],
+					AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
+					buf, sizeof(buf));
+	}
 }
-- 
1.7.11.7

