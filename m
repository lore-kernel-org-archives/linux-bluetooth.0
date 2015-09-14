Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] audio/avrcp: Enable volume notifications
Date: Mon, 14 Sep 2015 14:07:31 +0300
Message-Id: <1442228851-9652-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1442228851-9652-1-git-send-email-luiz.dentz@gmail.com>
References: <1442228851-9652-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When acting as a TG volume changes should be notified using
RegisterNotification not SetAbsoluteVolume as the later is a CT
operation.
---
 profiles/audio/avrcp.c     | 61 ++++++++++++++++++++++++++++++++++++++++++----
 profiles/audio/avrcp.h     |  2 +-
 profiles/audio/transport.c |  5 ++--
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index a9297f6..53170ec 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4135,7 +4135,53 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn,
 	return FALSE;
 }
 
-int avrcp_set_volume(struct btd_device *dev, uint8_t volume)
+static int avrcp_event(struct avrcp *session, uint8_t id, const void *data)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 2];
+	struct avrcp_header *pdu = (void *) buf;
+	uint8_t code;
+	uint16_t size;
+	int err;
+
+	/* Verify that the event is registered */
+	if (!(session->registered_events & (1 << id)))
+		return -ENOENT;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
+	code = AVC_CTYPE_CHANGED;
+	pdu->params[0] = id;
+
+	DBG("id=%u", id);
+
+	switch (id) {
+	case AVRCP_EVENT_VOLUME_CHANGED:
+		size = 2;
+		memcpy(&pdu->params[1], data, sizeof(uint8_t));
+		break;
+	default:
+		error("Unknown event %u", id);
+		return -EINVAL;
+	}
+
+	pdu->params_len = htons(size);
+
+	err = avctp_send_vendordep(session->conn,
+					session->transaction_events[id],
+					code, AVC_SUBUNIT_PANEL,
+					buf, size + AVRCP_HEADER_LENGTH);
+	if (err < 0)
+		return err;
+
+	/* Unregister event as per AVRCP 1.3 spec, section 5.4.2 */
+	session->registered_events ^= 1 << id;
+
+	return err;
+}
+
+int avrcp_set_volume(struct btd_device *dev, uint8_t volume, bool notify)
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
@@ -4147,18 +4193,23 @@ int avrcp_set_volume(struct btd_device *dev, uint8_t volume)
 		return -EINVAL;
 
 	session = find_session(server->sessions, dev);
-	if (session == NULL || session->target == NULL)
+	if (session == NULL)
 		return -ENOTCONN;
 
-	if (session->target->version < 0x0104)
+	if (notify) {
+		if (!session->target)
+			return -ENOTSUP;
+		return avrcp_event(session, AVRCP_EVENT_VOLUME_CHANGED,
+								&volume);
+	}
+
+	if (!session->controller || session->controller->version < 0x0104)
 		return -ENOTSUP;
 
 	memset(buf, 0, sizeof(buf));
 
 	set_company_id(pdu->company_id, IEEEID_BTSIG);
 
-	DBG("volume=%u", volume);
-
 	pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
 	pdu->params[0] = volume;
 	pdu->params_len = htons(1);
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index ec8c51b..86d310c 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -103,7 +103,7 @@ struct avrcp_player_cb {
 	bool (*previous) (void *user_data);
 };
 
-int avrcp_set_volume(struct btd_device *dev, uint8_t volume);
+int avrcp_set_volume(struct btd_device *dev, uint8_t volume, bool notify);
 
 struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 						struct avrcp_player_cb *cb,
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 112ec17..f5c829f 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -671,7 +671,8 @@ static void set_volume(const GDBusPropertyTable *property,
 	}
 
 	if (a2dp->volume != volume)
-		avrcp_set_volume(transport->device, volume);
+		avrcp_set_volume(transport->device, volume,
+				transport->source_watch ? true : false);
 
 	a2dp->volume = volume;
 
@@ -817,7 +818,7 @@ static int media_transport_init_sink(struct media_transport *transport)
 	transport->destroy = destroy_a2dp;
 
 	a2dp->volume = 127;
-	avrcp_set_volume(transport->device, a2dp->volume);
+	avrcp_set_volume(transport->device, a2dp->volume, true);
 	transport->source_watch = source_add_state_cb(service,
 							source_state_changed,
 							transport);
-- 
2.4.3

