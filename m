Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv4 3/3] android/pts: Update test results for HOGP
Date: Wed, 25 Feb 2015 13:22:11 +0100
Message-Id: <1424866931-13334-4-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1424866931-13334-1-git-send-email-mariusz.skamra@tieto.com>
References: <1424866931-13334-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-hogp.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
index 488d4dd..827e9b4 100644
--- a/android/pts-hogp.txt
+++ b/android/pts-hogp.txt
@@ -1,7 +1,7 @@
 PTS test results for HoG
 
 PTS version: 6.0
-Tested: 16-February-2015
+Tested: 24-February-2015
 Android version: 5.0
 
 Results:
@@ -18,7 +18,7 @@ TC_HGDS_HH_BV_02_I	PASS
 TC_HGDS_HH_BV_03_I	PASS
 TC_HGDS_HD_BV_01_I	N/A
 TC_HGDS_HD_BV_02_I	N/A
-TC_HGDR_RH_BV_01_I	INC	JIRA #BA-340
+TC_HGDR_RH_BV_01_I	PASS
 TC_HGDC_RH_BV_01_I	PASS
 TC_HGDC_RH_BV_02_I	PASS
 TC_HGDC_RH_BV_03_I	PASS
@@ -93,7 +93,7 @@ TC_HGCF_BH_BV_03_I	N/A
 TC_HGCF_BH_BV_04_I	N/A
 TC_HGCF_BH_BV_05_I	N/A
 TC_HGCF_BH_BV_06_I	N/A
-TC_HGNF_RH_BV_01_I	PASS
+TC_HGNF_RH_BV_01_I	PASS	PTS issue #12878
 TC_HGNF_RH_BI_01_I	PASS
 TC_HGNF_RH_BI_01_I	PASS
 TC_HGNF_BH_BV_02_I	N/A
-- 
1.9.1

