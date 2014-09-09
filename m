Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 25/39] android/hf-client: Add Operator Name event
Date: Tue,  9 Sep 2014 21:57:10 +0200
Message-Id: <1410292644-23497-26-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 22 ++++++++++++++++++++++
 android/hal-msg.h       |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 72a764a..b1b481f 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -92,6 +92,25 @@ static void handle_battery_level(void *buf, uint16_t len, int fd)
 		cbs->battery_level_cb(ev->battery_level);
 }
 
+static void handle_operator_name(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_operator_name *ev = buf;
+	uint16_t name_len = ev->name_len;
+	char *name = NULL;
+
+	if (len != sizeof(*ev) + name_len ||
+		(name_len != 0 && ev->name[name_len - 1] != '\0')) {
+		error("invalid  clip, aborting");
+		exit(EXIT_FAILURE);
+	}
+
+	if (name_len)
+		name = (char *) ev->name;
+
+	if (cbs->current_operator_cb)
+		cbs->current_operator_cb(name);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -117,6 +136,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_BATTERY_LEVEL */
 	{ handle_battery_level, false,
 			sizeof(struct hal_ev_hf_client_battery_level) },
+	/* HAL_EV_HF_CLIENT_OPERATOR_NAME */
+	{ handle_operator_name, true,
+			sizeof(struct hal_ev_hf_client_operator_name) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 85c81a8..0af198e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1749,3 +1749,9 @@ struct hal_ev_hf_client_net_signal_strength {
 struct hal_ev_hf_client_battery_level {
 	uint8_t battery_level;
 } __attribute__((packed));
+
+#define HAL_EV_HF_CLIENT_OPERATOR_NAME			0x88
+struct hal_ev_hf_client_operator_name {
+	uint16_t name_len;
+	uint8_t name[0];
+} __attribute__((packed));
-- 
1.8.4

