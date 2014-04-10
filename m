Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 4/4] android/pts: Re-test PBAP against PTS 5.1
Date: Thu, 10 Apr 2014 09:59:27 +0200
Message-Id: <1397116767-18192-4-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1397116767-18192-1-git-send-email-sebastian.chlad@tieto.com>
References: <1397116767-18192-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-pbap.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
index ecaaefa..cd6dcb6 100644
--- a/android/pts-pbap.txt
+++ b/android/pts-pbap.txt
@@ -1,7 +1,7 @@
 PTS test results for PBAP
 
-PTS version: 5.0
-Tested: 19-Feb-2014
+PTS version: 5.1
+Tested: 08-April-2014
 Android version: 4.4.2
 
 Results:
@@ -73,7 +73,7 @@ TC_PSE_PBD_BV_07_C	N/A
 TC_PSE_PBD_BV_08_C	N/A
 TC_PSE_PBD_BV_09_C	N/A
 TC_PSE_PBD_BV_10_C	N/A
-TC_PSE_PBD_BV_17_C	PASS	PTS 5.0 issue #11816 (updated ETS available)
+TC_PSE_PBD_BV_17_C	PASS
 TC_PSE_PBD_BV_18_C	N/A
 TC_PSE_PBD_BV_19_C	N/A
 TC_PSE_PBD_BV_20_C	N/A
@@ -132,4 +132,12 @@ TC_PSE_PBF_BV_01_I	PASS
 TC_PSE_PBF_BV_02_I	PASS	Tester must verify vcard content received by PTS
 TC_PSE_PDF_BV_01_I	PASS	Tester must compare phone book size with the
 				value given by PTS
+TC_PSE_BC_BV_03_I	N/A
+TC_PSE_CON_BV_02_I	N/A
+TC_PSE_ROB_BV_01_I	N/A
+TC_PSE_SRM_BI_03_I	N/A
+TC_PSE_SRM_BI_05_I	N/A
+TC_PSE_SRM_BV_08_I	N/A
+TC_PSE_SRMP_BI_02_I	N/A
+TX_PSE_SRMP_BV_02_I	N/A
 -------------------------------------------------------------------------------
-- 
1.8.5.3

