Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/5] android: Fix bt_adapter_init
Date: Thu, 24 Oct 2013 10:36:50 +0200
Message-ID: <1382603813-9157-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382603813-9157-1-git-send-email-szymon.janc@tieto.com>
References: <1382603813-9157-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

Make bt_adapter_init return void and use ready callback for error
reporting. This also fix returning incorrect status and invalid
mgmt_if unref (mgmt_send return 0 on error or >0 on success).
---
 android/adapter.c | 11 +++++------
 android/adapter.h |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 88ac19f..d85fa1f 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -277,7 +277,7 @@ failed:
 	adapter->ready(NULL, err);
 }
 
-bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
+void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 						bt_adapter_ready ready)
 {
 	struct bt_adapter *adapter;
@@ -289,12 +289,11 @@ bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 	adapter->ready = ready;
 
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
-				read_info_complete, adapter, NULL) > 0) {
-		mgmt_unref(mgmt_if);
-		return false;
-	}
+				read_info_complete, adapter, NULL) > 0)
+		return;
 
-	return adapter;
+	ready(-EIO);
+	mgmt_unref(mgmt_if);
 }
 
 static void set_mode_complete(uint8_t status, uint16_t length,
diff --git a/android/adapter.h b/android/adapter.h
index b8d0a58..9ae2d33 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -32,7 +32,7 @@ struct bt_adapter;
 
 typedef void (*bt_adapter_ready)(struct bt_adapter *adapter, int err);
 
-bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
+void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 						bt_adapter_ready func);
 
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-- 
1.8.4

