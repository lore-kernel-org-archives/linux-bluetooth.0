Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] android: Add bt_adapter_get_address function
Date: Wed, 23 Oct 2013 13:04:39 +0200
Message-ID: <1382526281-19711-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
References: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will be used to obtain adapter address.
---
 android/adapter.c | 5 +++++
 android/adapter.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 059a5be..f9843d1 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -364,6 +364,11 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 	ipc_send_error(io, HAL_SERVICE_ID_BLUETOOTH, status);
 }
 
+const bdaddr_t *bt_adapter_get_address(void)
+{
+	return &default_adapter->bdaddr;
+}
+
 bool bt_adapter_register(GIOChannel *io)
 {
 	DBG("");
diff --git a/android/adapter.h b/android/adapter.h
index 194950b..b8d0a58 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -38,5 +38,7 @@ bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len);
 
+const bdaddr_t *bt_adapter_get_address(void);
+
 bool bt_adapter_register(GIOChannel *io);
 void bt_adapter_unregister(void);
-- 
1.8.4

