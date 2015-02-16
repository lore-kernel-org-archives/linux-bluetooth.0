Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 2/2] android/pts: Update HOGP test results for PTS 6.0
Date: Mon, 16 Feb 2015 09:43:57 +0100
Message-Id: <1424076237-28349-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1424076237-28349-1-git-send-email-mariusz.skamra@tieto.com>
References: <1424076237-28349-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-hogp.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
index 98c14d8..488d4dd 100644
--- a/android/pts-hogp.txt
+++ b/android/pts-hogp.txt
@@ -1,7 +1,7 @@
 PTS test results for HoG
 
-PTS version: 5.3
-Tested: 01-December-2014
+PTS version: 6.0
+Tested: 16-February-2015
 Android version: 5.0
 
 Results:
@@ -13,13 +13,12 @@ N/A	test is disabled due to PICS setup
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_HGDS_HH_BV_01_I	PASS	PTS issue #12119
-				This issue affects all PTS test cases
+TC_HGDS_HH_BV_01_I	PASS
 TC_HGDS_HH_BV_02_I	PASS
 TC_HGDS_HH_BV_03_I	PASS
 TC_HGDS_HD_BV_01_I	N/A
 TC_HGDS_HD_BV_02_I	N/A
-TC_HGDR_RH_BV_01_I	PASS
+TC_HGDR_RH_BV_01_I	INC	JIRA #BA-340
 TC_HGDC_RH_BV_01_I	PASS
 TC_HGDC_RH_BV_02_I	PASS
 TC_HGDC_RH_BV_03_I	PASS
-- 
1.9.1

