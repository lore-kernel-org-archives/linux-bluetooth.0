Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2] android/pts: Update GAP results
Date: Wed, 18 Jun 2014 15:55:00 +0200
Message-Id: <1403099700-27378-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 62 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index bb943af..7081bd4 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -112,19 +112,35 @@ TC_CONN_UCON_BV_03_C	PASS	btmgmt connectable on
 				btmgmt discov limited 30
 TC_CONN_UCON_BV_04_C	N/A
 TC_CONN_UCON_BV_05_C	N/A
-TC_CONN_ACEP_BV_01_C	INC	No white list support
-				Note: pass on some chips with 'gattc connect'
-TC_CONN_ACEP_BV_02_C	INC	Privacy feature - not implemented
+TC_CONN_ACEP_BV_01_C	PASS	debugfs:
+					echo "module bluetooth +pmft" >
+					/sys/kernel/debug/dynamic_debug/control
+					echo -n "add <PTS addr> 0 1" >
+					/sys/kernel/debug/bluetooth/hciX/
+								le_auto_conn
+				btmgmt connectable on
+				btmgmt power on
+				btmgmt disconnect -t 1 <PTS addr>
+				debugfs:
+					echo -n "clr" > /sys/kernel/debug/
+						bluetooth/hciX/le_auto_conn
+TC_CONN_ACEP_BV_02_C	INC	Privacy feature - PTS issue #12308
 TC_CONN_GCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_GCEP_BV_02_C	PASS	'gattc connect' prior to pressing OK on PTS
-TC_CONN_GCEP_BV_03_C	INC	Privacy feature - not implemented
-TC_CONN_GCEP_BV_04_C	INC	Privacy feature - not implemented
+TC_CONN_GCEP_BV_03_C	PASS	gattc connect
+				bluetooth create_bond
+				gattc connect
+				gattc disconnect
+TC_CONN_GCEP_BV_04_C	INC	Privacy feature - PTS issue #12308
 TC_CONN_SCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
-TC_CONN_SCEP_BV_02_C	INC	Privacy feature - not implemented
+TC_CONN_SCEP_BV_02_C	INC	Privacy feature - PTS issue #12308
 TC_CONN_DCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
-TC_CONN_DCEP_BV_02_C	INC	Privacy feature - not implemented
+TC_CONN_DCEP_BV_02_C	INC	Privacy feature - PTS issue #12308
 TC_CONN_DCEP_BV_03_C	PASS
-TC_CONN_DCEP_BV_04_C	INC	Privacy feature - not implemented
+TC_CONN_DCEP_BV_04_C	PASS	gattc connect
+				gattc create_bond
+				gattc connect
+				gattc disconnect
 TC_CONN_CPUP_BV_01_C	N/A
 TC_CONN_CPUP_BV_02_C	N/A
 TC_CONN_CPUP_BV_03_C	N/A
@@ -141,8 +157,8 @@ TC_CONN_CPUP_BV_06_C	PASS	gattc register_client
 				gattc disconnect <client_if> <pts_bdaddr>
 					<conn_id>
 TC_CONN_TERM_BV_01_C	PASS
-TC_CONN_PRDA_BV_01_C	INC	Privacy feature - not implemented
-TC_CONN_PRDA_BV_02_C	INC	Privacy feature - not implemented
+TC_CONN_PRDA_BV_01_C	INC	PTS issue #12207
+TC_CONN_PRDA_BV_02_C	INC	PTS issue #12310
 TC_BOND_NBON_BV_01_C	PASS
 TC_BOND_NBON_BV_02_C	PASS	haltest: gattc_register_client
 				gattc connect <client_id> <address>
@@ -275,10 +291,28 @@ TC_SEC_CSIGN_BI_02_C	PASS	haltest:
 				gattc disconnect
 TC_SEC_CSIGN_BI_03_C	INC	Link security level elevation - not implemented
 TC_SEC_CSIGN_BI_04_C	INC	Link security level elevation - not implemented
-TC_PRIV_CONN_BV_01_C	INC	Privacy feature - not implemented
-TC_PRIV_CONN_BV_02_C	INC	Privacy feature - not implemented
-TC_PRIV_CONN_BV_03_C	INC	Privacy feature - not implemented
-TC_PRIV_CONN_BV_04_C	INC	Privacy feature - not implemented
+TC_PRIV_CONN_BV_01_C	PASS	gattc connect
+				gattc create_bond
+				gattc search service
+				gattc get_characteristic
+				gattc write_characteristic (privacy flag)
+				gattc write_characteristic (reconnection addr.)
+				gattc disconnect
+TC_PRIV_CONN_BV_02_C	PASS	gattc connect
+				gattc search service
+				gattc get_characteristic
+				gattc write_characteristic (reconnection addr.)
+				gattc disconnect
+TC_PRIV_CONN_BV_03_C	INC	Privacy feature - PTS issue #12308
+TC_PRIV_CONN_BV_04_C	PASS	gattc connect
+				gattc create_bond
+				gattc search service
+				gattc get_characteristic
+				gattc write_characteristic (privacy flag)
+				gattc write_characteristic (reconnection addr.)
+				gattc disconnect
+				gattc connect
+				gattc disconnect
 TC_PRIV_CONN_BV_05_C	N/A
 TC_PRIV_CONN_BV_06_C	N/A
 TC_PRIV_CONN_BV_07_C	N/A
-- 
2.0.0

