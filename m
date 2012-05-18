Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3 v2] AVRCP: Subscribe for VolumeChanged Notification
Date: Fri, 18 May 2012 19:11:43 +0300
Message-Id: <1337357504-7900-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337357504-7900-1-git-send-email-luiz.dentz@gmail.com>
References: <1337357504-7900-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the remote device support version 1.4 or latter send register command
for VolumeChanged event:

< AVCTP: Command : pt 0x00 transaction 0 pid 0x110e
    AV/C: Notify: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: RegisterNotification: pt Single len 0x0005
        EventID: 0x0d (EVENT_VOLUME_CHANGED)
        Interval: 0x00000000 (0 seconds)
> AVCTP: Response : pt 0x00 transaction 0 pid 0x110e
    AV/C: Interim: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: RegisterNotification: pt Single len 0x0002
        EventID: 0x0d (EVENT_VOLUME_CHANGED)
        Volume: 100.00% (127/127)
---
v2: remove useless debugs

 audio/avctp.c     |   86 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 audio/avctp.h     |    7 ++++
 audio/avrcp.c     |   62 +++++++++++++++++++++++++++++++++++++-
 audio/avrcp.h     |    1 +
 audio/media.c     |   31 ++++++++++++++++++-
 audio/transport.c |   15 +++++++++
 audio/transport.h |    2 +
 7 files changed, 194 insertions(+), 10 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 5161703..778862c 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -121,6 +121,12 @@ struct avctp_server {
 	GSList *sessions;
 };
 
+struct avctp_rsp_handler {
+	uint8_t id;
+	avctp_rsp_cb func;
+	void *user_data;
+};
+
 struct avctp {
 	struct avctp_server *server;
 	bdaddr_t dst;
@@ -135,6 +141,7 @@ struct avctp {
 	uint16_t mtu;
 
 	uint8_t key_quirks[256];
+	GSList *handlers;
 };
 
 struct avctp_pdu_handler {
@@ -162,6 +169,7 @@ static struct {
 static GSList *callbacks = NULL;
 static GSList *servers = NULL;
 static GSList *handlers = NULL;
+static uint8_t id = 0;
 
 static void auth_cb(DBusError *derr, void *user_data);
 
@@ -349,6 +357,7 @@ static void avctp_disconnected(struct avctp *session)
 	}
 
 	server->sessions = g_slist_remove(server->sessions, session);
+	g_slist_free_full(session->handlers, g_free);
 	g_free(session);
 }
 
@@ -396,6 +405,35 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 	}
 }
 
+static void handle_response(struct avctp *session, struct avctp_header *avctp,
+				struct avc_header *avc, uint8_t *operands,
+				size_t operand_count)
+{
+	GSList *l;
+
+	for (l = session->handlers; l; l = l->next) {
+		struct avctp_rsp_handler *handler = l->data;
+
+		if (handler->id == avctp->transaction) {
+			gboolean ret = FALSE;
+
+			if (handler->func)
+				ret = handler->func(session, avc->code,
+						avc->subunit_type,
+						operands, operand_count,
+						handler->user_data);
+
+			if (ret)
+				return;
+
+			session->handlers = g_slist_remove(session->handlers,
+								handler);
+			g_free(handler);
+			return;
+		}
+	}
+}
+
 static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
@@ -448,8 +486,10 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 			avc->code, avc->subunit_type, avc->subunit_id,
 			avc->opcode, operand_count);
 
-	if (avctp->cr == AVCTP_RESPONSE)
+	if (avctp->cr == AVCTP_RESPONSE) {
+		handle_response(session, avctp, avc, operands, operand_count);
 		return TRUE;
+	}
 
 	packet_size = AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH;
 	avctp->cr = AVCTP_RESPONSE;
@@ -856,14 +896,13 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op)
 	struct avc_header *avc = (void *) &buf[AVCTP_HEADER_LENGTH];
 	uint8_t *operands = &buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH];
 	int sk;
-	static uint8_t transaction = 0;
 
 	if (session->state != AVCTP_STATE_CONNECTED)
 		return -ENOTCONN;
 
 	memset(buf, 0, sizeof(buf));
 
