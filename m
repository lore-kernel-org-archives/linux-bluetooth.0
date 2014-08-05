Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Android/pts: Update PTS files for PAN
Date: Tue,  5 Aug 2014 16:48:56 +0200
Message-Id: <1407250136-25920-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PICS and PIXITs updated to PTS 5.2. Regression done for Android
4.4.4.
---
 android/pics-pan.txt  |  4 ++--
 android/pixit-pan.txt |  4 ++--
 android/pts-pan.txt   | 29 ++++++++++-------------------
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/android/pics-pan.txt b/android/pics-pan.txt
index f78fc10..b59bef7 100644
--- a/android/pics-pan.txt
+++ b/android/pics-pan.txt
@@ -1,6 +1,6 @@
 PAN PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -47,7 +47,7 @@ TSPC_PAN_2_6b	False		NAP: Support link-local address configuration
 TSPC_PAN_2_7	False		NAP: Support ping client for IPv4 (O)
 TSPC_PAN_2_8	False		NAP: Support DHCP Client for IPv4 (O)
 TSPC_PAN_2_9	False		NAP: Support DNS/LLMNR Resolver for IPv4 (O)
-TSPC_PAN_2_9a	False		NAP: Support LLMNR Sender for IPv4 (C.5)
+TSPC_PAN_2_9a	False (*)	NAP: Support LLMNR Sender for IPv4 (C.5)
 TSPC_PAN_2_9b	False		NAP: Support LLMNR Responder for IPv4 (O)
 TSPC_PAN_2_10	False		NAP: Support HTTP Client for IPv4 (O)
 TSPC_PAN_2_11	False		NAP: Support WAP Client for IPv4 (O)
diff --git a/android/pixit-pan.txt b/android/pixit-pan.txt
index 9053715..a4233c6 100644
--- a/android/pixit-pan.txt
+++ b/android/pixit-pan.txt
@@ -1,6 +1,6 @@
 PAN PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT or PTS Bluetooth address respectively
@@ -18,7 +18,7 @@ TSPX_security_enabled					False
 TSPX_pin_code						0000
 TSPX_delete_link_key					False
 TSPX_use_implicit_send					True
-TSPX_iut_ip_address					192.168.167.152
+TSPX_iut_ip_address					192.168.1.100 (*&)
 TSPX_iut_port_number					4242
 TSPX_PTS_ip_address					192.168.168.100
 TSPX_PTS_port_number					4242
diff --git a/android/pts-pan.txt b/android/pts-pan.txt
index 88f903d..5e3248c 100644
--- a/android/pts-pan.txt
+++ b/android/pts-pan.txt
@@ -1,8 +1,8 @@
 PTS test results for PAN
 
-PTS version: 5.1
-Tested: 07-April-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 05-August-2014
+Android version: 4.4.4
 
 Results:
 PASS	test passed
@@ -34,12 +34,7 @@ TC_BNEP_NAP_FORWARD_UNICAST_BV_05_C	N/A
 TC_BNEP_NAP_FORWARD_UNICAST_BV_06_C	N/A
 TC_BNEP_NAP_MULTICAST_0_BV_03_C		N/A
 TC_BNEP_NAP_MULTICAST_0_BV_04_C		N/A
-TC_BNEP_BRIDGE_RX_BV_02_I		PASS	Tester needs to send one
-						forward-unicast	BNEP packet
-						with given data (5 times)
-						0x00, 0x01, 0xFF followed by
-						0x00, 0x01, 0x9E, 0x9F
-						sendip -d <hexdata>
+TC_BNEP_BRIDGE_RX_BV_02_I		INC	PTS issue #12464
 TC_BNEP_BRIDGE_TX_BV_01_I		PASS
 TC_NAP_Ipv4_Autonet_BV_01_I		N/A
 TC_NAP_Ipv6_Autonet_BV_02_I		N/A
@@ -56,14 +51,12 @@ TC_SDP_NAP_BV_01_C			PASS
 TC_MISC_NAP_UUID_BV_01_C		PASS
 TC_MISC_NAP_UUID_BV_02_C		PASS
 TC_BNEP_PANU_BROADCAST_0_BV_04_C	N/A
-TC_PANU_Ipv4_Autonet_BV_01_I		PASS	When prompted connect to PTS.
-						From IUT: issue ARP request
-						iperf -c <addr> -p <port#>
+TC_PANU_Ipv4_Autonet_BV_01_I		PASS	After DHCP request fail send
+						DHCP address request.
+						From IUT: send address request
+						dhcpd -r 169.254.x.x bt-pan
 TC_PANU_Ipv6_Autonet_BV_02_I		N/A
-TC_PANU_IP_LLMNR_BV_01_I		PASS	When prompted connect to PTS.
-						From IUT: send LLMNR request
-						command
-						iperf -c <addr> -p <port#>
+TC_PANU_IP_LLMNR_BV_01_I		INC	PTS TSE errata #5871
 TC_PANU_IP_LLMNR_BV_02_I		N/A
 TC_PANU_IP_DHCP_BV_03_I			N/A
 TC_PANU_IP_DNS_BV_01_I			N/A
@@ -71,9 +64,7 @@ TC_PANU_IP_APP_BV_01_I			N/A
 TC_PANU_IP_APP_BV_02_I			N/A
 TC_PANU_IP_APP_BV_03_I			N/A
 TC_PANU_IP_APP_BV_04_I			N/A
-TC_PANU_IP_APP_BV_05_I			PASS	When prompted, connect to PTS
-						and then when prompted terminate
-						connection (IUT side)
+TC_PANU_IP_APP_BV_05_I			PASS
 TC_SDP_PANU_BV_01_C			N/A
 TC_MISC_PANU_UUID_BV_01_C		N/A
 TC_MISC_PANU_UUID_BV_02_C		N/A
-- 
1.9.3

