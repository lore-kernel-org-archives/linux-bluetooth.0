Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 3/5] android/pts: Update GAP test results
Date: Mon, 11 May 2015 14:49:46 +0200
Message-Id: <1431348588-3974-3-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1431348588-3974-1-git-send-email-mariusz.skamra@tieto.com>
References: <1431348588-3974-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-gap.txt  |  9 ++++++--
 android/pixit-gap.txt |  6 +++---
 android/pts-gap.txt   | 60 ++++++++++++++++++++++-----------------------------
 3 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/android/pics-gap.txt b/android/pics-gap.txt
index 466f451..f985d98 100644
--- a/android/pics-gap.txt
+++ b/android/pics-gap.txt
@@ -63,11 +63,16 @@ TSPC_GAP_1_4	True		Non-connectable mode (O)
 TSPC_GAP_1_5	True		Connectable mode (M)
 TSPC_GAP_1_6	True		Non-bondable mode (O)
 TSPC_GAP_1_7	True		Bondable mode (C.2)
-TSPC_GAP_1_8	False (*)	Non-Synchronizable Mode (O)
-TSPC_GAP_1_9	False (*)	Synchronizable Mode (O)
+TSPC_GAP_1_8	False (*)	Non-Synchronizable Mode (C.3)
+TSPC_GAP_1_9	False (*)	Synchronizable Mode (C.4)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_GAP_0_2 is supported, otherwise Optional.
 C.2: Mandatory if TSPC_GAP_3_5 is supported, otherwise Optional.
+C.3: Mandatory if TSPC_GAP_0A_2 or TSPC_GAP_0A_3 and is supported, otherwise
+	Excluded.
+C.4: Optional if TSPC_GAP_0A_2 or later is supported; Mandatory if TSPC_GAP_0A_2
+	or later and BB 3a/1 (Connectionless Slave Broadcast Transmitter) are
+	supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
diff --git a/android/pixit-gap.txt b/android/pixit-gap.txt
index 7a7107c..5a3fc6f 100644
--- a/android/pixit-gap.txt
+++ b/android/pixit-gap.txt
@@ -11,7 +11,7 @@ PTS version: 6.0
 Parameter Name						Value
 -------------------------------------------------------------------------------
 TSPX_bd_addr_iut					112233445566 (*&)
-TSPX_bd_addr_PTS					000000000000
+TSPX_bd_addr_PTS					C000DEADBEEF
 TSPX_broadcaster_class_of_device			100104
 TSPX_observer_class_of_device				100104
 TSPX_peripheral_class_of_device				100104
@@ -36,8 +36,8 @@ TSPX_iut_privacy_enabled				False
 TSPX_psm						1001
 TSPX_iut_valid_connection_interval_min			00C8
 TSPX_iut_valid_conneciton_interval_max			0960
-TSPX_iut_valid_connection_latency			0007
-TSPX_iut_valid_timeout_multiplier			0960
+TSPX_iut_valid_connection_latency			0006
+TSPX_iut_valid_timeout_multiplier			0962
 TSPX_iut_connection_parameter_timeout			30000
 TSPX_iut_invalid_connection_interval_min		0000
 TSPX_iut_invalid_conneciton_interval_max		0000
diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index cc87bc5..fe42d86 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -1,9 +1,9 @@
 PTS test results for GAP
 
-PTS version: 6.0
-Tested: 19-January-2015
-Android version: 5.0
-Kernel version: 3.18
+PTS version: 6.1
+Tested: 11-May-2015
+Android version: 5.1
+Kernel version: 4.1
 
 Results:
 PASS	test passed
@@ -265,13 +265,13 @@ TC_SEC_AUT_BV_23_C	PASS	haltest: gattc register_client
 				gatts send_response 3 1 0 1d 0 0x1234
 TC_SEC_AUT_BV_24_C	PASS	haltest: gatts register_server
 				gatts add_service 1 <uuid> 3
-				gatts add_characteristic 1 1b <uuid> 10 34
-				gatts start_service 1 1b 1
+				gatts add_characteristic 1 1d <uuid> 10 34
+				gatts start_service 1 1d 1
 				gatts connect
 				gatts disconnect
 				gatts connect
 				PTS asks for handle with insufficient encryption
-				gatts send_response 2 1 0 1d 0 0x1234
+				gatts send_response 2 1 0 1f 0 0x1234
 TC_SEC_CSIGN_BV_01_C	PASS	haltest:
 				gattc connect
 				bluetooth create_bond
