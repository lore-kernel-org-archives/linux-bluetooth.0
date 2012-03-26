Return-Path: <cyrus@holtmann.org>
From: Joohi RASTOGI <joohi.rastogi@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 26 Mar 2012 08:44:55 +0200
Subject: [PATCH Bluez] avcrp: Fix response length for unit info command.
Message-ID: <3176460F0F455A44B2E93431E34FC86C1F884413AE@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Fixed response length for Unit Info command. This affect PTS Test Case for TC_TG_ICC_BV_01_I.

>From f03c6037836bf8ef5253f8d87edb8ec2db0742af Mon Sep 17 00:00:00 2001
From: Joohi Rastogi <joohi.rastogi@stericsson.com>
Date: Mon, 26 Mar 2012 11:53:19 +0530
Subject: [PATCH Bluez] avcrp: Fix response length for unit info command.

---
 audio/avctp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index dfad9fd..5b84977 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -268,7 +268,7 @@ static size_t handle_unit_info(struct avctp *session,
 
 	DBG("reply to AVC_OP_UNITINFO");
 
-	return 0;
+	return operand_count;
 }
 
 static size_t handle_subunit_info(struct avctp *session,
-- 
1.7.5.4

-Joohi Rastogi
