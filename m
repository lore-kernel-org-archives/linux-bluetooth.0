Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] audio: Fix handling of a2dp abort indication
Date: Fri, 15 Jun 2012 11:04:25 +0300
Message-Id: <1339747468-31639-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339747468-31639-1-git-send-email-luiz.dentz@gmail.com>
References: <1339747468-31639-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When an abort is received all setup callbacks should return an error.
---
 audio/a2dp.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index cc94fbe..094476e 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1179,6 +1179,7 @@ static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Abort_Ind", sep);
@@ -1187,6 +1188,14 @@ static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 
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
1.7.10.2

