Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 17/20] Bluetooth: AMP: Add AMP key calculation
Date: Fri, 13 Jul 2012 16:39:19 +0300
Message-Id: <1342186762-32329-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1342186762-32329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1342186762-32329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function calculates AMP key using hmac_sha256 helper.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/pal.h |    1 +
 net/bluetooth/pal.c         |   61 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
index 6ce1dfb..8799285 100644
--- a/include/net/bluetooth/pal.h
+++ b/include/net/bluetooth/pal.h
@@ -53,5 +53,6 @@ int phylink_put(struct phy_link *plink);
 void phylink_get(struct phy_link *plink);
 void phylink_list_flush(struct amp_mgr *mgr);
 void phylink_del(struct amp_mgr *mgr, struct phy_link *plink);
+int phylink_gen_key(struct hci_conn *conn, u8 *data, u8 *len, u8 *type);
 
 #endif /* __PAL_H */
diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
index e9bab6c..dbca318 100644
--- a/net/bluetooth/pal.c
+++ b/net/bluetooth/pal.c
@@ -255,3 +255,64 @@ int hmac_sha256(u8 *key, u8 ksize, char *plaintext, u8 psize, u8 *output)
 	crypto_free_shash(tfm);
 	return ret;
 }
+
+static void hexdump(u8 *buf, size_t len)
+{
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET,
+		       16, 1, buf, len, false);
+}
+
+int phylink_gen_key(struct hci_conn *conn, u8 *data, u8 *len, u8 *type)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct link_key *key;
+	u8 keybuf[HCI_AMP_LINK_KEY_SIZE];
+	u8 gamp_key[HCI_AMP_LINK_KEY_SIZE];
+	u8 b802_key[HCI_AMP_LINK_KEY_SIZE];
+	int result;
+
+	if (!hci_conn_check_link_mode(conn))
+		return -EACCES;
+
+	BT_DBG("key_type %d", conn->key_type);
+
+	/* Legacy key */
+	if (conn->key_type < 3)
+		return -EACCES;
+
+	*type = conn->key_type;
+	*len = HCI_AMP_LINK_KEY_SIZE;
+
+	hci_dev_lock(hdev);
+	key = hci_find_link_key(hdev, &conn->dst);
+	hci_dev_unlock(hdev);
+
+	/* BR/EDR Link Key concatenated together with itself */
+	memcpy(&keybuf[0], key->val, HCI_LINK_KEY_SIZE);
+	memcpy(&keybuf[HCI_LINK_KEY_SIZE], key->val, HCI_LINK_KEY_SIZE);
+
+	hexdump(keybuf, HCI_AMP_LINK_KEY_SIZE);
+
+	result = hmac_sha256(keybuf, HCI_AMP_LINK_KEY_SIZE, "gamp", 4,
+			     gamp_key);
+	hexdump(gamp_key, HCI_AMP_LINK_KEY_SIZE);
+
+	if (result)
+		goto done;
+
+	if (conn->key_type == 3) {
+		BT_DBG("gamp_key");
+		hexdump(gamp_key, HCI_AMP_LINK_KEY_SIZE);
+		memcpy(data, gamp_key, HCI_AMP_LINK_KEY_SIZE);
+		goto done;
+	}
+
+	result = hmac_sha256(gamp_key, HCI_AMP_LINK_KEY_SIZE, "802b", 4,
+			     b802_key);
+	hexdump(b802_key, HCI_AMP_LINK_KEY_SIZE);
+
+	memcpy(data, b802_key, HCI_AMP_LINK_KEY_SIZE);
+
+done:
+	return result;
+}
-- 
1.7.9.5

