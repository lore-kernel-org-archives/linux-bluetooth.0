Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/ipc: Add PTS test results document for AVCTP
Date: Thu, 16 Jan 2014 11:01:02 +0100
Message-Id: <1389866462-7993-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389866462-7993-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389866462-7993-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow for better tracking of current state of implementation.
---
 android/Makefile.am   |  1 +
 android/pts-avctp.txt | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 android/pts-avctp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 95ed7a7..f030bd4 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -149,5 +149,6 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-a2dp.txt android/pixit-a2dp.txt \
 		android/pics-avctp.txt android/pixit-avctp.txt \
 		android/pts-a2dp.txt android/pts-avrcp.txt \
+		android/pts-avctp.txt \
 
 		android/pts-l2cap.txt
diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
new file mode 100644
index 0000000..c057a10
--- /dev/null
+++ b/android/pts-avctp.txt
@@ -0,0 +1,41 @@
+PTS test results for AVCTP
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
+		Controller (CT)
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_CT_CCM_BV_01_C	N/A
+TC_CT_CCM_BV_02_C	N/A
+TC_CT_CCM_BV_03_C	N/A
+TC_CT_CCM_BV_04_C	N/A
+TC_CT_CCM_BI_01_C	N/A
+TC_CT_NFR_BV_01_C	N/A
+TC_CT_NFR_BV_04_C	N/A
+TC_CT_FRA_BV_01_C	N/A
+TC_CT_FRA_BV_04_C	N/A
+-------------------------------------------------------------------------------
+
+
+		Target (TG)
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_TG_CCM_BV_01_C	INC
+TC_TG_CCM_BV_02_C	INC
+TC_TG_CCM_BV_03_C	INC
+TC_TG_CCM_BV_04_C	INC
+TC_TG_NFR_BV_02_C	INC
+TC_TG_NFR_BV_03_C	INC
+TC_TG_NFR_BI_01_C	INC
+TC_TG_FRA_BV_02_C	INC
+TC_TG_FRA_BV_03_C	INC
+-------------------------------------------------------------------------------
-- 
1.8.5.2

