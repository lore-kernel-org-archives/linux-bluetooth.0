Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 17/19] Bluetooth: AMP: Add AMP key calculation
Date: Fri, 29 Jun 2012 17:46:50 +0300
Message-Id: <1340981212-21709-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function calculates AMP key using hmac_sha256 helper.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/pal.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
index 1c74912..a020f97 100644
--- a/net/bluetooth/pal.c
+++ b/net/bluetooth/pal.c
@@ -260,3 +260,67 @@ int hmac_sha256(u8 *key, u8 ksize, char *plaintext, u8 psize, u8 *output)
 	crypto_free_shash(tfm);
 	return ret;
 }
+
+static void show_key(u8 *k)
+{
+	int i = 0;
+	for (i = 0; i < 32; i += 8)
+		BT_DBG("\t%02x %02x %02x %02x %02x %02x %02x %02x",
+		       *(k+i+0), *(k+i+1), *(k+i+2), *(k+i+3),
+		       *(k+i+4), *(k+i+5), *(k+i+6), *(k+i+7));
+}
+
+int phylink_security(struct hci_conn *conn, u8 *data, u8 *len, u8 *type)
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
+	show_key(keybuf);
+
+	result = hmac_sha256(keybuf, HCI_AMP_LINK_KEY_SIZE, "gamp", 4,
+			     gamp_key);
+	show_key(gamp_key);
+
+	if (result)
+		goto done;
+
+	if (conn->key_type == 3) {
+		BT_DBG("gamp_key");
+		show_key(gamp_key);
+		memcpy(data, gamp_key, 32);
+		goto done;
+	}
+
+	result = hmac_sha256(gamp_key, HCI_AMP_LINK_KEY_SIZE, "802b", 4,
+			     b802_key);
+	show_key(b802_key);
+
+	memcpy(data, b802_key, 32);
+
+done:
+	return result;
+}
-- 
1.7.9.5