-	avctp->transaction = transaction++;
+	avctp->transaction = id++;
 	avctp->packet_type = AVCTP_PACKET_SINGLE;
 	avctp->cr = AVCTP_COMMAND;
 	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
@@ -881,7 +920,7 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op)
 		return -errno;
 
 	/* Button release */
-	avctp->transaction = transaction++;
+	avctp->transaction = id++;
 	operands[0] |= 0x80;
 
 	if (write(sk, buf, sizeof(buf)) < 0)
@@ -890,8 +929,8 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op)
 	return 0;
 }
 
-int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
-				uint8_t code, uint8_t subunit,
+static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
+				uint8_t code, uint8_t subunit, uint8_t opcode,
 				uint8_t *operands, size_t operand_count)
 {
 	uint8_t *buf;
@@ -914,12 +953,12 @@ int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 
 	avctp->transaction = transaction;
 	avctp->packet_type = AVCTP_PACKET_SINGLE;
-	avctp->cr = AVCTP_RESPONSE;
+	avctp->cr = cr;
 	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
 
 	avc->code = code;
 	avc->subunit_type = subunit;
-	avc->opcode = AVC_OP_VENDORDEP;
+	avc->opcode = opcode;
 
 	memcpy(pdu, operands, operand_count);
 
@@ -930,6 +969,37 @@ int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 	return err;
 }
 
+int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
+				uint8_t code, uint8_t subunit,
+				uint8_t *operands, size_t operand_count)
+{
+	return avctp_send(session, transaction, AVCTP_RESPONSE, code, subunit,
+					AVC_OP_VENDORDEP, operands, operand_count);
+}
+
+int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
+					uint8_t subunit, uint8_t *operands,
+					size_t operand_count,
+					avctp_rsp_cb func, void *user_data)
+{
+	struct avctp_rsp_handler *handler;
+	int err;
+
+	err = avctp_send(session, id++, AVCTP_COMMAND, code, subunit,
+				AVC_OP_VENDORDEP, operands, operand_count);
+	if (err < 0)
+		return err;
+
+	handler = g_new0(struct avctp_rsp_handler, 1);
+	handler->id = id;
+	handler->func = func;
+	handler->user_data = user_data;
+
+	session->handlers = g_slist_prepend(session->handlers, handler);
+
+	return 0;
+}
+
 unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data)
 {
 	struct avctp_state_callback *state_cb;
diff --git a/audio/avctp.h b/audio/avctp.h
index 9727485..d0cbd97 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -78,6 +78,9 @@ typedef size_t (*avctp_pdu_cb) (struct avctp *session, uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
+typedef gboolean (*avctp_rsp_cb) (struct avctp *session, uint8_t code,
+					uint8_t subunit, uint8_t *operands,
+					size_t operand_count, void *user_data);
 
 unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
@@ -97,3 +100,7 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op);
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
 				uint8_t *operands, size_t operand_count);
+int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
+					uint8_t subunit, uint8_t *operands,
+					size_t operand_count,
+					avctp_rsp_cb func, void *user_data);
diff --git a/audio/avrcp.c b/audio/avrcp.c
index df39d04..6ed77a3 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -45,6 +45,9 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
+#include "../src/adapter.h"
+#include "../src/device.h"
+
 #include "log.h"
 #include "error.h"
 #include "device.h"
@@ -89,6 +92,8 @@
 #define CAP_COMPANY_ID		0x02
 #define CAP_EVENTS_SUPPORTED	0x03
 
