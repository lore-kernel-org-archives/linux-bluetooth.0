Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 06/12] android/bluetooth: Add support to read CSRK from the kernel
Date: Thu, 22 May 2014 21:06:20 +0200
Message-Id: <1400785586-22710-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index c972cd5..54eb65d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1805,6 +1805,39 @@ static void new_long_term_key_event(uint16_t index, uint16_t length,
 	/* TODO browse services here? */
 }
 
+static void new_csrk_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_new_csrk *ev = param;
+	struct device *dev;
+	char dst[18];
+
+	if (length < sizeof(*ev)) {
+		error("Too small csrk event (%u bytes)", length);
+		return;
+	}
+
+	ba2str(&ev->key.addr.bdaddr, dst);
+	dev = find_device(&ev->key.addr.bdaddr);
+	if (!dev)
+		return;
+
+	if (ev->key.master == 0x01) {
+		memcpy(dev->remote_csrk, ev->key.val, 16);
+		dev->remote_sign_cnt = 0;
+		dev->valid_remote_csrk = true;
+	} else if (ev->key.master == 0x00) {
+		memcpy(dev->local_csrk, ev->key.val, 16);
+		dev->local_sign_cnt = 0;
+		dev->valid_local_csrk = true;
+	} else {
+		error("Unknown key type 02%02x", ev->key.master);
+		return;
+	}
+
+	/*TODO: Store it. Remember about Sign Counter*/
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(mgmt_if, MGMT_EV_NEW_SETTINGS, adapter.index,
@@ -1854,6 +1887,10 @@ static void register_mgmt_handlers(void)
 
 	mgmt_register(mgmt_if, MGMT_EV_NEW_LONG_TERM_KEY, adapter.index,
 					new_long_term_key_event, NULL, NULL);
+
+	mgmt_register(mgmt_if, MGMT_EV_NEW_CSRK, adapter.index,
+						new_csrk_callback, NULL, NULL);
+
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
-- 
1.8.4

