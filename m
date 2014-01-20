Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/pts: Add PTS test results document for A2DP
Date: Mon, 20 Jan 2014 09:54:45 +0100
Message-Id: <1390208087-22838-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow for better tracking of current state of implementation.
---
 android/Makefile.am  |  1 +
 android/pts-a2dp.txt | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 android/pts-a2dp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index f24b754..d4508a4 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -167,4 +167,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-hid.txt \
 				android/pts-opp.txt \
 				android/pts-map.txt \
+				android/pts-a2dp.txt \
 				android/pts-pbap.txt
diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
new file mode 100644
index 0000000..a269ec1
--- /dev/null
+++ b/android/pts-a2dp.txt
@@ -0,0 +1,57 @@
+PTS test results for A2DP
+
+PTS version: 5.0
+Tested: --not yet tested--
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+		Source (SRC)
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_SRC_CC_BV_09_I	INC
+TC_SRC_CC_BV_10_I	N/A
+TC_SRC_REL_BV_01_I	INC
+TC_SRC_REL_BV_02_I	INC
+TC_SRC_SET_BV_01_I	INC
+TC_SRC_SET_BV_02_I	INC
+TC_SRC_SET_BV_03_I	INC
+TC_SRC_SET_BV_04_I	INC
+TC_SRC_SET_BV_05_I	INC
+TC_SRC_SET_BV_06_I	INC
+TC_SRC_SUS_BV_01_I	INC
+TC_SRC_SUS_BV_02_I	INC
+TC_SRC_SDP_BV_01_I	INC
+TC_SRC_AS_BV_01_I	INC
+-------------------------------------------------------------------------------
+
+
+		Sink (SNK)
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_SNK_CC_BV_01_I	N/A
+TC_SNK_CC_BV_02_I	N/A
+TC_SNK_CC_BV_03_I	N/A
+TC_SNK_CC_BV_04_I	N/A
+TC_SNK_CC_BV_05_I	N/A
+TC_SNK_CC_BV_06_I	N/A
+TC_SNK_CC_BV_07_I	N/A
+TC_SNK_CC_BV_08_I	N/A
+TC_SNK_REL_BV_01_I	N/A
+TC_SNK_REL_BV_02_I	N/A
+TC_SNK_SET_BV_01_I	N/A
+TC_SNK_SET_BV_02_I	N/A
+TC_SNK_SET_BV_03_I	N/A
+TC_SNK_SET_BV_04_I	N/A
+TC_SNK_SET_BV_05_I	N/A
+TC_SNK_SET_BV_06_I	N/A
+TC_SNK_SUS_BV_01_I	N/A
+TC_SNK_SUS_BV_02_I	N/A
+TC_SNK_SDP_BV_02_I	N/A
+TC_SNK_AS_BV_01_I	N/A
+-------------------------------------------------------------------------------
-- 
1.8.5.2

