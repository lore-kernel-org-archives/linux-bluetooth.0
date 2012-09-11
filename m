Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Anurag Gupta <anurag.gupta@stericsson.com>,
	Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Subject: [PATCH] avctp: Fix reply for message with invalid PID
Date: Tue, 11 Sep 2012 08:16:26 +0200
Message-ID: <1347344186-8517-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reply for control message with invalid (not registered for reception
of messages) PID should not have message information field present.

This was affecting AVCTP qualification test case TP/NFR/BI-01-C.
---
 audio/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 03f3e7f..4e0e8dc 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -500,7 +500,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 
 	if (avctp->pid != htons(AV_REMOTE_SVCLASS_ID)) {
 		avctp->ipid = 1;
-		avc->code = AVC_CTYPE_REJECTED;
+		packet_size = AVCTP_HEADER_LENGTH;
 		goto done;
 	}
 
-- 
1.7.11.3

