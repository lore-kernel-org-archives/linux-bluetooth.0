Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 6/6] audio/A2DP: Add implemention of audio Suspend Stream command
Date: Mon, 13 Jan 2014 09:52:05 +0200
Message-Id: <1389599525-6353-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389599525-6353-1-git-send-email-luiz.dentz@gmail.com>
References: <1389599525-6353-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 0598d4d..9061984 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -807,8 +807,29 @@ failed:
 
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

