Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 12/12] android/pts: Update HDP test results
Date: Fri, 27 Jun 2014 14:25:03 +0300
Message-Id: <1403868303-8129-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Mark ECHO server tests passed.
---
 android/pts-hdp.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
index 99aa2d6..f2b1528 100644
--- a/android/pts-hdp.txt
+++ b/android/pts-hdp.txt
@@ -1,7 +1,7 @@
 PTS test results for HDP
 
 PTS version: 5.1
-Tested: 17-June-2014
+Tested: 27-June-2014
 Android version: 4.4.2
 
 Results:
@@ -105,7 +105,11 @@ TC_SRC_HCT_BV_05_C	N/A
 TC_SRC_HCT_BV_06_C	INC
 TC_SRC_HCT_BV_07_C	INC
 TC_SRC_DE_BV_01_I	INC
-TC_SRC_DE_BV_02_I	INC
+TC_SRC_DE_BV_02_I	PASS	haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
 TC_SRC_DEP_BV_01_I	INC
 TC_SRC_DEP_BV_02_I	N/A
 TC_SNK_CON_BV_01_I	PASS	haltest:
@@ -195,7 +199,11 @@ TC_SNK_HCT_BV_05_C	N/A
 TC_SNK_HCT_BV_06_C	INC
 TC_SNK_HCT_BV_07_C	INC
 TC_SNK_DE_BV_01_I	N/A
-TC_SNK_DE_BV_02_I	INC
+TC_SNK_DE_BV_02_I	PASS	haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SINK 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
 TC_SNK_DEP_BV_03_I	INC
 TC_SNK_DEP_BV_04_I	INC
 -------------------------------------------------------------------------------
-- 
1.8.3.2

