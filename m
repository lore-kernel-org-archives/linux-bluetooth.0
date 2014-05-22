Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android/pts: Update MPS tests results
Date: Thu, 22 May 2014 11:57:54 +0200
Message-Id: <1400752674-31232-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400752674-31232-1-git-send-email-szymon.janc@tieto.com>
References: <1400752674-31232-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-mps.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pts-mps.txt b/android/pts-mps.txt
index 4930818..300046b 100644
--- a/android/pts-mps.txt
+++ b/android/pts-mps.txt
@@ -14,7 +14,7 @@ NONE	test result is none
 -------------------------------------------------------------------------------
 Test Name				Result	Notes
 -------------------------------------------------------------------------------
-TC_AG_SRC_HFAV_ACT_SD_BV_01_I		FAIL	JIRA: BZ-33
+TC_AG_SRC_HFAV_ACT_SD_BV_01_I		PASS
 TC_AG_SRC_HFAV_ACT_SD_BV_02_I		PASS
 TC_AG_SRC_HFAV_ACT_SD_BV_03_I		PASS
 TC_AG_SRC_HFAV_CLH_SD_BV_01_I		INC	JIRA: BZ-33
@@ -41,7 +41,7 @@ TC_HF_SNK_CT_HFAV_CLH_MD_BV_03_I	N/A
 TC_HF_SNK_CT_HFAV_CLH_MD_BV_04_I	N/A
 TC_HF_SNK_CT_HFAV_CLH_MD_BV_05_I	N/A
 TC_HF_SNK_CT_HFAV_CLH_MD_BV_06_I	N/A
-TC_SDP_CTH_SD_BV_01_I			INC	JIRA: BZ-34
+TC_SDP_CTH_SD_BV_01_I			PASS
 TC_SRC_TG_HFAV_ACT_MD_BV_01_I		PASS
 TC_SRC_TG_HFAV_CLH_MD_BV_01_I		PASS
 TC_SRC_TG_HFAV_CLH_MD_BV_02_I		PASS
-- 
1.9.1

