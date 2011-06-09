Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix AVCTP reply for message with invalid PID
Date: Thu, 9 Jun 2011 15:55:50 +0200
Message-ID: <1307627750-5346-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reply for control message with invalid (not registered for reception
of messages) PID should not have message information field present.

This was affecting AVCTP 1.3 qualification test case TP/NFR/BI-01-C.
---
 audio/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 9ede0f2..3db7d8e 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -566,7 +566,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 	} else if (avctp->pid != htons(AV_REMOTE_SVCLASS_ID)) {
 		avctp->ipid = 1;
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_REJECTED;
+		packet_size = sizeof(*avctp);
 	} else if (avctp->cr == AVCTP_COMMAND &&
 			avrcp->code == CTYPE_CONTROL &&
 			avrcp->subunit_type == SUBUNIT_PANEL &&
-- 
on behalf of ST-Ericsson

