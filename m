Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pts: PTS test results for PBAP
Date: Tue, 28 Jan 2014 19:25:31 +0200
Message-Id: <1390929931-10447-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-pbap.txt | 103 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 15 deletions(-)

diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
index 843b7cf..4312921 100644
--- a/android/pts-pbap.txt
+++ b/android/pts-pbap.txt
@@ -1,7 +1,7 @@
 PTS test results for PBAP
 
 PTS version: 5.0
-Tested: 14.11.2013
+Tested: 28.01.2014
 
 Results:
 PASS	test passed
@@ -17,32 +17,82 @@ TC_PCE_SSM_BV_02_C	N/A
 TC_PCE_SSM_BV_06_C	N/A
 TC_PCE_SSM_BV_08_C	N/A
 TC_PCE_SSM_BI_01_C	N/A
+TC_PCE_SSM_BV_09_C	N/A
+TC_PCE_SSM_BV_10_C	N/A
 TC_PCE_PBD_BV_01_C	N/A
 TC_PCE_PBD_BV_04_C	N/A
+TC_PCE_PBD_BV_38_C	N/A
+TC_PCE_PBD_BV_29_C	N/A
+TC_PCE_PBD_BV_40_C	N/A
+TC_PCE_PBD_BV_41_C	N/A
+TC_PCE_PBD_BV_42_C	N/A
+TC_PCE_PBD_BV_43_C	N/A
+TC_PCE_PBD_BV_44_C	N/A
+TC_PCE_PBD_BV_45_C	N/A
+TC_PCE_PBD_BV_46_C	N/A
+TC_PCE_PBD_BV_47_C	N/A
+TC_PCE_PBD_BV_48_C	N/A
 TC_PCE_PBB_BV_01_C	N/A
 TC_PCE_PBB_BV_02_C	N/A
 TC_PCE_PBB_BV_03_C	N/A
 TC_PCE_PBB_BV_05_C	N/A
+TC_PCE_PBB_BV_39_C	N/A
+TC_PCE_PBB_BV_40_C	N/A
+TC_PCE_PBB_BV_41_C	N/A
+TC_PCE_PBB_BV_42_C	N/A
+TC_PCE_PBB_BV_33_C	N/A
+TC_PCE_PBB_BV_34_C	N/A
+TC_PCE_PBB_BV_35_C	N/A
+TC_PCE_PBB_BV_36_C	N/A
+TC_PCE_PBB_BV_43_C	N/A
+TC_PCE_PBB_BV_37_C	N/A
+TC_PCE_PBB_BV_38_C	N/A
 TC_PCE_PBF_BV_01_I	N/A
 TC_PCE_PBF_BV_02_I	N/A
+TC_PCE_PBF_BV_03_I	N/A
 TC_PCE_PDF_BV_01_I	N/A
-TC_PCE_PDF_BV_04_I	N/A
+TC_PCE_PDF_BV_06_I	N/A
 TC_PSE_SSM_BV_03_C	PASS
 TC_PSE_SSM_BV_05_C	PASS
-TC_PSE_SSM_BV_07_C	PASS
+TC_PSE_SSM_BV_07_C	PASS	Tester must accept obex request with
+					TSPX_auth_password set in PIXITs
 TC_PSE_SSM_BI_02_C	PASS
 TC_PSE_SSM_BI_03_C	N/A
-TC_PSE_SSM_BV_08_I	PASS
-TC_PSE_PBD_BV_02_C	PASS
-TC_PSE_PBD_BV_03_C	PASS
+TC_PSE_SSM_BV_08_I	PASS	Tester must compare passkey on IUT and PTS
+TC_PSE_SSM_BV_11_C	N/A
+
+TC_PSE_PBD_BV_02_C	PASS	Tester must compare phone book size with the value
+					given by PTS
+TC_PSE_PBD_BV_03_C	PASS	Tester must compare phone book size with the value
+					given by PTS
 TC_PSE_PBD_BV_05_C	N/A
 TC_PSE_PBD_BI_01_C	FAIL
