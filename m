Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Update PTS tests for SPP
Date: Wed, 23 Jul 2014 09:17:56 +0200
Message-Id: <1406099876-30435-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-spp.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/pts-spp.txt b/android/pts-spp.txt
index 9a877ad..ade99d9 100644
--- a/android/pts-spp.txt
+++ b/android/pts-spp.txt
@@ -20,6 +20,8 @@ TC_DevB_APP_BV_02_C	PASS	haltest: socket listen BTSOCK_RFCOMM
 				<srvc_name> <uuid>
 TC_APP_BV_03_C		N/A	Missing in PTS
 				PTS issue #12388
+				Note: tests BV_03 : BV_6 currently not supported 
+				ETA: December 2014 (PTS 6.0)
 TC_APP_BV_04_C		N/A	Missing in PTS
 TC_APP_BV_05_C		N/A	Missing in PTS
 TC_APP_BV_06_C		N/A	Missing in PTS
-- 
1.8.5.3

