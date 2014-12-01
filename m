Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: PTS tests for HOGP on Android 5.0
Date: Mon,  1 Dec 2014 16:41:52 +0100
Message-Id: <1417448512-20973-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-hogp.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
index d86522d..98c14d8 100644
--- a/android/pts-hogp.txt
+++ b/android/pts-hogp.txt
@@ -1,8 +1,8 @@
 PTS test results for HoG
 
 PTS version: 5.3
-Tested: 21-October-2014
-Android version: 4.4.4
+Tested: 01-December-2014
+Android version: 5.0
 
 Results:
 PASS	test passed
@@ -13,7 +13,8 @@ N/A	test is disabled due to PICS setup
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_HGDS_HH_BV_01_I	PASS
+TC_HGDS_HH_BV_01_I	PASS	PTS issue #12119
+				This issue affects all PTS test cases
 TC_HGDS_HH_BV_02_I	PASS
 TC_HGDS_HH_BV_03_I	PASS
 TC_HGDS_HD_BV_01_I	N/A
@@ -83,11 +84,11 @@ TC_HGCF_RH_BV_02_I	PASS	haltest: hidhost connect <addr>
 				gattc get_characteristic 1 {1812,2,1}
 				gattc get_descriptor 1 {1812,2,1} {2a4d,5}
 				gattc write_descriptor 1 {1812,2,1} {2a4d,5}
-					{2902,0} 2 0x0000 0
+					{2902,1} 2 0x0000 0
 				gattc get_characteristic 1 {1812,5,1}
 				gattc get_descriptor 1 {1812,5,1} {2a4d,4}
 				gattc write_descriptor 1 {1812,5,1}
-					{2a4d,4} {2902,0} 2 0x0000 0
+					{2a4d,4} {2902,1} 2 0x0000 0
 				hidhost disconnect <addr>
 TC_HGCF_BH_BV_03_I	N/A
 TC_HGCF_BH_BV_04_I	N/A
-- 
1.9.3

