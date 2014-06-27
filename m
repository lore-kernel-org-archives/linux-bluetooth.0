Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 3/3] android/pts: Update MCAP results
Date: Fri, 27 Jun 2014 12:08:03 +0200
Message-Id: <1403863683-9844-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403863683-9844-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403863683-9844-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-mcap.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/android/pts-mcap.txt b/android/pts-mcap.txt
index 9542b8c..55b51d7 100644
--- a/android/pts-mcap.txt
+++ b/android/pts-mcap.txt
@@ -1,7 +1,7 @@
 PTS test results for MCAP
 
 PTS version: 5.1
-Tested: 26-June-2014
+Tested: 27-June-2014
 Android version: 4.4.2
 
 Results:
@@ -10,6 +10,9 @@ FAIL	test failed
 INC	test is inconclusive
 N/A	test is disabled due to PICS setup
 
+Note: Test were done with ssp enabled and in most of the cases requires pairing
+	confirmation. This can be done easily by using 'btmgmt monitor'.
+
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
@@ -32,7 +35,10 @@ TC_MCAP_CM_DIS_BV_05_C	PASS	mcaptest -C 4099 -D 4101
 TC_MCAP_CM_REC_BV_01_C	N/A
 TC_MCAP_CM_REC_BV_02_C	PASS	mcaptest -C 4099 -D 4101
 TC_MCAP_CM_REC_BV_03_C	N/A
-TC_MCAP_CM_REC_BV_04_C	INC	possible PTS issue #12182
+TC_MCAP_CM_REC_BV_04_C	PASS	mcaptest -C 4099 -D 4101
+				Note: It may be necessary to confirm pairing
+					twice (second time when UIT is back in
+					range).
 TC_MCAP_CM_REC_BV_05_C	N/A
 TC_MCAP_CM_REC_BV_06_C	PASS	mcaptest -C 4099 -D 4101
 TC_MCAP_CS_ERR_BI_01_C	N/A
@@ -58,15 +64,15 @@ TC_MCAP_ERR_BI_08_C	PASS	mcaptest -C 4099 -D 4101 -d
 TC_MCAP_ERR_BI_09_C	PASS	mcaptest -C 4099 -D 4101
 TC_MCAP_ERR_BI_10_C	PASS	mcaptest -C 4099 -D 4101
 TC_MCAP_ERR_BI_11_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_12_C	INC
+TC_MCAP_ERR_BI_12_C	PASS	mcaptest -C 4099 -D 4101 -d
 TC_MCAP_ERR_BI_13_C	PASS	mcaptest -C 4099 -D 4101
 TC_MCAP_ERR_BI_14_C	PASS	mcaptest -C 4099 -D 4101
 TC_MCAP_ERR_BI_15_C	PASS	mcaptest -C 4099 -D 4101 -d
-TC_MCAP_ERR_BI_16_C	INC
+TC_MCAP_ERR_BI_16_C	PASS	mcaptest -C 4099 -D 4101 -u
 TC_MCAP_ERR_BI_17_C	PASS	mcaptest -C 4099 -D 4101 -d
 TC_MCAP_ERR_BI_18_C	PASS	mcaptest -C 4099 -D 4101 -d
 TC_MCAP_ERR_BI_19_C	PASS	mcaptest -C 4099 -D 4101
-TC_MCAP_ERR_BI_20_C	INC
+TC_MCAP_ERR_BI_20_C	PASS	mcaptest -C 4099 -D 4101 -g
 TC_MCAP_INV_BI_01_C	PASS	mcaptest -C 4099 -D 4101 -dc <PTS addr>
 TC_MCAP_INV_BI_02_C	PASS	mcaptest -C 4099 -D 4101 -d
 TC_MCAP_INV_BI_03_C	PASS	mcaptest -C 4099 -D 4101 -dc <PTS addr>
-- 
2.0.0

