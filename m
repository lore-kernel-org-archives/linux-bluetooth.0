Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/hal: Add skeleton for handling av notifications
Date: Fri, 25 Oct 2013 17:52:03 +0200
Message-Id: <1382716327-25283-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only default case is handled in skeleton
---
 android/hal-av.c  | 13 +++++++++++++
 android/hal-ipc.c |  3 +++
 android/hal.h     |  1 +
 3 files changed, 17 insertions(+)

diff --git a/android/hal-av.c b/android/hal-av.c
index 0fe1b74..051fc3e 100644
--- a/android/hal-av.c
+++ b/android/hal-av.c
@@ -28,6 +28,19 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
+/* will be called from notification thread context */
+void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
+{
+	if (!interface_ready())
+		return;
+
+	switch (opcode) {
+	default:
+		DBG("Unhandled callback opcode=0x%x", opcode);
+		break;
+	}
+}
+
 static bt_status_t av_connect(bt_bdaddr_t *bd_addr)
 {
 	DBG("");
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 5723841..f68e789 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -49,6 +49,9 @@ static void notification_dispatch(struct hal_hdr *msg, int fd)
 	case HAL_SERVICE_ID_BLUETOOTH:
 		bt_notify_adapter(msg->opcode, msg->payload, msg->len);
 		break;
+	case HAL_SERVICE_ID_A2DP:
+		bt_notify_av(msg->opcode, msg->payload, msg->len);
+		break;
 	default:
 		DBG("Unhandled notification service=%d opcode=0x%x",
 						msg->service_id, msg->opcode);
diff --git a/android/hal.h b/android/hal.h
index 5cd5cab..a377649 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -29,3 +29,4 @@ btav_interface_t *bt_get_av_interface(void);
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len);
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
+void bt_notify_av(uint16_t opcode, void *buf, uint16_t len);
-- 
1.8.4.1

