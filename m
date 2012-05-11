Return-Path: <cyrus@holtmann.org>
From: Vani <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <vani.patel@stericsson.com>
Subject: [PATCH BlueZ 1/4] AVRCP: Register for VolumeChanged Notification
Date: Fri, 11 May 2012 16:32:10 +0530
Message-ID: <1336734130-31397-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

On connection of control channel, VolumeChanged
notification is registered with the CT.
---
 audio/avctp.c |    1 +
 audio/avrcp.c |   25 ++++++++++++++++++++++++-
 audio/avrcp.h |    4 +++-
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index c5fbc1b..0cbd114 100755
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -607,6 +607,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	init_uinput(session);
 
 	avctp_set_state(session, AVCTP_STATE_CONNECTED);
+	register_volume_notification(session);
 	session->mtu = imtu;
 	session->io_id = g_io_add_watch(chan,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 2b25253..f4f1b6a 100755
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -91,6 +91,7 @@
 #define CAP_EVENTS_SUPPORTED	0x03
 #define COMMAND		0
 #define RESPONSE		1
+#define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
 
 enum battery_status {
 	BATTERY_STATUS_NORMAL =		0,
@@ -591,11 +592,12 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
 
 		return AVC_CTYPE_STABLE;
 	case CAP_EVENTS_SUPPORTED:
-		pdu->params[1] = 4;
+		pdu->params[1] = 5;
 		pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
 		pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
 		pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
 		pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
+		pdu->params[6] = AVRCP_EVENT_VOLUME_CHANGED;
 
 		pdu->params_len = htons(2 + pdu->params[1]);
 		return AVC_CTYPE_STABLE;
@@ -1362,3 +1364,24 @@ void avrcp_unregister_player(struct avrcp_player *player)
 
 	player_destroy(player);
 }
+
+void register_volume_notification(struct avctp *session)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
+	struct avrcp_header *pdu = (void *) buf;
+	static uint8_t transaction = 0;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	pdu->params[0] = AVRCP_EVENT_VOLUME_CHANGED;
+	pdu->params_len = htons (AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
+
+	uint8_t length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+	uint8_t error = avctp_send_vendordep(session, transaction++,
+				AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
+				buf, length, COMMAND);
+}
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 58d555f..26432bc 100755
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -73,7 +73,8 @@
 #define AVRCP_EVENT_TRACK_CHANGED	0x02
 #define AVRCP_EVENT_TRACK_REACHED_END	0x03
 #define AVRCP_EVENT_TRACK_REACHED_START	0x04
-#define AVRCP_EVENT_LAST		AVRCP_EVENT_TRACK_REACHED_START
+#define AVRCP_EVENT_VOLUME_CHANGED		0x0d
+#define AVRCP_EVENT_LAST		AVRCP_EVENT_VOLUME_CHANGED
 
 struct avrcp_player_cb {
 	int (*get_setting) (uint8_t attr, void *user_data);
@@ -101,3 +102,4 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
 int avrcp_player_set_volume(struct avrcp_player *player, void *data);
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
+void register_volume_notification(struct avctp *session);
-- 
1.7.5.4

