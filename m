Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 07/11] avrcp: Handle RegisterNotification for volume
Date: Fri, 11 Jan 2013 17:25:30 -0300
Message-Id: <1357935934-20033-8-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commit answers a NOTIFY command to register for nofications of
EVENT_VOLUME_CHANGED with an INTERIM response containing the current
absolute volume value.
---
 profiles/audio/avrcp.c     | 15 +++++++++++++++
 profiles/audio/transport.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index bb8ab24..b1016df 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -62,6 +62,7 @@
 #include "avdtp.h"
 #include "sink.h"
 #include "player.h"
+#include "transport.h"
 
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
@@ -1247,6 +1248,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player = session->player;
+	struct audio_device *dev = session->dev;
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
 	GList *settings;
@@ -1293,6 +1295,17 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		}
 
 		break;
+	case AVRCP_EVENT_VOLUME_CHANGED:
+		if (session->version < 0x0104)
+			goto err;
+
+		pdu->params[1] = media_transport_get_device_volume(dev);
+		if (pdu->params[1] > 127)
+			goto err;
+
+		len = 2;
+
+		break;
 	default:
 		/* All other events are not supported yet */
 		goto err;
@@ -1414,6 +1427,8 @@ static const struct control_pdu_handler tg_control_handlers[] = {
 static const struct control_pdu_handler ct_control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
 					avrcp_handle_get_capabilities },
+		{ AVRCP_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
+					avrcp_handle_register_notification },
 		{ },
 };
 
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 78c6fa7..cbbd0b6 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -23,6 +23,7 @@
  */
 
 struct media_transport;
+struct media_endpoint;
 
 struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 						struct audio_device *device,
-- 
1.7.11.7

