Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update PTS results for MAP
Date: Wed,  8 Jan 2014 09:52:53 +0100
Message-Id: <1389171173-30512-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update MAP PTS results for BlueZ stack on Nexus4 (Android 4.4.2).
---
 android/pts-map.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pts-map.txt b/android/pts-map.txt
index 26702af..9850fd4 100644
--- a/android/pts-map.txt
+++ b/android/pts-map.txt
@@ -1,7 +1,7 @@
 PTS test results for MAP
 
 PTS version: 5.0
-Tested: 17.12.2013
+Tested: 07.01.2014
 
 Results:
 PASS	test passed
@@ -70,7 +70,7 @@ TC_MSE_MMB_BV_14_I	PASS
 TC_MSE_MMB_BV_15_I	PASS
 TC_MSE_MMB_BV_16_I	INC	Mailbox MAS instance not available on IUT.
 TC_MSE_MMD_BV_02_I	PASS
-TC_MSE_MMU_BV_02_I	PASS
+TC_MSE_MMU_BV_02_I	INC	Passing randomly. (Reported PTS Issue ID: 11689)
 TC_MSE_MMU_BV_03_I	PASS
 TC_MSE_MMN_BV_02_I	PASS
 TC_MSE_MMN_BV_04_I	N/A
-- 
1.8.5

