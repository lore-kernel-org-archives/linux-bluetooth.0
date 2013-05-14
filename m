Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] Bluetooth: Use HCI_MGMT instead of HCI_LINK_KEYS flag
Date: Tue, 14 May 2013 11:44:16 +0300
Message-Id: <1368521057-20931-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20130507114116.GA11873@x220>
References: <20130507114116.GA11873@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use HCI_MGMT flag instead of HCI_LINK_KEYS flag. There is a problem with
HCI_LINK_KEYS flag since it is set only when link keys are loaded. Otherwise
kernel assumes that old interface is used.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index db58e72..0437200 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2611,7 +2611,7 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		return;
 
 	hci_dev_lock(hdev);
@@ -2687,7 +2687,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_conn_drop(conn);
 	}
 
-	if (test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		hci_add_link_key(hdev, conn, 1, &ev->bdaddr, ev->link_key,
 				 ev->key_type, pin_len);
 
-- 
1.8.1.2

