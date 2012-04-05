Return-Path: <cyrus@holtmann.org>
From: <joohi.rastogi@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <joohi.rastogi@stericsson.com>
Subject: [PATCH] AVRCP: Fixed response length for Unit Info command
Date: Thu, 5 Apr 2012 11:11:09 +0530
Message-ID: <1333604469-18883-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joohi Rastogi <joohi.rastogi@stericsson.com>

This affect PTS Test Case TC_TG_ICC_BV_01_I
---
 audio/avctp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 009b94c..91a7886 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -271,7 +271,7 @@ static size_t handle_unit_info(struct avctp *session,
 
 	DBG("reply to AVC_OP_UNITINFO");
 
-	return 0;
+	return operand_count;
 }
 
 static size_t handle_subunit_info(struct avctp *session,
-- 
1.7.5.4

