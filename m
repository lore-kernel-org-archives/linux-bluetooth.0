Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] adapter/hal: Implement adapter disable call
Date: Tue, 22 Oct 2013 15:24:57 +0200
Message-Id: <1382448299-16887-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
References: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index d5019a4..efc5962 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -115,12 +115,19 @@ static int enable(void)
 
 static int disable(void)
 {
+	int ret;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_MSG_OP_BT_DISABLE, 0, NULL,
+								0, NULL, NULL);
+	if (ret < 0)
+		return -ret;
+
+	return BT_STATUS_SUCCESS;
 }
 
 static void cleanup(void)
-- 
1.8.4

