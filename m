Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/9] android/bluetooth: Add support for remote device friendly name
Date: Wed, 11 Dec 2013 11:31:21 +0100
Message-Id: <1386757887-29018-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to get and set remote device property with friendly name.
Storage support is still missing.
---
 android/bluetooth.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b6ef3e6..e32ddd6 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -95,6 +95,7 @@ struct device {
 	bdaddr_t bdaddr;
 	int bond_state;
 	char *name;
+	char *friendly_name;
 };
 
 struct browse_req {
@@ -2282,11 +2283,13 @@ static uint8_t get_device_service_rec(struct device *dev)
 
 static uint8_t get_device_friendly_name(struct device *dev)
 {
-	DBG("Not implemented");
+	if (!dev->friendly_name)
+		return HAL_STATUS_FAILED;
 
-	/* TODO */
+	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_FRIENDLY_NAME,
+				strlen(dev->friendly_name), dev->friendly_name);
 
-	return HAL_STATUS_FAILED;
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t get_device_rssi(struct device *dev)
@@ -2377,13 +2380,20 @@ failed:
 								status);
 }
 
-static uint8_t set_device_friendly_name(struct device *dev)
+static uint8_t set_device_friendly_name(struct device *dev, const uint8_t *val,
+								uint16_t len)
 {
-	DBG("Not implemented");
+	DBG("");
 
-	/* TODO */
+	g_free(dev->friendly_name);
+	dev->friendly_name = g_strndup((const char *) val, len);
 
-	return HAL_STATUS_FAILED;
+	/* TODO store friendly name */
+
+	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_FRIENDLY_NAME,
+				strlen(dev->friendly_name), dev->friendly_name);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t set_device_version_info(struct device *dev)
@@ -2419,7 +2429,7 @@ static void handle_set_remote_device_prop_cmd(const void *buf, uint16_t len)
 
 	switch (cmd->type) {
 	case HAL_PROP_DEVICE_FRIENDLY_NAME:
-		status = set_device_friendly_name(l->data);
+		status = set_device_friendly_name(l->data, cmd->val, cmd->len);
 		break;
 	case HAL_PROP_DEVICE_VERSION_INFO:
 		status = set_device_version_info(l->data);
-- 
1.8.3.2

