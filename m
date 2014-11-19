Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 12/15] android/handsfree-client: Retrieve subscriber number information
Date: Wed, 19 Nov 2014 10:43:45 +0100
Message-Id: <1416390228-28330-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 67 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index b78294a..eb3e7c3 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -647,10 +647,26 @@ done:
 
 static void handle_retrieve_subscr_info(const void *buf, uint16_t len)
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
+	if (hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+CNUM"))
+		status = HAL_STATUS_SUCCESS;
+	else
+		status = HAL_STATUS_FAILED;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
 					HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO,
-					HAL_STATUS_UNSUPPORTED);
+					status);
 }
 
 static void handle_send_dtmf(const void *buf, uint16_t len)
@@ -878,6 +894,52 @@ static void ciev_cb(struct hfp_context *context, void *user_data)
 	}
 }
 
+static void cnum_cb(struct hfp_context *context, void *user_data)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_hf_client_subscriber_service_info *ev = (void *) buf;
+	char number[33];
+	unsigned int service;
+
+	DBG("");
+
+	/* Alpha field is empty string, just skip it */
+	hfp_context_skip_field(context);
+
+	if (!hfp_context_get_string(context, number, sizeof(number))) {
+		error("hf-client: Could not get number");
+		return;
+	}
+
+	/* Type is not used in Android */
+	hfp_context_skip_field(context);
+
+	/* Speed field is empty string, just skip it*/
+	hfp_context_skip_field(context);
+
+	if (!hfp_context_get_number(context, &service))
+		return;
+
+	ev->name_len = strlen(number) + 1;
+	memcpy(ev->name, number, ev->name_len);
+
+	switch (service) {
+	case 4:
+		ev->type = HAL_HF_CLIENT_SUBSCR_TYPE_VOICE;
+		break;
+	case 5:
+		ev->type = HAL_HF_CLIENT_SUBSCR_TYPE_FAX;
+		break;
+	default:
+		ev->type = HAL_HF_CLIENT_SUBSCR_TYPE_UNKNOWN;
+		break;
+	}
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_EV_CLIENT_SUBSCRIBER_SERVICE_INFO,
+					sizeof(*ev) + ev->name_len, ev);
+}
+
 static void cops_cb(struct hfp_context *context, void *user_data)
 {
 	uint8_t buf[IPC_MTU];
@@ -937,6 +999,7 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, clcc_cb, "+CLCC", dev, NULL);
 	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
 	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
+	hfp_hf_register(dev->hf, cnum_cb, "+CNUM", dev, NULL);
 
 	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS=3,0"))
 		info("hf-client: Could not send AT+COPS=3,0");
-- 
1.8.4

