Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/hal-bluetooth: Fix sending invalid adapter property
Date: Fri, 29 Nov 2013 09:05:58 +0100
Message-Id: <1385712358-8121-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385712358-8121-1-git-send-email-szymon.janc@tieto.com>
References: <1385712358-8121-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If property to be set is of enum type it should be first converted to
byte value as size of enum might varry depending on architecture.

To keep code simple command buffer uses len received from framework
as this is more or equal to HAL property size.
---
 android/hal-bluetooth.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index f232afd..87d6fc7 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -35,6 +35,18 @@ static const bt_callbacks_t *bt_hal_cbacks = NULL;
 	e = *((uint8_t *) (hal_prop->val)); \
 } while (0)
 
+#define enum_prop_from_hal(prop, hal_len, hal_val, enum_type) do { \
+	enum_type e; \
+	if (prop->len != sizeof(e)) { \
+		error("invalid HAL property %u (%u vs %zu), aborting ", \
+					prop->type, prop->len, sizeof(e)); \
+		exit(EXIT_FAILURE); \
+	} \
+	memcpy(&e, prop->val, sizeof(e)); \
+	*((uint8_t *) hal_val) = e; /* enums are mapped to 1 byte */ \
+	*hal_len = 1; \
+} while (0)
+
 static void handle_adapter_state_changed(void *buf, uint16_t len)
 {
 	struct hal_ev_adapter_state_changed *ev = buf;
@@ -91,6 +103,23 @@ static void adapter_props_to_hal(bt_property_t *send_props,
 	exit(EXIT_FAILURE);
 }
 
+static void adapter_prop_from_hal(const bt_property_t *property, uint8_t *type,
+						uint16_t *len, void *val)
+{
+	/* type match IPC type */
+	*type = property->type;
+
+	switch(property->type) {
+	case HAL_PROP_ADAPTER_SCAN_MODE:
+		enum_prop_from_hal(property, len, val, bt_scan_mode_t);
+		break;
+	default:
+		*len = property->len;
+		memcpy(val, property->val, property->len);
+		break;
+	}
+}
+
 static void device_props_to_hal(bt_property_t *send_props,
 				struct hal_property *prop, uint8_t num_props,
 				uint16_t len)
@@ -458,13 +487,10 @@ static int set_adapter_property(const bt_property_t *property)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	/* type match IPC type */
-	cmd->type = property->type;
-	cmd->len = property->len;
-	memcpy(cmd->val, property->val, property->len);
+	adapter_prop_from_hal(property, &cmd->type, &cmd->len, cmd->val);
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_ADAPTER_PROP,
-					sizeof(buf), cmd, 0, NULL, NULL);
+				sizeof(*cmd) + cmd->len, cmd, 0, NULL, NULL);
 }
 
 static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
-- 
1.8.3.2

