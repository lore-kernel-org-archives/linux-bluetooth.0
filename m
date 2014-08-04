Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/gap: GAP tests for PTS 5.2
Date: Mon,  4 Aug 2014 15:46:31 +0200
Message-Id: <1407159991-5067-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-gap.txt  |  5 +++--
 android/pixit-gap.txt |  3 ++-
 android/pts-gap.txt   | 54 +++++++++++++++++++++++++++++++--------------------
 3 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/android/pics-gap.txt b/android/pics-gap.txt
index b3b896c..cd63971 100644
--- a/android/pics-gap.txt
+++ b/android/pics-gap.txt
@@ -1,6 +1,6 @@
 GAP PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 
@@ -709,7 +709,7 @@ C.5: Mandatory if (TSPC_GAP_4_1 or TSPC_GAP_4_2) is supported over BR/EDR,
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GAP_41_1	True ()	Central BR/EDR/LE: Security Aspects (M)
+TSPC_GAP_41_1	True		Central BR/EDR/LE: Security Aspects (M)
 -------------------------------------------------------------------------------
 
 
@@ -779,4 +779,5 @@ TSPC_SM_1_1	True (*)	Master Role (Initiator)
 TSPC_SM_1_2	True (*)	Slave Role (Responder)
 TSPC_SM_2_4	True (*)	OOB supported (O)
 TSPC_ALL	False		Turns on all
+TSPC_GATT_1_1	True		GATT Client Role
 -------------------------------------------------------------------------------
diff --git a/android/pixit-gap.txt b/android/pixit-gap.txt
index 494e24d..921f10a 100644
--- a/android/pixit-gap.txt
+++ b/android/pixit-gap.txt
@@ -1,6 +1,6 @@
 GAP PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -54,4 +54,5 @@ TSPX_pairing_before_service_request			False
 TSPX_iut_mandates_mitm					False
 TSPX_encryption_before_service_request			False
 TSPX_tester_appearance					0000
+TSPX_iut_advertising_data_in_broadcasting_mode		[set to default value]
 -------------------------------------------------------------------------------
diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 02430f4..af75dff 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -1,8 +1,8 @@
 PTS test results for GAP
 
-PTS version: 5.1
-Tested: 28-May-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 01-August-2014
+Android version: 4.4.4
 Kernel version: 3.17
 
 Results:
@@ -60,9 +60,12 @@ TC_DISC_GENM_BV_02_C	PASS	btmgmt connectable on
 				btmgmt discov on
 TC_DISC_GENM_BV_03_C	PASS	btmgmt connectable on
 				btmgmt discov on
+				<answer NO to non-connectable adv question>
 TC_DISC_GENM_BV_04_C	PASS	btmgmt connectable on
 				btmgmt power off
+				btmgmt le on
 				btmgmt bredr off
+				btmgmt power on
 				btmgmt discov on
 				btmgmt advertising on
 TC_DISC_LIMP_BV_01_C	PASS	btmgmt find -l
@@ -94,6 +97,7 @@ TC_IDLE_NAMP_BV_01_C	PASS	possible to PASS using haltest following steps:
 TC_IDLE_NAMP_BV_02_C	PASS	haltest: gatts connect
 TC_CONN_NCON_BV_01_C	PASS	btmgmt connectable off
 				btmgmt advertising on
+				<answer NO to non-connectable adv question>
 TC_CONN_NCON_BV_02_C	PASS	<answer NO to non-connectable adv question>
 				Note: non-connectable and discoverable ?
 TC_CONN_NCON_BV_03_C	PASS	<answer NO to non-connectable adv question>
@@ -122,6 +126,9 @@ TC_CONN_ACEP_BV_01_C	PASS	debugfs:
 				echo -n "clr" > /sys/kernel/debug/bluetooth/
 					hciX/le_auto_conn
 TC_CONN_ACEP_BV_02_C	INC	Privacy feature - PTS issue #12308
+				Note: PTS issue was closed. Test Spec Errata
+				was filled instead.
+				TSE issue #5825
 TC_CONN_GCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_GCEP_BV_02_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_GCEP_BV_03_C	PASS	gattc connect
@@ -130,10 +137,11 @@ TC_CONN_GCEP_BV_03_C	PASS	gattc connect
 				gattc disconnect
 TC_CONN_GCEP_BV_04_C	INC	Privacy feature - PTS issue #12308
 TC_CONN_SCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+				Note: test is not always passing. JIRA: BA-55
 TC_CONN_SCEP_BV_02_C	INC	Privacy feature - PTS issue #12308
 TC_CONN_DCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_DCEP_BV_02_C	INC	Privacy feature - PTS issue #12308
-TC_CONN_DCEP_BV_03_C	PASS
+TC_CONN_DCEP_BV_03_C	PASS	gattc connect
 TC_CONN_DCEP_BV_04_C	PASS	gattc connect
 				gattc create_bond
 				gattc connect
