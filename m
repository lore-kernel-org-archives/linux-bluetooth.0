Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 5/5] android/health: Update PTS results
Date: Mon, 23 Jun 2014 18:06:04 +0300
Message-Id: <1403535964-32644-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403535964-32644-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403535964-32644-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update test results for TC_SRC_CC_BV_03_C, TC_SRC_CC_BV_07_C,
TC_SNK_CC_BV_04_C, TC_SNK_HCT_BV_01_I, TC_SNK_CC_BV_08_C and
TC_SRC_HCT_BV_01_I.
---
 android/pts-hdp.txt | 81 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
index bdf8eca..99aa2d6 100644
--- a/android/pts-hdp.txt
+++ b/android/pts-hdp.txt
@@ -58,12 +58,46 @@ TC_SRC_CC_BV_01_C	PASS	haltest:
 
 				when prompted: bluetooth ssp_reply <args>
 TC_SRC_CC_BV_02_C	PASS	when prompted: bluetooth ssp_reply <args>
-TC_SRC_CC_BV_03_C	INC
+TC_SRC_CC_BV_03_C	PASS    haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
+
+				hl connect_channel <app_id> <bd_addr>
+				<mdep_cfg_index>
+
+				when prompted: bluetooth ssp_reply <args>
+
 TC_SRC_CC_BV_05_C	INC
-TC_SRC_CC_BV_07_C	INC
+TC_SRC_CC_BV_07_C	PASS    haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 2
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_STREAMING pulse-oximeter
+
+				hl connect_channel <app_id> <bd_addr>
+				<mdep_cfg_index>
+
+				when prompted: bluetooth ssp_reply <args>
+
+				when prompted:
+				hl connect_channel <app_id> <bd_addr>
+				<mdep_cfg_index>
 TC_SRC_CC_BV_09_C	INC
 TC_SRC_CC_BI_12_C	INC
-TC_SRC_HCT_BV_01_I	INC
+TC_SRC_HCT_BV_01_I	PASS    haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
+
+				hl connect_channel <app_id> <bd_addr>
+				<mdep_cfg_index>
+
+				when prompted: bluetooth ssp_reply <args>
 TC_SRC_HCT_BV_02_I	INC
 TC_SRC_HCT_BV_03_I	N/A
 TC_SRC_HCT_BV_04_I	INC
@@ -113,12 +147,47 @@ TC_SNK_CC_BV_01_C	PASS	haltest:
 
 				when prompted: bluetooth ssp_reply <args>
 TC_SNK_CC_BV_02_C	PASS	when prompted: bluetooth ssp_reply <args>
-TC_SNK_CC_BV_04_C	INC
+TC_SNK_CC_BV_04_C	PASS    haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SINK 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
+
+				hl connect_channel <app_id> <bd_addr>
+				<mdep_cfg_index>
+
+				when prompted: bluetooth ssp_reply <args>
+
 TC_SNK_CC_BV_06_C	INC
-TC_SNK_CC_BV_08_C	INC
+TC_SNK_CC_BV_08_C	PASS    haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 2
+				BTHL_MDEP_ROLE_SINK 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
+				BTHL_MDEP_ROLE_SINK 4100
+				BTHL_CHANNEL_TYPE_STREAMING pulse-oximeter
+
+				hl connect_channel <app_id> <bd_addr>
+				<mdep_cfg_index>
+
+				when prompted: bluetooth ssp_reply <args>
+
+				when prompted:
+				hl connect_channel <app_id> <bd_addr>
+				<mdep_cfg_index>
+
 TC_SNK_CC_BV_10_C	INC
 TC_SNK_CC_BI_11_C	INC
-TC_SNK_HCT_BV_01_I	INC
+TC_SNK_HCT_BV_01_I	PASS    haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SINK 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
+
+				hl connect_channel <app_id> <bd_addr>
+				<mdep_cfg_index>
+
+				when prompted: bluetooth ssp_reply <args>
 TC_SNK_HCT_BV_02_I	INC
 TC_SNK_HCT_BV_03_I	N/A
 TC_SNK_HCT_BV_04_I	INC
-- 
1.9.1

