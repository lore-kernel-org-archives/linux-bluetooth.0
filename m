Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 2/6] android/a2dp: Notify audio state on SEP close
Date: Mon, 10 Feb 2014 11:45:41 +0100
Message-ID: <1392029145-7954-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392029145-7954-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392029145-7954-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/a2dp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 8cff535..4c6ab18 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -990,6 +990,8 @@ static gboolean sep_close_ind(struct avdtp *session,
 		return FALSE;
 	}
 
+	bt_audio_notify_state(setup, HAL_AUDIO_STOPPED);
+
 	setup_remove(setup);
 
 	return TRUE;
@@ -1163,13 +1165,23 @@ static void sep_close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			void *user_data)
 {
 	struct a2dp_endpoint *endpoint = user_data;
+	struct a2dp_setup *setup;
 
 	DBG("");
 
 	if (err)
 		return;
 
-	setup_remove_by_id(endpoint->id);
+	setup = find_setup(endpoint->id);
+	if (!setup) {
+		error("Unable to find stream setup for %u endpoint",
+								endpoint->id);
+		return;
+	}
+
+	bt_audio_notify_state(setup, HAL_AUDIO_STOPPED);
+
+	setup_remove(setup);
 }
 
 static void sep_abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
-- 
1.8.5.3

