Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 03/15] android/hal: Add support for sending adapter set property command
Date: Fri, 25 Oct 2013 12:49:59 +0200
Message-ID: <1382698211-9123-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
References: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to set adapter property.
---
 android/hal-bluetooth.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 6e28c91..aae6078 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -153,15 +153,30 @@ static int get_adapter_property(bt_property_type_t type)
 
 static int set_adapter_property(const bt_property_t *property)
 {
+	char buf[sizeof(struct hal_cmd_set_adapter_prop) + property->len];
+	struct hal_cmd_set_adapter_prop *cmd = (void *) buf;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	if (property == NULL)
+	switch (property->type) {
+	case BT_PROPERTY_BDNAME:
+	case BT_PROPERTY_ADAPTER_SCAN_MODE:
+	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
+		break;
+	default:
 		return BT_STATUS_PARM_INVALID;
+	}
 
-	return BT_STATUS_UNSUPPORTED;
+	/* type match IPC type */
+	cmd->type = property->type;
+	cmd->len = property->len;
+	memcpy(cmd->val, property->val, property->len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_ADAPTER_PROP,
+					sizeof(buf), cmd, 0, NULL, NULL);
 }
 
 static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
-- 
1.8.4.1

