Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] avctp: Fix memory leak
Date: Tue,  4 Feb 2014 11:50:46 +0200
Message-Id: <1391507446-24171-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Unregister pdu hanlders in avctp_disconnected()
---
 profiles/audio/avctp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index a77aa9d..a28cf71 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -496,6 +496,15 @@ static void avctp_disconnected(struct avctp *session)
 	if (!session)
 		return;
 
+	if (session->passthrough_id > 0)
+		avctp_unregister_pdu_handler(session->passthrough_id);
+
+	if (session->unit_id > 0)
+		avctp_unregister_pdu_handler(session->unit_id);
+
+	if (session->subunit_id > 0)
+		avctp_unregister_pdu_handler(session->subunit_id);
+
 	if (session->browsing)
 		avctp_channel_destroy(session->browsing);
 
-- 
1.8.3.2

