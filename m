Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 3/5] android/avdtp: Remove extra check
Date: Thu, 19 Feb 2015 17:46:45 +0200
Message-Id: <1424360807-14402-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424360807-14402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424360807-14402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avdtp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 35bc548..b8a2147 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -3372,9 +3372,6 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 	if (!seid)
 		return NULL;
 
-	if (queue_length(lseps) > MAX_SEID)
-		return NULL;
-
 	sep = g_new0(struct avdtp_local_sep, 1);
 
 	sep->state = AVDTP_STATE_IDLE;
-- 
2.1.0

