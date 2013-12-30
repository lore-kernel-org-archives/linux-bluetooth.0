Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 3/9] android: Add audio open command/response struct
Date: Mon, 30 Dec 2013 14:34:09 +0200
Message-Id: <1388406855-8809-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
References: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definitions to audio open command and response.
---
 android/a2dp.c            |  9 +++++++++
 android/audio-ipc-api.txt |  2 +-
 android/hal-msg.h         | 18 ++++++++++++++++++
 android/ipc.c             |  5 ++++-
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 63f1f58..5cb01f7 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -352,7 +352,16 @@ static sdp_record_t *a2dp_record(void)
 	return record;
 }
 
+static void bt_audio_open(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AUDIO, AUDIO_OP_OPEN, HAL_STATUS_FAILED);
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
index 1afb1bc..4b52e5e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -567,3 +567,21 @@ struct hal_ev_a2dp_audio_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
+
+#define AUDIO_OP_OPEN				0x01
+struct audio_cmd_open {
+	uint16_t uuid;
+	uint8_t codec;
+	uint8_t presets;
+	uint8_t len;
+	uint8_t data[0];
+} __attribute__((packed));
+
+struct audio_preset {
+	uint8_t len;
+	uint8_t data[0];
+} __attribute__((packed));
+
+struct audio_rsp_open {
+	uint8_t id;
+} __attribute__((packed));
diff --git a/android/ipc.c b/android/ipc.c
index 6cdbf60..bb16553 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -301,7 +301,10 @@ void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status)
 	struct hal_status s;
 	int sk;
 
-	sk = g_io_channel_unix_get_fd(cmd_io);
+	if (service_id == HAL_SERVICE_ID_AUDIO)
+		sk = g_io_channel_unix_get_fd(audio_io);
+	else
+		sk = g_io_channel_unix_get_fd(cmd_io);
 
 	if (status == HAL_STATUS_SUCCESS) {
 		ipc_send(sk, service_id, opcode, 0, NULL, -1);
-- 
1.8.4.2