+#define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
+
 enum battery_status {
 	BATTERY_STATUS_NORMAL =		0,
 	BATTERY_STATUS_WARNING =	1,
@@ -994,7 +999,6 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
-
 static struct pdu_handler {
 	uint8_t pdu_id;
 	uint8_t code;
@@ -1119,11 +1123,53 @@ static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
 	return NULL;
 }
 
+static gboolean avrcp_handle_volume_changed(struct avctp *session,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t abs_volume = pdu->params[1] & 0x7F;
+
+	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
+		return FALSE;
+
+	if (player->cb->set_volume != NULL)
+		player->cb->set_volume(abs_volume, player->dev, player->user_data);
+
+	return TRUE;
+}
+
+static void register_volume_notification(struct avrcp_player *player)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
+	struct avrcp_header *pdu = (void *) buf;
+	uint8_t length;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	pdu->params[0] = AVRCP_EVENT_VOLUME_CHANGED;
+	pdu->params_len = htons(AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
+
+	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+	avctp_send_vendordep_req(player->session, AVC_CTYPE_NOTIFY,
+					AVC_SUBUNIT_PANEL, buf, length,
+					avrcp_handle_volume_changed, player);
+}
+
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 				avctp_state_t new_state, void *user_data)
 {
 	struct avrcp_server *server;
 	struct avrcp_player *player;
+	const sdp_record_t *rec;
+	sdp_list_t *list;
+	sdp_profile_desc_t *desc;
 
 	server = find_server(servers, &dev->src);
 	if (!server)
@@ -1153,6 +1199,20 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 							handle_vendordep_pdu,
 							player);
 		break;
+	case AVCTP_STATE_CONNECTED:
+		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
+		if (rec == NULL)
+			return;
+
+		if (sdp_get_profile_descs(rec, &list) < 0)
+			return;
+
+		desc = list->data;
+
+		if (desc && desc->version >= 0x0104)
+			register_volume_notification(player);
+
+		sdp_list_free(list, free);
 	default:
 		return;
 	}
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 9aef081..4d3527b 100644
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
index 3fe04d5..ee34283 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -103,6 +103,7 @@ struct media_player {
 	guint			track_watch;
 	uint8_t			status;
 	uint32_t		position;
+	uint8_t			volume;
 	GTimer			*timer;
 };
 
@@ -1340,6 +1341,33 @@ static uint32_t get_position(void *user_data)
 	return mp->position + sec * 1000 + msec;
 }
 
+static void set_volume(uint8_t volume, struct audio_device *dev, void *user_data)
+{
+	struct media_player *mp = user_data;
+	GSList *l;
+
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
+		media_transport_update_volume(transport, volume);
+	}
+}
 static struct avrcp_player_cb player_cb = {
 	.get_setting = get_setting,
 	.set_setting = set_setting,
@@ -1347,7 +1375,8 @@ static struct avrcp_player_cb player_cb = {
 	.get_uid = get_uid,
 	.get_metadata = get_metadata,
 	.get_position = get_position,
-	.get_status = get_status
+	.get_status = get_status,
+	.set_volume = set_volume
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data)
diff --git a/audio/transport.c b/audio/transport.c
index 753d4bf..4ad8608 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -77,6 +77,7 @@ struct media_transport {
 	uint16_t		omtu;		/* Transport output mtu */
 	uint16_t		delay;		/* Transport delay (a2dp only) */
 	unsigned int		nrec_id;	/* Transport nrec watch (headset only) */
+	uint8_t			volume;		/* Transport volume */
 	gboolean		read_lock;
 	gboolean		write_lock;
 	gboolean		in_use;
@@ -1063,3 +1064,17 @@ struct audio_device *media_transport_get_dev(struct media_transport *transport)
 {
 	return transport->device;
 }
+
+void media_transport_update_volume(struct media_transport *transport,
+								uint8_t volume)
+{
+	/* Check if volume really changed */
+	if (transport->volume == volume)
+		return;
+
+	transport->volume = volume;
+
+	emit_property_changed(transport->conn, transport->path,
+				MEDIA_TRANSPORT_INTERFACE, "Volume",
+				DBUS_TYPE_BYTE, &transport->volume);
+}
diff --git a/audio/transport.h b/audio/transport.h
index 1f86cde..d20c327 100644
--- a/audio/transport.h
+++ b/audio/transport.h
@@ -35,5 +35,7 @@ const char *media_transport_get_path(struct media_transport *transport);
 struct audio_device *media_transport_get_dev(struct media_transport *transport);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
+void media_transport_update_volume(struct media_transport *transport,
+								uint8_t volume);
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
-- 
1.7.7.6

