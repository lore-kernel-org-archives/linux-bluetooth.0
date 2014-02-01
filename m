Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Track if link is using P-256 authenticated combination key
Date: Sat,  1 Feb 2014 11:52:02 -0800
Message-Id: <1391284322-29778-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the ACL link is using P-256 authenticated combination key, mark
the link mode as HCI_LM_FIPS.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 36c9a488ac56..d2c6878a9d6a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1998,6 +1998,10 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			conn->link_mode |= HCI_LM_ENCRYPT;
 			conn->sec_level = conn->pending_sec_level;
 
+			/* P-256 authentication key implies FIPS */
+			if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
+				conn->link_mode |= HCI_LM_FIPS;
+
 			if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
 			    conn->type == LE_LINK)
 				set_bit(HCI_CONN_AES_CCM, &conn->flags);
-- 
1.8.5.3

