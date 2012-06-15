Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] audio: Fix handling of a2dp suspend indication
Date: Fri, 15 Jun 2012 11:04:22 +0300
Message-Id: <1339747468-31639-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339747468-31639-1-git-send-email-luiz.dentz@gmail.com>
References: <1339747468-31639-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When accepting the suspend indication all callbacks should be notified
that suspend completed.
---
 audio/a2dp.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 4df7b5c..2ba6c8d 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -985,6 +985,9 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_setup *setup;
+	gboolean start;
+	int perr;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Suspend_Ind", sep);
@@ -998,6 +1001,29 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
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
1.7.10.2

