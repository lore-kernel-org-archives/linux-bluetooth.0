Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/5] android/ipc-tester: Add case for MAP client service opcode boundries
Date: Wed, 15 Oct 2014 16:28:00 +0200
Message-Id: <1413383281-17292-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413383281-17292-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413383281-17292-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test sending out of range opcode for service.
---
 android/ipc-tester.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 161777d..7dd25e8 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -940,6 +940,10 @@ int main(int argc, char *argv[])
 			HAL_SERVICE_ID_BLUETOOTH,
 			HAL_SERVICE_ID_HANDSFREE_CLIENT);
 
+	test_opcode_valid("MAP_CLIENT", HAL_SERVICE_ID_MAP_CLIENT, 0x01, 0,
+						HAL_SERVICE_ID_BLUETOOTH,
+						HAL_SERVICE_ID_MAP_CLIENT);
+
 	/* check for valid data size */
 	test_datasize_valid("CORE Register+", HAL_SERVICE_ID_CORE,
 			HAL_OP_REGISTER_MODULE,
-- 
1.9.3

