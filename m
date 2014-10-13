Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] unit/test-avrcp: Add /TP/MCN/NP/BV-07-C test
Date: Mon, 13 Oct 2014 12:55:50 +0300
Message-Id: <1413194150-21751-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1413194150-21751-1-git-send-email-luiz.dentz@gmail.com>
References: <1413194150-21751-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify the NowPlayingContentChanged Notification issued by the TG.
---
 android/avrcp-lib.h |  1 +
 unit/test-avrcp.c   | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 2299c83..8e6ee40 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -54,6 +54,7 @@
 #define AVRCP_EVENT_TRACK_REACHED_START		0x04
 #define AVRCP_EVENT_PLAYBACK_POS_CHANGED	0x05
 #define AVRCP_EVENT_SETTINGS_CHANGED		0x08
+#define AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED	0x09
 #define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED	0x0a
 #define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED	0x0b
 #define AVRCP_EVENT_UIDS_CHANGED		0x0c
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 4f6526c..b26c553 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -631,6 +631,23 @@ static int uids_changed(struct avrcp *session, uint8_t transaction,
 	return 0;
 }
 
+static int now_playing_content_changed(struct avrcp *session,
+					uint8_t transaction, uint32_t interval,
+					void *user_data)
+{
+	DBG("");
+
+	avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_INTERIM,
+					AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED,
+					NULL, 0);
+
+	avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_CHANGED,
+					AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED,
+					NULL, 0);
+
+	return 0;
+}
+
 static int register_notification(struct avrcp *session, uint8_t transaction,
 					uint8_t event, uint32_t interval,
 					void *user_data)
@@ -651,6 +668,9 @@ static int register_notification(struct avrcp *session, uint8_t transaction,
 								user_data);
 	case AVRCP_EVENT_UIDS_CHANGED:
 		return uids_changed(session, transaction, interval, user_data);
+	case AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED:
+		return now_playing_content_changed(session, transaction,
+							interval, user_data);
 	default:
 		return -EINVAL;
 	}
@@ -1404,6 +1424,19 @@ int main(int argc, char *argv[])
 			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
 				0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00));
 
+	/* NowPlayingContentChanged Notification – TG */
+	define_test("/TP/MCN/NP/BV-07-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05, 0x09,
+				0x00, 0x00, 0x00, 0x00),
+			frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x01, 0x09),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x01, 0x09));
+
 	/* GetItemAttributes - CT */
 	define_test("/TP/MCN/NP/BV-08-C", test_client,
 			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
-- 
1.9.3

