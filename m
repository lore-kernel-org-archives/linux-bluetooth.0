Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/10 v4] AVRCP: Add support to UIDs changed event for CT role
Date: Mon,  4 Mar 2013 10:06:09 +0200
Message-Id: <1362384369-20709-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362384369-20709-1-git-send-email-luiz.dentz@gmail.com>
References: <1362384369-20709-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for registering to UIDs changed event if supported by
TG.
---
 profiles/audio/avrcp.c | 11 +++++++++++
 profiles/audio/avrcp.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 84860c8..b0117de 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2226,6 +2226,13 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 	avrcp_get_media_player_list(session);
 }
 
+static void avrcp_uids_changed(struct avrcp *session, struct avrcp_header *pdu)
+{
+	struct avrcp_player *player = session->player;
+
+	player->uid_counter = bt_get_be16(&pdu->params[1]);
+}
+
 static gboolean avrcp_handle_event(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
@@ -2262,6 +2269,9 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		avrcp_addressed_player_changed(session, pdu);
 		break;
+	case AVRCP_EVENT_UIDS_CHANGED:
+		avrcp_uids_changed(session, pdu);
+		break;
 	}
 
 	session->registered_events |= (1 << event);
@@ -2443,6 +2453,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 		case AVRCP_EVENT_TRACK_CHANGED:
 		case AVRCP_EVENT_SETTINGS_CHANGED:
 		case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+		case AVRCP_EVENT_UIDS_CHANGED:
 			avrcp_register_notification(session, event);
 			break;
 		}
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 3799da1..f452c2c 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -75,6 +75,7 @@
 #define AVRCP_EVENT_TRACK_REACHED_START		0x04
 #define AVRCP_EVENT_SETTINGS_CHANGED		0x08
 #define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED	0x0b
+#define AVRCP_EVENT_UIDS_CHANGED		0x0c
 #define AVRCP_EVENT_VOLUME_CHANGED		0x0d
 #define AVRCP_EVENT_LAST			AVRCP_EVENT_VOLUME_CHANGED
 
-- 
1.8.1.2

