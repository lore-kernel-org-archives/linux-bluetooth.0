Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/pts: Add PTS test results for GAP
Date: Thu, 12 Dec 2013 14:35:39 +0100
Message-Id: <1386855340-22911-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow for better tracking of current state of implementation.
---
 android/Makefile.am |   2 +-
 android/pts-gap.txt | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-gap.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 0bcab2f..7db0616 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -110,4 +110,4 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pixit-did.txt android/pts-did.txt \
 		android/pixit-gap.txt android/pixit-hid.txt \
 		android/pixit-opp.txt android/pixit-pan.txt \
-		android/pixit-pbap.txt
+		android/pixit-pbap.txt android/pts-gap.txt
diff --git a/android/pts-gap.txt b/android/pts-gap.txt
new file mode 100644
index 0000000..0ea5539
--- /dev/null
+++ b/android/pts-gap.txt
@@ -0,0 +1,155 @@
+PTS test results for GAP
+
+PTS version: 4.9
+Tested: 14.11.2013
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_MOD_NDIS_BV_01_C	PASS
+TC_MOD_LDIS_BV_01_C	N/A
+TC_MOD_LDIS_BV_02_C	N/A
+TC_MOD_LDIS_BV_03_C	N/A
+TC_MOD_GDIS_BV_01_C	PASS
+TC_MOD_GDIS_BV_02_C	PASS
+TC_MOD_NCON_BV_01_C	PASS
+TC_MOD_CON_BV_01_C	PASS
+TC_BROB_BCST_BV_01_C	N/A
+TC_BROB_BCST_BV_02_C	N/A
+TC_BROB_BCST_BV_03_C	N/A
+TC_BROB_OBSV_BV_01_C	N/A
+TC_BROB_OBSV_BV_02_C	N/A
+TC_BROB_OBSV_BV_03_C	N/A
+TC_BROB_OBSV_BV_04_C	N/A
+TC_BROB_OBSV_BV_05_C	N/A
+TC_DISC_NONM_BV_01_C	N/A
+TC_DISC_NONM_BV_02_C	N/A
+TC_DISC_LIMM_BV_01_C	N/A
+TC_DISC_LIMM_BV_02_C	N/A
+TC_DISC_LIMM_BV_03_C	N/A
+TC_DISC_LIMM_BV_04_C	N/A
+TC_DISC_GENM_BV_01_C	N/A
+TC_DISC_GENM_BV_02_C	N/A
+TC_DISC_GENM_BV_03_C	N/A
+TC_DISC_GENM_BV_04_C	N/A
+TC_DISC_LIMP_BV_01_C	N/A
+TC_DISC_LIMP_BV_02_C	N/A
+TC_DISC_LIMP_BV_03_C	N/A
+TC_DISC_LIMP_BV_04_C	N/A
+TC_DISC_LIMP_BV_05_C	N/A
+TC_DISC_GENP_BV_01_C	INC	LE not supported yet
+TC_DISC_GENP_BV_02_C	INC	LE not supported yet
+TC_DISC_GENP_BV_03_C	INC	LE not supported yet
+TC_DISC_GENP_BV_04_C	INC	LE not supported yet
+TC_DISC_GENP_BV_05_C	INC	LE not supported yet
+TC_IDLE_GIN_BV_01_C	PASS
+TC_IDLE_LIN_BV_01_C	N/A
+TC_IDLE_NAMP_BV_01_C	INC	LE not supported yet
+TC_IDLE_NAMP_BV_02_C	INC	LE not supported yet
+TC_CONN_NCON_BV_01_C	N/A
+TC_CONN_NCON_BV_02_C	N/A
+TC_CONN_NCON_BV_03_C	N/A
+TC_CONN_DCON_BV_01_C	N/A
+TC_CONN_DCON_BV_02_C	N/A
+TC_CONN_DCON_BV_03_C	N/A
+TC_CONN_UCON_BV_01_C	N/A
+TC_CONN_UCON_BV_02_C	N/A
+TC_CONN_UCON_BV_03_C	N/A
+TC_CONN_UCON_BV_04_C	N/A
+TC_CONN_UCON_BV_05_C	N/A
+TC_CONN_ACEP_BV_01_C	INC	LE not supported yet
+TC_CONN_ACEP_BV_02_C	N/A
+TC_CONN_GCEP_BV_01_C	INC	LE not supported yet
+TC_CONN_GCEP_BV_02_C	INC	LE not supported yet
+TC_CONN_GCEP_BV_03_C	N/A
+TC_CONN_GCEP_BV_04_C	N/A
+TC_CONN_SCEP_BV_01_C	INC	LE not supported yet
+TC_CONN_SCEP_BV_02_C	N/A
+TC_CONN_DCEP_BV_01_C	INC	LE not supported yet
+TC_CONN_DCEP_BV_02_C	N/A
+TC_CONN_DCEP_BV_03_C	INC	LE not supported yet
+TC_CONN_DCEP_BV_04_C	N/A
+TC_CONN_CPUP_BV_01_C	N/A
+TC_CONN_CPUP_BV_02_C	N/A
+TC_CONN_CPUP_BV_03_C	N/A
+TC_CONN_CPUP_BV_04_C	INC	LE not supported yet
+TC_CONN_CPUP_BV_05_C	INC	LE not supported yet
+TC_CONN_CPUP_BV_06_C	INC	LE not supported yet
+TC_CONN_TERM_BV_01_C	INC	LE not supported yet
+TC_CONN_PRDA_BV_01_C	N/A
+TC_CONN_PRDA_BV_02_C	INC	LE not supported yet
+TC_BOND_NBON_BV_01_C	N/A
+TC_BOND_NBON_BV_02_C	N/A
+TC_BOND_NBON_BV_03_C	N/A
+TC_BOND_BON_BV_01_C	N/A
+TC_BOND_BON_BV_02_C	INC	LE not supported yet
+TC_BOND_BON_BV_03_C	N/A
+TC_BOND_BON_BV_04_C	INC	LE not supported yet
+TC_SEC_AUT_BV_11_C	N/A
+TC_SEC_AUT_BV_12_C	INC	LE not supported yet
+TC_SEC_AUT_BV_13_C	N/A
+TC_SEC_AUT_BV_14_C	N/A
+TC_SEC_AUT_BV_15_C	N/A
+TC_SEC_AUT_BV_16_C	INC	LE not supported yet
+TC_SEC_AUT_BV_17_C	N/A
+TC_SEC_AUT_BV_18_C	N/A
+TC_SEC_AUT_BV_19_C	N/A
+TC_SEC_AUT_BV_20_C	N/A
+TC_SEC_AUT_BV_21_C	N/A
+TC_SEC_AUT_BV_22_C	N/A
+TC_SEC_AUT_BV_23_C	N/A
+TC_SEC_AUT_BV_24_C	N/A
+TC_SEC_CSIGN_BV_01_C	INC	LE not supported yet
+TC_SEC_CSIGN_BV_02_C	INC	LE not supported yet
+TC_SEC_CSIGN_BI_01_C	INC	LE not supported yet
+TC_SEC_CSIGN_BI_02_C	INC	LE not supported yet
+TC_SEC_CSIGN_BI_03_C	INC	LE not supported yet
+TC_SEC_CSIGN_BI_04_C	INC	LE not supported yet
+TC_PRIV_CONN_BV_01_C	N/A
+TC_PRIV_CONN_BV_02_C	N/A
+TC_PRIV_CONN_BV_03_C	N/A
+TC_PRIV_CONN_BV_04_C	N/A
+TC_PRIV_CONN_BV_05_C	N/A
+TC_PRIV_CONN_BV_06_C	N/A
+TC_PRIV_CONN_BV_07_C	N/A
+TC_PRIV_CONN_BV_08_C	N/A
+TC_PRIV_CONN_BV_09_C	N/A
+TC_ADV_BV_01_C		N/A
+TC_ADV_BV_02_C		N/A
+TC_ADV_BV_03_C		N/A
+TC_ADV_BV_04_C		N/A
+TC_ADV_BV_05_C		N/A
+TC_ADV_BV_06_C		N/A
+TC_ADV_BV_07_C		N/A
+TC_ADV_BV_08_C		N/A
+TC_ADV_BV_09_C		N/A
+TC_ADV_BV_10_C		N/A
+TC_GAT_BV_01_C		INC	LE not supported yet
+TC_GAT_BV_02_C		N/A
+TC_GAT_BV_03_C		N/A
+TC_GAT_BV_04_C		N/A
+TC_GAT_BV_05_C		N/A
+TC_GAT_BV_06_C		N/A
+TC_GAT_BV_07_C		N/A
+TC_GAT_BV_08_C		N/A
+TC_DM_NCON_BV_01_C	N/A
+TC_DM_CON_BV_01_C	N/A
+TC_DM_NBON_BV_01_C	N/A
+TC_DM_BON_BV_01_C	INC	LE not supported yet
+TC_DM_GIN_BV_01_C	INC	LE not supported yet
+TC_DM_LIN_BV_01_C	N/A
+TC_DM_NAD_BV_01_C	PASS
+TC_DM_NAD_BV_02_C	INC	LE not supported yet
+TC_DM_LEP_BV_01_C	N/A
+TC_DM_LEP_BV_02_C	N/A
+TC_DM_LEP_BV_03_C	N/A
+TC_DM_LEP_BV_04_C	N/A
+TC_DM_LEP_BV_05_C	N/A
+TC_DM_LEP_BV_06_C	INC	LE not supported yet
+-------------------------------------------------------------------------------
-- 
1.8.3.2

