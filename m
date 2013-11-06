Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 12/14] android/hal: Remove not neede buf len from bluetooth HAL
Date: Wed, 6 Nov 2013 15:09:28 +0100
Message-ID: <1383746970-25906-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message correctness is verified upon reception and handling functions
can simply make assumption that data in buffer is correct.
---
 android/hal-bluetooth.c | 35 ++++++++++++-----------------------
 android/hal-ipc.c       |  2 +-
 android/hal.h           |  2 +-
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 88c7b99..67e6eea 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -48,17 +48,11 @@ static void handle_adapter_state_changed(void *buf)
 
 static void adapter_props_to_hal(bt_property_t *send_props,
 					struct hal_property *hal_prop,
-					uint8_t num_props, void *buff_end)
+					uint8_t num_props)
 {
-	void *p = hal_prop;
 	uint8_t i;
 
 	for (i = 0; i < num_props; i++) {
-		if (p + sizeof(*hal_prop) + hal_prop->len > buff_end) {
-			error("invalid adapter properties event, aborting");
-			exit(EXIT_FAILURE);
-		}
-
 		send_props[i].type = hal_prop->type;
 
 		switch (hal_prop->type) {
@@ -99,17 +93,12 @@ static void adapter_hal_props_cleanup(bt_property_t *props, uint8_t num)
 
 static void device_props_to_hal(bt_property_t *send_props,
 					struct hal_property *hal_prop,
-					uint8_t num_props, void *buff_end)
+					uint8_t num_props)
 {
 	void *p = hal_prop;
 	uint8_t i;
 
 	for (i = 0; i < num_props; i++) {
-		if (p + sizeof(*hal_prop) + hal_prop->len > buff_end) {
-			error("invalid adapter properties event, aborting");
-			exit(EXIT_FAILURE);
-		}
-
 		send_props[i].type = hal_prop->type;
 
 		switch (hal_prop->type) {
@@ -148,7 +137,7 @@ static void device_hal_props_cleanup(bt_property_t *props, uint8_t num)
 	}
 }
 
-static void handle_adapter_props_changed(void *buf, uint16_t len)
+static void handle_adapter_props_changed(void *buf)
 {
 	struct hal_ev_adapter_props_changed *ev = buf;
 	bt_property_t props[ev->num_props];
@@ -158,7 +147,7 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
 	if (!bt_hal_cbacks->adapter_properties_cb)
 		return;
 
-	adapter_props_to_hal(props, ev->props, ev->num_props, buf + len);
+	adapter_props_to_hal(props, ev->props, ev->num_props);
 
 	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
 
@@ -232,7 +221,7 @@ static void handle_discovery_state_changed(void *buf)
 		bt_hal_cbacks->discovery_state_changed_cb(ev->state);
 }
 
-static void handle_device_found(void *buf, uint16_t len)
+static void handle_device_found(void *buf)
 {
 	struct hal_ev_device_found *ev = buf;
 	bt_property_t props[ev->num_props];
@@ -242,14 +231,14 @@ static void handle_device_found(void *buf, uint16_t len)
 	if (!bt_hal_cbacks->device_found_cb)
 		return;
 
-	device_props_to_hal(props, ev->props, ev->num_props, buf + len);
+	device_props_to_hal(props, ev->props, ev->num_props);
 
 	bt_hal_cbacks->device_found_cb(ev->num_props, props);
 
 	device_hal_props_cleanup(props, ev->num_props);
 }
 
-static void handle_device_state_changed(void *buf, uint16_t len)
+static void handle_device_state_changed(void *buf)
 {
 	struct hal_ev_remote_device_props *ev = buf;
 	bt_property_t props[ev->num_props];
@@ -259,7 +248,7 @@ static void handle_device_state_changed(void *buf, uint16_t len)
 	if (!bt_hal_cbacks->remote_device_properties_cb)
 		return;
 
-	device_props_to_hal(props, ev->props, ev->num_props, buf + len);
+	device_props_to_hal(props, ev->props, ev->num_props);
 
 	bt_hal_cbacks->remote_device_properties_cb(ev->status,
 						(bt_bdaddr_t *)ev->bdaddr,
@@ -281,7 +270,7 @@ static void handle_acl_state_changed(void *buf)
 }
 
 /* will be called from notification thread context */
-void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
+void bt_notify_adapter(uint16_t opcode, void *buf)
 {
 	if (!interface_ready())
 		return;
@@ -293,16 +282,16 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 		handle_adapter_state_changed(buf);
 		break;
 	case HAL_EV_ADAPTER_PROPS_CHANGED:
-		handle_adapter_props_changed(buf, len);
+		handle_adapter_props_changed(buf);
 		break;
 	case HAL_EV_DISCOVERY_STATE_CHANGED:
 		handle_discovery_state_changed(buf);
 		break;
 	case HAL_EV_DEVICE_FOUND:
-		handle_device_found(buf, len);
+		handle_device_found(buf);
 		break;
 	case HAL_EV_REMOTE_DEVICE_PROPS:
-		handle_device_state_changed(buf, len);
+		handle_device_state_changed(buf);
 		break;
 	case HAL_EV_BOND_STATE_CHANGED:
 		handle_bond_state_change(buf);
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 13392c2..7ca9fe4 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -47,7 +47,7 @@ static void notification_dispatch(struct hal_hdr *msg, int fd)
 {
 	switch (msg->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
-		bt_notify_adapter(msg->opcode, msg->payload, msg->len);
+		bt_notify_adapter(msg->opcode, msg->payload);
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
 		bt_notify_hh(msg->opcode, msg->payload, msg->len);
diff --git a/android/hal.h b/android/hal.h
index 5d6a93e..c10a27c 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -26,7 +26,7 @@ bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
 btav_interface_t *bt_get_av_interface(void);
 
-void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len);
+void bt_notify_adapter(uint16_t opcode, void *buf);
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
 void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len);
-- 
1.8.4.2

