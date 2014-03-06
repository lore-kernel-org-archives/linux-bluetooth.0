Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: PAN PICS and PTS results
Date: Thu,  6 Mar 2014 08:07:21 +0100
Message-Id: <1394089641-11398-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adjusting some optional PICS settings as well as updating PTS
test's results
---
 android/pics-pan.txt | 42 +++++++++++++++++++++---------------------
 android/pts-pan.txt  | 36 ++++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/android/pics-pan.txt b/android/pics-pan.txt
index 16457bf..0caa629 100644
--- a/android/pics-pan.txt
+++ b/android/pics-pan.txt
@@ -12,14 +12,14 @@ O - optional
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_PAN_1_1	True (*#)	Role: Network Access Point (O.1)
+TSPC_PAN_1_1	True (*)	Role: Network Access Point (O.1)
 TSPC_PAN_1_2	False		Role: Group Ad-hoc Network (O.1)
-TSPC_PAN_1_3	True (*#)	Role: PAN User (O.1)
-TSPC_PAN_1a_1	True (#)	BNEP: BNEP Connection Setup (M)
-TSPC_PAN_1a_2	True (#)	BNEP: BNEP Data Packet Reception (M)
-TSPC_PAN_1a_3	True (#)	BNEP: BNEP Data Packet Transmission (M)
-TSPC_PAN_1a_4	True (#)	BNEP: BNEP Control Message Processing (M)
-TSPC_PAN_1a_5	True (#)	BNEP: BNEP Extension Header Processing (M)
+TSPC_PAN_1_3	True (*)	Role: PAN User (O.1)
+TSPC_PAN_1a_1	True		BNEP: BNEP Connection Setup (M)
+TSPC_PAN_1a_2	True		BNEP: BNEP Data Packet Reception (M)
+TSPC_PAN_1a_3	True		BNEP: BNEP Data Packet Transmission (M)
+TSPC_PAN_1a_4	True		BNEP: BNEP Control Message Processing (M)
+TSPC_PAN_1a_5	True		BNEP: BNEP Extension Header Processing (M)
 TSPC_PAN_1a_6	False		BNEP: Network Protocol Filter Message
 					Transmission (O)
 TSPC_PAN_1a_7	False		BNEP: Multicast Address Filter Message
@@ -33,21 +33,21 @@ O.1: It is mandatory to support at least one of the defined roles.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_PAN_2_1	True (#)	NAP: Support BNEP (M)
-TSPC_PAN_2_2	True (#)	NAP: Support BNEP Forwarding (M)
+TSPC_PAN_2_1	True		NAP: Support BNEP (M)
+TSPC_PAN_2_2	True		NAP: Support BNEP Forwarding (M)
 TSPC_PAN_2_3	False		NAP: Support Layer 2-Bridging between PAN and
 					External Network (C.1)
-TSPC_PAN_2_4	True (*#)	NAP: Support IP forwarding between PAN and
+TSPC_PAN_2_4	True (*)	NAP: Support IP forwarding between PAN and
 					External Network (C.1)
 TSPC_PAN_2_5	False		NAP: Support BNEP Packet Filtering (O)
-TSPC_PAN_2_6	True (*#)	NAP: Support IPv4 (C.2)
-TSPC_PAN_2_6a	True (*#)	NAP: Supports operable routable IPv4 address (O)
+TSPC_PAN_2_6	False		NAP: Support IPv4 (C.2)
+TSPC_PAN_2_6a	False		NAP: Supports operable routable IPv4 address (O)
 TSPC_PAN_2_6b	False		NAP: Support link-local address configuration
 					for IPv4 (C.4)
 TSPC_PAN_2_7	False		NAP: Support ping client for IPv4 (O)
 TSPC_PAN_2_8	False		NAP: Support DHCP Client for IPv4 (O)
 TSPC_PAN_2_9	False		NAP: Support DNS/LLMNR Resolver for IPv4 (O)
-TSPC_PAN_2_9a	True (#)	NAP: Support LLMNR Sender for IPv4 (C.5)
+TSPC_PAN_2_9a	False		NAP: Support LLMNR Sender for IPv4 (C.5)
 TSPC_PAN_2_9b	False		NAP: Support LLMNR Responder for IPv4 (O)
 TSPC_PAN_2_10	False		NAP: Support HTTP Client for IPv4 (O)
 TSPC_PAN_2_11	False		NAP: Support WAP Client for IPv4 (O)
@@ -58,8 +58,8 @@ TSPC_PAN_2_14a	False (*)	NAP: Support LLMNR Sender for IPv6 (C.6)
 TSPC_PAN_2_14b	False		NAP: Support LLMNR Responder for IPv6 (O)
 TSPC_PAN_2_15	False		NAP: Support HTTP Client for IPv6 (O)
 TSPC_PAN_2_16	False		NAP: Support WAP Client for IPv6 (O)
-TSPC_PAN_2_17	True (#)	NAP: Supports Connectable Mode (M)
-TSPC_PAN_2_18	True (#)	NAP: NAP Service Record (M)
+TSPC_PAN_2_17	True		NAP: Supports Connectable Mode (M)
+TSPC_PAN_2_18	True		NAP: NAP Service Record (M)
 TSPC_PAN_2_19	False		NAP: Support at least three PANUs (O)
 TSPC_PAN_2_20	False		NAP: Support at least two PANUs (O)
 -------------------------------------------------------------------------------
@@ -73,7 +73,7 @@ C.3: Mandatory to support IF any IPv6-based transport protocol OR
 	(TSPC_PAN_2_13-16) is supported, ELSE Optional.
 C.4: Mandatory if TSPC_PAN_2_6 is supported and TSPC_PAN_2_6a is not supported,
 	otherwise optional.
-C.5: Mandatory if item (TSPC_PAN_2_6) or item supported.
+C.5: Mandatory if item (TSPC_PAN_2_6) supported.
 C.6: Mandatory if item (TSPC_PAN_2_12) supported
 -------------------------------------------------------------------------------
 
@@ -119,12 +119,12 @@ C.4: Mandatory to support if (TSPC_PAN_3_10) is supported.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_PAN_4_1	True (#)	PANU: Support BNEP (M)
-TSPC_PAN_4_2	True (*#)	PANU: Support IPv4 (C.1)
-TSPC_PAN_4_3	True (*#)	PANU: Support ping client for IPv4 (O)
-TSPC_PAN_4_4	True (*#)	PANU: Support DHCP client for  IPv4 (O)
+TSPC_PAN_4_1	True		PANU: Support BNEP (M)
+TSPC_PAN_4_2	True		PANU: Support IPv4 (C.1)
+TSPC_PAN_4_3	False		PANU: Support ping client for IPv4 (O)
+TSPC_PAN_4_4	False		PANU: Support DHCP client for  IPv4 (O)
 TSPC_PAN_4_5	False		PANU: Support DNS/LLMNR Resolver for IPv4 (O)
-TSPC_PAN_4_5a	True (#)	PANU: Support LLMNR Sender for IPv4 (C.2)
+TSPC_PAN_4_5a	True		PANU: Support LLMNR Sender for IPv4 (C.2)
 TSPC_PAN_4_5b	False		PANU: Support LLMNR Responder for IPv4 (O)
 TSPC_PAN_4_6	False		PANU: Support HTTP Client for IPv4 (O)
 TSPC_PAN_4_7	False		PANU: Support WAP Client for IPv4 (O)
diff --git a/android/pts-pan.txt b/android/pts-pan.txt
index 8e8ae41..74c482a 100644
--- a/android/pts-pan.txt
+++ b/android/pts-pan.txt
@@ -10,9 +10,9 @@ FAIL	test failed
 INC	test is inconclusive
 N/A	test is disabled due to PICS setup
 
--------------------------------------------------------------------------------
+--------------------------------------------------------------------------------
 Test Name				Result	Notes
--------------------------------------------------------------------------------
+--------------------------------------------------------------------------------
 TC_BNEP_GN_BROADCAST_0_BV_03_C		N/A
 TC_GN_Ipv4_Autonet_BV_01_I		N/A
 TC_GN_Ipv6_Autonet_BV_02_I		N/A
@@ -34,37 +34,49 @@ TC_BNEP_NAP_FORWARD_UNICAST_BV_05_C	N/A
 TC_BNEP_NAP_FORWARD_UNICAST_BV_06_C	N/A
 TC_BNEP_NAP_MULTICAST_0_BV_03_C		N/A
 TC_BNEP_NAP_MULTICAST_0_BV_04_C		N/A
-TC_BNEP_BRIDGE_RX_BV_02_I		INC
+TC_BNEP_BRIDGE_RX_BV_02_I		PASS	Tester needs to send one
+						forward-unicast	BNEP packet
+						with given data (5 times)
+						0x00, 0x01, 0xFF followed by
+						0x00, 0x01, 0x9E, 0x9F
+						sendip -d <hexdata>
 TC_BNEP_BRIDGE_TX_BV_01_I		PASS
 TC_NAP_Ipv4_Autonet_BV_01_I		N/A
 TC_NAP_Ipv6_Autonet_BV_02_I		N/A
 TC_NAP_IP_DHCP_BV_03_I			N/A
-TC_NAP_IP_LLMNR_BV_01_I			INC
+TC_NAP_IP_LLMNR_BV_01_I			N/A
 TC_NAP_IP_LLMNR_BV_02_I			N/A
 TC_NAP_IP_DNS_BV_01_I			N/A
 TC_NAP_IP_APP_BV_01_I			N/A
 TC_NAP_IP_APP_BV_02_I			N/A
 TC_NAP_IP_APP_BV_03_I			N/A
 TC_NAP_IP_APP_BV_04_I			N/A
-TC_NAP_IP_APP_BV_05_I			PASS
+TC_NAP_IP_APP_BV_05_I			N/A
 TC_SDP_NAP_BV_01_C			PASS
 TC_MISC_NAP_UUID_BV_01_C		PASS
 TC_MISC_NAP_UUID_BV_02_C		PASS
 TC_BNEP_PANU_BROADCAST_0_BV_04_C	N/A
-TC_PANU_Ipv4_Autonet_BV_01_I		INC
+TC_PANU_Ipv4_Autonet_BV_01_I		PASS	When prompted connect to PTS.
+						From IUT: issue ARP request
+						iperf -c <addr> -p <port#>
 TC_PANU_Ipv6_Autonet_BV_02_I		N/A
-TC_PANU_IP_LLMNR_BV_01_I		INC
+TC_PANU_IP_LLMNR_BV_01_I		PASS	When prompted connect to PTS.
+						From IUT: send LLMNR request
+						command
+						iperf -c <addr> -p <port#>
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
+TC_PANU_IP_APP_BV_05_I			PASS	When prompted, connect to PTS
+						and then when prompted terminate
+						connection (IUT side)
 TC_SDP_PANU_BV_01_C			N/A
 TC_MISC_PANU_UUID_BV_01_C		N/A
 TC_MISC_PANU_UUID_BV_02_C		N/A
 TC_MISC_ROLE_BV_01_C			N/A
 TC_MISC_ROLE_BV_BV_02_C			N/A
--------------------------------------------------------------------------------
+--------------------------------------------------------------------------------
-- 
1.8.5.3

