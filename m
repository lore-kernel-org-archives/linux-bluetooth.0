Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 17/19] avrcp: send response for registered events
Date: Tue, 19 Jul 2011 16:49:28 -0300
Message-Id: <1311104970-18600-18-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a certain event occur, check if CT registered to receive that
notification and send a response.
---
 audio/control.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index d37848e..894a706 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -79,6 +79,7 @@
 #define CTYPE_ACCEPTED		0x9
 #define CTYPE_REJECTED		0xA
 #define CTYPE_STABLE		0xC
+#define CTYPE_CHANGED		0xD
 #define CTYPE_INTERIM		0xF
 
 /* opcodes */
@@ -319,6 +320,7 @@ struct control {
 	uint8_t player_setting[PLAYER_SETTING_SCAN + 1];
 	struct media_info mi;
 	uint16_t registered_events;
+	uint8_t transaction_events[AVRCP_EVENT_VOLUME_CHANGED + 1];
 };
 
 static struct {
@@ -793,8 +795,74 @@ static dbus_bool_t emit_setting_changed(DBusConnection *conn,
 	return g_dbus_send_message(conn, signal);
 }
 
+static int avctp_send_event(struct control *control, uint8_t id)
+{
+	uint8_t buf[AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH +
+					AVRCP_SPECAVCPDU_HEADER_LENGTH + 9];
+	struct avctp_header *avctp = (void *) buf;
+	struct avrcp_header *avrcp = (void *) &buf[AVCTP_HEADER_LENGTH];
+	struct avrcp_spec_avc_pdu *pdu = (void *) &buf[AVCTP_HEADER_LENGTH +
+							AVRCP_HEADER_LENGTH];
+	int sk = g_io_channel_unix_get_fd(control->io);
+	uint16_t size;
+
+	memset(buf, 0, sizeof(buf));
+
+	avctp->transaction = control->transaction_events[id];
+	avctp->packet_type = AVCTP_PACKET_SINGLE;
+	avctp->cr = AVCTP_RESPONSE;
+	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
+
+	avrcp->code = CTYPE_CHANGED;
+	avrcp->subunit_type = SUBUNIT_PANEL;
+	avrcp->opcode = OP_VENDORDEP;
+
+	pdu->company_id[0] = IEEEID_BTSIG >> 16;
+	pdu->company_id[1] = (IEEEID_BTSIG >> 8) & 0xFF;
+	pdu->company_id[2] = IEEEID_BTSIG & 0xFF;
+
+	pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
+	pdu->params[0] = id;
+
+	switch (id) {
+	case (AVRCP_EVENT_PLAYBACK_STATUS_CHANGED):
+		size = 2;
+		pdu->params[1] = control->mi.status;
+
+		break;
+	case (AVRCP_EVENT_TRACK_CHANGED): {
+		size = 9;
+
+		/*
+		 * AVRCP 1.3 supports only one track identifier: PLAYING
+		 * (0x0). When 1.4 version is added, this shall be changed to
+		 * contain the identifier of the track.
+		 */
+		memset(&pdu->params[1], 0, 8);
+
+		break;
+	}
+	default:
+		error("Unknown event %u", id);
+		return -EINVAL;
+	}
+
+	pdu->params_len = htons(size);
+	size += AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH +
+					AVRCP_SPECAVCPDU_HEADER_LENGTH;
+
+	if (write(sk, buf, size) < 0)
+		return -errno;
+
+	/* Unregister event as per AVRCP 1.3 spec, section 5.4.2 */
+	control->registered_events ^= 1 << id;
+
+	return 0;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
+					struct avctp_header *avctp,
 					struct avrcp_header *avrcp,
 					int operand_count)
 {
@@ -1158,6 +1226,8 @@ static int handle_vendordep_pdu(struct control *control,
 
 			/* Register event */
 			control->registered_events |= (1 << pdu->params[0]);
+			control->transaction_events[pdu->params[0]] =
+							avctp->transaction;
 
 			avrcp->code = CTYPE_INTERIM;
 			pdu->params_len = htons(size);
@@ -1359,7 +1429,8 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 		int r_size;
 		operand_count -= 3;
 		avctp->cr = AVCTP_RESPONSE;
-		r_size = handle_vendordep_pdu(control, avrcp, operand_count);
+		r_size = handle_vendordep_pdu(control, avctp, avrcp,
+								operand_count);
 		packet_size = AVCTP_HEADER_LENGTH + r_size;
 	} else {
 		avctp->cr = AVCTP_RESPONSE;
@@ -2080,7 +2151,16 @@ static DBusMessage *control_change_playback(DBusConnection *conn,
 	if (status < 0)
 		return btd_error_invalid_args(msg);
 
-	control->mi.status = status;
+	if ((uint8_t) status != control->mi.status) {
+		control->mi.status = status;
+
+		if (control->registered_events &
+				(1 << AVRCP_EVENT_PLAYBACK_STATUS_CHANGED)) {
+			avctp_send_event(control,
+					AVRCP_EVENT_PLAYBACK_STATUS_CHANGED);
+		}
+	}
+
 	control->mi.current_position = elapsed;
 
 	DBG("Change playback: %s %u", statusstr, elapsed);
@@ -2203,6 +2283,9 @@ static DBusMessage *control_change_track(DBusConnection *conn,
 			   mi.title, mi.artist, mi.album, mi.genre,
 			   mi.ntracks, mi.track, mi.track_length);
 
+	if (control->registered_events & (1 << AVRCP_EVENT_TRACK_CHANGED))
+		avctp_send_event(control, AVRCP_EVENT_TRACK_CHANGED);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.6

