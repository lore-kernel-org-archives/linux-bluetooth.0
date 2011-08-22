Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] Fix handling of a2dp start indication
Date: Mon, 22 Aug 2011 16:25:48 +0300
Message-Id: <1314019551-3471-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
References: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Only process callbacks if avdtp_start was sent, otherwise it may cancel
setup callbacks that were registere via g_idle_add.
---
 audio/a2dp.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 5600a60..f6ad632 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -957,10 +957,6 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		DBG("Source %p: Start_Ind", sep);
 
-	setup = find_setup_by_session(session);
-	if (setup)
-		finalize_resume(setup);
-
 	if (!a2dp_sep->locked) {
 		a2dp_sep->session = avdtp_ref(session);
 		a2dp_sep->suspend_timer = g_timeout_add_seconds(SUSPEND_TIMEOUT,
@@ -968,6 +964,15 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 						a2dp_sep);
 	}
 
+	if (!a2dp_sep->starting)
+		return TRUE;
+
+	a2dp_sep->starting = FALSE;
+
+	setup = find_setup_by_session(session);
+	if (setup)
+		finalize_resume(setup);
+
 	return TRUE;
 }
 
@@ -983,6 +988,8 @@ static void start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		DBG("Source %p: Start_Cfm", sep);
 
+	a2dp_sep->starting = FALSE;
+
 	setup = find_setup_by_session(session);
 	if (!setup)
 		return;
@@ -2221,6 +2228,7 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 			error("avdtp_start failed");
 			goto failed;
 		}
+		sep->starting = TRUE;
 		break;
 	case AVDTP_STATE_STREAMING:
 		if (!sep->suspending && sep->suspend_timer) {
-- 
1.7.6

