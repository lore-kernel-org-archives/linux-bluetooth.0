Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] Fix handling of a2dp open indication
Date: Mon, 22 Aug 2011 16:25:47 +0300
Message-Id: <1314019551-3471-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
References: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When accepting the open indication all config callbacks should be
notified that open completed.
---
 audio/a2dp.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 38d25bf..5600a60 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -886,11 +886,22 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
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
1.7.6

