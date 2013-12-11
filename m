Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 7/9] android/bluetooth: Add support for get remote device properties command
Date: Wed, 11 Dec 2013 11:31:25 +0100
Message-Id: <1386757887-29018-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to get all properties of specified remote device.
---
 android/bluetooth.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 254ccb4..ffe1120 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2338,10 +2338,34 @@ static uint8_t get_device_timestamp(struct device *dev)
 
 static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
 {
-	/* TODO */
+	const struct hal_cmd_get_remote_device_props *cmd = buf;
+	uint8_t status;
+	bdaddr_t addr;
+	GSList *l;
+
+	android2bdaddr(cmd->bdaddr, &addr);
+
+	l = g_slist_find_custom(devices, &addr, bdaddr_cmp);
+	if (!l) {
+		status = HAL_STATUS_INVALID;
+		goto failed;
+	}
 
+	get_device_name(l->data);
+	get_device_uuids(l->data);
+	get_device_class(l->data);
+	get_device_type(l->data);
+	get_device_service_rec(l->data);
+	get_device_friendly_name(l->data);
+	get_device_rssi(l->data);
+	get_device_version_info(l->data);
+	get_device_timestamp(l->data);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_DEVICE_PROPS,
-							HAL_STATUS_FAILED);
+									status);
 }
 
 static void handle_get_remote_device_prop_cmd(const void *buf, uint16_t len)
-- 
1.8.3.2

