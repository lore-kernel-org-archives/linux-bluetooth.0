Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android/bluetooth: Add support for new long term key mgmt event
Date: Tue, 18 Mar 2014 16:18:11 +0100
Message-Id: <1395155891-8745-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1395155891-8745-1-git-send-email-szymon.janc@tieto.com>
References: <1395155891-8745-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index a6650ef..845c761 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1481,6 +1481,87 @@ static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
 							HAL_BOND_STATE_NONE);
 }
 
+static void store_ltk(const bdaddr_t *dst, uint8_t bdaddr_type, bool master,
+			const uint8_t *key, uint8_t key_type, uint8_t enc_size,
+			uint16_t ediv, uint64_t rand)
+{
+	const char *key_s, *keytype_s, *encsize_s, *ediv_s, *rand_s;
+	GKeyFile *key_file;
+	char key_str[33];
+	gsize length = 0;
+	char addr[18];
+	char *data;
+	int i;
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL)) {
+		g_key_file_free(key_file);
+		return;
+	}
+
+	ba2str(dst, addr);
+
+	key_s = master ? "LongTermKey" : "SlaveLongTermKey";
+	keytype_s = master ? "LongTermKeyType" : "SlaveLongTermKeyType";
+	encsize_s = master ? "LongTermKeyEncSize" : "SlaveLongTermKeyEncSize";
+	ediv_s = master ? "LongTermKeyEDiv" : "SlaveLongTermKeyEDiv";
+	rand_s = master ? "LongTermKeyRand" : "SlaveLongTermKeyRand";
+
+	for (i = 0; i < 16; i++)
+		sprintf(key_str + (i * 2), "%2.2X", key[i]);
+
+	g_key_file_set_string(key_file, addr, key_s, key_str);
+
+	g_key_file_set_integer(key_file, addr, keytype_s, key_type);
+
+	g_key_file_set_integer(key_file, addr, encsize_s, enc_size);
+
+	g_key_file_set_integer(key_file, addr, ediv_s, ediv);
+
+	g_key_file_set_uint64(key_file, addr, rand_s, rand);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(DEVICES_FILE, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
+static void new_long_term_key_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_new_long_term_key *ev = param;
+	const struct mgmt_addr_info *addr = &ev->key.addr;
+	char dst[18];
+
+	if (length < sizeof(*ev)) {
+		error("Too small long term key event (%u bytes)", length);
+		return;
+	}
+
+	ba2str(&addr->bdaddr, dst);
+
+	DBG("new LTK for %s type %u enc_size %u store_hint %u",
+			dst, ev->key.type, ev->key.enc_size, ev->store_hint);
+
+	set_device_bond_state(&addr->bdaddr, HAL_STATUS_SUCCESS,
+							HAL_BOND_STATE_BONDED);
+
+	if (ev->store_hint) {
+		const struct mgmt_ltk_info *key = &ev->key;
+		uint16_t ediv;
+		uint64_t rand;
+
+		ediv = le16_to_cpu(key->ediv);
+		rand = le64_to_cpu(key->rand);
+
+		store_ltk(&key->addr.bdaddr, key->addr.type, key->master,
+				key->val, key->type, key->enc_size, ediv, rand);
+	}
+
+	/* TODO browse services here? */
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(mgmt_if, MGMT_EV_NEW_SETTINGS, adapter.index,
@@ -1527,6 +1608,9 @@ static void register_mgmt_handlers(void)
 
 	mgmt_register(mgmt_if, MGMT_EV_DEVICE_UNPAIRED, adapter.index,
 				mgmt_device_unpaired_event, NULL, NULL);
+
+	mgmt_register(mgmt_if, MGMT_EV_NEW_LONG_TERM_KEY, adapter.index,
+					new_long_term_key_event, NULL, NULL);
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
@@ -2791,8 +2875,8 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 
 	DBG("status %u", status);
 
-	/* On success bond state change will be send when new link key event
-	 * is received */
+	/* On success bond state change will be send when new link key or LTK
+	 * event is received */
 	if (status == MGMT_STATUS_SUCCESS)
 		return;
 
-- 
1.8.5.3

