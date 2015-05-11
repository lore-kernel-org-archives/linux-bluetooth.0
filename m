Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/pts: Update PAN PTS 6.1 results for android 5.1
Date: Mon, 11 May 2015 17:17:33 +0200
Message-Id: <1431357454-30227-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test case list and results for PAN profile against
android 5.1.
---
 android/pics-pan.txt  |  2 +-
 android/pixit-pan.txt |  2 +-
 android/pts-pan.txt   | 49 ++++++++++++++++++++++---------------------------
 3 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/android/pics-pan.txt b/android/pics-pan.txt
index 73461f5..57863c0 100644
--- a/android/pics-pan.txt
+++ b/android/pics-pan.txt
@@ -1,6 +1,6 @@
 PAN PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-pan.txt b/android/pixit-pan.txt
index 6c00d27..713646e 100644
--- a/android/pixit-pan.txt
+++ b/android/pixit-pan.txt
@@ -1,6 +1,6 @@
 PAN PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT or PTS Bluetooth/MAC address respectively
diff --git a/android/pts-pan.txt b/android/pts-pan.txt
index ba4afac..350b84e 100644
--- a/android/pts-pan.txt
+++ b/android/pts-pan.txt
@@ -1,8 +1,8 @@
 PTS test results for PAN
 
-PTS version: 6.0
-Tested: 17-February-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 11-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
@@ -11,7 +11,7 @@ INC	test is inconclusive
 N/A	test is disabled due to PICS setup
 
 --------------------------------------------------------------------------------
-Test Name				Result	Notes
+Test Name					Result	Notes
 --------------------------------------------------------------------------------
 TC_BNEP_BROADCAST_0_BV_01_C			N/A
 TC_BNEP_BROADCAST_0_BV_02_C			N/A
@@ -39,38 +39,33 @@ TC_BNEP_FILTER_BV_14_C_TESTER_2			N/A
 TC_BNEP_FILTER_BV_15_C_TESTER_1			N/A
 TC_BNEP_FILTER_BV_15_C_TESTER_2			N/A
 TC_BRIDGE_TX_BV_01_I				PASS
-TC_BRIDGE_RX_BV_02_I				PASS
-						To initiate general ethernet
-						use for e.g. ping.
-TC_IPv4_AUTONET_BV_01_I				PASS
-						To initiate general ethernet
-						use for e.g. ping.
+TC_BRIDGE_RX_BV_02_I				PASS	To initiate general
+							ethernet use for e.g.
+							ping.
+TC_IPv4_AUTONET_BV_01_I				PASS	To initiate general
+							ethernet use for e.g.
+							ping.
 TC_IPv6_AUTONET_BV_02_I				N/A
 TC_IP_DHCP_BV_03_I				PASS
 TC_IP_LLMNR_BV_01_I				N/A
 TC_IP_LLMNR_BV_02_I				N/A
 TC_IP_DNS_BV_01_I				N/A
-TC_IP_APP_BV_03_I				ip neighbour add <PTS IP addr>
-							lladdr <PTS HW addr>
-							dev bt-pan
-						ping -c 1 <PTS IP addr>
-						Note: Add ARP record if bt-pan
-							connection is
-							established
-TC_IP_APP_BV_05_I				ip neighbour add <PTS IP addr>
-							lladdr <PTS HW addr>
-							dev bt-pan
-						Note: Add of ARP record should
-							be done immediately
-							after establish of
-							bt-pan, because PTS
-							treat other than ICMP
-							frames as error.
+TC_IP_APP_BV_03_I				N/A
+TC_IP_APP_BV_05_I				INC	PTS issue #13436
+							ip neighbour add
+							<PTS IP addr> lladdr
+							<PTS HW addr> dev bt-pan
+							Note: ARP record should
+							be add immediately after
+							establish of bt-pan,
+							because PTS treat other
+							than ICMP frames as
+							error.
 TC_MISC_ROLE_BV_01_C				N/A
 TC_MISC_ROLE_BV_02_C				N/A
 TC_MISC_UUID_BV_01_C				PASS
 TC_MISC_UUID_BV_02_C				PASS
 TC_SDP_NAP_BV_01_C				PASS
 TC_SDP_GN_BV_01_C				N/A
-TC_SDP_PANU_BV_01_C				PASS
+TC_SDP_PANU_BV_01_C				N/A
 --------------------------------------------------------------------------------
-- 
2.1.0

