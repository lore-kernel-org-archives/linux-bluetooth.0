Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Correct PICS and PTS tests
Date: Mon,  3 Mar 2014 07:48:46 +0100
Message-Id: <1393829326-32221-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adjusting some optional PICS settings effecting in disabling some
PTS test cases.
---
 android/pics-pan.txt |  4 ++--
 android/pts-pan.txt  | 29 ++++++++++++++++++-----------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/android/pics-pan.txt b/android/pics-pan.txt
index 16457bf..21c16b2 100644
--- a/android/pics-pan.txt
+++ b/android/pics-pan.txt
@@ -121,8 +121,8 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_PAN_4_1	True (#)	PANU: Support BNEP (M)
 TSPC_PAN_4_2	True (*#)	PANU: Support IPv4 (C.1)
-TSPC_PAN_4_3	True (*#)	PANU: Support ping client for IPv4 (O)
-TSPC_PAN_4_4	True (*#)	PANU: Support DHCP client for  IPv4 (O)
+TSPC_PAN_4_3	False		PANU: Support ping client for IPv4 (O)
+TSPC_PAN_4_4	False		PANU: Support DHCP client for  IPv4 (O)
 TSPC_PAN_4_5	False		PANU: Support DNS/LLMNR Resolver for IPv4 (O)
 TSPC_PAN_4_5a	True (#)	PANU: Support LLMNR Sender for IPv4 (C.2)
 TSPC_PAN_4_5b	False		PANU: Support LLMNR Responder for IPv4 (O)
diff --git a/android/pts-pan.txt b/android/pts-pan.txt
index 8e8ae41..37c78fc 100644
--- a/android/pts-pan.txt
+++ b/android/pts-pan.txt
@@ -10,9 +10,9 @@ FAIL	test failed
 INC	test is inconclusive
 N/A	test is disabled due to PICS setup
 
--------------------------------------------------------------------------------
+-------------------------------------------------------------------------------------------
 Test Name				Result	Notes
--------------------------------------------------------------------------------
+-------------------------------------------------------------------------------------------
 TC_BNEP_GN_BROADCAST_0_BV_03_C		N/A
 TC_GN_Ipv4_Autonet_BV_01_I		N/A
 TC_GN_Ipv6_Autonet_BV_02_I		N/A
@@ -34,12 +34,15 @@ TC_BNEP_NAP_FORWARD_UNICAST_BV_05_C	N/A
 TC_BNEP_NAP_FORWARD_UNICAST_BV_06_C	N/A
 TC_BNEP_NAP_MULTICAST_0_BV_03_C		N/A
 TC_BNEP_NAP_MULTICAST_0_BV_04_C		N/A
-TC_BNEP_BRIDGE_RX_BV_02_I		INC
+TC_BNEP_BRIDGE_RX_BV_02_I		INC	Tester needs to send one forward-unicast
+							BNEP packet with given data (5 times)
+							0x00, 0x01, 0xFF followed by
+							0x00, 0x01, 0x9E, 0x9F
 TC_BNEP_BRIDGE_TX_BV_01_I		PASS
 TC_NAP_Ipv4_Autonet_BV_01_I		N/A
 TC_NAP_Ipv6_Autonet_BV_02_I		N/A
 TC_NAP_IP_DHCP_BV_03_I			N/A
-TC_NAP_IP_LLMNR_BV_01_I			INC
+TC_NAP_IP_LLMNR_BV_01_I			INC	From IUT: send LLMNR request command
 TC_NAP_IP_LLMNR_BV_02_I			N/A
 TC_NAP_IP_DNS_BV_01_I			N/A
 TC_NAP_IP_APP_BV_01_I			N/A
@@ -51,20 +54,24 @@ TC_SDP_NAP_BV_01_C			PASS
 TC_MISC_NAP_UUID_BV_01_C		PASS
 TC_MISC_NAP_UUID_BV_02_C		PASS
 TC_BNEP_PANU_BROADCAST_0_BV_04_C	N/A
-TC_PANU_Ipv4_Autonet_BV_01_I		INC
+TC_PANU_Ipv4_Autonet_BV_01_I		INC	When prompted connect to PTS. From IUT:
+							issue ARP request
 TC_PANU_Ipv6_Autonet_BV_02_I		N/A
-TC_PANU_IP_LLMNR_BV_01_I		INC
+TC_PANU_IP_LLMNR_BV_01_I		INC	When prompted connect to PTS. From IUT:
+							send LLMNR request command
 TC_PANU_IP_LLMNR_BV_02_I		N/A
-TC_PANU_IP_DHCP_BV_03_I			PASS
+TC_PANU_IP_DHCP_BV_03_I			N/A
 TC_PANU_IP_DNS_BV_01_I			N/A
 TC_PANU_IP_APP_BV_01_I			N/A
 TC_PANU_IP_APP_BV_02_I			N/A
-TC_PANU_IP_APP_BV_03_I			INC
-TC_PANU_IP_APP_BV_04_I			INC
-TC_PANU_IP_APP_BV_05_I			PASS
+TC_PANU_IP_APP_BV_03_I			N/A
+TC_PANU_IP_APP_BV_04_I			N/A
+TC_PANU_IP_APP_BV_05_I			PASS	When prompted, connect to PTS and then
+							when prompted terminate connection
+							(IUT side)
 TC_SDP_PANU_BV_01_C			N/A
 TC_MISC_PANU_UUID_BV_01_C		N/A
 TC_MISC_PANU_UUID_BV_02_C		N/A
 TC_MISC_ROLE_BV_01_C			N/A
 TC_MISC_ROLE_BV_BV_02_C			N/A
--------------------------------------------------------------------------------
+-------------------------------------------------------------------------------------------
-- 
1.8.5.3

