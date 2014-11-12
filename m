Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 06/14] android/handsfree-client: Add handling +CLCC
Date: Wed, 12 Nov 2014 11:49:29 +0100
Message-Id: <1415789377-20458-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index b058a39..d5899b0 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -591,6 +591,7 @@ static void handle_query_current_calls(const void *buf, uint16_t len)
 		status = HAL_STATUS_SUCCESS;
 	else
 		status = HAL_STATUS_FAILED;
+
 done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
 					HAL_OP_HF_CLIENT_QUERY_CURRENT_CALLS,
@@ -759,6 +760,68 @@ static void brth_cb(struct hfp_context *context, void *user_data)
 				sizeof(ev), &ev);
 }
 
+static void clcc_cb(struct hfp_context *context, void *user_data)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_hf_client_current_call *ev = (void *) buf;
+	uint32_t val;
+	char number[20];
+
+	DBG("");
+
+	memset(buf, 0, sizeof(buf));
+
+	/*TODO: Shall we verify received values? */
+
+	if (!context) {
+		error("hf-client: incorrect CLCC response");
+		return;
+	}
+
+	if (!hfp_context_get_number(context, &val)) {
+		error("hf-client: Could not get index");
+		return;
+	}
+
+	ev->index = (uint8_t)val;
+
+	if (!hfp_context_get_number(context, &val)) {
+		error("hf-client: Could not get direction");
+		return;
+	}
+
+	ev->direction = val;
+
+	if (!hfp_context_get_number(context, &val)) {
+		error("hf-client: Could not get callstate");
+		return;
+	}
+
+	ev->call_state = val;
+
+	/* Next field is MODE but Android is not interested in this. Skip it */
+	if (!hfp_context_get_number(context, &val)) {
+		error("hf-client: Could not get mode");
+		return;
+	}
+
+	if (!hfp_context_get_number(context, &val)) {
+		error("hf-client: Could not get multiparty");
+		return;
+	}
+
+	ev->multiparty = val;
+
+	if (hfp_context_get_string(context, number,
+						(uint8_t) sizeof(number))) {
+		ev->number_len = strlen(number) + 1;
+		memcpy(ev->number, number, ev->number_len);
+	}
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_EV_HF_CLIENT_CURRENT_CALL, sizeof(*ev), ev);
+}
+
 static void slc_completed(struct device *dev)
 {
 	DBG("");
@@ -774,6 +837,7 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, vgm_cb, "+VGM", dev, NULL);
 	hfp_hf_register(dev->hf, vgs_cb, "+VGS", dev, NULL);
 	hfp_hf_register(dev->hf, brth_cb, "+BTRH", dev, NULL);
+	hfp_hf_register(dev->hf, clcc_cb, "+CLCC", dev, NULL);
 }
 
 static void slc_chld_cb(struct hfp_context *context, void *user_data)
-- 
1.8.4

