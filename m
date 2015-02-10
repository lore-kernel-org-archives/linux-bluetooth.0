Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] android/pts: Update MCAP test results for PTS 6.0
Date: Tue, 10 Feb 2015 18:17:30 +0100
Message-Id: <1423588650-12191-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test results and instructions for MCAP profile
against android 5.0
---
 android/pts-mcap.txt | 119 +++++++++++++++++----------------------------------
 1 file changed, 40 insertions(+), 79 deletions(-)

diff --git a/android/pts-mcap.txt b/android/pts-mcap.txt
index 2aa1848..2ad2858 100644
--- a/android/pts-mcap.txt
+++ b/android/pts-mcap.txt
@@ -1,7 +1,7 @@
 PTS test results for MCAP
 
-PTS version: 5.3
-Tested: 27-November-2014
+PTS version: 6.0
+Tested: 10-February-2015
 Android version: 5.0
 
 Results:
@@ -16,42 +16,28 @@ Note: Test were done with ssp enabled and in most of the cases requires pairing
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_MCAP_CE_BV_01_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -dc <PTS addr>
-TC_MCAP_CE_BV_02_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_CE_BV_03_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -c <PTS addr>
-TC_MCAP_CE_BV_04_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_CE_BV_01_C	PASS	mcaptest -C 4099 -D 4101 -f 2 -dc <PTS addr>
+TC_MCAP_CE_BV_02_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_CE_BV_03_C	PASS	mcaptest -C 4099 -D 4101 -f 2 -c <PTS addr>
+TC_MCAP_CE_BV_04_C	PASS	mcaptest -C 4099 -D 4101 -f 2 -d
 TC_MCAP_CM_ABT_BV_01_C	N/A
-TC_MCAP_CM_ABT_BV_02_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
+TC_MCAP_CM_ABT_BV_02_C	PASS	mcaptest -C 4099 -D 4101 -f 2
 TC_MCAP_CM_ABT_BV_03_C	N/A
 TC_MCAP_CM_DEL_BV_01_C	N/A
-TC_MCAP_CM_DEL_BV_02_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
+TC_MCAP_CM_DEL_BV_02_C	PASS	mcaptest -C 4099 -D 4101 -f 2
 TC_MCAP_CM_DEL_BV_03_C	N/A
-TC_MCAP_CM_DEL_BV_04_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_CM_DIS_BV_01_C	PASS	mcaptest -C 4099 -D 4101 -e 2 -f 2
+TC_MCAP_CM_DEL_BV_04_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_CM_DIS_BV_01_C	PASS	mcaptest -C 4099 -D 4101 -ab -e 2 -f 2
 TC_MCAP_CM_DIS_BV_02_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_CM_DIS_BV_03_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_CM_DIS_BV_04_C	PASS	mcaptest -C 4099 -D 4101 -e 2 -f 2
+TC_MCAP_CM_DIS_BV_03_C	PASS	mcaptest -C 4099 -D 4101 -n -f 2
+TC_MCAP_CM_DIS_BV_04_C	PASS	mcaptest -C 4099 -D 4101 -ab -e 2 -f 2
 TC_MCAP_CM_DIS_BV_05_C	PASS	mcaptest -C 4099 -D 4101
 TC_MCAP_CM_REC_BV_01_C	N/A
-TC_MCAP_CM_REC_BV_02_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
+TC_MCAP_CM_REC_BV_02_C	PASS	mcaptest -C 4099 -D 4101 -n -f 2
 TC_MCAP_CM_REC_BV_03_C	N/A
-TC_MCAP_CM_REC_BV_04_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-				Note: It may be necessary to confirm pairing
-					twice (second time when IUT is back in
-					range).
+TC_MCAP_CM_REC_BV_04_C	PASS	mcaptest -C 4099 -D 4101 -n -f 2
 TC_MCAP_CM_REC_BV_05_C	N/A
