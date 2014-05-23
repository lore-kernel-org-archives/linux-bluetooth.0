Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/4] android/pts: Update MPS tests results
Date: Fri, 23 May 2014 17:11:22 +0200
Message-Id: <1400857882-3298-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400857882-3298-1-git-send-email-szymon.janc@tieto.com>
References: <1400857882-3298-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-mps.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/android/pts-mps.txt b/android/pts-mps.txt
index 4930818..93bce31 100644
--- a/android/pts-mps.txt
+++ b/android/pts-mps.txt
@@ -1,7 +1,7 @@
 PTS test results for MPS
 
 PTS version: 5.1
-Tested: 20.05.2014
+Tested: 23.05.2014
 Android version: 4.4.2
 
 Results:
@@ -14,16 +14,16 @@ NONE	test result is none
 -------------------------------------------------------------------------------
 Test Name				Result	Notes
 -------------------------------------------------------------------------------
-TC_AG_SRC_HFAV_ACT_SD_BV_01_I		FAIL	JIRA: BZ-33
+TC_AG_SRC_HFAV_ACT_SD_BV_01_I		PASS
 TC_AG_SRC_HFAV_ACT_SD_BV_02_I		PASS
 TC_AG_SRC_HFAV_ACT_SD_BV_03_I		PASS
-TC_AG_SRC_HFAV_CLH_SD_BV_01_I		INC	JIRA: BZ-33
+TC_AG_SRC_HFAV_CLH_SD_BV_01_I		PASS
 TC_AG_SRC_HFAV_CLH_SD_BV_02_I		N/A
-TC_AG_SRC_HFAV_CLH_SD_BV_03_I		INC	JIRA: BZ-33
-TC_AG_SRC_HFAV_CLH_SD_BV_04_I		INC	JIRA: BZ-33
-TC_AG_SRC_HFAV_CLH_SD_BV_05_I		INC	JIRA: BZ-33
-TC_AG_SRC_HFAV_CLH_SD_BV_06_I		INC	JIRA: BZ-33
-TC_AVP_CTH_SD_BI_01_I			INC	JIRA: BZ-33
+TC_AG_SRC_HFAV_CLH_SD_BV_03_I		PASS
+TC_AG_SRC_HFAV_CLH_SD_BV_04_I		PASS
+TC_AG_SRC_HFAV_CLH_SD_BV_05_I		PASS
+TC_AG_SRC_HFAV_CLH_SD_BV_06_I		PASS
+TC_AVP_CTH_SD_BI_01_I			PASS
 TC_AVP_CTH_SD_BI_02_I			PASS
 TC_HF_SNK_HFAV_ACT_SD_BV_01_I		N/A
 TC_HF_SNK_HFAV_ACT_SD_BV_02_I		N/A
@@ -41,7 +41,7 @@ TC_HF_SNK_CT_HFAV_CLH_MD_BV_03_I	N/A
 TC_HF_SNK_CT_HFAV_CLH_MD_BV_04_I	N/A
 TC_HF_SNK_CT_HFAV_CLH_MD_BV_05_I	N/A
 TC_HF_SNK_CT_HFAV_CLH_MD_BV_06_I	N/A
-TC_SDP_CTH_SD_BV_01_I			INC	JIRA: BZ-34
+TC_SDP_CTH_SD_BV_01_I			FAIL	PTS issue #12245
 TC_SRC_TG_HFAV_ACT_MD_BV_01_I		PASS
 TC_SRC_TG_HFAV_CLH_MD_BV_01_I		PASS
 TC_SRC_TG_HFAV_CLH_MD_BV_02_I		PASS
-- 
1.9.1

