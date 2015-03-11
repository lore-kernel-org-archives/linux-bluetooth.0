Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] android/gatt: Add suport for server MTU changed callback
Date: Wed, 11 Mar 2015 15:41:23 +0100
Message-Id: <1426084883-10291-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1426084883-10291-1-git-send-email-szymon.janc@tieto.com>
References: <1426084883-10291-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When MTU is exchange notification is send with updated MTU.
For BR/EDR notification is always send after connection.
---
 android/gatt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 1a264ba..bf1741e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -956,6 +956,20 @@ static void notify_client_mtu_change(struct app_connection *conn, bool success)
 			HAL_EV_GATT_CLIENT_CONFIGURE_MTU, sizeof(ev), &ev);
 }
 
+static void notify_server_mtu(struct app_connection *conn)
+{
+	struct hal_ev_gatt_server_mtu_changed ev;
+	size_t mtu;
+
+	g_attrib_get_buffer(conn->device->attrib, &mtu);
+
+	ev.conn_id = conn->id;
+	ev.mtu = mtu;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_SERVER_MTU_CHANGED, sizeof(ev), &ev);
+}
+
 static void notify_mtu_change(void *data, void *user_data)
 {
 	struct gatt_device *device = user_data;
@@ -969,6 +983,8 @@ static void notify_mtu_change(void *data, void *user_data)
 		notify_client_mtu_change(conn, true);
 		break;
 	case GATT_SERVER:
+		notify_server_mtu(conn);
+		break;
 	default:
 		break;
 	}
-- 
1.9.3

