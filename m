Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/4] android/gatt: Add Client's refresh function call
Date: Thu, 10 Apr 2014 16:34:53 +0200
Message-Id: <1397140494-4023-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397140494-4023-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397140494-4023-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds clearing remote devices cache (services, characteristics and
descriptors).
---
 android/gatt.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 525ad41..5c33253 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1206,10 +1206,33 @@ static void handle_client_listen(const void *buf, uint16_t len)
 
 static void handle_client_refresh(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_refresh *cmd = buf;
+	struct gatt_device *dev;
+	uint8_t status;
+	bdaddr_t bda;
+
+	/* This is Android's framework hidden API call. It seams that no
+	 * notification is expected and Bluedroid silently updates device's
+	 * cache under the hood. As we use lazy caching ,we can just clear the
+	 * cache and we're done.
+	 */
+
 	DBG("");
 
+	android2bdaddr(&cmd->bdaddr, &bda);
+	dev = find_device(&bda);
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	queue_remove_all(dev->services, NULL, NULL, destroy_service);
+
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REFRESH,
-							HAL_STATUS_FAILED);
+									status);
 }
 
 static void handle_client_search_service(const void *buf, uint16_t len)
-- 
1.9.1

