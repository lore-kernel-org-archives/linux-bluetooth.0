Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] android/hid: Add handling of HAL_EV_HID_CONN_STATE
Date: Thu, 31 Oct 2013 14:19:48 +0200
Message-Id: <1383221988-1601-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383221988-1601-1-git-send-email-luiz.dentz@gmail.com>
References: <1383221988-1601-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This patches generate proper events when the connection state changes:

>hidhost connect
BlueZ D: android/hal-hidhost.c:hh_connect()
connection_state_cb: bd_addr= connection_state=BTHH_CONN_STATE_CONNECTING
if_hh->connect: BT_STATUS_SUCCESS
connection_state_cb: bd_addr= connection_state=BTHH_CONN_STATE_CONNECTED
>hidhost disconnect
BlueZ D: android/hal-hidhost.c:hh_disconnect()
connection_state_cb: bd_addr= connection_state=BTHH_CONN_STATE_DISCONNECTING
if_hh->disconnect: BT_STATUS_SUCCESS
connection_state_cb: bd_addr= connection_state=BTHH_CONN_STATE_DISCONNECTED
---
 android/hid.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index 92efd72..5caa25b 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -51,6 +51,7 @@ static GSList *devices = NULL;
 
 struct hid_device {
 	bdaddr_t	dst;
+	uint8_t		state;
 	GIOChannel	*ctrl_io;
 	GIOChannel	*intr_io;
 	guint		ctrl_watch;
@@ -104,18 +105,34 @@ static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 	return TRUE;
 }
 
+static void bt_hid_set_state(struct hid_device *hdev, uint8_t state)
+{
+	struct hal_ev_hid_conn_state ev;
+	char address[18];
+
+	if (hdev->state == state)
+		return;
+
+	hdev->state = state;
+
+	ba2str(&hdev->dst, address);
+	DBG("device %s state %u", address, state);
+
+	bdaddr2android(&hdev->dst, ev.bdaddr);
+	ev.state = state;
+
+	ipc_send(notification_io, HAL_SERVICE_ID_HIDHOST,
+				HAL_EV_HID_CONN_STATE, sizeof(ev), &ev, -1);
+}
+
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
 	struct hid_device *hdev = data;
-	char address[18];
 
 	if (cond & G_IO_IN)
 		return intr_io_watch_cb(chan, data);
 
-	ba2str(&hdev->dst, address);
-	DBG("Device %s disconnected", address);
-
 	/* Checking for ctrl_watch avoids a double g_io_channel_shutdown since
 	 * it's likely that ctrl_watch_cb has been queued for dispatching in
 	 * this mainloop iteration */
@@ -143,7 +160,7 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
 	char address[18];
 
 	ba2str(&hdev->dst, address);
-	DBG("Device %s disconnected", address);
+	bt_hid_set_state(hdev, HAL_HID_STATE_DISCONNECTED);
 
 	/* Checking for intr_watch avoids a double g_io_channel_shutdown since
 	 * it's likely that intr_watch_cb has been queued for dispatching in
@@ -175,6 +192,8 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				intr_watch_cb, hdev);
 
+	bt_hid_set_state(hdev, HAL_HID_STATE_CONNECTED);
+
 	return;
 
 failed:
@@ -203,6 +222,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 	DBG("");
 
 	if (conn_err) {
+		bt_hid_set_state(hdev, HAL_HID_STATE_DISCONNECTED);
 		error("%s", conn_err->message);
 		goto failed;
 	}
@@ -270,6 +290,7 @@ static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 	}
 
 	devices = g_slist_append(devices, hdev);
+	bt_hid_set_state(hdev, HAL_HID_STATE_CONNECTING);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -277,6 +298,7 @@ static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
 								uint16_t len)
 {
+	struct hid_device *hdev;
 	GSList *l;
 	bdaddr_t dst;
 
@@ -291,7 +313,16 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
 	if (!l)
 		return HAL_STATUS_FAILED;
 
-	hid_device_free(l->data);
+	hdev = l->data;
+
+	/* Wait either channels to HUP */
+	if (hdev->intr_io)
+		g_io_channel_shutdown(hdev->intr_io, TRUE, NULL);
+
+	if (hdev->ctrl_io)
+		g_io_channel_shutdown(hdev->ctrl_io, TRUE, NULL);
+
+	bt_hid_set_state(hdev, HAL_HID_STATE_DISCONNECTING);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -357,7 +388,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		hdev->ctrl_watch = g_io_add_watch(hdev->ctrl_io,
 					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					ctrl_watch_cb, hdev);
-
+		bt_hid_set_state(hdev, HAL_HID_STATE_CONNECTING);
 		break;
 
 	case L2CAP_PSM_HIDP_INTR:
@@ -370,6 +401,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		hdev->intr_watch = g_io_add_watch(hdev->intr_io,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				intr_watch_cb, hdev);
+		bt_hid_set_state(hdev, HAL_HID_STATE_CONNECTED);
 		break;
 	}
 }
-- 
1.8.3.1

