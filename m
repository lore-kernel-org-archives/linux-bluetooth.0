Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/pts: Add PTS test results for PBAP
Date: Thu, 12 Dec 2013 16:38:57 +0100
Message-Id: <1386862737-30606-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386862737-30606-1-git-send-email-szymon.janc@tieto.com>
References: <1386862737-30606-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow for better tracking of current state of implementation.
---
 android/Makefile.am  |  2 +-
 android/pts-pbap.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-pbap.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index bcd9f2b..79f30d7 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -111,4 +111,4 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pixit-gap.txt android/pixit-hid.txt \
 		android/pixit-opp.txt android/pixit-pan.txt \
 		android/pixit-pbap.txt android/pts-gap.txt android/pts-hid.txt \
-		android/pts-opp.txt
+		android/pts-opp.txt android/pts-pbap.txt
diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
new file mode 100644
index 0000000..3bf682f
--- /dev/null
+++ b/android/pts-pbap.txt
@@ -0,0 +1,59 @@
+PTS test results for PBAP
+
+PTS version: 4.9
+Tested: 14.11.2013
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
+TC_PCE_SSM_BV_01_C	N/A
+TC_PCE_SSM_BV_02_C	N/A
+TC_PCE_SSM_BV_06_C	N/A
+TC_PCE_SSM_BV_08_C	N/A
+TC_PCE_SSM_BI_01_C	N/A
+TC_PCE_PBD_BV_01_C	N/A
+TC_PCE_PBD_BV_04_C	N/A
+TC_PCE_PBB_BV_01_C	N/A
+TC_PCE_PBB_BV_02_C	N/A
+TC_PCE_PBB_BV_03_C	N/A
+TC_PCE_PBB_BV_05_C	N/A
+TC_PCE_PBF_BV_01_I	N/A
+TC_PCE_PBF_BV_02_I	N/A
+TC_PCE_PDF_BV_01_I	N/A
+TC_PCE_PDF_BV_04_I	N/A
+TC_PSE_SSM_BV_03_C	PASS
+TC_PSE_SSM_BV_05_C	PASS
+TC_PSE_SSM_BV_07_C	PASS
+TC_PSE_SSM_BI_02_C	INC
+TC_PSE_SSM_BI_03_C	N/A
+TC_PSE_SSM_BV_08_I	PASS
+TC_PSE_PBD_BV_02_C	PASS
+TC_PSE_PBD_BV_03_C	PASS
+TC_PSE_PBD_BV_05_C	N/A
+TC_PSE_PBD_BI_01_C	FAIL
+TC_PSE_PBD_BV_11_C	N/A
+TC_PSE_PBD_BV_12_C	N/A
+TC_PSE_PBD_BV_13_C	N/A
+TC_PSE_PBD_BV_14_C	N/A
+TC_PSE_PBD_BV_15_C	N/A
+TC_PSE_PBD_BV_16_C	N/A
+TC_PSE_PBB_BV_06_C	PASS
+TC_PSE_PBB_BV_07_C	PASS
+TC_PSE_PBB_BV_08_C	PASS
+TC_PSE_PBB_BV_09_C	PASS
+TC_PSE_PBB_BV_10_C	PASS
+TC_PSE_PBB_BV_11_C	INC
+TC_PSE_PBB_BI_01_C	PASS
+TC_PSE_PBB_BI_07_C	PASS
+TC_PSE_PBF_BV_01_I	PASS
+TC_PSE_PBF_BV_02_I	PASS
+TC_PSE_PDF_BV_01_I	PASS
+TC_PSE_PDF_BV_03_I	N/A
+TC_PSE_PDF_BV_05_I	N/A
+-------------------------------------------------------------------------------
-- 
1.8.3.2

