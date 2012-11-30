Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] control: Add methods FastForward and Rewind
Date: Fri, 30 Nov 2012 14:48:19 +0200
Message-Id: <1354279699-1245-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These method can be used to fast-forward and rewind the playback, their
action will keep active until another method is called.

The commands are reapeated every 2 seconds to conform with AVC spec.
---
 doc/control-api.txt      |  10 ++++
 profiles/audio/avctp.c   | 148 ++++++++++++++++++++++++++++++++++++++++++-----
 profiles/audio/control.c |  14 +++++
 3 files changed, 157 insertions(+), 15 deletions(-)

diff --git a/doc/control-api.txt b/doc/control-api.txt
index e0ed04a..55cebe8 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -40,6 +40,16 @@ Methods		void Play()
 
 			Adjust remote volume one step down
 
+		void FastForward()
+
+			Fast forward playback, this action is only stopped
+			when another method in this interface is called.
+
+		void Rewind()
+
+			Rewind playback, this action is only stopped
+			when another method in this interface is called.
+
 Properties
 
 		boolean Connected [readonly]
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index e48c257..8693784 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -162,6 +162,11 @@ struct avctp_channel {
 	guint process_id;
 };
 
+struct key_pressed {
+	uint8_t op;
+	guint timer;
+};
+
 struct avctp {
 	struct avctp_server *server;
 	bdaddr_t dst;
@@ -179,6 +184,7 @@ struct avctp {
 	struct avctp_channel *browsing;
 
 	uint8_t key_quirks[256];
+	struct key_pressed *key;
 };
 
 struct avctp_pdu_handler {
@@ -214,6 +220,9 @@ static GSList *servers = NULL;
 
 static void auth_cb(DBusError *derr, void *user_data);
 static gboolean process_queue(gpointer user_data);
+static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
+					uint8_t subunit, uint8_t *operands,
+					size_t operand_count, void *user_data);
 
 static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
 {
@@ -409,6 +418,13 @@ static void avctp_disconnected(struct avctp *session)
 		session->auth_id = 0;
 	}
 
+	if (session->key != NULL) {
+		if (session->key->timer > 0)
+			g_source_remove(session->key->timer);
+		g_free(session->key);
+	}
+
+
 	if (session->uinput >= 0) {
 		char address[18];
 
@@ -1272,6 +1288,116 @@ static int avctp_send_req(struct avctp *session, uint8_t code,
 	return 0;
 }
 
+static char *op2str(uint8_t op)
+{
+	switch (op & 0x7f) {
+	case AVC_VOLUME_UP:
+		return "VOLUME UP";
+	case AVC_VOLUME_DOWN:
+		return "VOLUME DOWN";
+	case AVC_MUTE:
+		return "MUTE";
+	case AVC_PLAY:
+		return "PLAY";
+	case AVC_STOP:
+		return "STOP";
+	case AVC_PAUSE:
+		return "PAUSE";
+	case AVC_RECORD:
+		return "RECORD";
+	case AVC_REWIND:
+		return "REWIND";
+	case AVC_FAST_FORWARD:
+		return "FAST FORWARD";
+	case AVC_EJECT:
+		return "EJECT";
+	case AVC_FORWARD:
+		return "FORWARD";
+	case AVC_BACKWARD:
+		return "BACKWARD";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static int avctp_passthrough_press(struct avctp *session, uint8_t op)
+{
+	uint8_t operands[2];
+
+	DBG("%s", op2str(op));
+
+	/* Button pressed */
+	operands[0] = op & 0x7f;
+	operands[1] = 0;
+
+	return avctp_send_req(session, AVC_CTYPE_CONTROL,
+				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
+				operands, sizeof(operands),
+				avctp_passthrough_rsp, NULL);
+}
+
+static int avctp_passthrough_release(struct avctp *session, uint8_t op)
+{
+	uint8_t operands[2];
+
+	DBG("%s", op2str(op));
+
+	/* Button released */
+	operands[0] = op | 0x80;
+	operands[1] = 0;
+
+	return avctp_send_req(session, AVC_CTYPE_CONTROL,
+				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
+				operands, sizeof(operands),
+				NULL, NULL);
+}
+
+static gboolean repeat_timeout(gpointer user_data)
+{
+	struct avctp *session = user_data;
+	struct key_pressed *key = session->key;
+
+	avctp_passthrough_release(session, key->op);
+	avctp_passthrough_press(session, key->op);
+
+	return TRUE;
+}
+
+static void release_pressed(struct avctp *session)
+{
+	struct key_pressed *key = session->key;
+
+	avctp_passthrough_release(session, key->op);
+
+	if (key->timer > 0)
+		g_source_remove(key->timer);
+
+	g_free(key);
+	session->key = NULL;
+}
+
+static bool set_pressed(struct avctp *session, uint8_t op)
+{
+	struct key_pressed *key;
+
+	if (session->key != NULL) {
+		if (session->key->op == op)
+			return TRUE;
+		release_pressed(session);
+	}
+
+	if (op != AVC_FAST_FORWARD && op != AVC_REWIND)
+		return FALSE;
+
+	key = g_new0(struct key_pressed, 1);
+	key->op = op;
+	key->timer = g_timeout_add_seconds(2, repeat_timeout, session);
+
+	session->key = key;
+
+	return TRUE;
+}
+
 static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
 					uint8_t subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
@@ -1279,29 +1405,21 @@ static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
 	if (code != AVC_CTYPE_ACCEPTED)
 		return FALSE;
 
-	/* Button release */
-	operands[0] |= 0x80;
+	if (set_pressed(session, operands[0]))
+		return FALSE;
 
-	avctp_send_req(session, AVC_CTYPE_CONTROL,
-				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
-				operands, operand_count,
-				NULL, NULL);
+	avctp_passthrough_release(session, operands[0]);
 
 	return FALSE;
 }
 
 int avctp_send_passthrough(struct avctp *session, uint8_t op)
 {
-	uint8_t operands[2];
-
-	/* Button pressed */
-	operands[0] = op & 0x7f;
-	operands[1] = 0;
+	/* Auto release if key pressed */
+	if (session->key != NULL)
+		release_pressed(session);
 
-	return avctp_send_req(session, AVC_CTYPE_CONTROL,
-				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
-				operands, sizeof(operands),
-				avctp_passthrough_rsp, NULL);
+	return avctp_passthrough_press(session, op);
 }
 
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 0013f8d..7299b7e 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -238,6 +238,18 @@ static DBusMessage *control_previous(DBusConnection *conn, DBusMessage *msg,
 	return key_pressed(conn, msg, AVC_BACKWARD, data);
 }
 
+static DBusMessage *control_fast_forward(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return key_pressed(conn, msg, AVC_FAST_FORWARD, data);
+}
+
+static DBusMessage *control_rewind(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return key_pressed(conn, msg, AVC_REWIND, data);
+}
+
 static gboolean control_property_get_connected(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
@@ -258,6 +270,8 @@ static const GDBusMethodTable control_methods[] = {
 	{ GDBUS_METHOD("Previous", NULL, NULL, control_previous) },
 	{ GDBUS_METHOD("VolumeUp", NULL, NULL, control_volume_up) },
 	{ GDBUS_METHOD("VolumeDown", NULL, NULL, control_volume_down) },
+	{ GDBUS_METHOD("FastForward", NULL, NULL, control_fast_forward) },
+	{ GDBUS_METHOD("Rewind", NULL, NULL, control_rewind) },
 	{ }
 };
 
-- 
1.7.11.7

