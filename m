Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/pts: Update GAP results
Date: Tue, 28 Oct 2014 14:28:30 +0100
Message-Id: <1414502910-17279-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1414502910-17279-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1414502910-17279-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some cases were disabled due to updated PICS setup (mostly Privacy Feature 1.0)
---
 android/pts-gap.txt | 146 ++++++++++++++++++++++++----------------------------
 1 file changed, 66 insertions(+), 80 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 9bfa143..99a6a7d 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -1,7 +1,7 @@
 PTS test results for GAP
 
-PTS version: 5.2
-Tested: 01-August-2014
+PTS version: 5.3
+Tested: 28-October-2014
 Android version: 4.4.4
 Kernel version: 3.18
 
@@ -94,7 +94,8 @@ TC_IDLE_NAMP_BV_01_C	PASS	possible to PASS using haltest following steps:
 				gattc - register client, connect to PTS, search
 				all services, get characteristic and then read
 				characteristic (name)
-TC_IDLE_NAMP_BV_02_C	PASS	haltest: gatts connect
+TC_IDLE_NAMP_BV_02_C	INC	PTS issue #12679
+				haltest: gatts connect
 TC_CONN_NCON_BV_01_C	PASS	btmgmt connectable off
 				btmgmt advertising on
 				<answer NO to non-connectable adv question>
@@ -116,38 +117,25 @@ TC_CONN_UCON_BV_03_C	PASS	btmgmt connectable on
 				btmgmt discov limited 30
 TC_CONN_UCON_BV_04_C	N/A
 TC_CONN_UCON_BV_05_C	N/A
-TC_CONN_ACEP_BV_01_C	PASS	debugfs:
-				echo -n "add <PTS addr> 0 1" > /sys/kernel/
-					debug/bluetooth/hciX/le_auto_conn
-				btmgmt le on
-				btmgmt power on
-				btmgmt disconnect -t 1 <PTS addr>
-				debugfs:
-				echo -n "clr" > /sys/kernel/debug/bluetooth/
-					hciX/le_auto_conn
-TC_CONN_ACEP_BV_02_C	INC	Privacy feature - PTS issue #12308
-				Note: PTS issue was closed. Test Spec Errata
-				was filled instead.
-				TSE issue #5825
+TC_CONN_ACEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_ACEP_BV_02_C	N/A
 TC_CONN_GCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_GCEP_BV_02_C	PASS	'gattc connect' prior to pressing OK on PTS
-TC_CONN_GCEP_BV_03_C	PASS	gattc connect
-				bluetooth create_bond
-				gattc connect
-				gattc disconnect
-TC_CONN_GCEP_BV_04_C	INC	Privacy feature - PTS issue #12308
+TC_CONN_GCEP_BV_03_C	N/A
+TC_CONN_GCEP_BV_04_C	N/A
 TC_CONN_SCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
-TC_CONN_SCEP_BV_02_C	INC	Privacy feature - PTS issue #12308
+TC_CONN_SCEP_BV_02_C	N/A
 TC_CONN_DCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
-TC_CONN_DCEP_BV_02_C	INC	Privacy feature - PTS issue #12308
+TC_CONN_DCEP_BV_02_C	INC	Test Spec. Errata approved - PTS issue #12600
+				is claimed to be resolved in upcoming ETS 8400
 TC_CONN_DCEP_BV_03_C	PASS	gattc connect
-TC_CONN_DCEP_BV_04_C	PASS	gattc connect
-				gattc create_bond
-				gattc connect
-				gattc disconnect
-TC_CONN_CPUP_BV_01_C	N/A
-TC_CONN_CPUP_BV_02_C	N/A
-TC_CONN_CPUP_BV_03_C	N/A
+TC_CONN_DCEP_BV_04_C	N/A
+TC_CONN_CPUP_BV_01_C	PASS	gattc register_client
+				gattc listen
+TC_CONN_CPUP_BV_02_C	PASS	gattc register_client
+				gattc listen
+TC_CONN_CPUP_BV_03_C	PASS	gattc register_client
+				gattc listen
 TC_CONN_CPUP_BV_04_C	PASS	gattc register_client
 				gattc connect
 				gattc disconnect
@@ -156,12 +144,14 @@ TC_CONN_CPUP_BV_05_C	PASS	gattc register_client
 				gattc disconnect
 TC_CONN_CPUP_BV_06_C	PASS	gattc register_client
 				gattc connect 1 <pts_bdaddr>
-				hcitool lecup <handle> 0x0008 0x0C7B 0x0010
-					0x0014
+				hcitool lecup <handle> 0x00C8 0x0960 0x0007
+					0x0960
 				gattc disconnect <client_if> <pts_bdaddr>
 					<conn_id>
 TC_CONN_TERM_BV_01_C	PASS
