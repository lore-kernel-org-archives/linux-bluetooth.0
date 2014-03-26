Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/gatt: Add implementation of client_register_for_notif_cb
Date: Wed, 26 Mar 2014 15:37:18 +0100
Message-Id: <1395844640-11602-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1395844640-11602-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395844640-11602-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will send notification with register_for_notification_cb.
It will be used also for deregister_for_notification.
---
 android/gatt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index e98de48..794a302 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1224,6 +1224,16 @@ static void client_register_for_notif_cb(int32_t conn_id, int32_t registered,
 					const struct hal_gatt_srvc_id *srvc,
 					const struct hal_gatt_gatt_id *ch)
 {
+	struct hal_ev_gatt_client_reg_for_notif ev;
+
+	ev.conn_id = conn_id;
+	ev.status = status;
+	ev.registered = registered;
+	memcpy(&ev.srvc_id, srvc, sizeof(ev.srvc_id));
+	memcpy(&ev.char_id, ch, sizeof(ev.char_id));
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_REGISTER_FOR_NOTIF, sizeof(ev), &ev);
 }
 
 static void handle_client_register_for_notification(const void *buf,
-- 
1.8.3.1

