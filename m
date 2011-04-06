Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Fix handling of a2dp suspend indication
Date: Wed,  6 Apr 2011 14:00:34 +0300
Message-Id: <1302087637-30131-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1302087637-30131-1-git-send-email-luiz.dentz@gmail.com>
References: <1302087637-30131-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When accepting the suspend indication all callbacks should be notified
that suspend completed.
---
 audio/a2dp.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 1f3bc99..c7b6c6a 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -986,6 +986,9 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_setup *setup;
+	gboolean start;
+	int perr;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Suspend_Ind", sep);
@@ -999,6 +1002,29 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
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
1.7.1