-TC_MCAP_CM_REC_BV_06_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
+TC_MCAP_CM_REC_BV_06_C	PASS	mcaptest -C 4099 -D 4101 -f 2
 TC_MCAP_CS_ERR_BI_01_C	N/A
 TC_MCAP_CS_ERR_BI_02_C	N/A
 TC_MCAP_CS_ERR_BI_03_C	N/A
@@ -64,56 +50,31 @@ TC_MCAP_CS_R_BV_01_I	N/A
 TC_MCAP_CS_R_BV_02_I	N/A
 TC_MCAP_CS_R_BV_03_C	N/A
 TC_MCAP_CS_T_BV_04_C	N/A
-TC_MCAP_ERR_BI_01_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_02_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_03_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_04_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_05_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_06_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_07_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_08_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_09_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_10_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_11_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_12_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_13_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_14_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_15_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_16_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -u
-TC_MCAP_ERR_BI_17_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_18_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
+TC_MCAP_ERR_BI_01_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_ERR_BI_02_C	PASS	mcaptest -C 4099 -D 4101 -dn -f 2
+TC_MCAP_ERR_BI_03_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_ERR_BI_04_C	PASS	mcaptest -C 4099 -D 4101 -dn -f 2
+TC_MCAP_ERR_BI_05_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_ERR_BI_06_C	PASS	mcaptest -C 4099 -D 4101 -dn -f 2
+TC_MCAP_ERR_BI_07_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_ERR_BI_08_C	PASS	mcaptest -C 4099 -D 4101 -dn -f 2
+TC_MCAP_ERR_BI_09_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_ERR_BI_10_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_ERR_BI_11_C	PASS	mcaptest -C 4099 -D 4101 -dn -f 2
+TC_MCAP_ERR_BI_12_C	PASS	mcaptest -C 4099 -D 4101 -dn -f 2
+TC_MCAP_ERR_BI_13_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_ERR_BI_14_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_ERR_BI_15_C	PASS	mcaptest -C 4099 -D 4101 -dn -f 2
+TC_MCAP_ERR_BI_16_C	PASS	mcaptest -C 4099 -D 4101 -u -f 2
+TC_MCAP_ERR_BI_17_C	PASS	mcaptest -C 4099 -D 4101 -dn -f 2
+TC_MCAP_ERR_BI_18_C	PASS	mcaptest -C 4099 -D 4101 -dn -f 2
 TC_MCAP_ERR_BI_19_C	N/A
-TC_MCAP_ERR_BI_20_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -g
+TC_MCAP_ERR_BI_20_C	PASS	mcaptest -C 4099 -D 4101 -g -f 2
 TC_MCAP_INV_BI_01_C	PASS	mcaptest -C 4099 -D 4101 -dc <PTS addr>
-TC_MCAP_INV_BI_02_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -d
-TC_MCAP_INV_BI_03_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -dc <PTS addr>
-TC_MCAP_INV_BI_04_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101 -c <PTS addr>
-TC_MCAP_INV_BI_05_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_INV_BI_06_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
-TC_MCAP_INV_BI_07_C	INC	PTS issue #12693
-				mcaptest -C 4099 -D 4101
+TC_MCAP_INV_BI_02_C	PASS	mcaptest -C 4099 -D 4101 -dn -f 2
+TC_MCAP_INV_BI_03_C	PASS	mcaptest -C 4099 -D 4101 -d -f 2 -c <PTS addr>
+TC_MCAP_INV_BI_04_C	PASS	mcaptest -C 4099 -D 4101 -f 2 -c <PTS addr>
+TC_MCAP_INV_BI_05_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_INV_BI_06_C	PASS	mcaptest -C 4099 -D 4101 -f 2
+TC_MCAP_INV_BI_07_C	PASS	mcaptest -C 4099 -D 4101 -f 2
 -------------------------------------------------------------------------------
-- 
1.9.3

