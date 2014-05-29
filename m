Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/pts: Update GAP tests results
Date: Thu, 29 May 2014 10:01:07 +0200
Message-Id: <1401350467-8805-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1401350467-8805-1-git-send-email-szymon.janc@tieto.com>
References: <1401350467-8805-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 137 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 90 insertions(+), 47 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index d1f0402..1ebd658 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -1,7 +1,7 @@
 PTS test results for GAP
 
 PTS version: 5.1
-Tested: 16-May-2014
+Tested: 28-May-2014
 Android version: 4.4.2
 
 Results:
@@ -29,16 +29,41 @@ TC_BROB_OBSV_BV_02_C	N/A
 TC_BROB_OBSV_BV_03_C	N/A
 TC_BROB_OBSV_BV_04_C	N/A
 TC_BROB_OBSV_BV_05_C	N/A
-TC_DISC_NONM_BV_01_C	N/A
-TC_DISC_NONM_BV_02_C	N/A
-TC_DISC_LIMM_BV_01_C	N/A
-TC_DISC_LIMM_BV_02_C	N/A
-TC_DISC_LIMM_BV_03_C	N/A
-TC_DISC_LIMM_BV_04_C	N/A
-TC_DISC_GENM_BV_01_C	N/A
-TC_DISC_GENM_BV_02_C	N/A
-TC_DISC_GENM_BV_03_C	N/A
-TC_DISC_GENM_BV_04_C	N/A
+TC_DISC_NONM_BV_01_C	PASS	btmgmt connectable off
+				btmgmt advertising on
+TC_DISC_NONM_BV_02_C	PASS	btmgmt connectable on
+				btmgmt discov off
+				btmgmt advertising on
+TC_DISC_LIMM_BV_01_C	PASS	btmgmt connectable on
+				btmgmt discov off
+				<answer NO to non-connectable adv question>
+				btmgmt discov limited 30
+TC_DISC_LIMM_BV_02_C	PASS	btmgmt connectable on
+				btmgmt advertising on
+				btmgmt discov limited 30
+TC_DISC_LIMM_BV_03_C	PASS	btmgmt connectable on
+				btmgmt discov off
+				<answer NO to non-connectable adv question>
+				btmgmt discov limited 30
+TC_DISC_LIMM_BV_04_C	PASS	btmgmt connectable on
+				btmgmt discov off
+				btmgmt power off
+				btmgmt bredr off
+				btmgmt power on
+				btmgmt discov limited 30
+TC_DISC_GENM_BV_01_C	PASS	btmgmt connectable on
+				btmgmt discov on
+				<answer NO to non-connectable adv question>
+TC_DISC_GENM_BV_02_C	PASS	btmgmt connectable on
+				btmgmt advertising on
+				btmgmt discov on
+TC_DISC_GENM_BV_03_C	PASS	btmgmt connectable on
+				btmgmt discov on
+TC_DISC_GENM_BV_04_C	PASS	btmgmt connectable on
+				btmgmt power off
+				btmgmt bredr off
+				btmgmt discov on
+				btmgmt advertising on
 TC_DISC_LIMP_BV_01_C	PASS	btmgmt find -l
 				PTS AD flags must have bit 1 unset and bit 0 set
 TC_DISC_LIMP_BV_02_C	PASS	btmgmt find -l
@@ -66,18 +91,28 @@ TC_IDLE_NAMP_BV_01_C	PASS	possible to PASS using haltest following steps:
 				all services, get characteristic and then read
 				characteristic (name)
 TC_IDLE_NAMP_BV_02_C	PASS	haltest: gatts connect
-TC_CONN_NCON_BV_01_C	N/A
-TC_CONN_NCON_BV_02_C	N/A
-TC_CONN_NCON_BV_03_C	N/A
-TC_CONN_DCON_BV_01_C	N/A
+TC_CONN_NCON_BV_01_C	PASS	btmgmt connectable off
+				btmgmt advertising on
+TC_CONN_NCON_BV_02_C	PASS	<answer NO to non-connectable adv question>
+				Note: non-connectable and discoverable ?
+TC_CONN_NCON_BV_03_C	PASS	<answer NO to non-connectable adv question>
+				Note: non-connectable and discoverable ?
+TC_CONN_DCON_BV_01_C	PASS	btmgmt connectable on
+				btmgmt advertising on
 TC_CONN_DCON_BV_02_C	N/A
 TC_CONN_DCON_BV_03_C	N/A
