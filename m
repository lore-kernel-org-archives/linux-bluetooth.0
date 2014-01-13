Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 2/6] audio/A2DP: Add implemention of audio Close command
Date: Mon, 13 Jan 2014 12:35:57 +0200
Message-Id: <1389609361-27883-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389609361-27883-1-git-send-email-luiz.dentz@gmail.com>
References: <1389609361-27883-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index c7e3d8d..88e43d6 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -517,11 +517,37 @@ failed:
 	audio_ipc_send_rsp(AUDIO_OP_OPEN, AUDIO_STATUS_FAILED);
 }
 
+static struct a2dp_endpoint *find_endpoint(uint8_t id)
+{
+	GSList *l;
+
+	for (l = endpoints; l; l = g_slist_next(l)) {
+		struct a2dp_endpoint *endpoint = l->data;
+
+		if (endpoint->id == id)
+			return endpoint;
+	}
+
+	return NULL;
+}
+
 static void bt_audio_close(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct audio_cmd_close *cmd = buf;
+	struct a2dp_endpoint *endpoint;
+
+	DBG("");
+
+	endpoint = find_endpoint(cmd->id);
+	if (!endpoint) {
+		error("Unable to find endpoint %u", cmd->id);
+		audio_ipc_send_rsp(AUDIO_OP_CLOSE, AUDIO_STATUS_FAILED);
+		return;
+	}
+
+	unregister_endpoint(endpoint);
 
-	audio_ipc_send_rsp(AUDIO_OP_CLOSE, HAL_STATUS_FAILED);
+	audio_ipc_send_rsp(AUDIO_OP_CLOSE, AUDIO_STATUS_SUCCESS);
 }
 
 static void bt_stream_open(const void *buf, uint16_t len)
-- 
1.8.4.2

