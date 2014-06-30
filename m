Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update PTS test results for HDP
Date: Mon, 30 Jun 2014 12:25:52 +0300
Message-Id: <1404120352-11532-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/pts-hdp.txt | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
index f2b1528..06d956c 100644
--- a/android/pts-hdp.txt
+++ b/android/pts-hdp.txt
@@ -1,7 +1,7 @@
 PTS test results for HDP
 
 PTS version: 5.1
-Tested: 27-June-2014
+Tested: 30-June-2014
 Android version: 4.4.2
 
 Results:
@@ -98,7 +98,11 @@ TC_SRC_HCT_BV_01_I	PASS    haltest:
 				<mdep_cfg_index>
 
 				when prompted: bluetooth ssp_reply <args>
-TC_SRC_HCT_BV_02_I	INC
+TC_SRC_HCT_BV_02_I	PASS	haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
 TC_SRC_HCT_BV_03_I	N/A
 TC_SRC_HCT_BV_04_I	INC
 TC_SRC_HCT_BV_05_C	N/A
@@ -162,7 +166,13 @@ TC_SNK_CC_BV_04_C	PASS    haltest:
 
 				when prompted: bluetooth ssp_reply <args>
 
-TC_SNK_CC_BV_06_C	INC
+TC_SNK_CC_BV_06_C	PASS	haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 2
+				BTHL_MDEP_ROLE_SINK 4100 BTHL_CHANNEL_TYPE_RELIABLE
+				pulse-oximeter
+				BTHL_MDEP_ROLE_SINK 4100 BTHL_CHANNEL_TYPE_STREAMING
+				pulse-oximeter
 TC_SNK_CC_BV_08_C	PASS    haltest:
 				hl register_application bluez-android Bluez
 				bluez-hdp health-device-profile 2
@@ -180,8 +190,18 @@ TC_SNK_CC_BV_08_C	PASS    haltest:
 				hl connect_channel <app_id> <bd_addr>
 				<mdep_cfg_index>
 
-TC_SNK_CC_BV_10_C	INC
-TC_SNK_CC_BI_11_C	INC
+TC_SNK_CC_BV_10_C	PASS	haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 2
+				BTHL_MDEP_ROLE_SINK 4100 BTHL_CHANNEL_TYPE_RELIABLE
+				pulse-oximeter
+				BTHL_MDEP_ROLE_SINK 4100 BTHL_CHANNEL_TYPE_STREAMING
+				pulse-oximeter
+TC_SNK_CC_BI_11_C	PASS	haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SINK 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
 TC_SNK_HCT_BV_01_I	PASS    haltest:
 				hl register_application bluez-android Bluez
 				bluez-hdp health-device-profile 1
-- 
1.8.3.2

