Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 10/11] avrcp: Handle SetAbsoluteVolume command
Date: Fri, 11 Jan 2013 17:25:33 -0300
Message-Id: <1357935934-20033-11-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avrcp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index d715177..8bd5fb6 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1392,6 +1392,32 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
+						struct avrcp_header *pdu,
+						uint8_t transaction)
+{
+	struct avrcp_player *player = session->player;
+	uint16_t len = ntohs(pdu->params_len);
+
+	if (len != 1)
+		goto err;
+
+	if (pdu->params[0] > 127)
+		goto err;
+
+	if (!player)
+		goto err;
+
+	media_transport_update_device_volume(session->dev, pdu->params[0]);
+
+	return AVC_CTYPE_ACCEPTED;
+
+err:
+	pdu->params_len = htons(1);
+	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
+	return AVC_CTYPE_REJECTED;
+}
+
 static const struct control_pdu_handler tg_control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
 					avrcp_handle_get_capabilities },
@@ -1429,6 +1455,8 @@ static const struct control_pdu_handler ct_control_handlers[] = {
 					avrcp_handle_get_capabilities },
 		{ AVRCP_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
 					avrcp_handle_register_notification },
+		{ AVRCP_SET_ABSOLUTE_VOLUME, AVC_CTYPE_CONTROL,
+					avrcp_handle_set_absolute_volume },
 		{ },
 };
 
-- 
1.7.11.7

