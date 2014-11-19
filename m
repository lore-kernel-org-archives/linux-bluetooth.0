Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 10/15] android/handsfree-client: Add support to get operator name
Date: Wed, 19 Nov 2014 10:43:43 +0100
Message-Id: <1416390228-28330-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index d3a3bd1..6c318fc 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -623,10 +623,26 @@ done:
 
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
@@ -862,6 +878,37 @@ static void ciev_cb(struct hfp_context *context, void *user_data)
 	}
 }
 
+static void cops_cb(struct hfp_context *context, void *user_data)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_hf_client_operator_name *ev = (void *) buf;
+	char name[17];
+	unsigned int format;
+
+	DBG("");
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
@@ -889,6 +936,7 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, brth_cb, "+BTRH", dev, NULL);
 	hfp_hf_register(dev->hf, clcc_cb, "+CLCC", dev, NULL);
 	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
+	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
 }
 
 static void slc_chld_cb(struct hfp_context *context, void *user_data)
-- 
1.8.4

