Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 5/8] android/pan: Notify control state callback on HAL .enable call
Date: Tue,  5 Aug 2014 14:19:11 +0300
Message-Id: <1407237554-5079-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index c11ee29..d8572cc 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -255,7 +255,8 @@ static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
 		pan_device_remove(dev);
 }
 
-static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
+static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state,
+								uint8_t status)
 {
 	struct hal_ev_pan_ctrl_state ev;
 
@@ -263,13 +264,13 @@ static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
 
 	ev.state = state;
 	ev.local_role = local_role;
-	ev.status = HAL_STATUS_SUCCESS;
+	ev.status = status;
 
 	memset(ev.name, 0, sizeof(ev.name));
 
 	if (local_role == HAL_PAN_ROLE_NAP)
 		memcpy(ev.name, BNEP_BRIDGE, sizeof(BNEP_BRIDGE));
-	else
+	else if (local_role == HAL_PAN_ROLE_PANU)
 		memcpy(ev.name, dev->iface, sizeof(dev->iface));
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_PAN, HAL_EV_PAN_CTRL_STATE,
@@ -301,7 +302,7 @@ static void bnep_conn_cb(char *iface, int err, void *data)
 
 	DBG("%s connected", dev->iface);
 
-	bt_pan_notify_ctrl_state(dev, HAL_PAN_CTRL_ENABLED);
+	bt_pan_notify_ctrl_state(dev, HAL_PAN_CTRL_ENABLED, HAL_STATUS_SUCCESS);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_CONNECTED);
 }
 
@@ -534,7 +535,7 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 	g_io_channel_unref(dev->io);
 	dev->io = NULL;
 
-	bt_pan_notify_ctrl_state(dev, HAL_PAN_CTRL_ENABLED);
+	bt_pan_notify_ctrl_state(dev, HAL_PAN_CTRL_ENABLED, HAL_STATUS_SUCCESS);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_CONNECTED);
 
 	return FALSE;
@@ -648,7 +649,7 @@ static int register_nap_server(void)
 static void bt_pan_enable(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_pan_enable *cmd = buf;
-	uint8_t status;
+	uint8_t status, state;
 	int err;
 
 	DBG("");
@@ -665,8 +666,10 @@ static void bt_pan_enable(const void *buf, uint16_t len)
 	case HAL_PAN_ROLE_NAP:
 		break;
 	case HAL_PAN_ROLE_NONE:
+		local_role = HAL_PAN_ROLE_NONE;
 		status = HAL_STATUS_SUCCESS;
-		goto reply;
+		state = HAL_PAN_CTRL_DISABLED;
+		goto notify;
 	default:
 		status = HAL_STATUS_UNSUPPORTED;
 		goto reply;
@@ -681,6 +684,10 @@ static void bt_pan_enable(const void *buf, uint16_t len)
 	}
 
 	status = HAL_STATUS_SUCCESS;
+	state = HAL_PAN_CTRL_ENABLED;
+
+notify:
+	bt_pan_notify_ctrl_state(NULL, state, status);
 
 reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE, status);
-- 
1.9.1