-TC_CONN_PRDA_BV_01_C	INC	PTS issue #12207
+TC_CONN_PRDA_BV_01_C	PASS	gattc register_client
+				gattc listen
+				gattc disconnect
 TC_CONN_PRDA_BV_02_C	INC	PTS issue #12310
 				Note: PTS issues #12207 & #12310 are claimed
 				to be resolved by the ETS provided in PTS issue
@@ -184,7 +174,9 @@ TC_BOND_BON_BV_01_C	PASS	PTS issue #12503
 				To bond with PTS execute
 				btmgmt pair -t 0x01 -c 0x03 <PTS addr>
 TC_BOND_BON_BV_02_C	PASS
-TC_BOND_BON_BV_03_C	PASS	gattc register_client
+TC_BOND_BON_BV_03_C	INC	PTS issue #12678
+				Note: tiny chance to pass if PTS won't crash
+				gattc register_client
 				gattc listen 1
 TC_BOND_BON_BV_04_C	PASS	haltest: gattc_register_client
 				gattc connect <client_id> <address>
@@ -200,7 +192,8 @@ TC_SEC_AUT_BV_11_C	PASS	haltest: gattc register_client
 				PTS asks for handle with Insufficient auth
 				bluetooth ssp_reply <addr> <passkey>
 				gatts send_response
-TC_SEC_AUT_BV_12_C	PASS	haltest: gatts register_server
+TC_SEC_AUT_BV_12_C	INC	PTS issue #12657
+				haltest: gatts register_server
 				gatts add_service 2 <uuid> 3
 				gatts add_characteristic 2 <service_handle>
 								<uuid> 10 68
@@ -209,7 +202,8 @@ TC_SEC_AUT_BV_12_C	PASS	haltest: gatts register_server
 				PTS asks for handle with Insufficient auth
 				bluetooth ssp_reply <addr> <passkey>
 				gatts send_response
-TC_SEC_AUT_BV_13_C	PASS	haltest: gatts register_server
+TC_SEC_AUT_BV_13_C	INC	PTS issue #12657
+				haltest: gatts register_server
 				gatts add_service 2 <uuid> 3
 				gatts add_characteristic 2 <service_handle>
 								<uuid> 10 68
@@ -218,7 +212,8 @@ TC_SEC_AUT_BV_13_C	PASS	haltest: gatts register_server
 				PTS asks for handle with Insufficient auth
 				bluetooth ssp_reply <addr> <passkey>
 				gatts send_response
-TC_SEC_AUT_BV_14_C	PASS	haltest:gattc register_client
+TC_SEC_AUT_BV_14_C	INC	PTS issue #12657
+				haltest:gattc register_client
 				gatts register_server
 				gatts add_service 2 <uuid> 3
 				gatts add_characteristic 2 1b <uuid> 10 68
@@ -228,17 +223,7 @@ TC_SEC_AUT_BV_14_C	PASS	haltest:gattc register_client
 				bluetooth ssp_reply <addr> <passkey>
 				gatts send_response
 TC_SEC_AUT_BV_15_C	N/A
-TC_SEC_AUT_BV_16_C	PASS	haltest: gatts register_server
-				gatts add_service 2 <uuid> 3
-				gatts add_characteristic 2 <service_handle>
-								<uuid> 10 34
-				gatts start_service 2 <service_handle> 1
-				gatts connect <server_if> <addr>
-				gatts disconnect <server_if> <addr>
-				gatts connect <server_if> <addr>
-				PTS asks for handle with Insufficient encrypt
-				bluetooth ssp_reply <addr> <passkey>
-				gatts send_response
+TC_SEC_AUT_BV_16_C	N/A
 TC_SEC_AUT_BV_17_C	PASS
 TC_SEC_AUT_BV_18_C	PASS	haltest: gattc register_client
 				gattc listen
@@ -248,16 +233,28 @@ TC_SEC_AUT_BV_18_C	PASS	haltest: gattc register_client
 				bluetooth create_bond
 				gattc read_characteristic
 TC_SEC_AUT_BV_19_C	PASS
-TC_SEC_AUT_BV_20_C	INC	PTS issue #12284
+TC_SEC_AUT_BV_20_C	PASS	haltest: gattc register_client
+				gattc listen <client_id> 1
+				Confirm bonding
+				gattc search_service
+				gattc get_characteristic
+				gattc read_characteristic
+				gattc listen <client_id> 0
+				Click OK on PTS popup to disconnect
+				bluetooth remove bond
+				gattc listen <client_id> 1
+				gattc read_characteristic
 TC_SEC_AUT_BV_21_C	PASS	haltest: gattc register_client
 				gattc connect
 				bluetooth create_bond
 				gattc connect
+				gattc test_command 226 <addr> 0 1
 TC_SEC_AUT_BV_22_C	PASS	btmgmt io-cap 3
 				haltest: gattc register_client
 				gattc listen
 				gattc test_command 226 <addr> <u1> 1
-TC_SEC_AUT_BV_23_C	PASS	haltest: gatts register_server
+TC_SEC_AUT_BV_23_C	INC	PTS issue #12657
+				haltest: gatts register_server
 				gatts add_service 2 <uuid> 3
 				gatts add_characteristic 2 <service_handle>
 								<uuid> 10 34
