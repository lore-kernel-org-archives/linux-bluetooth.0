Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Fix handling of a2dp abort indication
Date: Wed,  6 Apr 2011 14:00:37 +0300
Message-Id: <1302087637-30131-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1302087637-30131-1-git-send-email-luiz.dentz@gmail.com>
References: <1302087637-30131-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When an abort indication is received reset all flags and finalize any
ongoing setup.
---
 audio/a2dp.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index e7234eb..719658b 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1180,6 +1180,7 @@ static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Abort_Ind", sep);
@@ -1187,6 +1188,16 @@ static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 		DBG("Source %p: Abort_Ind", sep);
 
 	a2dp_sep->stream = NULL;
+	a2dp_sep->suspending = FALSE;
+	a2dp_sep->starting = FALSE;
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return TRUE;
+
+	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
+							finalize_resume,
+							finalize_config);
 
 	return TRUE;
 }
-- 
1.7.1

