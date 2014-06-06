Return-Path: <cyrus@holtmann.org>
From: Eva Kolanska <eva.kolanska@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eva Kolanska <eva.kolanska@tieto.com>
Subject: [PATCH] android/pts: Update GAP test results
Date: Fri,  6 Jun 2014 15:54:45 +0200
Message-Id: <1402062885-25627-1-git-send-email-eva.kolanska@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt |   75 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 20 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index a08e385..9323f3c 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -154,26 +154,52 @@ TC_BOND_BON_BV_04_C	PASS	haltest: gattc_register_client
 				gattc connect <client_id> <address>
 				bluetooth remove_bond <address>
 				gattc connect <client_id> <address>
-TC_SEC_AUT_BV_11_C	INC
-TC_SEC_AUT_BV_12_C	INC	JIRA: BZ-29
-TC_SEC_AUT_BV_13_C	INC	JIRA: BZ-30
-TC_SEC_AUT_BV_14_C	INC
+TC_SEC_AUT_BV_11_C	INC	Handling sec-lev level on-link - not implemented
+TC_SEC_AUT_BV_12_C	INC	Handling sec-lev level on-link - not implemented
+TC_SEC_AUT_BV_13_C	INC	Handling sec-lev level on-link - not implemented
+TC_SEC_AUT_BV_14_C	INC	Handling sec-lev level on-link - not implemented
 TC_SEC_AUT_BV_15_C	N/A
-TC_SEC_AUT_BV_16_C	INC	Not implemented
+TC_SEC_AUT_BV_16_C	INC	Handling sec-lev level on-link - not implemented
 TC_SEC_AUT_BV_17_C	PASS
-TC_SEC_AUT_BV_18_C	INC
+TC_SEC_AUT_BV_18_C	INC	Handling sec-lev level on-link - not implemented
 TC_SEC_AUT_BV_19_C	PASS
-TC_SEC_AUT_BV_20_C	INC
-TC_SEC_AUT_BV_21_C	INC	Not implemented
-TC_SEC_AUT_BV_22_C	INC
-TC_SEC_AUT_BV_23_C	INC
-TC_SEC_AUT_BV_24_C	INC	Not implemented
-TC_SEC_CSIGN_BV_01_C	INC	Not yet implemented - signed write
-TC_SEC_CSIGN_BV_02_C	INC	Not implemented
-TC_SEC_CSIGN_BI_01_C	INC	Not implemented
-TC_SEC_CSIGN_BI_02_C	INC	Not implemented
-TC_SEC_CSIGN_BI_03_C	INC	Not implemented
-TC_SEC_CSIGN_BI_04_C	INC	Not implemented
+TC_SEC_AUT_BV_20_C	INC	Handling sec-lev level on-link - not implemented
+TC_SEC_AUT_BV_21_C	INC	Handling sec-lev level on-link - not implemented
+TC_SEC_AUT_BV_22_C	INC	Handling sec-lev level on-link - not implemented
+TC_SEC_AUT_BV_23_C	INC	Handling sec-lev level on-link - not implemented
+TC_SEC_AUT_BV_24_C	INC	Handling sec-lev level on-link - not implemented
+TC_SEC_CSIGN_BV_01_C	PASS	haltest:
+				gattc connect
+				bluetooth create_bond
+				gattc connect
+				gattc write_characteristic: <write_type> 4
+				gattc disconnect
+TC_SEC_CSIGN_BV_02_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 66
+						<permissions> 129
+				gatts start_service
+				gatts disconnect
+				gattc disconnect
+TC_SEC_CSIGN_BI_01_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 66
+						<permissions> 129
+				gatts start_service
+				gatts disconnect
+				gattc disconnect
+TC_SEC_CSIGN_BI_02_C	PASS	haltest:
+				gatts add_service
+				gatts add_chaaracteristic:
+						<properties> 66
+						<permissions> 129
+				gatts start_service
+				gatts disconnect
+				gattc disconnect
+TC_SEC_CSIGN_BI_03_C	INC	Handling sec-lev level on-link - not implemented
+TC_SEC_CSIGN_BI_04_C	INC	Handling sec-lev level on-link - not implemented
 TC_PRIV_CONN_BV_01_C	INC	Privacy feature - not implemented
 TC_PRIV_CONN_BV_02_C	INC	Privacy feature - not implemented
 TC_PRIV_CONN_BV_03_C	INC	Privacy feature - not implemented
@@ -224,8 +250,10 @@ TC_DM_NAD_BV_01_C	PASS	Start discovery from IUT
 TC_DM_NAD_BV_02_C	PASS
 TC_DM_LEP_BV_01_C	PASS	gattc register_client
 				gattc listen 1 1
-TC_DM_LEP_BV_02_C	INC
-TC_DM_LEP_BV_03_C	INC
+TC_DM_LEP_BV_02_C	PASS	Use basic rate PTS dongle
+				haltest:
+				bluetooth set_adapter_property
+TC_DM_LEP_BV_03_C	N/A	correction of CR impl - removed 2013-10-22
 TC_DM_LEP_BV_04_C	PASS	l2test -n <PTS bdaddr>
 TC_DM_LEP_BV_05_C	PASS	btmgmt find -b
 				l2test -n 00:1B:DC:06:06:22
@@ -233,6 +261,13 @@ TC_DM_LEP_BV_06_C	PASS
 TC_DM_LEP_BV_07_C	PASS
 TC_DM_LEP_BV_08_C	PASS
 TC_DM_LEP_BV_09_C	PASS
-TC_DM_LEP_BV_10_C	INC
+TC_DM_LEP_BV_10_C	PASS	haltest:
+				gattc listen 1
+				gattc listen 1 0
+				bluetooth start_discovery
+				bluetooth cancel_discovery
+				gattc listen 1
+				gattc listen 1 0
+				bluetooth create_bond
 TC_DM_LEP_BV_11_C	PASS
 -------------------------------------------------------------------------------
-- 
1.7.9.5

