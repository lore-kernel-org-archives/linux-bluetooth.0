Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] Fix handling of a2dp suspend indication
Date: Mon, 22 Aug 2011 16:25:46 +0300
Message-Id: <1314019551-3471-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
References: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When accepting the suspend indication all callbacks should be notified
that suspend completed.
---
 audio/a2dp.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 09b6572..38d25bf 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -989,6 +989,9 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_setup *setup;
+	gboolean start;
+	int perr;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Suspend_Ind", sep);
@@ -1002,6 +1005,29 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 		a2dp_sep->session = NULL;
 	}
 
+	if (!a2dp_sep->suspending)
+		return TRUE;
+
+	a2dp_sep->suspending = FALSE;
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return TRUE;
+
+	start = setup->start;
+	setup->start = FALSE;
+
+	finalize_suspend(setup);
+
+	if (!start)
+		return TRUE;
+
+	perr = avdtp_start(session, a2dp_sep->stream);
+	if (perr < 0) {
+		error("Error on avdtp_start %s (%d)", strerror(-perr), -perr);
+		finalize_setup_errno(setup, -EIO, finalize_resume);
+	}
+
 	return TRUE;
 }
 
-- 
1.7.6

