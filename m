Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianchlad@gmail.com>
Subject: [PATCH 1/4] android/avctp: PTS tests results for AVCTP
Date: Mon, 24 Mar 2014 15:14:54 +0100
Message-Id: <1395670497-12969-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sebastian Chlad <sebastianchlad@gmail.com>

---
 android/pts-avctp.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
index 64fd5fc..e7b0ab9 100644
--- a/android/pts-avctp.txt
+++ b/android/pts-avctp.txt
@@ -1,7 +1,7 @@
 PTS test results for AVCTP
 
 PTS version: 5.0
-Tested: 18-Mar-2014
+Tested: 24-Mar-2014
 Android version: 4.4.2
 
 Results:
@@ -20,7 +20,7 @@ TC_CT_CCM_BV_03_C	N/A
 TC_CT_CCM_BV_04_C	N/A
 TC_CT_CCM_BI_01_C	N/A
 TC_CT_NFR_BV_01_C	N/A
-TC_CT_NFR_BV_04_C	N/A
+TC_CT_NFR_BV_04_C	INC
 TC_CT_FRA_BV_01_C	N/A
 TC_CT_FRA_BV_04_C	N/A
 -------------------------------------------------------------------------------
@@ -30,12 +30,12 @@ TC_CT_FRA_BV_04_C	N/A
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_TG_CCM_BV_01_C	PASS
+TC_TG_CCM_BV_01_C	INC
 TC_TG_CCM_BV_02_C	PASS
 TC_TG_CCM_BV_03_C	PASS
-TC_TG_CCM_BV_04_C	PASS
-TC_TG_NFR_BV_02_C	PASS
-TC_TG_NFR_BV_03_C	PASS
+TC_TG_CCM_BV_04_C	INC
+TC_TG_NFR_BV_02_C	INC
+TC_TG_NFR_BV_03_C	INC
 TC_TG_NFR_BI_01_C	PASS
 TC_TG_FRA_BV_02_C	N/A	Fragmentation not supported
 TC_TG_FRA_BV_03_C	N/A	Fragmentation not supported
-- 
1.8.5.3

