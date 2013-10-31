Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/14] android: Add support for handling new link key mgmt event
Date: Thu, 31 Oct 2013 02:55:43 +0000
Message-Id: <1383188154-22905-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When link key is emitted by kernel bond state change notification is
send to HAL. Storing link key is not yet implemented.
---
 android/adapter.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 15b65e5..4b4905b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -195,6 +195,60 @@ static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
 	/* TODO: Gatt attrib set*/
 }
 
+static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
+					uint8_t type, uint8_t pin_length)
+{
+	/* TODO store link key */
+
+}
+
+static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
+								uint8_t state)
+{
+	struct hal_ev_bond_state_changed ev;
+
+	ev.status = status;
+	ev.state = state;
+	bdaddr2android(addr, ev.bdaddr);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev, -1);
+}
+
+static void new_link_key_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_new_link_key *ev = param;
+	const struct mgmt_addr_info *addr = &ev->key.addr;
+	char dst[18];
+
+	if (length < sizeof(*ev)) {
+		error("Too small new link key event");
+		return;
+	}
+
+	ba2str(&addr->bdaddr, dst);
+
+	DBG("new key for %s type %u pin_len %u",
+					dst, ev->key.type, ev->key.pin_len);
+
+	if (ev->key.pin_len > 16) {
+		error("Invalid PIN length (%u) in new_key event",
+							ev->key.pin_len);
+		return;
+	}
+
+	if (ev->store_hint) {
+		const struct mgmt_link_key_info *key = &ev->key;
+
+		store_link_key(&addr->bdaddr, key->val, key->type,
+								key->pin_len);
+	}
+
+	send_bond_state_change(&addr->bdaddr, HAL_STATUS_SUCCESS,
+							HAL_BOND_STATE_BONDED);
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
@@ -207,6 +261,9 @@ static void register_mgmt_handlers(void)
 	mgmt_register(adapter->mgmt, MGMT_EV_LOCAL_NAME_CHANGED,
 				adapter->index, mgmt_local_name_changed_event,
 				NULL, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_NEW_LINK_KEY, adapter->index,
+					new_link_key_callback, NULL, NULL);
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
-- 
1.8.4.rc3

