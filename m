Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 4/4] android/pts: Update PTS GAP results
Date: Wed, 18 Jun 2014 11:08:19 +0200
Message-Id: <1403082499-2349-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1403082499-2349-1-git-send-email-marcin.kraglak@tieto.com>
References: <1403082499-2349-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index bb943af..e09f73d 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -222,7 +222,10 @@ TC_SEC_AUT_BV_21_C	PASS	haltest: gattc register_client
 				gattc connect
 				bluetooth create_bond
 				gattc connect
-TC_SEC_AUT_BV_22_C	INC	Link security level elevation - not implemented
+TC_SEC_AUT_BV_22_C	PASS	btmgmt io-cap 3
+				haltest: gattc register_client
+				gattc listen
+				gattc test_command 226 <addr> <u1> 1
 TC_SEC_AUT_BV_23_C	PASS	haltest: gatts register_server
 				gatts add_service 2 <uuid> 3
 				gatts add_characteristic 2 <service_handle>
@@ -273,8 +276,25 @@ TC_SEC_CSIGN_BI_02_C	PASS	haltest:
 				gatts start_service
 				gatts disconnect
 				gattc disconnect
-TC_SEC_CSIGN_BI_03_C	INC	Link security level elevation - not implemented
-TC_SEC_CSIGN_BI_04_C	INC	Link security level elevation - not implemented
+TC_SEC_CSIGN_BI_03_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 64
+						<permissions> 128
+				gatts start_service
+				gattc listen
+				bluetooth ssp_reply
+				gatts disconnect
+				bluetooth remove_bond
+TC_SEC_CSIGN_BI_04_C	PASS	haltest:
+				gatts add_service
+				gatts add_characteristic:
+						<properties> 64
+						<permissions> 256
+				gatts start_service
+				gattc listen
+				bluetooth ssp_reply
+				gatts disconnect
 TC_PRIV_CONN_BV_01_C	INC	Privacy feature - not implemented
 TC_PRIV_CONN_BV_02_C	INC	Privacy feature - not implemented
 TC_PRIV_CONN_BV_03_C	INC	Privacy feature - not implemented
-- 
1.9.3

