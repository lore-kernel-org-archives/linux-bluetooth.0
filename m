Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] Fix handling of a2dp abort indication
Date: Mon, 22 Aug 2011 16:25:49 +0300
Message-Id: <1314019551-3471-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
References: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When an abort is received all setup callbacks should return an error.
---
 audio/a2dp.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index f6ad632..10a5e3c 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1183,6 +1183,7 @@ static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Abort_Ind", sep);
@@ -1191,6 +1192,14 @@ static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	a2dp_sep->stream = NULL;
 
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return TRUE;
+
+	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
+							finalize_resume,
+							finalize_config);
+
 	return TRUE;
 }
 
-- 
1.7.6