-TC_PSE_PBD_BV_11_C	N/A
-TC_PSE_PBD_BV_12_C	N/A
-TC_PSE_PBD_BV_13_C	N/A
-TC_PSE_PBD_BV_14_C	N/A
-TC_PSE_PBD_BV_15_C	N/A
-TC_PSE_PBD_BV_16_C	N/A
+TC_PSE_PBD_BV_06_C	N/A
+TC_PSE_PBD_BV_07_C	N/A
+TC_PSE_PBD_BV_08_C	N/A
+TC_PSE_PBD_BV_09_C	N/A
+TC_PSE_PBD_BV_10_C	N/A
+TC_PSE_PBD_BV_17_C	FAIL
+TC_PSE_PBD_BV_18_C	N/A
+TC_PSE_PBD_BV_19_C	N/A
+TC_PSE_PBD_BV_20_C	N/A
+TC_PSE_PBD_BV_21_C	N/A
+TC_PSE_PBD_BV_22_C	N/A
+TC_PSE_PBD_BV_23_C	N/A
+TC_PSE_PBD_BV_24_C	N/A
+TC_PSE_PBD_BV_25_C	N/A
+TC_PSE_PBD_BV_26_C	N/A
+TC_PSE_PBD_BV_27_C	N/A
+TC_PSE_PBD_BV_28_C	N/A
+TC_PSE_PBD_BV_29_C	N/A
+TC_PSE_PBD_BV_30_C	N/A
+TC_PSE_PBD_BV_31_C	N/A
+TC_PSE_PBD_BV_32_C	N/A
+TC_PSE_PBD_BV_33_C	N/A
+TC_PSE_PBD_BV_34_C	N/A
+TC_PSE_PBD_BV_35_C	N/A
+TC_PSE_PBD_BV_36_C	PASS
+TC_PSE_PBD_BV_37_C	N/A
 TC_PSE_PBB_BV_06_C	PASS
 TC_PSE_PBB_BV_07_C	PASS
 TC_PSE_PBB_BV_08_C	PASS
@@ -51,9 +101,32 @@ TC_PSE_PBB_BV_10_C	PASS
 TC_PSE_PBB_BV_11_C	PASS
 TC_PSE_PBB_BI_01_C	PASS
 TC_PSE_PBB_BI_07_C	PASS
+TC_PSE_PBB_BV_12_C	PASS
+TC_PSE_PBB_BV_13_C	N/A
+TC_PSE_PBB_BV_14_C	N/A
+TC_PSE_PBB_BV_15_C	N/A
+TC_PSE_PBB_BV_16_C	N/A
+TC_PSE_PBB_BV_17_C	N/A
+TC_PSE_PBB_BV_18_C	N/A
+TC_PSE_PBB_BV_19_C	N/A
+TC_PSE_PBB_BV_20_C	N/A
+TC_PSE_PBB_BV_21_C	N/A
+TC_PSE_PBB_BV_22_C	N/A
+TC_PSE_PBB_BV_23_C	N/A
+TC_PSE_PBB_BV_24_C	N/A
+TC_PSE_PBB_BV_25_C	N/A
+TC_PSE_PBB_BV_26_C	N/A
+TC_PSE_PBB_BV_27_C	N/A
+TC_PSE_PBB_BV_44_C	N/A
+TC_PSE_PBB_BV_45_C	N/A
+TC_PSE_PBB_BV_46_C	N/A
+TC_PSE_PBB_BV_28_C	N/A
+TC_PSE_PBB_BV_29_C	N/A
+TC_PSE_PBB_BV_30_C	N/A
+TC_PSE_PBB_BV_31_C	PASS
+TC_PSE_PBB_BV_32_C	N/A
 TC_PSE_PBF_BV_01_I	PASS
 TC_PSE_PBF_BV_02_I	PASS
-TC_PSE_PDF_BV_01_I	PASS
-TC_PSE_PDF_BV_03_I	N/A
-TC_PSE_PDF_BV_05_I	N/A
+TC_PSE_PDF_BV_01_I	PASS	Tester must compare phone book size with the value
+					given by PTS
 -------------------------------------------------------------------------------
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

