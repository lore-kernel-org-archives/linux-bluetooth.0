Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 24/39] android/hf-client: Add Battery Level event
Date: Tue,  9 Sep 2014 21:57:09 +0200
Message-Id: <1410292644-23497-25-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 044e296..72a764a 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -84,6 +84,14 @@ static void handle_network_signal(void *buf, uint16_t len, int fd)
 		cbs->network_signal_cb(ev->signal_strength);
 }
 
+static void handle_battery_level(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_battery_level *ev = buf;
+
+	if (cbs->battery_level_cb)
+		cbs->battery_level_cb(ev->battery_level);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -106,6 +114,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_NET_SIGNAL_STRENGTH */
 	{ handle_network_signal, false,
 			sizeof(struct hal_ev_hf_client_net_signal_strength) },
+	/* HAL_EV_HF_CLIENT_BATTERY_LEVEL */
+	{ handle_battery_level, false,
+			sizeof(struct hal_ev_hf_client_battery_level) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index a780e30..85c81a8 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1744,3 +1744,8 @@ struct hal_ev_hf_client_net_roaming_type {
 struct hal_ev_hf_client_net_signal_strength {
 	uint8_t signal_strength;
 } __attribute__((packed));
+
+#define HAL_EV_HF_CLIENT_BATTERY_LEVEL			0x87
+struct hal_ev_hf_client_battery_level {
+	uint8_t battery_level;
+} __attribute__((packed));
-- 
1.8.4

