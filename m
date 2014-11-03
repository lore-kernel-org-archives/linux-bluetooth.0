Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Correct typo in MCAP tests listing
Date: Mon,  3 Nov 2014 16:50:39 +0100
Message-Id: <1415029839-7065-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-mcap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pts-mcap.txt b/android/pts-mcap.txt
index 9d1fdcd..3b4766f 100644
--- a/android/pts-mcap.txt
+++ b/android/pts-mcap.txt
@@ -31,7 +31,7 @@ TC_MCAP_CM_ABT_BV_03_C	N/A
 TC_MCAP_CM_DEL_BV_01_C	N/A
 TC_MCAP_CM_DEL_BV_02_C	INC	PTS Issue #12693
 				mcaptest -C 4099 -D 4101
-TC_MCAP_CM_DEL_BV_02_C	N/A
+TC_MCAP_CM_DEL_BV_03_C	N/A
 TC_MCAP_CM_DEL_BV_04_C	INC	PTS Issue #12693
 				mcaptest -C 4099 -D 4101
 TC_MCAP_CM_DIS_BV_01_C	PASS	mcaptest -C 4099 -D 4101 -e 2 -f 2
-- 
1.8.5.3

