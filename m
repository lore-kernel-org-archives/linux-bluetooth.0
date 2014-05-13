Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 1/3] android/pts: Add PTS test listing for HDP
Date: Tue, 13 May 2014 12:25:49 +0200
Message-Id: <1399976751-4206-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am |  3 ++-
 android/pts-hdp.txt | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-hdp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 78015e6..3d1595f 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -262,4 +262,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-hfp.txt \
 				android/pts-gatt.txt \
 				android/pts-hsp.txt \
-				android/pts-iopt.txt
+				android/pts-iopt.txt \
+				android/pts-hdp.txt
diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
new file mode 100644
index 0000000..1dec18c
--- /dev/null
+++ b/android/pts-hdp.txt
@@ -0,0 +1,72 @@
+PTS test results for HDP
+
+PTS version: 5.1
+Tested: not tested
+Android version: 4.4.2
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_SRC_CON_BV_01_I	INC
+TC_SRC_CON_BV_02_I	INC
+TC_SRC_CON_BV_03_I	INC
+TC_SRC_CON_BV_04_I	INC
+TC_SRC_CON_BV_05_I	INC
+TC_SRC_CON_BV_06_I	INC
+TC_SRC_CON_BV_07_I	INC
+TC_SRC_CON_BV_08_I	INC
+TC_SRC_CON_BV_09_I	INC
+TC_SRC_CON_BV_10_I	INC
+TC_SRC_CC_BV_01_C	INC
+TC_SRC_CC_BV_02_C	INC
+TC_SRC_CC_BV_03_C	INC
+TC_SRC_CC_BV_05_C	INC
+TC_SRC_CC_BV_07_C	INC
+TC_SRC_CC_BV_09_C	INC
+TC_SRC_CC_BI_12_C	INC
+TC_SRC_HCT_BV_01_I	INC
+TC_SRC_HCT_BV_02_I	INC
+TC_SRC_HCT_BV_03_I	N/A
+TC_SRC_HCT_BV_04_I	INC
+TC_SRC_HCT_BV_05_C	N/A
+TC_SRC_HCT_BV_06_C	INC
+TC_SRC_HCT_BV_07_C	INC
+TC_SRC_DE_BV_01_I	INC
+TC_SRC_DE_BV_02_I	INC
+TC_SRC_DEP_BV_01_I	INC
+TC_SRC_DEP_BV_02_I	N/A
+TC_SNK_CON_BV_01_I	INC
+TC_SNK_CON_BV_02_I	INC
+TC_SNK_CON_BV_03_I	INC
+TC_SNK_CON_BV_04_I	INC
+TC_SNK_CON_BV_05_I	INC
+TC_SNK_CON_BV_06_I	INC
+TC_SNK_CON_BV_07_I	INC
+TC_SNK_CON_BV_08_I	INC
+TC_SNK_CON_BV_09_I	INC
+TC_SNK_CON_BV_10_I	INC
+TC_SNK_CC_BV_01_C	INC
+TC_SNK_CC_BV_02_C	INC
+TC_SNK_CC_BV_04_C	INC
+TC_SNK_CC_BV_06_C	INC
+TC_SNK_CC_BV_08_C	INC
+TC_SNK_CC_BV_10_C	INC
+TC_SNK_CC_BI_11_C	INC
+TC_SNK_HCT_BV_01_I	INC
+TC_SNK_HCT_BV_02_I	INC
+TC_SNK_HCT_BV_03_I	N/A
+TC_SNK_HCT_BV_04_I	INC
+TC_SNK_HCT_BV_05_C	N/A
+TC_SNK_HCT_BV_06_C	INC
+TC_SNK_HCT_BV_07_C	INC
+TC_SNK_DE_BV_01_I	N/A
+TC_SNK_DE_BV_02_I	INC
+TC_SNK_DEP_BV_03_I	INC
+TC_SNK_DEP_BV_04_I	INC
+-------------------------------------------------------------------------------
-- 
1.8.5.3

