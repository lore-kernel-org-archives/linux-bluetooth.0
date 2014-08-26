Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/2] android/pts: Update PTS GATT test results.
Date: Tue, 26 Aug 2014 12:20:54 +0200
Message-Id: <1409048454-16116-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1409048454-16116-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409048454-16116-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 0220009..9d57007 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -468,8 +468,8 @@ TC_GAW_CL_BV_01_C	PASS	haltest:
 								handle from logs
 				gattc write_characteristic
 				gattc disconnect
-TC_GAW_CL_BV_02_C	INC	PTS issue #12446
-				haltest:
+TC_GAW_CL_BV_02_C	PASS	haltest:
+				gattc connect
 				bluetooth create_bond
 				gattc disconnect
 				gattc connect
-- 
1.9.3

