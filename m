Return-Path: <cyrus@holtmann.org>
From: Vani <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <vani.patel@stericsson.com>
Subject: [PATCH  BlueZ 3/3] AVRCP: Implement SetAbsoluteVolume
Date: Thu, 10 May 2012 16:02:05 +0530
Message-ID: <1336645925-30602-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

Register for PropertyChanged on
MediaTransport. On "Volume" changed
send SetAbsoluteVolume
---
 audio/avctp.c |    4 ++--
 audio/avctp.h |    2 +-
 audio/avrcp.c |   37 ++++++++++++++++++++++++++++++++++++-
 audio/avrcp.h |    1 +
 audio/media.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 audio/avctp.c
 mode change 100644 => 100755 audio/avctp.h
 mode change 100644 => 100755 audio/avrcp.c
 mode change 100644 => 100755 audio/avrcp.h
 mode change 100644 => 100755 audio/media.c

diff --git a/audio/avctp.c b/audio/avctp.c
old mode 100644
new mode 100755
index 5161703..c5fbc1b
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -892,7 +892,7 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op)
 
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
-				uint8_t *operands, size_t operand_count)
+				uint8_t *operands, size_t operand_count, uint8_t cr)
 {
 	uint8_t *buf;
 	struct avctp_header *avctp;
@@ -914,7 +914,7 @@ int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 
 	avctp->transaction = transaction;
 	avctp->packet_type = AVCTP_PACKET_SINGLE;
-	avctp->cr = AVCTP_RESPONSE;
+	avctp->cr = cr;
 	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
 
 	avc->code = code;
diff --git a/audio/avctp.h b/audio/avctp.h
old mode 100644
new mode 100755
index 9727485..0b9ff37
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -96,4 +96,4 @@ gboolean avctp_unregister_pdu_handler(unsigned int id);
 int avctp_send_passthrough(struct avctp *session, uint8_t op);
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
-				uint8_t *operands, size_t operand_count);
+				uint8_t *operands, size_t operand_count, uint8_t cr);
diff --git a/audio/avrcp.c b/audio/avrcp.c
old mode 100644
new mode 100755
index 9ec0730..2b25253
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -84,10 +84,13 @@
 #define AVRCP_REGISTER_NOTIFICATION	0x31
 #define AVRCP_REQUEST_CONTINUING	0x40
 #define AVRCP_ABORT_CONTINUING		0x41
+#define AVRCP_SET_ABSOLUTE_VOLUME	0x50
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
 #define CAP_EVENTS_SUPPORTED	0x03
+#define COMMAND		0
+#define RESPONSE		1
 
 enum battery_status {
 	BATTERY_STATUS_NORMAL =		0,
@@ -164,6 +167,7 @@ static unsigned int avctp_id = 0;
 static uint32_t company_ids[] = {
 	IEEEID_BTSIG,
 };
+static uint8_t request_transaction = 0;
 
 static sdp_record_t *avrcp_ct_record(void)
 {
@@ -395,7 +399,7 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 
 	err = avctp_send_vendordep(player->session, player->transaction_events[id],
 					AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
-					buf, size + AVRCP_HEADER_LENGTH);
+					buf, size + AVRCP_HEADER_LENGTH, RESPONSE);
 	if (err < 0)
 		return err;
 
@@ -405,6 +409,37 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	return 0;
 }
 
+int avrcp_player_set_volume(struct avrcp_player *player, void *data)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 9];
+	struct avrcp_header *pdu = (void *) buf;
+	uint16_t size = 1;
+	int err;
+	uint8_t volume = 0;
+
+	if (player->session == NULL)
+		return -ENOTCONN;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+
+	volume = *((uint8_t *)data);
+	volume = 1.27 * volume;
+
+	pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
+	pdu->params_len = htons(size);
+	pdu->params[0] = volume;
+
+	err = avctp_send_vendordep(player->session, request_transaction++,
+					AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
+					buf, size + AVRCP_HEADER_LENGTH, COMMAND);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static uint16_t player_write_media_attribute(struct avrcp_player *player,
 						uint32_t id, uint8_t *buf,
 						uint16_t *pos,
diff --git a/audio/avrcp.h b/audio/avrcp.h
old mode 100644
new mode 100755
index 8a09546..58d555f
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -98,5 +98,6 @@ struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
 void avrcp_unregister_player(struct avrcp_player *player);
 
 int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
+int avrcp_player_set_volume(struct avrcp_player *player, void *data);
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
diff --git a/audio/media.c b/audio/media.c
old mode 100644
new mode 100755
index 61ec153..680f5a4
--- a/audio/media.c
+++ b/audio/media.c
@@ -55,6 +55,7 @@
 #define MEDIA_INTERFACE "org.bluez.Media"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint"
 #define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
+#define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport"
 
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
@@ -101,8 +102,10 @@ struct media_player {
 	guint			watch;
 	guint			property_watch;
 	guint			track_watch;
+	guint                   volume_watch;
 	uint8_t			status;
 	uint32_t		position;
+	uint8_t			volume;
 	GTimer			*timer;
 };
 
@@ -1642,6 +1645,43 @@ static gboolean track_changed(DBusConnection *connection, DBusMessage *msg,
 	return TRUE;
 }
 
+static gboolean volume_changed(DBusConnection *connection, DBusMessage *msg,
+							void *user_data)
+{
+	struct media_player *mp = user_data;
+	DBusMessageIter iter, value;
+	uint8_t volume;
+	const char *property;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
+		error("Unexpected signature in %s.%s signal",
+					dbus_message_get_interface(msg),
+					dbus_message_get_member(msg));
+		return FALSE;
+	}
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return FALSE;
+
+	dbus_message_iter_recurse(&iter, &value);
+
+	if (g_strcmp0(property, "Volume") != 0)
+		return FALSE;
+
+	if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_BYTE)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&value, &volume);
+	mp->volume = volume;
+	avrcp_player_set_volume(mp->player, &volume);
+
+	return TRUE;
+}
 static struct media_player *media_player_create(struct media_adapter *adapter,
 						const char *sender,
 						const char *path,
@@ -1668,6 +1708,11 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 						"TrackChanged",
 						track_changed,
 						mp, NULL);
+	mp->volume_watch = g_dbus_add_signal_watch(adapter->conn, sender,
+						path, MEDIA_TRANSPORT_INTERFACE,
+						"PropertyChanged",
+						volume_changed,
+						mp, NULL);
 	mp->player = avrcp_register_player(&adapter->src, &player_cb, mp,
 						media_player_free);
 	if (!mp->player) {
-- 
1.7.5.4

