Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/6] android/pts: Update GATT PTS status
Date: Thu, 29 May 2014 12:34:08 +0200
Message-Id: <1401359648-576-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401359648-576-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401359648-576-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index a15c1d2..dde7267 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -78,12 +78,27 @@ TC_GAR_CL_BI_03_C	PASS	haltest:
 TC_GAR_CL_BI_04_C	PASS	haltest:
 				gattc read_characteristic
 TC_GAR_CL_BI_05_C	INC	not implemented (encryption)
-TC_GAR_CL_BV_03_C	INC	JIRA: BZ-31
-TC_GAR_CL_BI_06_C	INC	JIRA: BZ-31
-TC_GAR_CL_BI_07_C	INC	JIRA: BZ-31
-TC_GAR_CL_BI_09_C	INC	JIRA: BZ-31
-TC_GAR_CL_BI_10_C	INC	JIRA: BZ-31
-TC_GAR_CL_BI_11_C	INC	not implemented (encryption)
+TC_GAR_CL_BV_03_C	INC	JIRA: BZ-31, Possible PTS issue #12227
+TC_GAR_CL_BI_06_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GAR_CL_BI_07_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GAR_CL_BI_09_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GAR_CL_BI_10_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
+TC_GAR_CL_BI_11_C	PASS	haltest:
+				gattc connect
+				test_command: <cmd> 224 [u1] 8
+				gattc disconnect
 TC_GAR_CL_BV_04_C	PASS	haltest:
 				gattc read_characteristic
 TC_GAR_CL_BI_12_C	PASS	haltest:
-- 
1.9.3

