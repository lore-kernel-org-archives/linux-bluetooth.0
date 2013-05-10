Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] AVCTP: Add support to register pass-through handler
Date: Fri, 10 May 2013 14:02:00 +0300
Message-Id: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Pass-through handler can be used to capture AV/C Panel commands before
they are sent to uinput.
---
 profiles/audio/avctp.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/avctp.h |  8 ++++++
 2 files changed, 80 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 21aeb6f..705bf71 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -192,10 +192,18 @@ struct avctp {
 	struct avctp_channel *control;
 	struct avctp_channel *browsing;
 
+	struct avctp_passthrough_handler *handler;
+
 	uint8_t key_quirks[256];
 	struct key_pressed *key;
 };
 
+struct avctp_passthrough_handler {
+	avctp_passthrough_cb cb;
+	void *user_data;
+	unsigned int id;
+};
+
 struct avctp_pdu_handler {
 	uint8_t opcode;
 	avctp_control_pdu_cb cb;
@@ -280,6 +288,8 @@ static size_t handle_panel_passthrough(struct avctp *session,
 					uint8_t *subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
 {
+	struct key_pressed *key = session->key;
+	struct avctp_passthrough_handler *handler = session->handler;
 	const char *status;
 	int pressed, i;
 
@@ -299,6 +309,12 @@ static size_t handle_panel_passthrough(struct avctp *session,
 		pressed = 1;
 	}
 
+	if (key == NULL && handler != NULL) {
+		if (handler->cb(session, operands[0] & 0x7F,
+						pressed, handler->user_data))
+			goto done;
+	}
+
 	for (i = 0; key_map[i].name != NULL; i++) {
 		uint8_t key_quirks;
 
@@ -321,6 +337,16 @@ static size_t handle_panel_passthrough(struct avctp *session,
 			break;
 		}
 
+		if (pressed) {
+			if (key == NULL)
+				key = g_new0(struct key_pressed, 1);
+			key->op = key_map[i].avc;
+			session->key = key;
+		} else if (key && key->op == key_map[i].avc) {
+			g_free(key);
+			session->key = NULL;
+		}
+
 		send_key(session->uinput, key_map[i].uinput, pressed);
 		break;
 	}
@@ -1692,6 +1718,52 @@ gboolean avctp_remove_state_cb(unsigned int id)
 	return FALSE;
 }
 
+unsigned int avctp_register_passthrough_handler(struct avctp *session,
+						avctp_passthrough_cb cb,
+						void *user_data)
+{
+	struct avctp_channel *control = session->control;
+	struct avctp_passthrough_handler *handler;
+	static unsigned int id = 0;
+
+	if (control == NULL || session->handler != NULL)
+		return 0;
+
+	handler = g_new(struct avctp_passthrough_handler, 1);
+	handler->cb = cb;
+	handler->user_data = user_data;
+	handler->id = ++id;
+
+	session->handler = handler;
+
+	return handler->id;
+}
+
+bool avctp_unregister_passthrough_handler(unsigned int id)
+{
+	GSList *l;
+
+	for (l = servers; l; l = l->next) {
+		struct avctp_server *server = l->data;
+		GSList *s;
+
+		for (s = server->sessions; s; s = s->next) {
+			struct avctp *session = s->data;
+
+			if (session->handler == NULL)
+				continue;
+
+			if (session->handler->id == id) {
+				g_free(session->handler);
+				session->handler = NULL;
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
 unsigned int avctp_register_pdu_handler(struct avctp *session, uint8_t opcode,
 						avctp_control_pdu_cb cb,
 						void *user_data)
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 648e982..0a414af 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -94,6 +94,9 @@ typedef void (*avctp_state_cb) (struct audio_device *dev,
 				avctp_state_t old_state,
 				avctp_state_t new_state);
 
+typedef bool (*avctp_passthrough_cb) (struct avctp *session,
+					uint8_t op, bool pressed,
+					void *user_data);
 typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
 					uint8_t transaction, uint8_t *code,
 					uint8_t *subunit, uint8_t *operands,
@@ -120,6 +123,11 @@ struct avctp *avctp_get(struct audio_device *device);
 int avctp_connect_browsing(struct avctp *session);
 void avctp_disconnect(struct avctp *session);
 
+unsigned int avctp_register_passthrough_handler(struct avctp *session,
+						avctp_passthrough_cb cb,
+						void *user_data);
+bool avctp_unregister_passthrough_handler(unsigned int id);
+
 unsigned int avctp_register_pdu_handler(struct avctp *session, uint8_t opcode,
 						avctp_control_pdu_cb cb,
 						void *user_data);
-- 
1.8.1.4

