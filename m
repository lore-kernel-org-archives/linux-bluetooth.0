Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] android/hal: Use correct service id for adapter commands
Date: Tue, 22 Oct 2013 18:47:54 +0200
Message-Id: <1382460476-6604-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
References: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix enabling and disabling adapter commands.
---
 android/hal-bluetooth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 852dc85..d988778 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -104,8 +104,8 @@ static int enable(void)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_MSG_OP_BT_ENABLE, 0, NULL,
-								0, NULL, NULL);
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_MSG_OP_BT_ENABLE, 0,
+							NULL, 0, NULL, NULL);
 }
 
 static int disable(void)
@@ -115,8 +115,8 @@ static int disable(void)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_MSG_OP_BT_DISABLE, 0, NULL,
-								0, NULL, NULL);
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_MSG_OP_BT_DISABLE, 0,
+							NULL, 0, NULL, NULL);
 }
 
 static void cleanup(void)
-- 
1.8.4

