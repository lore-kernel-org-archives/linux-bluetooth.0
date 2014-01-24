Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianchlad@gmail.com>
Subject: [PATCH] android/pts: Add PTS test results for PBAP
Date: Fri, 24 Jan 2014 14:56:16 -0500
Message-Id: <1390593376-4905-1-git-send-email-sebastianchlad@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-pbap.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
index 3bf682f..843b7cf 100644
--- a/android/pts-pbap.txt
+++ b/android/pts-pbap.txt
@@ -1,6 +1,6 @@
 PTS test results for PBAP
 
-PTS version: 4.9
+PTS version: 5.0
 Tested: 14.11.2013
 
 Results:
@@ -30,7 +30,7 @@ TC_PCE_PDF_BV_04_I	N/A
 TC_PSE_SSM_BV_03_C	PASS
 TC_PSE_SSM_BV_05_C	PASS
 TC_PSE_SSM_BV_07_C	PASS
-TC_PSE_SSM_BI_02_C	INC
+TC_PSE_SSM_BI_02_C	PASS
 TC_PSE_SSM_BI_03_C	N/A
 TC_PSE_SSM_BV_08_I	PASS
 TC_PSE_PBD_BV_02_C	PASS
@@ -48,7 +48,7 @@ TC_PSE_PBB_BV_07_C	PASS
 TC_PSE_PBB_BV_08_C	PASS
 TC_PSE_PBB_BV_09_C	PASS
 TC_PSE_PBB_BV_10_C	PASS
-TC_PSE_PBB_BV_11_C	INC
+TC_PSE_PBB_BV_11_C	PASS
 TC_PSE_PBB_BI_01_C	PASS
 TC_PSE_PBB_BI_07_C	PASS
 TC_PSE_PBF_BV_01_I	PASS
-- 
1.8.5.3

