Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] core: Rename authentication to key_type in mgmt_ltk_info
Date: Fri, 31 Jan 2014 18:46:23 -0800
Message-Id: <1391222783-36848-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/mgmt.h    | 2 +-
 src/adapter.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 58a651c1b10e..afd4e8b29ea3 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -177,7 +177,7 @@ struct mgmt_cp_load_link_keys {
 
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
-	uint8_t authenticated;
+	uint8_t type;
 	uint8_t master;
 	uint8_t enc_size;
 	uint16_t ediv;
diff --git a/src/adapter.c b/src/adapter.c
index 649fc7a957cf..18601eaa13dd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2444,7 +2444,7 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 		memcpy(key->val, info->val, sizeof(info->val));
 		memcpy(key->rand, info->rand, sizeof(info->rand));
 		memcpy(&key->ediv, &info->ediv, sizeof(key->ediv));
-		key->authenticated = info->authenticated;
+		key->type = info->authenticated;
 		key->master = info->master;
 		key->enc_size = info->enc_size;
 	}
@@ -5371,8 +5371,8 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 
 	ba2str(&addr->bdaddr, dst);
 
-	DBG("hci%u new LTK for %s authenticated %u enc_size %u",
-		adapter->dev_id, dst, ev->key.authenticated, ev->key.enc_size);
+	DBG("hci%u new LTK for %s type %u enc_size %u",
+		adapter->dev_id, dst, ev->key.type, ev->key.enc_size);
 
 	device = btd_adapter_get_device(adapter, &addr->bdaddr, addr->type);
 	if (!device) {
@@ -5386,7 +5386,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 
 		store_longtermkey(bdaddr, &key->addr.bdaddr,
 					key->addr.type, key->val, key->master,
-					key->authenticated, key->enc_size,
+					key->type, key->enc_size,
 					key->ediv, key->rand);
 
 		device_set_bonded(device, TRUE);
-- 
1.8.5.3

