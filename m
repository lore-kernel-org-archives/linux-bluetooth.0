Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Re-run PTS GAP tests
Date: Fri,  9 May 2014 16:13:56 +0200
Message-Id: <1399644837-17723-1-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
References: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 90 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 8be9a5a..eb7d8d2 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -1,7 +1,7 @@
 PTS test results for GAP
 
 PTS version: 5.1
-Tested: 11-April-2014
+Tested: 09-May-2014
 Android version: 4.4.2
 
 Results:
@@ -9,6 +9,7 @@ PASS	test passed
 FAIL	test failed
 INC	test is inconclusive
 N/A	test is disabled due to PICS setup
+(#)	not implemented
 
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
@@ -61,8 +62,11 @@ TC_DISC_GENP_BV_05_C	PASS	btmgmt find -l
 				PTS AD flags must have bit 1 and bit 0 unset
 TC_IDLE_GIN_BV_01_C	PASS	Start discovery from IUT
 TC_IDLE_LIN_BV_01_C	PASS	hcitool scan --iac=liac
-TC_IDLE_NAMP_BV_01_C	PASS
-TC_IDLE_NAMP_BV_02_C	INC
+TC_IDLE_NAMP_BV_01_C	PASS	possible to PASS using haltest following steps:
+				gattc - register client, connect to PTS, search
+				all services, get characteristic and then read
+				characteristic (name)
+TC_IDLE_NAMP_BV_02_C	PASS	haltest: gatts connect
 TC_CONN_NCON_BV_01_C	N/A
 TC_CONN_NCON_BV_02_C	N/A
 TC_CONN_NCON_BV_03_C	N/A
@@ -74,65 +78,71 @@ TC_CONN_UCON_BV_02_C	N/A
 TC_CONN_UCON_BV_03_C	N/A
 TC_CONN_UCON_BV_04_C	N/A
 TC_CONN_UCON_BV_05_C	N/A
-TC_CONN_ACEP_BV_01_C	INC
-TC_CONN_ACEP_BV_02_C	INC
-TC_CONN_GCEP_BV_01_C	INC
-TC_CONN_GCEP_BV_02_C	INC
-TC_CONN_GCEP_BV_03_C	INC
-TC_CONN_GCEP_BV_04_C	INC
-TC_CONN_SCEP_BV_01_C	INC
-TC_CONN_SCEP_BV_02_C	INC
-TC_CONN_DCEP_BV_01_C	INC
-TC_CONN_DCEP_BV_02_C	INC
+TC_CONN_ACEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_ACEP_BV_02_C	(#)	Privacy feature - not implemented
+TC_CONN_GCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_GCEP_BV_02_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_GCEP_BV_03_C	(#)	Privacy feature - not implemented
+TC_CONN_GCEP_BV_04_C	(#)	Privacy feature - not implemented
+TC_CONN_SCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_SCEP_BV_02_C	(#)	Privacy feature - not implemented
+TC_CONN_DCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_DCEP_BV_02_C	(#)	Privacy feature - not implemented
 TC_CONN_DCEP_BV_03_C	PASS
-TC_CONN_DCEP_BV_04_C	INC
+TC_CONN_DCEP_BV_04_C	(#)	Privacy feature - not implemented
 TC_CONN_CPUP_BV_01_C	N/A
 TC_CONN_CPUP_BV_02_C	N/A
 TC_CONN_CPUP_BV_03_C	N/A
 TC_CONN_CPUP_BV_04_C	PASS
 TC_CONN_CPUP_BV_05_C	PASS
-TC_CONN_CPUP_BV_06_C	INC
+TC_CONN_CPUP_BV_06_C	INC	PTS issue - to be verified
 TC_CONN_TERM_BV_01_C	PASS
 TC_CONN_PRDA_BV_01_C	N/A
-TC_CONN_PRDA_BV_02_C	INC
+TC_CONN_PRDA_BV_02_C	(#)	Privacy feature - not implemented
 TC_BOND_NBON_BV_01_C	PASS
-TC_BOND_NBON_BV_02_C	INC
+TC_BOND_NBON_BV_02_C	PASS	haltest: gattc_register_client
+				gattc connect <client_id> <address>
+				bluetooth create_bond <address>
+				bluetooth remove_bond <address>
 TC_BOND_NBON_BV_03_C	N/A
 TC_BOND_BON_BV_01_C	N/A
-TC_BOND_BON_BV_02_C	INC
+TC_BOND_BON_BV_02_C	PASS
 TC_BOND_BON_BV_03_C	N/A
-TC_BOND_BON_BV_04_C	INC
+TC_BOND_BON_BV_04_C	PASS	haltest: gattc_register_client
+				gattc connect <client_id> <address>
+				bluetooth remove_bond <address>
+				gattc connect <client_id> <address>
 TC_SEC_AUT_BV_11_C	N/A
 TC_SEC_AUT_BV_12_C	INC
 TC_SEC_AUT_BV_13_C	INC
 TC_SEC_AUT_BV_14_C	N/A
 TC_SEC_AUT_BV_15_C	N/A
-TC_SEC_AUT_BV_16_C	INC
-TC_SEC_AUT_BV_17_C	INC
+TC_SEC_AUT_BV_16_C	(#)
+TC_SEC_AUT_BV_17_C	PASS
 TC_SEC_AUT_BV_18_C	N/A
-TC_SEC_AUT_BV_19_C	INC
+TC_SEC_AUT_BV_19_C	PASS
 TC_SEC_AUT_BV_20_C	N/A
-TC_SEC_AUT_BV_21_C	INC
+TC_SEC_AUT_BV_21_C	(#)
 TC_SEC_AUT_BV_22_C	N/A
 TC_SEC_AUT_BV_23_C	N/A
-TC_SEC_AUT_BV_24_C	INC
-TC_SEC_CSIGN_BV_01_C	INC
-TC_SEC_CSIGN_BV_02_C	INC
-TC_SEC_CSIGN_BI_01_C	INC
-TC_SEC_CSIGN_BI_02_C	INC
-TC_SEC_CSIGN_BI_03_C	INC
-TC_SEC_CSIGN_BI_04_C	INC
-TC_PRIV_CONN_BV_01_C	INC
-TC_PRIV_CONN_BV_02_C	INC
-TC_PRIV_CONN_BV_03_C	INC
-TC_PRIV_CONN_BV_04_C	INC
+TC_SEC_AUT_BV_24_C	(#)
+TC_SEC_CSIGN_BV_01_C	(#)	Not yet implemented - signed write
+TC_SEC_CSIGN_BV_02_C	(#)
+TC_SEC_CSIGN_BI_01_C	(#)
+TC_SEC_CSIGN_BI_02_C	(#)
+TC_SEC_CSIGN_BI_03_C	(#)
+TC_SEC_CSIGN_BI_04_C	(#)
+TC_PRIV_CONN_BV_01_C	(#)	Privacy feature - not implemented
+TC_PRIV_CONN_BV_02_C	(#)	Privacy feature - not implemented
+TC_PRIV_CONN_BV_03_C	(#)	Privacy feature - not implemented
+TC_PRIV_CONN_BV_04_C	(#)	Privacy feature - not implemented
 TC_PRIV_CONN_BV_05_C	N/A
 TC_PRIV_CONN_BV_06_C	N/A
 TC_PRIV_CONN_BV_07_C	N/A
 TC_PRIV_CONN_BV_08_C	N/A
 TC_PRIV_CONN_BV_09_C	N/A
 TC_PRIV_CONN_BV_10_C	N/A
-TC_PRIV_CONN_BV_11_C	INC
+TC_PRIV_CONN_BV_11_C	(#)	Privacy feature - not implemented
 TC_ADV_BV_01_C		N/A
 TC_ADV_BV_02_C		N/A
 TC_ADV_BV_03_C		N/A
@@ -149,7 +159,9 @@ TC_ADV_BV_13_C		N/A
 TC_ADV_BV_14_C		N/A
 TC_ADV_BV_15_C		N/A
 TC_ADV_BV_16_C		N/A
-TC_GAT_BV_01_C		INC
+TC_GAT_BV_01_C		INC	IUT does not have GAP primary service in the
+				database
+				JIRA BlueZ: BZ-13
 TC_GAT_BV_02_C		N/A
 TC_GAT_BV_03_C		N/A
 TC_GAT_BV_04_C		N/A
@@ -160,9 +172,9 @@ TC_GAT_BV_08_C		N/A
 TC_DM_NCON_BV_01_C	N/A
 TC_DM_CON_BV_01_C	N/A
 TC_DM_NBON_BV_01_C	N/A
-TC_DM_BON_BV_01_C	INC
-TC_DM_GIN_BV_01_C	INC
-TC_DM_LIN_BV_01_C	INC
+TC_DM_BON_BV_01_C	FAIL	JIRA: BZ-14
+TC_DM_GIN_BV_01_C	PASS
+TC_DM_LIN_BV_01_C	PASS
 TC_DM_NAD_BV_01_C	PASS	Start discovery from IUT
 TC_DM_NAD_BV_02_C	PASS
 TC_DM_LEP_BV_01_C	N/A
-- 
1.8.5.3

