Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] android/A2DP: Notify when audio state change to stopped
Date: Fri, 17 Jan 2014 15:33:06 +0200
Message-Id: <1389965587-20066-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389965587-20066-1-git-send-email-luiz.dentz@gmail.com>
References: <1389965587-20066-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 515cf17..12a8a69 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1106,13 +1106,23 @@ static void sep_suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			void *user_data)
 {
 	struct a2dp_endpoint *endpoint = user_data;
+	struct a2dp_setup *setup;
 
 	DBG("");
 
-	if (!err)
+	if (err) {
+		setup_remove_by_id(endpoint->id);
 		return;
+	}
 
-	setup_remove_by_id(endpoint->id);
+	setup = find_setup(endpoint->id);
+	if (!setup) {
+		error("Unable to find stream setup for %u endpoint",
+								endpoint->id);
+		return;
+	}
+
+	bt_audio_notify_state(setup, HAL_AUDIO_STOPPED);
 }
 
 static void sep_close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
-- 
1.8.4.2

