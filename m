Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Apr 2012 10:01:46 +0200
Subject: RFC: [PATCH BlueZ 1/2] AVRCP 1.4 - Implemented SetAbsoluteVolume
 Function
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B221E0A6C8B@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

As correctly pointed out and suggested by Luiz, I have modified SetAbsoluteVolume implementation.

The patch has been broken into two parts - 

1/2 - Handling of SetAbsoluteVolume Function in avrcp.c where AbsoluteVolume related error handling is done and for correct parameters, media callback for volume_changed is called.
2/2 - Implementation of volume_changed function in media.c which searches for all the transports matching the device and emits PropertyChanged signal to them

Please let me know your valuable feedback for this change.


>From 80c83ada0bce859c76410375a407dbfa1965af37 Mon Sep 17 00:00:00 2001
From: Vani Patel <vani.patel@stericsson.com>
Date: Mon, 9 Apr 2012 12:31:02 +0530
Subject: [PATCH BlueZ 1/2] AVRCP 1.4 - Implemented SetAbsoluteVolume Function

---
 audio/avrcp.c |   38 ++++++++++++++++++++++++++++++++++++++
 audio/avrcp.h |    1 +
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index d80daec..c36e60d 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -63,6 +63,7 @@
 #define E_INVALID_PARAM		0x01
 #define E_PARAM_NOT_FOUND	0x02
 #define E_INTERNAL		0x03
+#define E_NO_ERR		0x04
 
 /* Packet types */
 #define AVRCP_PACKET_TYPE_SINGLE	0x00
@@ -85,10 +86,12 @@
 #define AVRCP_REGISTER_NOTIFICATION	0x31
 #define AVRCP_REQUEST_CONTINUING	0x40
 #define AVRCP_ABORT_CONTINUING		0x41
+#define AVRCP_SET_ABSOLUTE_VOLUME	0x50
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
 #define CAP_EVENTS_SUPPORTED	0x03
+#define MAX_ABSOLUTE_VOLUME	0x7F
 
 enum battery_status {
 	BATTERY_STATUS_NORMAL =		0,
@@ -994,6 +997,36 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint8_t avrcp_set_absolute_volume(struct avrcp_player *player,
+ 						struct avrcp_header *pdu,
+ 						uint8_t transaction)
+{
+ 	uint16_t len = ntohs(pdu->params_len);
+ 	uint8_t abs_volume = 0;
+ 	if (len != 1) {
+ 		pdu->params[0] = E_PARAM_NOT_FOUND;
+ 		DBG("Param not Found \n");
+ 		goto err;
+ 	}
+
+ 	abs_volume = pdu->params[0];
+ 	if (abs_volume > MAX_ABSOLUTE_VOLUME) {
+ 		pdu->params[0] = E_INVALID_PARAM;
+		DBG("Invalid Param \n");
+ 		goto err;
+ 	}
+
+	if (player->cb->volume_changed != NULL ) {
+		player->cb->volume_changed(abs_volume, player->user_data, player->dev);
+	 	pdu->params[0] = abs_volume;
+	 	pdu->params_len = htons(len);
+	 	return AVC_CTYPE_ACCEPTED;
+	}
+
+err:
+ 	pdu->params_len = htons(1);
+ 	return AVC_CTYPE_REJECTED;
+}
 
 static struct pdu_handler {
 	uint8_t pdu_id;
@@ -1030,6 +1063,8 @@ static struct pdu_handler {
 					avrcp_handle_request_continuing },
 		{ AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
 					avrcp_handle_abort_continuing },
+		{ AVRCP_SET_ABSOLUTE_VOLUME, AVC_CTYPE_CONTROL,
+ 					avrcp_set_absolute_volume },
 		{ },
 };
 
@@ -1147,6 +1182,9 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 	case AVCTP_STATE_CONNECTING:
 		player->session = avctp_connect(&dev->src, &dev->dst);
 
+		if (!player->dev)
+			player->dev = dev;
+
 		if (!player->handler)
 			player->handler = avctp_register_pdu_handler(
 							AVC_OP_VENDORDEP,
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 8a09546..f049d71 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -83,6 +83,7 @@ struct avrcp_player_cb {
 	GList *(*list_metadata) (void *user_data);
 	uint8_t (*get_status) (void *user_data);
 	uint32_t (*get_position) (void *user_data);
+	void (*volume_changed)(uint8_t volume, void *user_data,struct audio_device *dev);
 };
 
 int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
-- 
1.7.5.4

-Regards,
Vani Patel
