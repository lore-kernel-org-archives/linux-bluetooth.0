Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 06/15] android/handsfree-client: Implement query current calls
Date: Wed, 19 Nov 2014 10:43:39 +0100
Message-Id: <1416390228-28330-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index c6812ec..6860bed 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -596,10 +596,26 @@ done:
 
 static void handle_query_current_calls(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	struct device *dev;
+	uint8_t status;
+
+	DBG("");
+
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+CLCC"))
+		status = HAL_STATUS_SUCCESS;
+	else
+		status = HAL_STATUS_FAILED;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
 					HAL_OP_HF_CLIENT_QUERY_CURRENT_CALLS,
-					HAL_STATUS_UNSUPPORTED);
+					status);
 }
 
 static void handle_query_operator_name(const void *buf, uint16_t len)
-- 
1.8.4

