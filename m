Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/10] android/ipc: Add audio_ipc_register and audio_ipc_unregister
Date: Tue, 31 Dec 2013 13:29:54 +0200
Message-Id: <1388489402-8919-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388489402-8919-1-git-send-email-luiz.dentz@gmail.com>
References: <1388489402-8919-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These function can be used to register command handlers for audio IPC.
---
 android/hal-msg.h |  4 ++++
 android/ipc.c     | 14 ++++++++++++++
 android/ipc.h     |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index b14eced..267f9b2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -48,6 +48,10 @@ struct hal_hdr {
 
 #define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_GATT
 
+#define AUDIO_SERVICE_ID_CORE		0
+
+#define AUDIO_SERVICE_ID_MAX AUDIO_SERVICE_ID_CORE
+
 /* Core Service */
 
 #define HAL_STATUS_SUCCESS		0x00
diff --git a/android/ipc.c b/android/ipc.c
index d062d95..751284f 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -46,6 +46,7 @@ struct service_handler {
 };
 
 static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
+static struct service_handler audio_services[AUDIO_SERVICE_ID_MAX + 1];
 
 static GIOChannel *cmd_io = NULL;
 static GIOChannel *notif_io = NULL;
@@ -379,3 +380,16 @@ void audio_ipc_cleanup(void)
 		audio_io = NULL;
 	}
 }
+
+void audio_ipc_register(uint8_t service, const struct ipc_handler *handlers,
+								uint8_t size)
+{
+	audio_services[service].handler = handlers;
+	audio_services[service].size = size;
+}
+
+void audio_ipc_unregister(uint8_t service)
+{
+	audio_services[service].handler = NULL;
+	audio_services[service].size = 0;
+}
diff --git a/android/ipc.h b/android/ipc.h
index 8e92811..44d5a5d 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -40,3 +40,7 @@ void ipc_unregister(uint8_t service);
 
 void audio_ipc_init(void);
 void audio_ipc_cleanup(void);
+
+void audio_ipc_register(uint8_t service, const struct ipc_handler *handlers,
+								uint8_t size);
+void audio_ipc_unregister(uint8_t service);
-- 
1.8.4.2

