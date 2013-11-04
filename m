Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android: Send current state of all properties while powering adapter
Date: Mon, 4 Nov 2013 16:34:25 +0100
Message-ID: <1383579265-24614-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383579265-24614-1-git-send-email-szymon.janc@tieto.com>
References: <1383579265-24614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When adapter is powered on it is expected to emit all properties so
that framework could synchronize its state machine with current
state of HAL. There is no need to set scan mode to none on startup
as framework will set scan mode if current mode is different than
desired one.
---
 android/adapter.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 54aed40..17ea72b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1485,16 +1485,9 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 
 	switch (opcode) {
 	case HAL_OP_ENABLE:
-		/*
-		 * In case the controller has connectable and discoverable
-		 * enabled, make sure to disable it first.
-		 *
-		 * It is enough to just clear the connectable setting since
-		 * at the same time it will automatically clear discoverable
-		 * setting.
-		 */
-		if (adapter->current_settings & MGMT_SETTING_CONNECTABLE)
-			set_mode(MGMT_OP_SET_CONNECTABLE, 0x00);
+		/* Framework expects all properties to be emitted while
+		 * enabling adapter */
+		get_properties();
 
 		if (adapter->current_settings & MGMT_SETTING_POWERED) {
 			status = HAL_STATUS_DONE;
-- 
1.8.4.1

