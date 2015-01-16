Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pts: Update AVDTP PTS 6.0 results for android 5.0
Date: Fri, 16 Jan 2015 11:25:13 +0100
Message-Id: <1421403913-16197-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1421403913-16197-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1421403913-16197-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test case list and results for PAN profile against
android 5.0.
---
 android/pts-avdtp.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/android/pts-avdtp.txt b/android/pts-avdtp.txt
index 6ff8624..683ba6d 100644
--- a/android/pts-avdtp.txt
+++ b/android/pts-avdtp.txt
@@ -1,7 +1,7 @@
 PTS test results for AVDTP
 
-PTS version: 5.3
-Tested: 24-November-2014
+PTS version: 6.0
+Tested: 16-January-2015
 Android version: 5.0
 
 Results:
@@ -56,9 +56,7 @@ TC_ACP_SNK_SIG_SMG_BI_34_C		N/A
 TC_ACP_SNK_SIG_SMG_ESR04_BI_28_C	PASS	avdtptest -d SINK -l
 TC_ACP_SNK_SIG_SMG_ESR05_BI_15_C	N/A
 TC_ACP_SNK_SIG_SYN_BV_01_C		PASS	avdtptest -d SINK -l
-TC_ACP_SNK_SIG_SYN_BV_02_C		PASS	avdtptest -d SINK -l -p
 TC_ACP_SNK_SIG_SYN_BV_03_C		PASS	avdtptest -d SINK -l
-TC_ACP_SNK_SIG_SYN_BV_04_C		PASS	avdtptest -d SINK -l -p
 TC_ACP_SNK_TRA_BTR_BI_01_C		PASS	avdtptest -d SINK -l
 TC_ACP_SNK_TRA_BTR_BV_02_C		PASS	avdtptest -d SINK -l
 TC_ACP_SNK_TRA_MUX_BI_01_C		N/A
-- 
1.9.3

