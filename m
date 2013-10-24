Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2 2/5] android: Fix bt_adapter_init
Date: Thu, 24 Oct 2013 11:54:21 +0200
Message-ID: <1382608464-10389-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382608464-10389-1-git-send-email-szymon.janc@tieto.com>
References: <1382608464-10389-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

Make bt_adapter_init return void and use ready callback for error
reporting. This also fix returning incorrect status and invalid
mgmt_if unref (mgmt_send return 0 on error or >0 on success).
---
 android/adapter.c | 15 +++++++--------
 android/adapter.h |  4 ++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 88ac19f..79cfcfd 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -277,8 +277,8 @@ failed:
 	adapter->ready(NULL, err);
 }
 
-bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
-						bt_adapter_ready ready)
+void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
+							bt_adapter_ready cb)
 {
 	struct bt_adapter *adapter;
 
@@ -286,15 +286,14 @@ bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 
 	adapter->mgmt = mgmt_ref(mgmt_if);
 	adapter->index = index;
-	adapter->ready = ready;
+	adapter->ready = cb;
 
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
-				read_info_complete, adapter, NULL) > 0) {
-		mgmt_unref(mgmt_if);
-		return false;
-	}
+				read_info_complete, adapter, NULL) > 0)
+		return;
 
-	return adapter;
+	mgmt_unref(mgmt_if);
+	adapter->ready(-EIO);
 }
 
 static void set_mode_complete(uint8_t status, uint16_t length,
diff --git a/android/adapter.h b/android/adapter.h
index b8d0a58..236f10a 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -32,8 +32,8 @@ struct bt_adapter;
 
 typedef void (*bt_adapter_ready)(struct bt_adapter *adapter, int err);
 
-bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
-						bt_adapter_ready func);
+void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
+							bt_adapter_ready cb);
 
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len);
-- 
1.8.4

