Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 7/7] android/handsfree-client: Handle disconnect command
Date: Wed,  5 Nov 2014 12:22:11 +0100
Message-Id: <1415186531-23288-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415186531-23288-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415186531-23288-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index d90cef0..751a9f1 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -195,9 +195,32 @@ static struct device *get_device(const bdaddr_t *addr)
 
 static void handle_disconnect(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct hal_cmd_hf_client_disconnect *cmd = buf;
+	struct device *dev;
+	uint32_t status;
+	bdaddr_t bdaddr;
+	char addr[18];
+
+	DBG("");
+
+	android2bdaddr(&cmd->bdaddr, &bdaddr);
+
+	ba2str(&bdaddr, addr);
+	DBG("Disconnect %s", addr);
+
+	dev = get_device(&bdaddr);
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	status = hfp_hf_disconnect(dev->hf) ? HAL_STATUS_SUCCESS :
+							HAL_STATUS_FAILED;
+
+done:
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
-			HAL_OP_HF_CLIENT_DISCONNECT, HAL_STATUS_UNSUPPORTED);
+			HAL_OP_HF_CLIENT_DISCONNECT, status);
 }
 
 static void handle_connect_audio(const void *buf, uint16_t len)
-- 
1.8.4

