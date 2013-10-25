Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] android/hal: Add support for handling av audio state event
Date: Fri, 25 Oct 2013 17:52:05 +0200
Message-Id: <1382716327-25283-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-av.c  | 11 +++++++++++
 android/hal-msg.h |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/android/hal-av.c b/android/hal-av.c
index 8aa096d..d537e84 100644
--- a/android/hal-av.c
+++ b/android/hal-av.c
@@ -38,6 +38,14 @@ static void handle_connection_state(void *buf)
 						(bt_bdaddr_t *) (ev->bdaddr));
 }
 
+static void handle_audio_state(void *buf)
+{
+	struct hal_msg_ev_bt_av_audio_state *ev = buf;
+
+	if (cbs->audio_state_cb)
+		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *)(ev->bdaddr));
+}
+
 /* will be called from notification thread context */
 void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -48,6 +56,9 @@ void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_MSG_EV_BT_AV_CONNECTION_STATE:
 		handle_connection_state(buf);
 		break;
+	case HAL_MSG_EV_BT_AV_AUDIO_STATE:
+		handle_audio_state(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 558e030..2206f47 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -366,3 +366,9 @@ struct hal_msg_ev_bt_av_connection_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
+
+#define HAL_MSG_EV_BT_AV_AUDIO_STATE	0x82
+struct hal_msg_ev_bt_av_audio_state {
+	uint8_t state;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
-- 
1.8.4.1

