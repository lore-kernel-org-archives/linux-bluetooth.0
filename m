Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 06/10] android/A2DP: Add audio close command/response struct
Date: Tue,  7 Jan 2014 13:53:19 +0200
Message-Id: <1389095603-30504-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
References: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definitions to audio close command and response.
---
 android/a2dp.c      | 9 +++++++++
 android/audio-msg.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 38384f6..97e2778 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -361,9 +361,18 @@ static void bt_audio_open(const void *buf, uint16_t len)
 	audio_ipc_send_rsp(AUDIO_OP_OPEN, AUDIO_STATUS_FAILED);
 }
 
+static void bt_audio_close(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	audio_ipc_send_rsp(AUDIO_OP_CLOSE, HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler audio_handlers[] = {
 	/* AUDIO_OP_OPEN */
 	{ bt_audio_open, true, sizeof(struct audio_cmd_open) },
+	/* AUDIO_OP_CLOSE */
+	{ bt_audio_close, false, sizeof(struct audio_cmd_close) },
 };
 
 bool bt_a2dp_register(const bdaddr_t *addr)
diff --git a/android/audio-msg.h b/android/audio-msg.h
index 158a2ab..6ac1fff 100644
--- a/android/audio-msg.h
+++ b/android/audio-msg.h
@@ -52,3 +52,8 @@ struct audio_cmd_open {
 struct audio_rsp_open {
 	uint8_t id;
 } __attribute__((packed));
+
+#define AUDIO_OP_CLOSE			0x02
+struct audio_cmd_close {
+	uint8_t id;
+} __attribute__((packed));
-- 
1.8.4.2

