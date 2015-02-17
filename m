Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pts: Update PAN PTS 6.0 results for android 5.0
Date: Tue, 17 Feb 2015 13:29:14 +0100
Message-Id: <1424176154-4285-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1424176154-4285-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424176154-4285-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test case list and results for PAN profile against
android 5.0.
---
 android/pts-pan.txt | 121 +++++++++++++++++++++++++++-------------------------
 1 file changed, 62 insertions(+), 59 deletions(-)

diff --git a/android/pts-pan.txt b/android/pts-pan.txt
index e95a82e..ba4afac 100644
--- a/android/pts-pan.txt
+++ b/android/pts-pan.txt
@@ -1,7 +1,7 @@
 PTS test results for PAN
 
-PTS version: 5.3
-Tested: 17-November-2014
+PTS version: 6.0
+Tested: 17-February-2015
 Android version: 5.0
 
 Results:
@@ -13,61 +13,64 @@ N/A	test is disabled due to PICS setup
 --------------------------------------------------------------------------------
 Test Name				Result	Notes
 --------------------------------------------------------------------------------
-TC_BNEP_GN_BROADCAST_0_BV_03_C		N/A
-TC_GN_Ipv4_Autonet_BV_01_I		N/A
-TC_GN_Ipv6_Autonet_BV_02_I		N/A
-TC_GN_IP_DHCP_BV_03_I			N/A
-TC_GN_IP_LLMNR_BV_01_I			N/A
-TC_GN_IP_LLMNR_BV_02_I			N/A
-TC_GN_IP_DNS_BV_01_I			N/A
-TC_GN_IP_APP_BV_01_I			N/A
-TC_GN_IP_APP_BV_02_I			N/A
-TC_GN_IP_APP_BV_03_I			N/A
-TC_GN_IP_APP_BV_04_I			N/A
-TC_GN_IP_APP_BV_05_I			N/A
-TC_SDP_GN_BV_02_C			N/A
-TC_MISC_GN_UUID_BV_01_C			N/A
-TC_MISC_GN_UUID_BV_02_C			N/A
-TC_BNEP_NAP_BROADCAST_0_BV_01_C		N/A
-TC_BNEP_NAP_BROADCAST_0_BV_02_C		N/A
-TC_BNEP_NAP_FORWARD_UNICAST_BV_05_C	N/A
-TC_BNEP_NAP_FORWARD_UNICAST_BV_06_C	N/A
-TC_BNEP_NAP_MULTICAST_0_BV_03_C		N/A
-TC_BNEP_NAP_MULTICAST_0_BV_04_C		N/A
-TC_BNEP_BRIDGE_RX_BV_02_I		INC	PTS issue #12464
-TC_BNEP_BRIDGE_TX_BV_01_I		PASS
-TC_NAP_Ipv4_Autonet_BV_01_I		N/A
-TC_NAP_Ipv6_Autonet_BV_02_I		N/A
-TC_NAP_IP_DHCP_BV_03_I			N/A
-TC_NAP_IP_LLMNR_BV_01_I			N/A
-TC_NAP_IP_LLMNR_BV_02_I			N/A
-TC_NAP_IP_DNS_BV_01_I			N/A
-TC_NAP_IP_APP_BV_01_I			N/A
-TC_NAP_IP_APP_BV_02_I			N/A
-TC_NAP_IP_APP_BV_03_I			N/A
-TC_NAP_IP_APP_BV_04_I			N/A
-TC_NAP_IP_APP_BV_05_I			N/A
-TC_SDP_NAP_BV_01_C			PASS
-TC_MISC_NAP_UUID_BV_01_C		PASS
-TC_MISC_NAP_UUID_BV_02_C		PASS
-TC_BNEP_PANU_BROADCAST_0_BV_04_C	N/A
-TC_PANU_Ipv4_Autonet_BV_01_I		PASS	After DHCP request fail send
-						DHCP address request.
-						From IUT: send address request
-						dhcpcd -r 169.254.x.x bt-pan
-TC_PANU_Ipv6_Autonet_BV_02_I		N/A
-TC_PANU_IP_LLMNR_BV_01_I		N/A	SE #3558, TSE #4382, TCW #448
-TC_PANU_IP_LLMNR_BV_02_I		N/A
-TC_PANU_IP_DHCP_BV_03_I			N/A
-TC_PANU_IP_DNS_BV_01_I			N/A
-TC_PANU_IP_APP_BV_01_I			N/A
-TC_PANU_IP_APP_BV_02_I			N/A
-TC_PANU_IP_APP_BV_03_I			N/A
-TC_PANU_IP_APP_BV_04_I			N/A
-TC_PANU_IP_APP_BV_05_I			PASS
-TC_SDP_PANU_BV_01_C			N/A
-TC_MISC_PANU_UUID_BV_01_C		N/A
-TC_MISC_PANU_UUID_BV_02_C		N/A
-TC_MISC_ROLE_BV_01_C			N/A
-TC_MISC_ROLE_BV_BV_02_C			N/A
+TC_BNEP_BROADCAST_0_BV_01_C			N/A
+TC_BNEP_BROADCAST_0_BV_02_C			N/A
+TC_BNEP_MULTICAST_0_BV_03_C			N/A
+TC_BNEP_MULTICAST_0_BV_04_C			N/A
+TC_BNEP_FORWARD_UNICAST_BV_05_C			N/A
+TC_BNEP_FORWARD_UNICAST_BV_06_C			N/A
+TC_BNEP_EXTENSION_0_BV_07_C_TESTER_1		N/A
+TC_BNEP_EXTENSION_0_BV_07_C_TESTER_2		N/A
+TC_BNEP_FORWARD_BV_08_C_TESTER_1		N/A
+TC_BNEP_FORWARD_BV_08_C_TESTER_2		N/A
+TC_BNEP_FORWARD_BROADCAST_BV_09_C_TESTER_1	N/A
+TC_BNEP_FORWARD_BROADCAST_BV_09_C_TESTER_2	N/A
+TC_BNEP_FORWARD_BROADCAST_BV_09_C_TESTER_3	N/A
+TC_BNEP_FILTER_BV_10_C_TESTER_1			N/A
+TC_BNEP_FILTER_BV_10_C_TESTER_2			N/A
+TC_BNEP_FILTER_BV_11_C_TESTER_1			N/A
+TC_BNEP_FILTER_BV_11_C_TESTER_2			N/A
+TC_BNEP_FILTER_BV_12_C_TESTER_1			N/A
+TC_BNEP_FILTER_BV_12_C_TESTER_2			N/A
+TC_BNEP_FILTER_BV_13_C_TESTER_1			N/A
+TC_BNEP_FILTER_BV_13_C_TESTER_2			N/A
+TC_BNEP_FILTER_BV_14_C_TESTER_1			N/A
+TC_BNEP_FILTER_BV_14_C_TESTER_2			N/A
+TC_BNEP_FILTER_BV_15_C_TESTER_1			N/A
+TC_BNEP_FILTER_BV_15_C_TESTER_2			N/A
+TC_BRIDGE_TX_BV_01_I				PASS
+TC_BRIDGE_RX_BV_02_I				PASS
+						To initiate general ethernet
+						use for e.g. ping.
+TC_IPv4_AUTONET_BV_01_I				PASS
+						To initiate general ethernet
+						use for e.g. ping.
+TC_IPv6_AUTONET_BV_02_I				N/A
+TC_IP_DHCP_BV_03_I				PASS
+TC_IP_LLMNR_BV_01_I				N/A
+TC_IP_LLMNR_BV_02_I				N/A
+TC_IP_DNS_BV_01_I				N/A
+TC_IP_APP_BV_03_I				ip neighbour add <PTS IP addr>
+							lladdr <PTS HW addr>
+							dev bt-pan
+						ping -c 1 <PTS IP addr>
+						Note: Add ARP record if bt-pan
+							connection is
+							established
+TC_IP_APP_BV_05_I				ip neighbour add <PTS IP addr>
+							lladdr <PTS HW addr>
+							dev bt-pan
+						Note: Add of ARP record should
+							be done immediately
+							after establish of
+							bt-pan, because PTS
+							treat other than ICMP
+							frames as error.
+TC_MISC_ROLE_BV_01_C				N/A
+TC_MISC_ROLE_BV_02_C				N/A
+TC_MISC_UUID_BV_01_C				PASS
+TC_MISC_UUID_BV_02_C				PASS
+TC_SDP_NAP_BV_01_C				PASS
+TC_SDP_GN_BV_01_C				N/A
+TC_SDP_PANU_BV_01_C				PASS
 --------------------------------------------------------------------------------
-- 
1.9.3

