Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update PTS GAP test results
Date: Tue, 17 Jun 2014 15:14:37 +0200
Message-Id: <1403010877-2391-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index cd70326..bb7f172 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -217,8 +217,11 @@ TC_SEC_AUT_BV_18_C	PASS	haltest: gattc register_client
 				bluetooth create_bond
 				gattc read_characteristic
 TC_SEC_AUT_BV_19_C	PASS
-TC_SEC_AUT_BV_20_C	INC	Link security level elevation - not implemented
-TC_SEC_AUT_BV_21_C	INC	Link security level elevation - not implemented
+TC_SEC_AUT_BV_20_C	INC	PTS issue [ID:12284]
+TC_SEC_AUT_BV_21_C	PASS	haltest: gattc register_client
+				gattc connect
+				bluetooth create_bond
+				gattc connect
 TC_SEC_AUT_BV_22_C	INC	Link security level elevation - not implemented
 TC_SEC_AUT_BV_23_C	PASS	haltest: gatts register_server
 				gatts add_service 2 <uuid> 3
-- 
1.9.3

