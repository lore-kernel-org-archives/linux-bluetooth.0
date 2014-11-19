Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 07/15] android/handsfree-client: Add handling +CLCC
Date: Wed, 19 Nov 2014 10:43:40 +0100
Message-Id: <1416390228-28330-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 6860bed..79779c2 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -776,6 +776,63 @@ static void brth_cb(struct hfp_context *context, void *user_data)
 				sizeof(ev), &ev);
 }
 
+static void clcc_cb(struct hfp_context *context, void *user_data)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_hf_client_current_call *ev = (void *) buf;
+	unsigned int val;
+	char number[33];
+
+	DBG("");
+
+	memset(buf, 0, sizeof(buf));
+
+	if (!hfp_context_get_number(context, &val)) {
+		error("hf-client: Could not get index");
+		return;
+	}
+
+	ev->index = val;
+
+	if (!hfp_context_get_number(context, &val) ||
+				val > HAL_HF_CLIENT_DIRECTION_INCOMIGN) {
+		error("hf-client: Could not get direction");
+		return;
+	}
+
+	ev->direction = val;
+
+	if (!hfp_context_get_number(context, &val) ||
+			val > HAL_HF_CLIENT_CALL_STATE_HELD_BY_RESP_AND_HOLD) {
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
+	if (!hfp_context_get_number(context, &val) || val > 1) {
+		error("hf-client: Could not get multiparty");
+		return;
+	}
+
+	ev->multiparty = val;
+
+	if (hfp_context_get_string(context, number, sizeof(number))) {
+		ev->number_len = strlen(number) + 1;
+		memcpy(ev->number, number, ev->number_len);
+	}
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_EV_HF_CLIENT_CURRENT_CALL,
+					sizeof(*ev) + ev->number_len, ev);
+}
+
 static void slc_completed(struct device *dev)
 {
 	DBG("");
@@ -791,6 +848,7 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, vgm_cb, "+VGM", dev, NULL);
 	hfp_hf_register(dev->hf, vgs_cb, "+VGS", dev, NULL);
 	hfp_hf_register(dev->hf, brth_cb, "+BTRH", dev, NULL);
+	hfp_hf_register(dev->hf, clcc_cb, "+CLCC", dev, NULL);
 }
 
 static void slc_chld_cb(struct hfp_context *context, void *user_data)
-- 
1.8.4

