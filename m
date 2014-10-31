Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Add JIRA issue number to TC_GAD_CL_BV_03_C
Date: Fri, 31 Oct 2014 10:05:58 +0100
Message-Id: <1414746358-4266-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 22e3bdb..9e85bcb 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -48,7 +48,7 @@ TC_GAD_CL_BV_02_C	PASS	haltest:
 				gattc disconnect
 				gattc connect
 				gattc refresh
-TC_GAD_CL_BV_03_C	FAIL
+TC_GAD_CL_BV_03_C	FAIL	JIRA #BA-188
 TC_GAD_CL_BV_04_C	PASS	haltest:
 				when requested: gattc get_characteristic
 TC_GAD_CL_BV_05_C	PASS	haltest:
-- 
1.9.3

