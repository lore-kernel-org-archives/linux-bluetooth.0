Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 5/5] android/health: Update PTS result
Date: Mon, 30 Jun 2014 19:58:28 +0300
Message-Id: <1404147508-22756-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1404147508-22756-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1404147508-22756-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Results for TC_SRC_HCT_BV_04_I, TC_SRC_HCT_BV_06_C and
TC_SNK_HCT_BV_04_I.
---
 android/pts-hdp.txt | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
index fc5bd93..29a2434 100644
--- a/android/pts-hdp.txt
+++ b/android/pts-hdp.txt
@@ -108,9 +108,21 @@ TC_SRC_HCT_BV_02_I	PASS	haltest:
 				BTHL_MDEP_ROLE_SOURCE 4100
 				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
 TC_SRC_HCT_BV_03_I	N/A
-TC_SRC_HCT_BV_04_I	INC
+TC_SRC_HCT_BV_04_I	PASS    haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
+
+				when prompted: bluetooth ssp_reply <args>
 TC_SRC_HCT_BV_05_C	N/A
-TC_SRC_HCT_BV_06_C	INC
+TC_SRC_HCT_BV_06_C	PASS    haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
+
+				when prompted: bluetooth ssp_reply <args>
 TC_SRC_HCT_BV_07_C	INC
 TC_SRC_DE_BV_01_I	INC
 TC_SRC_DE_BV_02_I	PASS	haltest:
@@ -222,7 +234,13 @@ TC_SNK_HCT_BV_02_I	PASS	haltest:
 				BTHL_MDEP_ROLE_SINK 4100
 				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
 TC_SNK_HCT_BV_03_I	N/A
-TC_SNK_HCT_BV_04_I	INC
+TC_SNK_HCT_BV_04_I	PASS    haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SINK 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
+
+				when prompted: bluetooth ssp_reply <args>
 TC_SNK_HCT_BV_05_C	N/A
 TC_SNK_HCT_BV_06_C	PASS	haltest:
 				hl register_application bluez-android Bluez
-- 
1.9.1

