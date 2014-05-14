Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Run PTS tests for SM
Date: Wed, 14 May 2014 15:38:25 +0200
Message-Id: <1400074705-10299-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am |  3 ++-
 android/pts-sm.txt  | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-sm.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index be8bb5b..e663790 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -274,4 +274,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-iopt.txt \
 				android/pts-hdp.txt \
 				android/pts-mcap.txt \
-				android/pts-mps.txt
+				android/pts-mps.txt \
+				android/pts-sm.txt
diff --git a/android/pts-sm.txt b/android/pts-sm.txt
new file mode 100644
index 0000000..0792de8
--- /dev/null
+++ b/android/pts-sm.txt
@@ -0,0 +1,63 @@
+PTS test results for SM
+
+PTS version: 5.1
+Tested: 14-May-2014
+Android version: 4.4.2
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+NONE	test result is none
+
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_PROT_BV_01_C		PASS
+TC_PROT_BV_02_C		FAIL	JIRA: BZ-24
+				btmgmt advertising on
+TC_JW_BV_01_C		FAIL	JIRA: BZ-25
+TC_JW_BV_02_C		INC	JIRA: BZ-26
+TC_JW_BV_05_C		INC
+TC_JW_BI_01_C		PASS
+TC_JW_BI_02_C		INC
+TC_JW_BI_03_C		INC
+TC_JW_BI_04_C		FAIL
+TC_PKE_BV_01_C		FAIL
+TC_PKE_BV_02_C		INC
+TC_PKE_BV_04_C		FAIL
+TC_PKE_BV_05_C		INC
+TC_PKE_BI_01_C		INC
+TC_PKE_BI_02_C		PASS
+TC_PKE_BI_03_C		INC
+TC_OOB_BV_01_C		FAIL
+TC_OOB_BV_02_C		INC
+TC_OOB_BV_03_C		FAIL
+TC_OOB_BV_04_C		INC
+TC_OOB_BV_05_C		INC
+TC_OOB_BV_06_C		INC
+TC_OOB_BV_07_C		INC
+TC_OOB_BV_08_C		INC
+TC_OOB_BV_09_C		INC
+TC_OOB_BV_10_C		INC
+TC_OOB_BI_01_C		INC
+TC_OOB_BI_02_C		INC
+TC_EKS_BV_01_C		INC
+TC_EKS_BV_02_C		INC
+TC_EKS_BI_01_C		INC
+TC_EKS_BI_02_C		INC
+TC_SIGN_BV_01_C		INC
+TC_SIGN_BV_03_C		INC
+TC_SIGN_BI_01_C		INC
+TC_KDU_BV_01_C		INC
+TC_KDU_BV_02_C		INC
+TC_KDU_BV_03_C		INC
+TC_KDU_BV_04_C		INC
+TC_KDU_BV_05_C		INC
+TC_KDU_BV_06_C		INC
+TC_KDU_BV_07_C		INC
+TC_SIP_BV_01_C		INC
+TC_SIP_BV_02_C		FAIL
+TC_SIE_BV_01_C		INC
+-------------------------------------------------------------------------------
-- 
1.8.5.3

