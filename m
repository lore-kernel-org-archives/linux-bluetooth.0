Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] android/ipc-tester: Add missing service opcode boundries test cases
Date: Thu,  9 Oct 2014 14:45:08 +0200
Message-Id: <1412858714-2845-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds tests sending out of range opcode for each service.
---
 android/ipc-tester.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index ea71c8d..161777d 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -919,9 +919,23 @@ int main(int argc, char *argv[])
 	test_opcode_valid("PAN", HAL_SERVICE_ID_PAN, 0x05, 0,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
 
+	test_opcode_valid("HANDSFREE", HAL_SERVICE_ID_HANDSFREE, 0x0f, 0,
+						HAL_SERVICE_ID_BLUETOOTH,
+						HAL_SERVICE_ID_HANDSFREE);
+
 	test_opcode_valid("A2DP", HAL_SERVICE_ID_A2DP, 0x03, 0,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_A2DP);
 
+	test_opcode_valid("HEALTH", HAL_SERVICE_ID_HEALTH, 0x06, 0,
+						HAL_SERVICE_ID_BLUETOOTH,
+						HAL_SERVICE_ID_HEALTH);
+
+	test_opcode_valid("AVRCP", HAL_SERVICE_ID_AVRCP, 0x0b, 0,
+				HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_AVRCP);
+
+	test_opcode_valid("GATT", HAL_SERVICE_ID_GATT, 0x24, 0,
+				HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_GATT);
+
 	test_opcode_valid("HF_CLIENT", HAL_SERVICE_ID_HANDSFREE_CLIENT, 0x10, 0,
 			HAL_SERVICE_ID_BLUETOOTH,
 			HAL_SERVICE_ID_HANDSFREE_CLIENT);
-- 
1.9.3

