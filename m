Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] android/hidhost: Add idle time callback implementation
Date: Tue, 18 Feb 2014 11:05:20 +0100
Message-Id: <1392717924-7712-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Although this callback is for deprecated functionality and
corresponding notification is never send by daemon it should be
implemented for library and IPC completeness.
---
 android/hal-hidhost.c   | 14 ++++++++++++++
 android/hal-ipc-api.txt | 10 ++++++++--
 android/hal-msg.h       | 11 +++++++++--
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index fd3ad2d..dcaf996 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -69,6 +69,15 @@ static void handle_proto_mode(void *buf, uint16_t len)
 							ev->status, ev->mode);
 }
 
+static void handle_idle_time(void *buf, uint16_t len)
+{
+	struct hal_ev_hidhost_idle_time *ev = buf;
+
+	if (cbacks->idle_time_cb)
+		cbacks->idle_time_cb((bt_bdaddr_t *) ev->bdaddr, ev->status,
+								ev->idle_rate);
+}
+
 static void handle_get_report(void *buf, uint16_t len)
 {
 	struct hal_ev_hidhost_get_report *ev = buf;
@@ -110,6 +119,11 @@ static const struct hal_ipc_handler ev_handlers[] = {
 		.var_len = false,
 		.data_len = sizeof(struct hal_ev_hidhost_proto_mode),
 	},
+	{	/* HAL_EV_HIDHOST_IDLE_TIME */
+		.handler = handle_idle_time,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_hidhost_idle_time),
+	},
 	{	/* HAL_EV_HIDHOST_GET_REPORT */
 		.handler = handle_get_report,
 		.var_len = true,
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index ee3bd76..22dd50d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -614,14 +614,20 @@ Notifications:
 		                      0x01 = Boot
 		                      0xff = Unsupported
 
-	Opcode 0x84 - Get Report notification
+	Opcode 0x84 - Idle Time notification
+
+		Notification parameters: Remote address (6 octets)
+		                         Status (1 octet)
+		                         Idle time (2 octets)
+
+	Opcode 0x85 - Get Report notification
 
 		Notification parameters: Remote address (6 octets)
 		                         Status (1 octet)
 		                         Report length (2 octets)
 		                         Report data (variable)
 
-	Opcode 0x85 - Virtual Unplug notification
+	Opcode 0x86 - Virtual Unplug notification
 
 		Notification parameters: Remote address (6 octets)
 		                         Status (1 octet)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 6504408..15c7ebe 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -648,7 +648,14 @@ struct hal_ev_hidhost_proto_mode {
 	uint8_t mode;
 } __attribute__((packed));
 
-#define HAL_EV_HIDHOST_GET_REPORT		0x84
+#define HAL_EV_HIDHOST_IDLE_TIME		0x84
+struct hal_ev_hidhost_idle_time {
+	uint8_t bdaddr[6];
+	uint8_t status;
+	uint32_t idle_rate;
+} __attribute__((packed));
+
+#define HAL_EV_HIDHOST_GET_REPORT		0x85
 struct hal_ev_hidhost_get_report {
 	uint8_t  bdaddr[6];
 	uint8_t  status;
@@ -656,7 +663,7 @@ struct hal_ev_hidhost_get_report {
 	uint8_t  data[0];
 } __attribute__((packed));
 
-#define HAL_EV_HIDHOST_VIRTUAL_UNPLUG		0x85
+#define HAL_EV_HIDHOST_VIRTUAL_UNPLUG		0x86
 struct hal_ev_hidhost_virtual_unplug {
 	uint8_t  bdaddr[6];
 	uint8_t  status;
-- 
1.8.3.2

