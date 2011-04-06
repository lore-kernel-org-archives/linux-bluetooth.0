Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Fix handling of a2dp start indication
Date: Wed,  6 Apr 2011 14:00:36 +0300
Message-Id: <1302087637-30131-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1302087637-30131-1-git-send-email-luiz.dentz@gmail.com>
References: <1302087637-30131-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Only process callbacks if avdtp_start was sent, otherwise it may cancel
setup callbacks that were registered via g_idle_add.
---
 audio/a2dp.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index a607f06..e7234eb 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -954,10 +954,6 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		DBG("Source %p: Start_Ind", sep);
 
-	setup = find_setup_by_session(session);
-	if (setup)
-		finalize_resume(setup);
-
 	if (!a2dp_sep->locked) {
 		a2dp_sep->session = avdtp_ref(session);
 		a2dp_sep->suspend_timer = g_timeout_add_seconds(SUSPEND_TIMEOUT,
@@ -965,6 +961,15 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
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
 
@@ -980,6 +985,8 @@ static void start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		DBG("Source %p: Start_Cfm", sep);
 
+	a2dp_sep->starting = FALSE;
+
 	setup = find_setup_by_session(session);
 	if (!setup)
 		return;
@@ -2209,6 +2216,7 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 			error("avdtp_start failed");
 			goto failed;
 		}
+		sep->starting = TRUE;
 		break;
 	case AVDTP_STATE_STREAMING:
 		if (!sep->suspending && sep->suspend_timer) {
-- 
1.7.1