-TC_CONN_UCON_BV_01_C	N/A
-TC_CONN_UCON_BV_02_C	N/A
-TC_CONN_UCON_BV_03_C	N/A
+TC_CONN_UCON_BV_01_C	PASS	btmgmt connectable on
+				btmgmt advertising on
+TC_CONN_UCON_BV_02_C	PASS	btmgmt connectable on
+				btmgmt discov on
+				btmgmt advertising on
+TC_CONN_UCON_BV_03_C	PASS	btmgmt connectable on
+				btmgmt advertising on
+				btmgmt discov limited 30
 TC_CONN_UCON_BV_04_C	N/A
 TC_CONN_UCON_BV_05_C	N/A
-TC_CONN_ACEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_ACEP_BV_01_C	INC	No white list support
+				Note: pass on some chips with 'gattc connect'
 TC_CONN_ACEP_BV_02_C	INC	Privacy feature - not implemented
 TC_CONN_GCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_GCEP_BV_02_C	PASS	'gattc connect' prior to pressing OK on PTS
@@ -92,39 +127,44 @@ TC_CONN_DCEP_BV_04_C	INC	Privacy feature - not implemented
 TC_CONN_CPUP_BV_01_C	N/A
 TC_CONN_CPUP_BV_02_C	N/A
 TC_CONN_CPUP_BV_03_C	N/A
-TC_CONN_CPUP_BV_04_C	PASS
-TC_CONN_CPUP_BV_05_C	PASS
-TC_CONN_CPUP_BV_06_C	PASS	PTS issue - ID: 12187
-				ETS + new pixit file should be added
+TC_CONN_CPUP_BV_04_C	PASS	gattc register_client
+				gattc connect 1 <pts_bdaddr>
+				gattc disconnect 1 <pts_bdaddr> 1
+TC_CONN_CPUP_BV_05_C	PASS	gattc register_client
+				gattc connect 1 <pts_bdaddr>
+				gattc disconnect 1 <pts_bdaddr> 1
+TC_CONN_CPUP_BV_06_C	INC
 TC_CONN_TERM_BV_01_C	PASS
-TC_CONN_PRDA_BV_01_C	N/A
+TC_CONN_PRDA_BV_01_C	INC	Privacy feature - not implemented
 TC_CONN_PRDA_BV_02_C	INC	Privacy feature - not implemented
 TC_BOND_NBON_BV_01_C	PASS
 TC_BOND_NBON_BV_02_C	PASS	haltest: gattc_register_client
 				gattc connect <client_id> <address>
 				bluetooth create_bond <address>
 				bluetooth remove_bond <address>
-TC_BOND_NBON_BV_03_C	N/A
-TC_BOND_BON_BV_01_C	N/A
+TC_BOND_NBON_BV_03_C	PASS
+TC_BOND_BON_BV_01_C	PASS	gattc register_client
+				gattc listen 1
+				bluetooth create_bond <pts_bdaddr>
 TC_BOND_BON_BV_02_C	PASS
-TC_BOND_BON_BV_03_C	N/A
+TC_BOND_BON_BV_03_C	FAIL
 TC_BOND_BON_BV_04_C	PASS	haltest: gattc_register_client
 				gattc connect <client_id> <address>
 				bluetooth remove_bond <address>
 				gattc connect <client_id> <address>
-TC_SEC_AUT_BV_11_C	N/A
+TC_SEC_AUT_BV_11_C	INC
 TC_SEC_AUT_BV_12_C	INC	JIRA: BZ-29
 TC_SEC_AUT_BV_13_C	INC	JIRA: BZ-30
