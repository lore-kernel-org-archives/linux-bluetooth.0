Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/avctp: Fix memory leak: unregister pdu handler
Date: Tue,  4 Feb 2014 11:28:09 +0200
Message-Id: <1391506089-23985-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Unregister pdu handlers on shutdown.
---
 android/avctp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/avctp.c b/android/avctp.c
index 8f35403..8681cb0 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -1462,6 +1462,15 @@ void avctp_shutdown(struct avctp *session)
 	if (session->browsing)
 		avctp_channel_destroy(session->browsing);
 
+	if (session->passthrough_id > 0)
+		avctp_unregister_pdu_handler(session, session->passthrough_id);
+
+	if (session->unit_id > 0)
+		avctp_unregister_pdu_handler(session, session->unit_id);
+
+	if (session->subunit_id > 0)
+		avctp_unregister_pdu_handler(session, session->subunit_id);
+
 	if (session->control)
 		avctp_channel_destroy(session->control);
 
-- 
1.8.3.2

