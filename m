Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] audio: Fix handling of a2dp open indication
Date: Fri, 15 Jun 2012 11:04:23 +0300
Message-Id: <1339747468-31639-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339747468-31639-1-git-send-email-luiz.dentz@gmail.com>
References: <1339747468-31639-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When accepting the open indication all config callbacks should be
notified that open completed.
---
 audio/a2dp.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 2ba6c8d..cf8ffda 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -882,11 +882,22 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Open_Ind", sep);
 	else
 		DBG("Source %p: Open_Ind", sep);
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return TRUE;
+
+	if (setup->reconfigure)
+		setup->reconfigure = FALSE;
+
+	finalize_config(setup);
+
 	return TRUE;
 }
 
-- 
1.7.10.2

