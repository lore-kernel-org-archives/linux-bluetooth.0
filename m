Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH] android/hal-pan: Fix order of event handler registration
Date: Tue, 19 Nov 2013 23:24:18 +0200
Message-Id: <1384896258-12789-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

IPC message handler determines handler offset with
opcode = msg->opcode - HAL_MINIMUM_EVENT. But here order is misplaced.
---
 android/hal-pan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index e12eac8..e7b8a20 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -54,14 +54,14 @@ static void handle_ctrl_state(void *buf, uint16_t len)
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT' */
 static const struct hal_ipc_handler ev_handlers[] = {
 	{	/* HAL_EV_PAN_CTRL_STATE */
-		.handler = handle_conn_state,
+		.handler = handle_ctrl_state,
 		.var_len = false,
-		.data_len = sizeof(struct hal_ev_pan_conn_state),
+		.data_len = sizeof(struct hal_ev_pan_ctrl_state),
 	},
 	{	/* HAL_EV_PAN_CONN_STATE */
-		.handler = handle_ctrl_state,
+		.handler = handle_conn_state,
 		.var_len = false,
-		.data_len = sizeof(struct hal_ev_pan_ctrl_state),
+		.data_len = sizeof(struct hal_ev_pan_conn_state),
 	},
 };
 
-- 
1.8.3.2

