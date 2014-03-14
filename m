Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/hsp: PTS tests results for HSP
Date: Fri, 14 Mar 2014 11:01:14 +0100
Message-Id: <1394791274-8216-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am |  3 ++-
 android/pts-hsp.txt | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-hsp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 330529f..5a97f4a 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -219,4 +219,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-avrcp.txt \
 				android/pts-avctp.txt \
 				android/pts-pbap.txt \
-				android/pts-hfp.txt
+				android/pts-hfp.txt \
+				android/pts-hsp.txt
diff --git a/android/pts-hsp.txt b/android/pts-hsp.txt
new file mode 100644
index 0000000..167fdb5
--- /dev/null
+++ b/android/pts-hsp.txt
@@ -0,0 +1,41 @@
+PTS test results for HSP
+
+PTS version: 5.0
+Tested: 14-Mar-2014
+Android version: 4.4.2
+
+Results:
+PASS    test passed
+FAIL    test failed
+INC     test is inconclusive
+N/A     test is disabled due to PICS setup
+
+-------------------------------------------------------------------------------
+Test Name               Result  Notes
+-------------------------------------------------------------------------------
+TC_AG_IAC_BV_01_I	PASS
+TC_AG_IAC_BV_02_I	N/A
+TC_AG_OAC_BV_01_I	PASS
+HSP_TC_AG_ACR_BV_01_I	PASS
+HSP_TC_AG_ACR_BV_02_I	PASS
+TC_AG_ACT_BV_01_I	PASS
+TC_AG_ACT_BV_02_I	PASS
+TC_AG_RAV_BV_01_I	N/A
+TC_AG_RAV_BV_02_I	N/A
+TC_AG_RAV_BV_03_I	N/A
+TC_AG_RAV_BV_04_I	N/A
+TC_AG_RAV_BV_05_I	N/A
+TC_AG_RAV_BV_06_I	N/A
+TC_HS_IAC_BV_01_I	N/A
+TC_HS_IAC_BV_02_I	N/A
+TC_HS_OAC_BV_01_I	N/A
+TC_HS_ACR_BV_01_I	N/A
+TC_HS_ACR_BV_02_I	N/A
+TC_HS_ACT_BV_01_I	N/A
+TC_HS_ACT_BV_02_I	N/A
+TC_HS_RAV_BV_01_I	N/A
+TC_HS_RAV_BV_02_I	N/A
+TC_HS_RAV_BV_03_I	N/A
+TC_HS_RAV_BV_04_I	N/A
+TC_HS_RAV_BV_05_I	N/A
+TC_HS_RAV_BV_06_I	N/A
-- 
1.8.5.3

