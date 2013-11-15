Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/hal: Remove unneeded code
Date: Fri, 15 Nov 2013 12:13:54 +0200
Message-Id: <1384510435-17497-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384510435-17497-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384510435-17497-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Socket HAL always registers with Bluetooth HAL and there is no sense
to send 2 commands over IPC.
---
 android/hal-bluetooth.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 078d537..8cd4327 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -347,15 +347,6 @@ static int init(bt_callbacks_t *callbacks)
 		goto fail;
 	}
 
-	cmd.service_id = HAL_SERVICE_ID_SOCK;
-
-	status = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-					sizeof(cmd), &cmd, NULL, NULL, NULL);
-	if (status != BT_STATUS_SUCCESS) {
-		error("Failed to register 'socket' service");
-		goto fail;
-	}
-
 	return status;
 
 fail:
-- 
1.7.10.4