@@ -142,11 +150,11 @@ TC_CONN_CPUP_BV_01_C	N/A
 TC_CONN_CPUP_BV_02_C	N/A
 TC_CONN_CPUP_BV_03_C	N/A
 TC_CONN_CPUP_BV_04_C	PASS	gattc register_client
-				gattc connect 1 <pts_bdaddr>
-				gattc disconnect 1 <pts_bdaddr> 1
+				gattc connect
+				gattc disconnect
 TC_CONN_CPUP_BV_05_C	PASS	gattc register_client
-				gattc connect 1 <pts_bdaddr>
-				gattc disconnect 1 <pts_bdaddr> 1
+				gattc connect
+				gattc disconnect
 TC_CONN_CPUP_BV_06_C	PASS	gattc register_client
 				gattc connect 1 <pts_bdaddr>
 				hcitool lecup <handle> 0x0008 0x0C7B 0x0010
@@ -156,24 +164,28 @@ TC_CONN_CPUP_BV_06_C	PASS	gattc register_client
 TC_CONN_TERM_BV_01_C	PASS
 TC_CONN_PRDA_BV_01_C	INC	PTS issue #12207
 TC_CONN_PRDA_BV_02_C	INC	PTS issue #12310
+				Note: PTS issues #12207 & #12310 are claimed
+				to be resolved by the ETS provided in PTS issue
+				#12312 however it does not solve the problem
 TC_BOND_NBON_BV_01_C	PASS
-TC_BOND_NBON_BV_02_C	PASS	haltest: gattc_register_client
+TC_BOND_NBON_BV_02_C	PASS	haltest: gattc register_client
 				gattc connect <client_id> <address>
 				bluetooth create_bond <address>
 				bluetooth remove_bond <address>
-TC_BOND_NBON_BV_03_C	PASS
-TC_BOND_BON_BV_01_C	PASS	gattc register_client
+TC_BOND_NBON_BV_03_C	PASS	haltest: gattc listen
+TC_BOND_BON_BV_01_C	INC	gattc register_client
 				gattc listen 1
 				bluetooth create_bond <pts_bdaddr>
+				JIRA #BA-68
 TC_BOND_BON_BV_02_C	PASS
-TC_BOND_BON_BV_03_C	PASS	haltest: bluetooth remove_bond <pts_bdaddr>
-				gattc_register_client
+TC_BOND_BON_BV_03_C	PASS	gattc register_client
 				gattc listen 1
-TC_BOND_BON_BV_04_C	PASS	haltest: gattc_register_client
+TC_BOND_BON_BV_04_C	FAIL	haltest: gattc_register_client
 				gattc connect <client_id> <address>
 				bluetooth remove_bond <address>
 				gattc connect <client_id> <address>
-TC_SEC_AUT_BV_11_C	PASS	haltest:gattc register_client
+				JIRA #BA-70
+TC_SEC_AUT_BV_11_C	PASS	haltest: gattc register_client
 				gatts register_server
 				gatts add_service 2 <uuid> 3
 				gatts add_characteristic 2 1b <uuid> 10 68
@@ -357,7 +369,7 @@ TC_ADV_BV_15_C		N/A
 TC_ADV_BV_16_C		N/A
 TC_GAT_BV_01_C		PASS	haltest:
 				gattc register_client
-				gattc connect
+				gattc listen
 TC_GAT_BV_02_C		N/A
 TC_GAT_BV_03_C		N/A
 TC_GAT_BV_04_C		N/A
@@ -365,8 +377,8 @@ TC_GAT_BV_05_C		N/A
 TC_GAT_BV_06_C		N/A
 TC_GAT_BV_07_C		N/A
 TC_GAT_BV_08_C		N/A
-TC_DM_NCON_BV_01_C	PASS
-TC_DM_CON_BV_01_C	PASS
+TC_DM_NCON_BV_01_C	PASS	btmgmt connectable off
+TC_DM_CON_BV_01_C	PASS	btmgmt connectable on
 TC_DM_NBON_BV_01_C	PASS
 TC_DM_BON_BV_01_C	PASS	haltest:
 				create_bond and remove_bond when requested
@@ -385,8 +397,8 @@ TC_DM_LEP_BV_05_C	PASS	btmgmt find -b
 TC_DM_LEP_BV_06_C	PASS
 TC_DM_LEP_BV_07_C	PASS
 TC_DM_LEP_BV_08_C	PASS
-TC_DM_LEP_BV_09_C	PASS
-TC_DM_LEP_BV_10_C	PASS	haltest:
+TC_DM_LEP_BV_09_C	INC	JIRA #BA-64
+TC_DM_LEP_BV_10_C	INC	haltest:
 				gattc listen 1
 				gattc listen 1 0
 				bluetooth start_discovery
@@ -394,5 +406,5 @@ TC_DM_LEP_BV_10_C	PASS	haltest:
 				gattc listen 1
 				gattc listen 1 0
 				bluetooth create_bond
-TC_DM_LEP_BV_11_C	PASS
+TC_DM_LEP_BV_11_C	INC
 -------------------------------------------------------------------------------
-- 
1.8.5.3

