Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org, gustavo@padovan.org
Subject: [PATCHv5 13/17] Bluetooth: AMP: Add AMP key calculation
Date: Mon, 17 Sep 2012 16:24:30 +0300
Message-Id: <1347888274-30779-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function calculates AMP keys using hmac_sha256 helper. Calculated keys
are Generic AMP Link Key (gamp) and Dedicated AMP Link Key with
keyID "802b" for 802.11 PAL.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/pal.h |    1 +
 net/bluetooth/Kconfig       |    1 +
 net/bluetooth/pal.c         |   45 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
index 918a4be..3b6213c 100644
--- a/include/net/bluetooth/pal.h
+++ b/include/net/bluetooth/pal.h
@@ -36,5 +36,6 @@ struct amp_ctrl *amp_ctrl_lookup(struct amp_mgr *mgr, u8 id);
 void amp_ctrl_list_flush(struct amp_mgr *mgr);
 struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 			     u8 remote_id);
+int phylink_gen_key(struct hci_conn *conn, u8 *data, u8 *len, u8 *type);
 
 #endif /* __PAL_H */
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 3537d38..1c11d0d 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -11,6 +11,7 @@ menuconfig BT
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES
 	select CRYPTO_ECB
+	select CRYPTO_SHA256
 	help
 	  Bluetooth is low-cost, low-power, short-range wireless technology.
 	  It was designed as a replacement for cables and other short-range
diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
index 8e28986..99817ce 100644
--- a/net/bluetooth/pal.c
+++ b/net/bluetooth/pal.c
@@ -157,3 +157,48 @@ int hmac_sha256(u8 *key, u8 ksize, char *plaintext, u8 psize, u8 *output)
 	crypto_free_shash(tfm);
 	return ret;
 }
+
+int phylink_gen_key(struct hci_conn *conn, u8 *data, u8 *len, u8 *type)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct link_key *key;
+	u8 keybuf[HCI_AMP_LINK_KEY_SIZE];
+	u8 gamp_key[HCI_AMP_LINK_KEY_SIZE];
+	int err;
+
+	if (!hci_conn_check_link_mode(conn))
+		return -EACCES;
+
+	BT_DBG("conn %p key_type %d", conn, conn->key_type);
+
+	/* Legacy key */
+	if (conn->key_type < 3) {
+		BT_ERR("Legacy key type %d", conn->key_type);
+		return -EACCES;
+	}
+
+	*type = conn->key_type;
+	*len = HCI_AMP_LINK_KEY_SIZE;
+
+	key = hci_find_link_key(hdev, &conn->dst);
+
+	/* BR/EDR Link Key concatenated together with itself */
+	memcpy(&keybuf[0], key->val, HCI_LINK_KEY_SIZE);
+	memcpy(&keybuf[HCI_LINK_KEY_SIZE], key->val, HCI_LINK_KEY_SIZE);
+
+	/* Derive Generic AMP Link Key (gamp) */
+	err = hmac_sha256(keybuf, HCI_AMP_LINK_KEY_SIZE, "gamp", 4, gamp_key);
+	if (err) {
+		BT_ERR("Could not derive Generic AMP Key: err %d", err);
+		return err;
+	}
+
+	if (conn->key_type == HCI_LK_DEBUG_COMBINATION) {
+		BT_DBG("Use Generic AMP Key (gamp)");
+		memcpy(data, gamp_key, HCI_AMP_LINK_KEY_SIZE);
+		return err;
+	}
+
+	/* Derive Dedicated AMP Link Key: "802b" is 802.11 PAL keyID */
+	return hmac_sha256(gamp_key, HCI_AMP_LINK_KEY_SIZE, "802b", 4, data);
+}
-- 
1.7.9.5

