Return-Path: <cyrus@holtmann.org>
From: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/1] avctp: Set browsing channel connection for ct
Date: Tue, 22 Jan 2013 11:34:04 +0100
Message-Id: <1358850844-19752-2-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
In-Reply-To: <1358850844-19752-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
References: <1358850844-19752-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add two extra states for the browsing channel and handle the connection
sequence in avrcp.c

---
 profiles/audio/avctp.c  | 11 +++++++++++
 profiles/audio/avctp.h  |  4 +++-
 profiles/audio/avrcp.c  | 28 +++++++++++++++++++++++-----
 profiles/audio/device.c |  4 ++++
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index e65594d..753f8fe 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -476,6 +476,12 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 	case AVCTP_STATE_CONNECTED:
 		DBG("AVCTP Connected");
 		break;
+	case AVCTP_STATE_BROWSING_CONNECTING:
+		DBG("AVCTP Browsing Connecting");
+		break;
+	case AVCTP_STATE_BROWSING_CONNECTED:
+		DBG("AVCTP Browsing Connected");
+		break;
 	default:
 		error("Invalid AVCTP state %d", new_state);
 		return;
@@ -913,9 +919,12 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) session_browsing_cb, session);
 
+	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTED);
 	return;
 
 fail:
+	avctp_set_state(session, AVCTP_STATE_CONNECTED);
+
 	if (session->browsing) {
 		avctp_channel_destroy(session->browsing);
 		session->browsing = NULL;
@@ -1648,6 +1657,8 @@ int avctp_connect_browsing(struct avctp *session)
 	if (session->browsing != NULL)
 		return 0;
 
+	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTING);
+
 	io = bt_io_connect(avctp_connect_browsing_cb, session, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR,
 				adapter_get_address(session->server->adapter),
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index c25a3b3..d1fe693 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -67,7 +67,9 @@ struct avctp;
 typedef enum {
 	AVCTP_STATE_DISCONNECTED = 0,
 	AVCTP_STATE_CONNECTING,
-	AVCTP_STATE_CONNECTED
+	AVCTP_STATE_CONNECTED,
+	AVCTP_STATE_BROWSING_CONNECTING,
+	AVCTP_STATE_BROWSING_CONNECTED
 } avctp_state_t;
 
 typedef void (*avctp_state_cb) (struct audio_device *dev,
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 636d3e4..6cab45f 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2182,12 +2182,9 @@ static void session_tg_init(struct avrcp *session)
 				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
 				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
 
-	if (session->version >= 0x0104) {
+	if (session->version >= 0x0104)
 		avrcp_register_notification(session,
 						AVRCP_EVENT_VOLUME_CHANGED);
-		if (session->features & AVRCP_FEATURE_BROWSING)
-			avctp_connect_browsing(session->conn);
-	}
 
 	session->control_id = avctp_register_pdu_handler(session->conn,
 							AVC_OP_VENDORDEP,
@@ -2341,6 +2338,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
+	uint8_t browsing_failed = false;
 
 	server = find_server(servers, device_get_adapter(dev->btd_dev));
 	if (!server)
@@ -2367,8 +2365,28 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (session == NULL)
 			break;
 
-		session->init(session);
+		if (session->version <= 0x0103) {
+			session->init(session);
+			break;
+		}
+
+		/*AVCRP >= 1.4*/
+		if (old_state == AVCTP_STATE_CONNECTING) {
+			if (avctp_connect_browsing(session->conn) != 0)
+				browsing_failed = true;
+		} else if (old_state == AVCTP_STATE_BROWSING_CONNECTING) {
+			browsing_failed = true;
+		}
 
+		if (browsing_failed)
+			session->init(session);
+		break;
+	case AVCTP_STATE_BROWSING_CONNECTED:
+		if (session == NULL)
+			break;
+
+		session->init(session);
+		break;
 	default:
 		return;
 	}
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index d4ba6d2..2aa22bb 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -289,6 +289,10 @@ static void device_avctp_cb(struct audio_device *dev,
 		break;
 	case AVCTP_STATE_CONNECTED:
 		break;
+	case AVCTP_STATE_BROWSING_CONNECTING:
+		break;
+	case AVCTP_STATE_BROWSING_CONNECTED:
+		break;
 	}
 }
 
-- 
1.8.1

