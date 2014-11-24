Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: PTS tests for HSP on Android 5.0 and PTS 5.3
Date: Mon, 24 Nov 2014 15:44:01 +0100
Message-Id: <1416840241-22060-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-hsp.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/pts-hsp.txt b/android/pts-hsp.txt
index 9031b82..9f03ead 100644
--- a/android/pts-hsp.txt
+++ b/android/pts-hsp.txt
@@ -1,8 +1,8 @@
 PTS test results for HSP
 
 PTS version: 5.3
-Tested: 10-October-2014
-Android version: 4.4.4
+Tested: 24-November-2014
+Android version: 5.0
 
 Results:
 PASS    test passed
@@ -16,8 +16,8 @@ Test Name               Result  Notes
 TC_AG_IAC_BV_01_I	PASS
 TC_AG_IAC_BV_02_I	N/A
 TC_AG_OAC_BV_01_I	PASS
-HSP_TC_AG_ACR_BV_01_I	PASS
-HSP_TC_AG_ACR_BV_02_I	PASS
+TC_AG_ACR_BV_01_I	PASS
+TC_AG_ACR_BV_02_I	PASS
 TC_AG_ACT_BV_01_I	PASS
 TC_AG_ACT_BV_02_I	PASS
 TC_AG_RAV_BV_01_I	PASS
-- 
1.8.5.3

