Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/10] android/hal-ipc: Move daemon starting to bluetooth HAL
Date: Wed, 11 Jun 2014 16:32:50 +0200
Message-Id: <1402497172-12436-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 8 ++++++++
 android/hal-ipc.c       | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index a220328..b8eae69 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -423,6 +423,14 @@ static int init(bt_callbacks_t *callbacks)
 
 	bt_hal_cbacks = callbacks;
 
+	/* Start Android Bluetooth daemon service */
+	if (property_set("bluetooth.start", "daemon") < 0) {
+		error("Failed to set bluetooth.start=daemon");
+		hal_ipc_cleanup();
+		bt_hal_cbacks = NULL;
+		return BT_STATUS_FAIL;
+	}
+
 	if (!hal_ipc_accept()) {
 		hal_ipc_cleanup();
 		bt_hal_cbacks = NULL;
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index b1b85b0..7dd6870 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -238,12 +238,6 @@ bool hal_ipc_accept(void)
 {
 	int err;
 
-	/* Start Android Bluetooth daemon service */
-	if (property_set("bluetooth.start", "daemon") < 0) {
-		error("Failed to set bluetooth.start=daemon");
-		return false;
-	}
-
 	cmd_sk = accept_connection(listen_sk);
 	if (cmd_sk < 0)
 		return false;
-- 
1.9.1

