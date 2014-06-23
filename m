Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 2/2] android/health: Update PTS result
Date: Mon, 23 Jun 2014 15:46:58 +0300
Message-Id: <1403527618-8975-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403527618-8975-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403527618-8975-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update test results for TC_SRC_HCT_BV_01_I.
---
 android/pts-hdp.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
index e27d918..99aa2d6 100644
--- a/android/pts-hdp.txt
+++ b/android/pts-hdp.txt
@@ -88,7 +88,16 @@ TC_SRC_CC_BV_07_C	PASS    haltest:
 				<mdep_cfg_index>
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
-- 
1.9.1

