Return-Path: <cyrus@holtmann.org>
From: chen.ganir@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH] Fixed wrong AVCTP response to unregistered PID
Date: Tue, 28 Jun 2011 14:28:41 +0300
Message-Id: <1309260521-9943-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

AVCTP response to unregistered PID should consist only
from the first 3 octets of the AVCTP header, without
any additional frame data (Fix for PTS certification
issue)
---
 audio/control.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index ceb3d88..7c92d10 100755
--- a/audio/control.c
+++ b/audio/control.c
@@ -580,9 +580,10 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 		avctp->cr = AVCTP_RESPONSE;
 		avrcp->code = CTYPE_NOT_IMPLEMENTED;
 	} else if (avctp->pid != htons(AV_REMOTE_SVCLASS_ID)) {
+		DBG("AVCTP invalid pid (%d) specified. Rejecting request",avctp->pid);
 		avctp->ipid = 1;
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_REJECTED;
+		packet_size = sizeof(struct avctp_header);
 	} else if (avctp->cr == AVCTP_COMMAND &&
 			avrcp->code == CTYPE_CONTROL &&
 			avrcp->subunit_type == SUBUNIT_PANEL &&
-- 
1.7.1