-TC_SEC_AUT_BV_14_C	N/A
+TC_SEC_AUT_BV_14_C	INC
 TC_SEC_AUT_BV_15_C	N/A
 TC_SEC_AUT_BV_16_C	INC	Not implemented
 TC_SEC_AUT_BV_17_C	PASS
-TC_SEC_AUT_BV_18_C	N/A
+TC_SEC_AUT_BV_18_C	INC
 TC_SEC_AUT_BV_19_C	PASS
-TC_SEC_AUT_BV_20_C	N/A
+TC_SEC_AUT_BV_20_C	INC
 TC_SEC_AUT_BV_21_C	INC	Not implemented
-TC_SEC_AUT_BV_22_C	N/A
-TC_SEC_AUT_BV_23_C	N/A
+TC_SEC_AUT_BV_22_C	INC
+TC_SEC_AUT_BV_23_C	INC
 TC_SEC_AUT_BV_24_C	INC	Not implemented
 TC_SEC_CSIGN_BV_01_C	INC	Not yet implemented - signed write
 TC_SEC_CSIGN_BV_02_C	INC	Not implemented
@@ -144,10 +184,12 @@ TC_PRIV_CONN_BV_09_C	N/A
 TC_PRIV_CONN_BV_10_C	N/A
 TC_PRIV_CONN_BV_11_C	INC	Privacy feature - not implemented
 TC_ADV_BV_01_C		N/A
-TC_ADV_BV_02_C		N/A
-TC_ADV_BV_03_C		N/A
+TC_ADV_BV_02_C		FAIL	PTS issue #12254
+TC_ADV_BV_03_C		PASS	gattc register_client
+				gattc listen 1 1
 TC_ADV_BV_04_C		N/A
-TC_ADV_BV_05_C		N/A
+TC_ADV_BV_05_C		PASS	gattc register_client
+				gattc listen 1 1
 TC_ADV_BV_06_C		N/A
 TC_ADV_BV_07_C		N/A
 TC_ADV_BV_08_C		N/A
@@ -169,25 +211,26 @@ TC_GAT_BV_05_C		N/A
 TC_GAT_BV_06_C		N/A
 TC_GAT_BV_07_C		N/A
 TC_GAT_BV_08_C		N/A
-TC_DM_NCON_BV_01_C	N/A
-TC_DM_CON_BV_01_C	N/A
-TC_DM_NBON_BV_01_C	N/A
+TC_DM_NCON_BV_01_C	PASS
+TC_DM_CON_BV_01_C	PASS
+TC_DM_NBON_BV_01_C	PASS
 TC_DM_BON_BV_01_C	PASS	haltest:
 				create_bond and remove_bond when requested
 TC_DM_GIN_BV_01_C	PASS
 TC_DM_LIN_BV_01_C	PASS
 TC_DM_NAD_BV_01_C	PASS	Start discovery from IUT
 TC_DM_NAD_BV_02_C	PASS
-TC_DM_LEP_BV_01_C	N/A
-TC_DM_LEP_BV_02_C	N/A
-TC_DM_LEP_BV_03_C	N/A
+TC_DM_LEP_BV_01_C	PASS	gattc register_client
+				gattc listen 1 1
+TC_DM_LEP_BV_02_C	INC
+TC_DM_LEP_BV_03_C	INC
 TC_DM_LEP_BV_04_C	PASS	l2test -n <PTS bdaddr>
 TC_DM_LEP_BV_05_C	PASS	btmgmt find -b
 				l2test -n 00:1B:DC:06:06:22
 TC_DM_LEP_BV_06_C	PASS
-TC_DM_LEP_BV_07_C	N/A
-TC_DM_LEP_BV_08_C	N/A
-TC_DM_LEP_BV_09_C	N/A
-TC_DM_LEP_BV_10_C	N/A
-TC_DM_LEP_BV_11_C	N/A
+TC_DM_LEP_BV_07_C	PASS
+TC_DM_LEP_BV_08_C	PASS
+TC_DM_LEP_BV_09_C	PASS
+TC_DM_LEP_BV_10_C	INC
+TC_DM_LEP_BV_11_C	PASS
 -------------------------------------------------------------------------------
-- 
1.9.3

