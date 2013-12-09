Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/8] android/bluetooth: Add stubs for set device property command
Date: Mon,  9 Dec 2013 16:14:07 +0100
Message-Id: <1386602049-5533-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386602049-5533-1-git-send-email-szymon.janc@tieto.com>
References: <1386602049-5533-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds per property stubs.
---
 android/bluetooth.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4b17f60..7528921 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2362,10 +2362,30 @@ failed:
 								status);
 }
 
+static uint8_t set_device_friendly_name(struct device *dev)
+{
+	DBG("Not implemented");
+
+	/* TODO */
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t set_device_version_info(struct device *dev)
+{
+	DBG("Not implemented");
+
+	/* TODO */
+
+	return HAL_STATUS_FAILED;
+}
+
 static void handle_set_remote_device_prop_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_set_remote_device_prop *cmd = buf;
 	uint8_t status;
+	bdaddr_t addr;
+	GSList *l;
 
 	if (len != sizeof(*cmd) + cmd->len) {
 		error("Invalid set remote device prop cmd (0x%x), terminating",
@@ -2374,15 +2394,27 @@ static void handle_set_remote_device_prop_cmd(const void *buf, uint16_t len)
 		return;
 	}
 
-	/* TODO */
+	android2bdaddr(cmd->bdaddr, &addr);
+
+	l = g_slist_find_custom(devices, &addr, bdaddr_cmp);
+	if (!l) {
+		status = HAL_STATUS_INVALID;
+		goto failed;
+	}
 
 	switch (cmd->type) {
+	case HAL_PROP_DEVICE_FRIENDLY_NAME:
+		status = set_device_friendly_name(l->data);
+		break;
+	case HAL_PROP_DEVICE_VERSION_INFO:
+		status = set_device_version_info(l->data);
+		break;
 	default:
-		DBG("Unhandled property type 0x%x", cmd->type);
 		status = HAL_STATUS_FAILED;
 		break;
 	}
 
+failed:
 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_REMOTE_DEVICE_PROP,
 									status);
 }
-- 
1.8.3.2

