Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 14/15] android/handsfree-client: Implement handling AT+BINP and +BINP
Date: Wed, 19 Nov 2014 10:43:47 +0100
Message-Id: <1416390228-28330-15-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 79e96a1..fbee44e 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -694,10 +694,23 @@ done:
 
 static void handle_get_last_vc_tag_num(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	struct device *dev;
+	uint8_t status;
+
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+BINP=1"))
+		status = HAL_STATUS_SUCCESS;
+	else
+		status = HAL_STATUS_FAILED;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
-					HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM,
-					HAL_STATUS_UNSUPPORTED);
+			HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM, status);
 }
 
 static void disconnect_watch(void *user_data)
@@ -987,6 +1000,27 @@ static void cops_cb(struct hfp_context *context, void *user_data)
 					sizeof(*ev) + ev->name_len, ev);
 }
 
+static void binp_cb(struct hfp_context *context, void *user_data)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_hf_client_last_void_call_tag_num *ev = (void *) buf;
+	char number[33];
+
+	DBG("");
+
+	if (!hfp_context_get_string(context, number, sizeof(number))) {
+		error("hf-client: incorrect COPS response");
+		return;
+	}
+
+	ev->number_len = strlen(number) + 1;
+	memcpy(ev->number, number, ev->number_len);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_EV_CLIENT_LAST_VOICE_CALL_TAG_NUM,
+					sizeof(*ev) + ev->number_len, ev);
+}
+
 static void slc_completed(struct device *dev)
 {
 	int i;
@@ -1016,6 +1050,7 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
 	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
 	hfp_hf_register(dev->hf, cnum_cb, "+CNUM", dev, NULL);
+	hfp_hf_register(dev->hf, binp_cb, "+BINP", dev, NULL);
 
 	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS=3,0"))
 		info("hf-client: Could not send AT+COPS=3,0");
-- 
1.8.4

