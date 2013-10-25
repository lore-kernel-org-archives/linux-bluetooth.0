Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/15] android/hal: Add support for sending adapter get property command
Date: Fri, 25 Oct 2013 10:56:07 +0200
Message-ID: <1382691378-31940-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
References: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to get adapter property.
---
 android/hal-bluetooth.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index aae6078..a71de83 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -143,12 +143,33 @@ static int get_adapter_properties(void)
 
 static int get_adapter_property(bt_property_type_t type)
 {
+	struct hal_cmd_get_adapter_prop cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	switch (type) {
+	case BT_PROPERTY_BDNAME:
+	case BT_PROPERTY_BDADDR:
+	case BT_PROPERTY_UUIDS:
+	case BT_PROPERTY_CLASS_OF_DEVICE:
+	case BT_PROPERTY_TYPE_OF_DEVICE:
+	case BT_PROPERTY_SERVICE_RECORD:
+	case BT_PROPERTY_ADAPTER_SCAN_MODE:
+	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
+	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
+		break;
+	default:
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	/* type match IPC type */
+	cmd.type = type;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROP,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int set_adapter_property(const bt_property_t *property)
-- 
1.8.4.1

