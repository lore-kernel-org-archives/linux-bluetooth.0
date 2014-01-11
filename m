Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] audio/A2DP: Add implemention of audio Suspend Stream command
Date: Sat, 11 Jan 2014 12:13:36 +0200
Message-Id: <1389435216-29040-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389435216-29040-1-git-send-email-luiz.dentz@gmail.com>
References: <1389435216-29040-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 2d886e9..8d7d554 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -805,8 +805,29 @@ failed:
 
 static void bt_stream_suspend(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct audio_cmd_suspend_stream *cmd = buf;
+	struct a2dp_setup *setup;
+	int err;
+
+	DBG("");
+
+	setup = find_setup(cmd->id);
+	if (!setup) {
+		error("Unable to find stream for endpoint %u", cmd->id);
+		goto failed;
+	}
+
+	err = avdtp_suspend(setup->dev->session, setup->stream);
+	if (err < 0) {
+		error("avdtp_suspend: %s", strerror(-err));
+		goto failed;
+	}
 
+	audio_ipc_send_rsp(AUDIO_OP_SUSPEND_STREAM, AUDIO_STATUS_SUCCESS);
+
+	return;
+
+failed:
 	audio_ipc_send_rsp(AUDIO_OP_SUSPEND_STREAM, AUDIO_STATUS_FAILED);
 }
 
-- 
1.8.4.2

