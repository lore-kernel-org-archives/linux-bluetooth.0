Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/3] android/health: Update PTS result for TC_SRC_CC_BV_09_C
Date: Wed,  2 Jul 2014 12:32:02 +0300
Message-Id: <1404293522-7220-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1404293522-7220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1404293522-7220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-hdp.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
index 1734df2..f254bd0 100644
--- a/android/pts-hdp.txt
+++ b/android/pts-hdp.txt
@@ -90,7 +90,15 @@ TC_SRC_CC_BV_07_C	PASS    haltest:
 				when prompted:
 				hl connect_channel <app_id> <bd_addr>
 				<mdep_cfg_index>
-TC_SRC_CC_BV_09_C	INC
+TC_SRC_CC_BV_09_C	PASS    haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 2
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_STREAMING pulse-oximeter
+
+				when prompted: bluetooth ssp_reply <args>
 TC_SRC_CC_BI_12_C	PASS	haltest:
 				hl register_application bluez-android Bluez
 				bluez-hdp health-device-profile 1
-- 
1.9.1

