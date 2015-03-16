Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unneeded HCI_CONN_REMOTE_OOB connection flag
Date: Sun, 15 Mar 2015 17:08:19 -0700
Message-Id: <1426464499-24874-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI_CONN_REMOTE_OOB connection flag is used to indicate if the
pairing initiator has provided out-of-band data. However since that
value is no longer used in any decision making, just remove it.

It is actually unclear what purpose the OOB data present field from
the HCI IO Capability Response event serves in the first place. If
either side provided out-of-band data, then that data will be used
for pairing.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 -
 net/bluetooth/hci_event.c        | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ce94bcb33600..e4dc18eed446 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -596,7 +596,6 @@ enum {
 	HCI_CONN_SC_ENABLED,
 	HCI_CONN_AES_CCM,
 	HCI_CONN_POWER_SAVE,
-	HCI_CONN_REMOTE_OOB,
 	HCI_CONN_FLUSH_KEY,
 	HCI_CONN_ENCRYPT,
 	HCI_CONN_AUTH,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 10d760c46df1..d800f0c5aa21 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4006,8 +4006,6 @@ static void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn->remote_cap = ev->capability;
 	conn->remote_auth = ev->authentication;
-	if (ev->oob_data)
-		set_bit(HCI_CONN_REMOTE_OOB, &conn->flags);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.1.0

