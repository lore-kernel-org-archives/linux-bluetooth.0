Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 09/14] android/handsfree-client: Add support to get operator name
Date: Wed, 12 Nov 2014 11:49:32 +0100
Message-Id: <1415789377-20458-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 58 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index c710b48..2931c5c 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -603,10 +603,26 @@ done:
 
 static void handle_query_operator_name(const void *buf, uint16_t len)
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
+	if (hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS?"))
+		status = HAL_STATUS_SUCCESS;
+	else
+		status = HAL_STATUS_FAILED;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
 					HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME,
-					HAL_STATUS_UNSUPPORTED);
+					status);
 }
 
 static void handle_retrieve_subscr_info(const void *buf, uint16_t len)
@@ -857,6 +873,43 @@ static void ciev_cb(struct hfp_context *context, void *user_data)
 	}
 }
 
+static void cops_cb(struct hfp_context *context, void *user_data)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_hf_client_operator_name *ev = (void *) buf;
+	char name[17];
+	uint32_t format;
+
+	DBG("");
+
+	if (!context) {
+		error("hf-client: incorrect COPS response");
+		return;
+	}
+
+	/* Not interested in mode */
+	hfp_context_skip_field(context);
+
+	if (!hfp_context_get_number(context, &format))
+		return;
+
+	if (format != 0)
+		info("hf-client: Not correct string format in +COSP");
+
+	if (!hfp_context_get_string(context, name, sizeof(name))) {
+		error("hf-client: incorrect COPS response");
+		return;
+	}
+
+	memset(buf, 0, sizeof(buf));
+	ev->name_len = strlen(name) + 1;
+	memcpy(ev->name, name, ev->name_len);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_EV_HF_CLIENT_OPERATOR_NAME,
+					sizeof(*ev) + ev->name_len, ev);
+}
+
 static void slc_completed(struct device *dev)
 {
 	int i;
@@ -884,6 +937,7 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, brth_cb, "+BTRH", dev, NULL);
 	hfp_hf_register(dev->hf, clcc_cb, "+CLCC", dev, NULL);
 	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
+	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
 }
 
 static void slc_chld_cb(struct hfp_context *context, void *user_data)
-- 
1.8.4

