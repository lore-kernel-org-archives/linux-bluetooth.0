Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Track the AES-CCM encryption status of LE and BR/EDR links
Date: Fri, 31 Jan 2014 16:24:28 -0800
Message-Id: <1391214268-13443-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When encryption for LE links has been enabled, it will always be use
AES-CCM encryption. In case of BR/EDR Secure Connections, the link
will also use AES-CCM encryption. In both cases track the AES-CCM
status in the connection flags.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_event.c        | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 378e2f32cfa0..3dbf1a0872b4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -449,6 +449,7 @@ enum {
 	HCI_CONN_MGMT_CONNECTED,
 	HCI_CONN_SSP_ENABLED,
 	HCI_CONN_SC_ENABLED,
+	HCI_CONN_AES_CCM,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
 	HCI_CONN_6LOWPAN,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 62aea2edc231..36c9a488ac56 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1997,8 +1997,14 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			conn->link_mode |= HCI_LM_AUTH;
 			conn->link_mode |= HCI_LM_ENCRYPT;
 			conn->sec_level = conn->pending_sec_level;
-		} else
+
+			if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
+			    conn->type == LE_LINK)
+				set_bit(HCI_CONN_AES_CCM, &conn->flags);
+		} else {
 			conn->link_mode &= ~HCI_LM_ENCRYPT;
+			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+		}
 	}
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
-- 
1.8.5.3

