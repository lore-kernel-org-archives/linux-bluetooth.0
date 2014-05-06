Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Re-run GAP test suit
Date: Tue,  6 May 2014 08:14:18 +0200
Message-Id: <1399356858-27431-1-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
References: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 8be9a5a..535f565 100644
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
@@ -74,15 +74,15 @@ TC_CONN_UCON_BV_02_C	N/A
 TC_CONN_UCON_BV_03_C	N/A
 TC_CONN_UCON_BV_04_C	N/A
 TC_CONN_UCON_BV_05_C	N/A
-TC_CONN_ACEP_BV_01_C	INC
+TC_CONN_ACEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_ACEP_BV_02_C	INC
-TC_CONN_GCEP_BV_01_C	INC
-TC_CONN_GCEP_BV_02_C	INC
+TC_CONN_GCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
+TC_CONN_GCEP_BV_02_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_GCEP_BV_03_C	INC
 TC_CONN_GCEP_BV_04_C	INC
-TC_CONN_SCEP_BV_01_C	INC
+TC_CONN_SCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_SCEP_BV_02_C	INC
-TC_CONN_DCEP_BV_01_C	INC
+TC_CONN_DCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_DCEP_BV_02_C	INC
 TC_CONN_DCEP_BV_03_C	PASS
 TC_CONN_DCEP_BV_04_C	INC
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
@@ -161,8 +163,8 @@ TC_DM_NCON_BV_01_C	N/A
 TC_DM_CON_BV_01_C	N/A
 TC_DM_NBON_BV_01_C	N/A
 TC_DM_BON_BV_01_C	INC
-TC_DM_GIN_BV_01_C	INC
-TC_DM_LIN_BV_01_C	INC
+TC_DM_GIN_BV_01_C	PASS
+TC_DM_LIN_BV_01_C	PASS
 TC_DM_NAD_BV_01_C	PASS	Start discovery from IUT
 TC_DM_NAD_BV_02_C	PASS
 TC_DM_LEP_BV_01_C	N/A
-- 
1.8.5.3

