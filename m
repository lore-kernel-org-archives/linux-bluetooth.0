Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/pts: Update GAP pts test results
Date: Thu, 12 Jun 2014 11:08:26 +0200
Message-Id: <1402564106-27044-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1402564106-27044-1-git-send-email-marcin.kraglak@tieto.com>
References: <1402564106-27044-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For these tests kernel version is defined as 3.17.
---
 android/pts-gap.txt | 83 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 8 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 2b335a1..cd70326 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -3,6 +3,7 @@ PTS test results for GAP
 PTS version: 5.1
 Tested: 28-May-2014
 Android version: 4.4.2
+Kernel version: 3.17
 
 Results:
 PASS	test passed
@@ -159,20 +160,86 @@ TC_BOND_BON_BV_04_C	PASS	haltest: gattc_register_client
 				gattc connect <client_id> <address>
 				bluetooth remove_bond <address>
 				gattc connect <client_id> <address>
-TC_SEC_AUT_BV_11_C	INC	Link security level elevation - not implemented
-TC_SEC_AUT_BV_12_C	INC	Link security level elevation - not implemented
-TC_SEC_AUT_BV_13_C	INC	Link security level elevation - not implemented
-TC_SEC_AUT_BV_14_C	INC	Link security level elevation - not implemented
+TC_SEC_AUT_BV_11_C	PASS	haltest:gattc register_client
+				gatts register_server
+				gatts add_service 2 <uuid> 3
+				gatts add_characteristic 2 1b <uuid> 10 68
+				gatts start_service 2 1b 1
+				gattc listen
+				PTS asks for handle with Insufficient auth
+				bluetooth ssp_reply <addr> <passkey>
+				gatts send_response
+TC_SEC_AUT_BV_12_C	PASS	haltest: gatts register_server
+				gatts add_service 2 <uuid> 3
+				gatts add_characteristic 2 <service_handle>
+								<uuid> 10 68
+				gatts start_service 2 <service_handle> 1
+				gatts connect <server_if> <addr>
+				PTS asks for handle with Insufficient auth
+				bluetooth ssp_reply <addr> <passkey>
+				gatts send_response
+TC_SEC_AUT_BV_13_C	PASS	haltest: gatts register_server
+				gatts add_service 2 <uuid> 3
+				gatts add_characteristic 2 <service_handle>
+								<uuid> 10 68
+				gatts start_service 2 <service_handle> 1
+				gatts connect <server_if> <addr>
+				PTS asks for handle with Insufficient auth
+				bluetooth ssp_reply <addr> <passkey>
+				gatts send_response
+TC_SEC_AUT_BV_14_C	PASS	haltest:gattc register_client
+				gatts register_server
+				gatts add_service 2 <uuid> 3
+				gatts add_characteristic 2 1b <uuid> 10 68
+				gatts start_service 2 1b 1
+				gattc listen
+				PTS asks for handle with Insufficient auth
+				bluetooth ssp_reply <addr> <passkey>
+				gatts send_response
 TC_SEC_AUT_BV_15_C	N/A
-TC_SEC_AUT_BV_16_C	INC	Link security level elevation - not implemented
+TC_SEC_AUT_BV_16_C	PASS	haltest: gatts register_server
+				gatts add_service 2 <uuid> 3
+				gatts add_characteristic 2 <service_handle>
+								<uuid> 10 34
+				gatts start_service 2 <service_handle> 1
+				gatts connect <server_if> <addr>
+				gatts disconnect <server_if> <addr>
+				gatts connect <server_if> <addr>
+				PTS asks for handle with Insufficient encrypt
+				bluetooth ssp_reply <addr> <passkey>
+				gatts send_response
 TC_SEC_AUT_BV_17_C	PASS
-TC_SEC_AUT_BV_18_C	INC	Link security level elevation - not implemented
+TC_SEC_AUT_BV_18_C	PASS	haltest: gattc register_client
+				gattc listen
+				gattc search_service
+				gattc get_characteristic
+				gattc read_characteristic
+				bluetooth create_bond
+				gattc read_characteristic
 TC_SEC_AUT_BV_19_C	PASS
 TC_SEC_AUT_BV_20_C	INC	Link security level elevation - not implemented
 TC_SEC_AUT_BV_21_C	INC	Link security level elevation - not implemented
 TC_SEC_AUT_BV_22_C	INC	Link security level elevation - not implemented
-TC_SEC_AUT_BV_23_C	INC	Link security level elevation - not implemented
-TC_SEC_AUT_BV_24_C	INC	Link security level elevation - not implemented
+TC_SEC_AUT_BV_23_C	PASS	haltest: gatts register_server
+				gatts add_service 2 <uuid> 3
+				gatts add_characteristic 2 <service_handle>
+								<uuid> 10 34
+				gatts start_service 2 <service_handle> 1
+				gattc register_client
+				gattc listen
+				bluetooth ssp_reply
+				gatts send_response
+TC_SEC_AUT_BV_24_C	PASS	haltest: gatts register_server
+				gatts add_service 2 <uuid> 3
+				gatts add_characteristic 2 <service_handle>
+								<uuid> 10 34
+				gatts start_service 2 <service_handle> 1
+				gatts connect <PTS addr>
+				bluetooth ssp_reply
+				gatts disconnect
+				gatts connect
+				PTS asks for handle with insufficient encryption
+				gatts send_response
 TC_SEC_CSIGN_BV_01_C	PASS	haltest:
 				gattc connect
 				bluetooth create_bond
-- 
1.9.3

