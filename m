Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] adapter/hal: Implement adapter enable call
Date: Tue, 22 Oct 2013 15:24:56 +0200
Message-Id: <1382448299-16887-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
References: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 2c8a902..d5019a4 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -98,9 +98,19 @@ fail:
 
 static int enable(void)
 {
+	int ret;
+
 	DBG("");
 
-	return BT_STATUS_UNSUPPORTED;
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_MSG_OP_BT_ENABLE, 0, NULL,
+								0, NULL, NULL);
+	if (ret < 0)
+		return -ret;
+
+	return BT_STATUS_SUCCESS;
 }
 
 static int disable(void)
-- 
1.8.4