@@ -266,7 +263,8 @@ TC_SEC_AUT_BV_23_C	PASS	haltest: gatts register_server
 				gattc listen
 				bluetooth ssp_reply
 				gatts send_response
-TC_SEC_AUT_BV_24_C	PASS	haltest: gatts register_server
+TC_SEC_AUT_BV_24_C	INC	PTS issue #12657
+				haltest: gatts register_server
 				gatts add_service 2 <uuid> 3
 				gatts add_characteristic 2 <service_handle>
 								<uuid> 10 34
@@ -283,7 +281,8 @@ TC_SEC_CSIGN_BV_01_C	PASS	haltest:
 				gattc connect
 				gattc write_characteristic: <write_type> 4
 				gattc disconnect
-TC_SEC_CSIGN_BV_02_C	PASS	haltest:
+TC_SEC_CSIGN_BV_02_C	INC	PTS issue #12675
+				haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 66
@@ -291,7 +290,8 @@ TC_SEC_CSIGN_BV_02_C	PASS	haltest:
 				gatts start_service
 				gatts disconnect
 				gattc disconnect
-TC_SEC_CSIGN_BI_01_C	PASS	haltest:
+TC_SEC_CSIGN_BI_01_C	INC	PTS issue #12675
+				haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 66
@@ -299,7 +299,8 @@ TC_SEC_CSIGN_BI_01_C	PASS	haltest:
 				gatts start_service
 				gatts disconnect
 				gattc disconnect
-TC_SEC_CSIGN_BI_02_C	PASS	haltest:
+TC_SEC_CSIGN_BI_02_C	INC	PTS issue #12675
+				haltest:
 				gatts add_service
 				gatts add_chaaracteristic:
 						<properties> 66
@@ -307,7 +308,8 @@ TC_SEC_CSIGN_BI_02_C	PASS	haltest:
 				gatts start_service
 				gatts disconnect
 				gattc disconnect
-TC_SEC_CSIGN_BI_03_C	PASS	haltest:
+TC_SEC_CSIGN_BI_03_C	INC	PTS issue #12675
+				haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 64
@@ -317,7 +319,8 @@ TC_SEC_CSIGN_BI_03_C	PASS	haltest:
 				bluetooth ssp_reply
 				gatts disconnect
 				bluetooth remove_bond
-TC_SEC_CSIGN_BI_04_C	PASS	haltest:
+TC_SEC_CSIGN_BI_04_C	INC	PTS issue #12675
+				haltest:
 				gatts add_service
 				gatts add_characteristic:
 						<properties> 64
@@ -326,37 +329,20 @@ TC_SEC_CSIGN_BI_04_C	PASS	haltest:
 				gattc listen
 				bluetooth ssp_reply
 				gatts disconnect
-TC_PRIV_CONN_BV_01_C	PASS	gattc connect
-				gattc create_bond
-				gattc search service
-				gattc get_characteristic
-				gattc write_characteristic (privacy flag)
-				gattc write_characteristic (reconnection addr.)
-				gattc disconnect
-TC_PRIV_CONN_BV_02_C	PASS	gattc connect
-				gattc search service
-				gattc get_characteristic
-				gattc write_characteristic (reconnection addr.)
-				gattc disconnect
-TC_PRIV_CONN_BV_03_C	INC	Privacy feature - PTS issue #12308
-TC_PRIV_CONN_BV_04_C	PASS	gattc connect
-				gattc create_bond
-				gattc search service
-				gattc get_characteristic
-				gattc write_characteristic (privacy flag)
-				gattc write_characteristic (reconnection addr.)
-				gattc disconnect
-				gattc connect
-				gattc disconnect
+TC_PRIV_CONN_BV_01_C	N/A
+TC_PRIV_CONN_BV_02_C	N/A
+TC_PRIV_CONN_BV_03_C	N/A
+TC_PRIV_CONN_BV_04_C	N/A
 TC_PRIV_CONN_BV_05_C	N/A
 TC_PRIV_CONN_BV_06_C	N/A
 TC_PRIV_CONN_BV_07_C	N/A
 TC_PRIV_CONN_BV_08_C	N/A
 TC_PRIV_CONN_BV_09_C	N/A
 TC_PRIV_CONN_BV_10_C	INC	PTS issue #12312
-TC_PRIV_CONN_BV_11_C	INC	PTS issue #12310
+TC_PRIV_CONN_BV_11_C	INC	PTS issue #12310, JIRA #BA-186
 TC_ADV_BV_01_C		N/A
-TC_ADV_BV_02_C		FAIL	PTS issue #12254
+TC_ADV_BV_02_C		PASS	gattc register_client
+				gattc listen 1 1
 TC_ADV_BV_03_C		PASS	gattc register_client
 				gattc listen 1 1
 TC_ADV_BV_04_C		N/A
-- 
1.9.1