@@ -281,15 +281,15 @@ TC_SEC_CSIGN_BV_01_C	PASS	haltest:
 TC_SEC_CSIGN_BV_02_C	PASS	haltest: gattc register_client
 				gatts register_server
 				gatts add_service 2 <uuid> 3
-				gatts add_characteristic 2 1b <uuid> 66 129
-				gatts start_service 2 1b 1
+				gatts add_characteristic 2 1d <uuid> 66 129
+				gatts start_service 2 1d 1
 				gattc listen 1
 				gatts disconnect
 TC_SEC_CSIGN_BI_01_C	PASS	gattc register_client
 				gatts register_server
 				gatts add_service 2 <uuid> 3
-				gatts add_characteristic 2 1b <uuid> 66 129
-				gatts start_service 2 1b 1
+				gatts add_characteristic 2 1d <uuid> 66 129
+				gatts start_service 2 1d 1
 				gattc listen 1
 				gatts disconnect
 				gattc disconnect
@@ -377,15 +377,15 @@ TC_DM_CON_BV_01_C	PASS	bluetooth set_adapter_property
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
 				gattc register_client
 				gattc listen 1
-TC_DM_NBON_BV_01_C	PASS	btmgmt bondable off
-TC_DM_BON_BV_01_C	PASS	haltest:
-				create_bond and remove_bond when requested
+TC_DM_NBON_BV_01_C	PASS	btmgmt pairable off
+				btmgmt pair -c 0x04 -t 0x01 <addr>
+TC_DM_BON_BV_01_C	PASS	btmgmt pairable on
+				btmgmt pair -c 0x04 -t 0x01 <addr>
 TC_DM_GIN_BV_01_C	PASS
 TC_DM_LIN_BV_01_C	PASS
-TC_DM_NAD_BV_01_C	PASS	Start discovery from IUT
+TC_DM_NAD_BV_01_C	PASS	btmgmt find
 TC_DM_NAD_BV_02_C	PASS
-TC_DM_LEP_BV_01_C	PASS	PTS issue #12949
-				bluetooth set_adapter_property
+TC_DM_LEP_BV_01_C	PASS	bluetooth set_adapter_property
 					BT_PROPERTY_ADAPTER_SCAN_MODE
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
 				gattc register_client
@@ -393,18 +393,18 @@ TC_DM_LEP_BV_01_C	PASS	PTS issue #12949
 TC_DM_LEP_BV_02_C	PASS	Use basic rate PTS dongle
 				haltest:
 				bluetooth set_adapter_property
-TC_DM_LEP_BV_04_C	PASS	l2test -n <PTS bdaddr>
-TC_DM_LEP_BV_05_C	PASS	btmgmt find -b
+TC_DM_LEP_BV_04_C	PASS	haltest:
+				gattc connect <PTS bdaddr>
+TC_DM_LEP_BV_05_C	PASS	Use basic rate PTS dongle
+				btmgmt find -b
 				l2test -n <PTS bdaddr>
 TC_DM_LEP_BV_06_C	PASS	gattc connect
-TC_DM_LEP_BV_07_C	PASS	PTS issue #12949
-				bluetooth set_adapter_property
+TC_DM_LEP_BV_07_C	PASS	bluetooth set_adapter_property
 					BT_PROPERTY_ADAPTER_SCAN_MODE
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
 				gattc register_client
 				gattc listen 1 1
-TC_DM_LEP_BV_08_C	PASS	PTS issue #12949
-				bluetooth set_adapter_property
+TC_DM_LEP_BV_08_C	PASS	bluetooth set_adapter_property
 					BT_PROPERTY_ADAPTER_SCAN_MODE
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
 				gattc register_client
@@ -415,19 +415,11 @@ TC_DM_LEP_BV_09_C	PASS	haltest:
 					BT_PROPERTY_ADAPTER_SCAN_MODE
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
 				gattc register_client
-				bluetooth start_discovery
-				gattc connect
+				gattc scan 1
+				gattc connect <PTS addr>
 				l2test -n -P 31 <PTS addr>
 				disconnect
-TC_DM_LEP_BV_10_C	PASS	PTS issue #12949
-				haltest:
-				bluetooth enable
-				bluetooth set_adapter_property
-					BT_PROPERTY_ADAPTER_SCAN_MODE
-					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
-				gattc register_client
-				gattc listen
-				bluetooth start_discovery
+TC_DM_LEP_BV_10_C	PASS	btmgmt find
 				l2test -n -P 31 <PTS addr>
 TC_DM_LEP_BV_11_C	PASS	haltest:
 				bluetooth enable
-- 
1.9.1

