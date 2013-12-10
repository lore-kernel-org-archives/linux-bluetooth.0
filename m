Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 5/8] android/bluetooth: Add stubs for get device properties command
Date: Tue, 10 Dec 2013 16:06:19 +0100
Message-Id: <1386687982-1799-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386687982-1799-1-git-send-email-szymon.janc@tieto.com>
References: <1386687982-1799-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds per property stubs.
---
 android/bluetooth.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 326f6d2..f46238a 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2240,6 +2240,78 @@ static void handle_get_adapter_props_cmd(const void *buf, uint16_t len)
 							HAL_STATUS_SUCCESS);
 }
 
+static uint8_t get_device_uuids(struct device *dev)
+{
+	DBG("Not implemented");
+
+	/* TODO */
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t get_device_class(struct device *dev)
+{
+	DBG("Not implemented");
+
+	/* TODO */
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t get_device_type(struct device *dev)
+{
+	DBG("Not implemented");
+
+	/* TODO */
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t get_device_service_rec(struct device *dev)
+{
+	DBG("Not implemented");
+
+	/* TODO */
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t get_device_friendly_name(struct device *dev)
+{
+	DBG("Not implemented");
+
+	/* TODO */
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t get_device_rssi(struct device *dev)
+{
+	DBG("Not implemented");
+
+	/* TODO */
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t get_device_version_info(struct device *dev)
+{
+	DBG("Not implemented");
+
+	/* TODO */
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t get_device_timestamp(struct device *dev)
+{
+	DBG("Not implemented");
+
+	/* TODO */
+
+	return HAL_STATUS_FAILED;
+}
+
 static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
 {
 	/* TODO */
@@ -2250,10 +2322,55 @@ static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
 
 static void handle_get_remote_device_prop_cmd(const void *buf, uint16_t len)
 {
-	/* TODO */
+	const struct hal_cmd_get_remote_device_prop *cmd = buf;
+	uint8_t status;
+	bdaddr_t addr;
+	GSList *l;
 
+	android2bdaddr(cmd->bdaddr, &addr);
+
+	l = g_slist_find_custom(devices, &addr, bdaddr_cmp);
+	if (!l) {
+		status = HAL_STATUS_INVALID;
+		goto failed;
+	}
+
+	switch (cmd->type) {
+	case HAL_PROP_DEVICE_NAME:
+		status = get_device_name(l->data);
+		break;
+	case HAL_PROP_DEVICE_UUIDS:
+		status = get_device_uuids(l->data);
+		break;
+	case HAL_PROP_DEVICE_CLASS:
+		status = get_device_class(l->data);
+		break;
+	case HAL_PROP_DEVICE_TYPE:
+		status = get_device_type(l->data);
+		break;
+	case HAL_PROP_DEVICE_SERVICE_REC:
+		status = get_device_service_rec(l->data);
+		break;
+	case HAL_PROP_DEVICE_FRIENDLY_NAME:
+		status = get_device_friendly_name(l->data);
+		break;
+	case HAL_PROP_DEVICE_RSSI:
+		status = get_device_rssi(l->data);
+		break;
+	case HAL_PROP_DEVICE_VERSION_INFO:
+		status = get_device_version_info(l->data);
+		break;
+	case HAL_PROP_DEVICE_TIMESTAMP:
+		status = get_device_timestamp(l->data);
+		break;
+	default:
+		status = HAL_STATUS_FAILED;
+		break;
+	}
+
+failed:
 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_DEVICE_PROP,
-							HAL_STATUS_FAILED);
+								status);
 }
 
 static void handle_set_remote_device_prop_cmd(const void *buf, uint16_t len)
-- 
1.8.3.2

