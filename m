Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/pts: Update GAP results
Date: Wed, 18 Jun 2014 09:38:16 +0200
Message-Id: <1403077096-4020-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index cd70326..c8d4a73 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -114,17 +114,23 @@ TC_CONN_UCON_BV_04_C	N/A
 TC_CONN_UCON_BV_05_C	N/A
 TC_CONN_ACEP_BV_01_C	INC	No white list support
 				Note: pass on some chips with 'gattc connect'
-TC_CONN_ACEP_BV_02_C	INC	Privacy feature - not implemented
+TC_CONN_ACEP_BV_02_C	INC	No white list support
 TC_CONN_GCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_GCEP_BV_02_C	PASS	'gattc connect' prior to pressing OK on PTS
-TC_CONN_GCEP_BV_03_C	INC	Privacy feature - not implemented
+TC_CONN_GCEP_BV_03_C	PASS	gattc connect
+				bluetooth create_bond
+				gattc connect
+				gattc disconnect
 TC_CONN_GCEP_BV_04_C	INC	Privacy feature - not implemented
 TC_CONN_SCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_SCEP_BV_02_C	INC	Privacy feature - not implemented
 TC_CONN_DCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_DCEP_BV_02_C	INC	Privacy feature - not implemented
 TC_CONN_DCEP_BV_03_C	PASS
-TC_CONN_DCEP_BV_04_C	INC	Privacy feature - not implemented
+TC_CONN_DCEP_BV_04_C	PASS	gattc connect
+				gattc create_bond
+				gattc connect
+				gattc disconnect
 TC_CONN_CPUP_BV_01_C	N/A
 TC_CONN_CPUP_BV_02_C	N/A
 TC_CONN_CPUP_BV_03_C	N/A
@@ -272,10 +278,28 @@ TC_SEC_CSIGN_BI_02_C	PASS	haltest:
 				gattc disconnect
 TC_SEC_CSIGN_BI_03_C	INC	Link security level elevation - not implemented
 TC_SEC_CSIGN_BI_04_C	INC	Link security level elevation - not implemented
-TC_PRIV_CONN_BV_01_C	INC	Privacy feature - not implemented
-TC_PRIV_CONN_BV_02_C	INC	Privacy feature - not implemented
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
 TC_PRIV_CONN_BV_03_C	INC	Privacy feature - not implemented
-TC_PRIV_CONN_BV_04_C	INC	Privacy feature - not implemented
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

