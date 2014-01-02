Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/10] android/A2DP: Add audio close command/response struct
Date: Thu,  2 Jan 2014 13:58:30 +0200
Message-Id: <1388663914-25003-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
References: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definitions to audio close command and response.
---
 android/a2dp.c    | 10 ++++++++++
 android/hal-msg.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 325c282..e3d58ca 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -360,9 +360,19 @@ static void bt_audio_open(const void *buf, uint16_t len)
 							HAL_STATUS_FAILED);
 }
 
+static void bt_audio_close(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	audio_ipc_send_rsp(AUDIO_SERVICE_ID_CORE, AUDIO_OP_CLOSE,
+							HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler audio_handlers[] = {
 	/* AUDIO_OP_OPEN */
 	{ bt_audio_open, true, sizeof(struct audio_cmd_open) },
+	/* AUDIO_OP_CLOSE */
+	{ bt_audio_close, false, sizeof(struct audio_cmd_close) },
 };
 
 bool bt_a2dp_register(const bdaddr_t *addr)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1036988..d1135df 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -588,3 +588,8 @@ struct audio_cmd_open {
 struct audio_rsp_open {
 	uint8_t id;
 } __attribute__((packed));
+
+#define AUDIO_OP_CLOSE				0x02
+struct audio_cmd_close {
+	uint8_t id;
+} __attribute__((packed));
-- 
1.8.4.2

