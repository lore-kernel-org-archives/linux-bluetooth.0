Return-Path: <cyrus@holtmann.org>
From: Joohi RASTOGI <joohi.rastogi@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 27 Mar 2012 10:09:10 +0200
Subject: [PATCH Bluez] AVRCP: Fix response length for Subunit info command
Message-ID: <3176460F0F455A44B2E93431E34FC86C1F884A624F@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Fixed response length for Subunit Info command. This affect PTS Test Case for TC_TG_ICC_BV_02_I.

>From 1c00b2eb68706fc3ec0e36b74c6713903f848f85 Mon Sep 17 00:00:00 2001
From: Joohi Rastogi <joohi.rastogi@stericsson.com>
Date: Tue, 27 Mar 2012 13:29:41 +0530
Subject: [PATCH Bluez] AVRCP: Fix response length for Subunit info command.

---
 audio/avctp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index dfad9fd..9733c79 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -292,7 +292,7 @@ static size_t handle_subunit_info(struct avctp *session,

        DBG("reply to AVC_OP_SUBUNITINFO");

-       return 0;
+       return operand_count;
 }

 static struct avctp_pdu_handler *find_handler(GSList *list, uint8_t opcode)
-- 
1.7.5.4

-Joohi Rastogi
