Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Use HCI_MGMT instead of HCI_LINK_KEYS flag
Date: Tue,  7 May 2013 14:35:47 +0300
Message-Id: <1367926547-8279-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1367926547-8279-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20130507111436.GA11154@x220>
 <1367926547-8279-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove HCI_LINK_KEYS flag since standard HCI_MGMT can be used instead.
There is also problem with HCI_LINK_KEYS flag since it is set only
when link keys are loaded. Otherwise kernel assumes that old
interface is used.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h | 1 -
 net/bluetooth/hci_event.c   | 2 +-
 net/bluetooth/mgmt.c        | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e0512aa..3c592cf 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -107,7 +107,6 @@ enum {
 	HCI_MGMT,
 	HCI_PAIRABLE,
 	HCI_SERVICE_CACHE,
-	HCI_LINK_KEYS,
 	HCI_DEBUG_KEYS,
 	HCI_UNREGISTER,
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e547cfd..0437200 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2687,7 +2687,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_conn_drop(conn);
 	}
 
-	if (test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		hci_add_link_key(hdev, conn, 1, &ev->bdaddr, ev->link_key,
 				 ev->key_type, pin_len);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8567764..5cd3aee 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1736,8 +1736,6 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_link_keys_clear(hdev);
 
-	set_bit(HCI_LINK_KEYS, &hdev->dev_flags);
-
 	if (cp->debug_keys)
 		set_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
 	else
-- 
1.8.1.2

