Return-Path: <cyrus@holtmann.org>
From: <joohi.rastogi@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <joohi.rastogi@stericsson.com>
Subject: [PATCH] AVRCP: Fixed response length for Subunit Info command
Date: Thu, 5 Apr 2012 11:28:08 +0530
Message-ID: <1333605488-23543-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joohi Rastogi <joohi.rastogi@stericsson.com>

This affect PTS Test Case TC_TG_ICC_BV_02_I
---
 audio/avctp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 009b94c..d8f740a 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -295,7 +295,7 @@ static size_t handle_subunit_info(struct avctp *session,
 
 	DBG("reply to AVC_OP_SUBUNITINFO");
 
-	return 0;
+	return operand_count;
 }
 
 static struct avctp_pdu_handler *find_handler(GSList *list, uint8_t opcode)
-- 
1.7.5.4

