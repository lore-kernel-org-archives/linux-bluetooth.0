Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/10] android/A2DP: Add audio open command/response struct
Date: Thu,  2 Jan 2014 13:58:29 +0200
Message-Id: <1388663914-25003-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
References: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definitions to audio open command and response.
---
 android/a2dp.c            | 10 ++++++++++
 android/audio-ipc-api.txt |  2 +-
 android/hal-msg.h         | 18 ++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 7550644..325c282 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -352,7 +352,17 @@ static sdp_record_t *a2dp_record(void)
 	return record;
 }
 
+static void bt_audio_open(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	audio_ipc_send_rsp(AUDIO_SERVICE_ID_CORE, AUDIO_OP_OPEN,
+							HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler audio_handlers[] = {
+	/* AUDIO_OP_OPEN */
+	{ bt_audio_open, true, sizeof(struct audio_cmd_open) },
 };
 
 bool bt_a2dp_register(const bdaddr_t *addr)
diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
index 1c42800..37a1569 100644
--- a/android/audio-ipc-api.txt
+++ b/android/audio-ipc-api.txt
@@ -49,9 +49,9 @@ Identifier: "audio" (BT_AUDIO_ID)
 
 		Command parameters: Service UUID (16 octets)
 				    Codec ID (1 octet)
+				    Number of codec presets (1 octet)
 				    Codec capabilities length (1 octet)
 				    Codec capabilities (variable)
-				    Number of codec presets (1 octet)
 				    Codec preset # length (1 octet)
 				    Codec preset # configuration (variable)
 				    ...
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 267f9b2..1036988 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -570,3 +570,21 @@ struct hal_ev_a2dp_audio_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
+
+#define AUDIO_OP_OPEN				0x01
+struct audio_preset {
+	uint8_t len;
+	uint8_t data[0];
+} __attribute__((packed));
+
+struct audio_cmd_open {
+	uint16_t uuid;
+	uint8_t codec;
+	uint8_t presets;
+	uint8_t len;
+	struct audio_preset preset[0];
+} __attribute__((packed));
+
+struct audio_rsp_open {
+	uint8_t id;
+} __attribute__((packed));
-- 
1.8.4.2

