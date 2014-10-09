Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] android/ipc-tester: Add cases for MAP client msg size
Date: Thu,  9 Oct 2014 14:45:10 +0200
Message-Id: <1412858714-2845-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add cases testing message size verification for MAP client opcodes.
---
 android/ipc-tester.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 7dd25e8..357dda9 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -1486,5 +1486,19 @@ int main(int argc, char *argv[])
 			HAL_SERVICE_ID_BLUETOOTH,
 			HAL_SERVICE_ID_HANDSFREE_CLIENT);
 
+	/* check for valid data size for MAP CLIENT */
+	test_datasize_valid("MAP CLIENT Get instances+",
+				HAL_SERVICE_ID_MAP_CLIENT,
+				HAL_OP_MAP_CLIENT_GET_INSTANCES,
+				sizeof(struct hal_cmd_map_client_get_instances),
+				1, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_SERVICE_ID_MAP_CLIENT);
+	test_datasize_valid("MAP CLIENT Get instances-",
+				HAL_SERVICE_ID_MAP_CLIENT,
+				HAL_OP_MAP_CLIENT_GET_INSTANCES,
+				sizeof(struct hal_cmd_map_client_get_instances),
+				-1, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_SERVICE_ID_MAP_CLIENT);
+
 	return tester_run();
 }
-- 
1.9.3

