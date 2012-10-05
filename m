Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/7] Bluetooth: AMP: Fix possible NULL dereference
Date: Fri,  5 Oct 2012 16:56:53 +0300
Message-Id: <1349445419-16788-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349445419-16788-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349445419-16788-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check that link key exist before accessing.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/amp.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 5dab2d1..b6e1c3a 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -184,6 +184,10 @@ int phylink_gen_key(struct hci_conn *conn, u8 *data, u8 *len, u8 *type)
 	*len = HCI_AMP_LINK_KEY_SIZE;
 
 	key = hci_find_link_key(hdev, &conn->dst);
+	if (!key) {
+		BT_DBG("No Link key for conn %p dst %pMR", conn, &conn->dst);
+		return -EACCES;
+	}
 
 	/* BR/EDR Link Key concatenated together with itself */
 	memcpy(&keybuf[0], key->val, HCI_LINK_KEY_SIZE);
-- 
1.7.9.5

