Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Re-run GAP test suit
Date: Tue,  6 May 2014 13:19:45 +0200
Message-Id: <1399375185-15559-1-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
References: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 78 +++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 8be9a5a..8b90cfc 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -1,7 +1,7 @@
 PTS test results for GAP
 
 PTS version: 5.1
-Tested: 11-April-2014
+Tested: 29-April-2014
 Android version: 4.4.2
 
 Results:
@@ -62,7 +62,7 @@ TC_DISC_GENP_BV_05_C	PASS	btmgmt find -l
 TC_IDLE_GIN_BV_01_C	PASS	Start discovery from IUT
 TC_IDLE_LIN_BV_01_C	PASS	hcitool scan --iac=liac
 TC_IDLE_NAMP_BV_01_C	PASS
-TC_IDLE_NAMP_BV_02_C	INC
+TC_IDLE_NAMP_BV_02_C	INC	JIRA BlueZ: BZ-11
 TC_CONN_NCON_BV_01_C	N/A
 TC_CONN_NCON_BV_02_C	N/A
 TC_CONN_NCON_BV_03_C	N/A
@@ -74,65 +74,65 @@ TC_CONN_UCON_BV_02_C	N/A
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
+TC_CONN_ACEP_BV_02_C	INC	not implemented yet (BZ-15)
+TC_CONN_GCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_GCEP_BV_02_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_GCEP_BV_03_C	INC	JIRA: BZ-14
+TC_CONN_GCEP_BV_04_C	INC	not implemented yet (BZ-15)
+TC_CONN_SCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_SCEP_BV_02_C	INC	not implemented yet (BZ-15)
+TC_CONN_DCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_DCEP_BV_02_C	INC	not implemented yet (BZ-15)
 TC_CONN_DCEP_BV_03_C	PASS
-TC_CONN_DCEP_BV_04_C	INC
+TC_CONN_DCEP_BV_04_C	INC	JIRA: BZ-14
 TC_CONN_CPUP_BV_01_C	N/A
 TC_CONN_CPUP_BV_02_C	N/A
 TC_CONN_CPUP_BV_03_C	N/A
 TC_CONN_CPUP_BV_04_C	PASS
 TC_CONN_CPUP_BV_05_C	PASS
-TC_CONN_CPUP_BV_06_C	INC
+TC_CONN_CPUP_BV_06_C	INC	dunno know!!!!!!!!!!!!!
 TC_CONN_TERM_BV_01_C	PASS
 TC_CONN_PRDA_BV_01_C	N/A
-TC_CONN_PRDA_BV_02_C	INC
+TC_CONN_PRDA_BV_02_C	INC	JIRA: BZ-14
 TC_BOND_NBON_BV_01_C	PASS
-TC_BOND_NBON_BV_02_C	INC
+TC_BOND_NBON_BV_02_C	INC	JIRA: BZ-14
 TC_BOND_NBON_BV_03_C	N/A
 TC_BOND_BON_BV_01_C	N/A
-TC_BOND_BON_BV_02_C	INC
+TC_BOND_BON_BV_02_C	INC	JIRA: BZ-14
 TC_BOND_BON_BV_03_C	N/A
-TC_BOND_BON_BV_04_C	INC
+TC_BOND_BON_BV_04_C	INC	JIRA: BZ-14
 TC_SEC_AUT_BV_11_C	N/A
 TC_SEC_AUT_BV_12_C	INC
 TC_SEC_AUT_BV_13_C	INC
 TC_SEC_AUT_BV_14_C	N/A
 TC_SEC_AUT_BV_15_C	N/A
-TC_SEC_AUT_BV_16_C	INC
-TC_SEC_AUT_BV_17_C	INC
+TC_SEC_AUT_BV_16_C	INC	not yet implemented
+TC_SEC_AUT_BV_17_C	INC	JIRA: BZ-14
 TC_SEC_AUT_BV_18_C	N/A
-TC_SEC_AUT_BV_19_C	INC
+TC_SEC_AUT_BV_19_C	INC	JIRA: BZ-14
 TC_SEC_AUT_BV_20_C	N/A
-TC_SEC_AUT_BV_21_C	INC
+TC_SEC_AUT_BV_21_C	INC	JIRA: BZ-14
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
+TC_SEC_AUT_BV_24_C	FAIL	JIRA: BZ-16
+TC_SEC_CSIGN_BV_01_C	INC	JIRA: BZ-14
+TC_SEC_CSIGN_BV_02_C	INC	JIRA: BZ-14
+TC_SEC_CSIGN_BI_01_C	INC	JIRA: BZ-14
+TC_SEC_CSIGN_BI_02_C	INC	JIRA: BZ-14
+TC_SEC_CSIGN_BI_03_C	INC	JIRA: BZ-14
+TC_SEC_CSIGN_BI_04_C	INC	JIRA: BZ-14
+TC_PRIV_CONN_BV_01_C	INC	JIRA: BZ-14
+TC_PRIV_CONN_BV_02_C	INC	not implemented yet (BZ-15)
+TC_PRIV_CONN_BV_03_C	INC	JIRA: BZ-14
+TC_PRIV_CONN_BV_04_C	INC	not implemented yet (BZ-15)
 TC_PRIV_CONN_BV_05_C	N/A
 TC_PRIV_CONN_BV_06_C	N/A
 TC_PRIV_CONN_BV_07_C	N/A
 TC_PRIV_CONN_BV_08_C	N/A
 TC_PRIV_CONN_BV_09_C	N/A
 TC_PRIV_CONN_BV_10_C	N/A
-TC_PRIV_CONN_BV_11_C	INC
+TC_PRIV_CONN_BV_11_C	INC	JIRA: BZ-14
 TC_ADV_BV_01_C		N/A
 TC_ADV_BV_02_C		N/A
 TC_ADV_BV_03_C		N/A
@@ -149,7 +149,9 @@ TC_ADV_BV_13_C		N/A
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
@@ -160,9 +162,9 @@ TC_GAT_BV_08_C		N/A
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

