Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] android/pts: Update PTS results for MCAP
Date: Mon,  3 Nov 2014 10:31:16 +0100
Message-Id: <1415007076-5141-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Tested on android 4.4.4 against PTS 5.3
---
 android/pts-mcap.txt | 114 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 75 insertions(+), 39 deletions(-)

diff --git a/android/pts-mcap.txt b/android/pts-mcap.txt
index c35fefb..9d1fdcd 100644
--- a/android/pts-mcap.txt
+++ b/android/pts-mcap.txt
@@ -1,7 +1,7 @@
 PTS test results for MCAP
 
-PTS version: 5.2
-Tested: 07-August-2014
+PTS version: 5.3
+Tested: 30-October-2014
 Android version: 4.4.4
 
 Results:
@@ -16,31 +16,42 @@ Note: Test were done with ssp enabled and in most of the cases requires pairing
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_MCAP_CE_BV_01_C	PASS	mcaptest -C 4099 -D 4101 -dc <PTS addr>
-TC_MCAP_CE_BV_02_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_CE_BV_03_C	PASS	mcaptest -C 4099 -D 4101 -c <PTS addr>
-TC_MCAP_CE_BV_04_C	PASS	mcaptest -C 4099 -D 4101 -d
+TC_MCAP_CE_BV_01_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -dc <PTS addr>
+TC_MCAP_CE_BV_02_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_CE_BV_03_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -c <PTS addr>
+TC_MCAP_CE_BV_04_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
 TC_MCAP_CM_ABT_BV_01_C	N/A
-TC_MCAP_CM_ABT_BV_02_C	PASS	mcaptest -C 4099 -D 4101
+TC_MCAP_CM_ABT_BV_02_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
 TC_MCAP_CM_ABT_BV_03_C	N/A
 TC_MCAP_CM_DEL_BV_01_C	N/A
-TC_MCAP_CM_DEL_BV_02_C	PASS	mcaptest -C 4099 -D 4101
+TC_MCAP_CM_DEL_BV_02_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
 TC_MCAP_CM_DEL_BV_02_C	N/A
-TC_MCAP_CM_DEL_BV_04_C	PASS	mcaptest -C 4099 -D 4101
+TC_MCAP_CM_DEL_BV_04_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
 TC_MCAP_CM_DIS_BV_01_C	PASS	mcaptest -C 4099 -D 4101 -e 2 -f 2
 TC_MCAP_CM_DIS_BV_02_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_CM_DIS_BV_03_C	PASS	mcaptest -C 4099 -D 4101
+TC_MCAP_CM_DIS_BV_03_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
 TC_MCAP_CM_DIS_BV_04_C	PASS	mcaptest -C 4099 -D 4101 -e 2 -f 2
 TC_MCAP_CM_DIS_BV_05_C	PASS	mcaptest -C 4099 -D 4101
 TC_MCAP_CM_REC_BV_01_C	N/A
-TC_MCAP_CM_REC_BV_02_C	PASS	mcaptest -C 4099 -D 4101
+TC_MCAP_CM_REC_BV_02_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
 TC_MCAP_CM_REC_BV_03_C	N/A
-TC_MCAP_CM_REC_BV_04_C	PASS	mcaptest -C 4099 -D 4101
+TC_MCAP_CM_REC_BV_04_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
 				Note: It may be necessary to confirm pairing
 					twice (second time when IUT is back in
 					range).
 TC_MCAP_CM_REC_BV_05_C	N/A
-TC_MCAP_CM_REC_BV_06_C	PASS	mcaptest -C 4099 -D 4101
+TC_MCAP_CM_REC_BV_06_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
 TC_MCAP_CS_ERR_BI_01_C	N/A
 TC_MCAP_CS_ERR_BI_02_C	N/A
 TC_MCAP_CS_ERR_BI_03_C	N/A
@@ -53,31 +64,56 @@ TC_MCAP_CS_R_BV_01_I	N/A
 TC_MCAP_CS_R_BV_02_I	N/A
 TC_MCAP_CS_R_BV_03_C	N/A
 TC_MCAP_CS_T_BV_04_C	N/A
-TC_MCAP_ERR_BI_01_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_02_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_03_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_04_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_05_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_06_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_07_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_08_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_09_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_10_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_11_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_12_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_13_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_14_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_15_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_16_C	PASS	mcaptest -C 4099 -D 4101 -u
-TC_MCAP_ERR_BI_17_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_18_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_19_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_20_C	PASS	mcaptest -C 4099 -D 4101 -g
+TC_MCAP_ERR_BI_01_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_ERR_BI_02_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_ERR_BI_03_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_ERR_BI_04_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_ERR_BI_05_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_ERR_BI_06_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_ERR_BI_07_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_ERR_BI_08_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_ERR_BI_09_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_ERR_BI_10_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_ERR_BI_11_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_ERR_BI_12_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_ERR_BI_13_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_ERR_BI_14_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_ERR_BI_15_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_ERR_BI_16_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -u
+TC_MCAP_ERR_BI_17_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_ERR_BI_18_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_ERR_BI_19_C	N/A
+TC_MCAP_ERR_BI_20_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -g
 TC_MCAP_INV_BI_01_C	PASS	mcaptest -C 4099 -D 4101 -dc <PTS addr>
-TC_MCAP_INV_BI_02_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_INV_BI_03_C	PASS	mcaptest -C 4099 -D 4101 -dc <PTS addr>
-TC_MCAP_INV_BI_04_C	PASS	mcaptest -C 4099 -D 4101 -c <PTS addr>
-TC_MCAP_INV_BI_05_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_INV_BI_06_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_INV_BI_07_C	PASS	mcaptest -C 4099 -D 4101
+TC_MCAP_INV_BI_02_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_INV_BI_03_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -dc <PTS addr>
+TC_MCAP_INV_BI_04_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101 -c <PTS addr>
+TC_MCAP_INV_BI_05_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_INV_BI_06_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
+TC_MCAP_INV_BI_07_C	INC	PTS Issue #12693
+				mcaptest -C 4099 -D 4101
 -------------------------------------------------------------------------------
-- 
1.9.3

