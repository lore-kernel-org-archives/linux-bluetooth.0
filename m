Return-Path: <cyrus@holtmann.org>
From: Vani <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <vani.patel@stericsson.com>
Subject: [PATCH BlueZ 4/4] AVRCP: Response for VolumeChanged Notification
Date: Fri, 11 May 2012 16:33:38 +0530
Message-ID: <1336734218-22355-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

Handling of interim and changed response for
VolumeChanged notification.
---
 audio/avctp.c |   18 ++++++++----------
 audio/avrcp.c |   21 +++++++++++++++++++++
 audio/avrcp.h |    1 +
 audio/media.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 0cbd114..5cc5e34 100755
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -403,7 +403,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	uint8_t buf[1024], *operands, code, subunit;
 	struct avctp_header *avctp;
 	struct avc_header *avc;
-	int ret, packet_size, operand_count, sock;
+	int ret, packet_size, operand_count, sock, avrcp_packet_length=0;
 	struct avctp_pdu_handler *handler;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
@@ -448,9 +448,6 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 			avc->code, avc->subunit_type, avc->subunit_id,
 			avc->opcode, operand_count);
 
-	if (avctp->cr == AVCTP_RESPONSE)
-		return TRUE;
-
 	packet_size = AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH;
 	avctp->cr = AVCTP_RESPONSE;
 
@@ -476,19 +473,20 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	code = avc->code;
 	subunit = avc->subunit_type;
 
-	packet_size += handler->cb(session, avctp->transaction, &code,
+	avrcp_packet_length = handler->cb(session, avctp->transaction, &code,
 					&subunit, operands, operand_count,
 					handler->user_data);
-
+	packet_size += avrcp_packet_length;
 	avc->code = code;
 	avc->subunit_type = subunit;
 
 done:
-	ret = write(sock, buf, packet_size);
-	if (ret != packet_size)
-		goto failed;
+	if (avrcp_packet_length == 0)
+		return TRUE;
 
-	return TRUE;
+	ret = write(sock, buf, packet_size);
+	if (ret == packet_size)
+		return TRUE;
 
 failed:
 	DBG("AVCTP session %p got disconnected", session);
diff --git a/audio/avrcp.c b/audio/avrcp.c
index b11dc21..8b0d574 100755
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1031,6 +1031,18 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint8_t avrcp_handle_volume_changed (struct avrcp_player *player,
+						struct avrcp_header *pdu,
+						uint8_t transaction)
+{
+	uint8_t abs_volume = pdu->params[1] & 0x7F;
+	abs_volume = (abs_volume * 100)/127;
+
+	if(player->cb->set_volume != NULL)
+		player->cb->set_volume(abs_volume, player->dev, player->user_data);
+
+	return 0;
+}
 
 static struct pdu_handler {
 	uint8_t pdu_id;
@@ -1089,6 +1101,13 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 	DBG("AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
 			pdu->pdu_id, company_id, pdu->params_len);
 
+	if (pdu->pdu_id == AVRCP_REGISTER_NOTIFICATION) {
+		if (pdu->params[0] == AVRCP_EVENT_VOLUME_CHANGED)
+			return avrcp_handle_volume_changed(player, pdu, transaction);
+		else 
+			return 0;
+	}
+
 	pdu->packet_type = 0;
 	pdu->rsvd = 0;
 
@@ -1183,6 +1202,8 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		break;
 	case AVCTP_STATE_CONNECTING:
 		player->session = avctp_connect(&dev->src, &dev->dst);
+		if (!player->dev)
+			player->dev = dev;
 
 		if (!player->handler)
 			player->handler = avctp_register_pdu_handler(
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 21cbc5c..31e004e 100755
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -84,6 +84,7 @@ struct avrcp_player_cb {
 	GList *(*list_metadata) (void *user_data);
 	uint8_t (*get_status) (void *user_data);
 	uint32_t (*get_position) (void *user_data);
+	void (*set_volume) (uint8_t volume, struct audio_device *dev, void *user_data);
 };
 
 int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
diff --git a/audio/media.c b/audio/media.c
index 680f5a4..ebac291 100755
--- a/audio/media.c
+++ b/audio/media.c
@@ -1343,6 +1343,56 @@ static uint32_t get_position(void *user_data)
 	return mp->position + sec * 1000 + msec;
 }
 
+static void set_volume(uint8_t volume, struct audio_device *dev, void *user_data)
+{
+	struct media_player *mp = user_data;
+	DBusMessage *msg;
+	DBusMessageIter iter, value;
+	const char *property = "Volume";
+
+	GSList *l;
+	if (mp->volume == volume)
+		return;
+
+	mp->volume = volume;
+
+	for (l = mp->adapter->endpoints; l; l = l->next) {
+
+		struct media_endpoint *endpoint;
+		struct media_transport *transport;
+
+		if (l->data == NULL)
+			continue;
+
+		endpoint = l->data;
+		transport = find_device_transport(endpoint, dev);
+		
+		if (transport == NULL)
+			continue;
+
+		const char *path = media_transport_get_path(transport);
+		msg = dbus_message_new_method_call("org.bluez",
+							path,
+							MEDIA_TRANSPORT_INTERFACE,
+							"SetProperty");
+		if (!msg) {
+			DBG ( "Unable to allocate new.PropertyChanged msg\n");
+			continue ;
+		}
+
+		dbus_message_iter_init_append(msg, &iter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &property);
+		dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT, DBUS_TYPE_BYTE_AS_STRING, &value);
+		dbus_message_iter_append_basic(&value, DBUS_TYPE_BYTE, &volume);
+		dbus_message_iter_close_container(&iter, &value);
+		
+		if (!dbus_connection_send(media_transport_get_conn(transport),msg,NULL))
+			continue;
+	}
+
+	register_volume_notification (avrcp_get_session(mp->player));
+}
+
 static struct avrcp_player_cb player_cb = {
 	.get_setting = get_setting,
 	.set_setting = set_setting,
@@ -1350,7 +1400,8 @@ static struct avrcp_player_cb player_cb = {
 	.get_uid = get_uid,
 	.get_metadata = get_metadata,
 	.get_position = get_position,
-	.get_status = get_status
+	.get_status = get_status,
+	.set_volume = set_volume
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data)
-- 
1.7.5.4

