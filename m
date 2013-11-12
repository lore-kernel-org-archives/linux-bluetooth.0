Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/4] android/pan: Handle connection and control state notifications
Date: Tue, 12 Nov 2013 16:20:42 +0200
Message-Id: <1384266042-6344-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384266042-6344-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384266042-6344-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-pan.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index 78d526c..595cde9 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -31,10 +31,41 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
+static void handle_conn_state(void *buf)
+{
+	struct hal_ev_pan_conn_state *ev = buf;
+
+	if (cbs->connection_state_cb)
+		cbs->connection_state_cb(ev->state, ev->status,
+					(bt_bdaddr_t *) ev->bdaddr,
+					ev->local_role, ev->remote_role);
+}
+
+static void handle_ctrl_state(void *buf)
+{
+	struct hal_ev_pan_ctrl_state *ev = buf;
+
+	if (cbs->control_state_cb)
+		cbs->control_state_cb(ev->state, ev->status,
+					ev->local_role, (char *)ev->name);
+}
+
 void bt_notify_pan(uint16_t opcode, void *buf, uint16_t len)
 {
 	if (!interface_ready())
 		return;
+
+	switch (opcode) {
+	case HAL_EV_PAN_CONN_STATE:
+		handle_conn_state(buf);
+		break;
+	case HAL_EV_PAN_CTRL_STATE:
+		handle_ctrl_state(buf);
+		break;
+	default:
+		DBG("Unhandled callback opcode=0x%x", opcode);
+		break;
+	}
 }
 
 static bt_status_t pan_enable(int local_role)
-- 
1.8.3.2

