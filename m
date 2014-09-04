Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: test IOPT TC_SDAS_BV_03_I against PTS 5.2
Date: Thu,  4 Sep 2014 10:27:18 +0200
Message-Id: <1409819238-19371-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-iopt.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pts-iopt.txt b/android/pts-iopt.txt
index 3065836..2ce572c 100644
--- a/android/pts-iopt.txt
+++ b/android/pts-iopt.txt
@@ -18,7 +18,7 @@ TC_COD_BV_02_I	N/A	Under PTS 5.1 test shall be disabled as there is
 			matching test case in HFP test suit (test No. 15)
 			PICS settings for HFP shall be disabled for IOPT
 TC_SDSS_BV_02_I	PASS
-TC_SDSA_BV_03_I	FAIL	JIRA #BA-92
+TC_SDSA_BV_03_I	PASS
 TC_SDR_BV_04_I	PASS	for every PTS bt profile:
 			haltest: bluetooth get_remote_service_record <addr>
 							<requred 128 sdp uuid>
-- 
1.8.5.3

