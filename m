Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Add white list lookup for incoming connection requests
Date: Wed,  9 Jul 2014 11:18:38 +0300
Message-Id: <1404893918-6908-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404893918-6908-1-git-send-email-johan.hedberg@gmail.com>
References: <1404893918-6908-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds support for looking up entries in the white list when
HCI_CONNECTABLE is not set. The logic is fairly simple: if we're
connectable check the black list, if we're not connectable check the
white list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6d1d5b3e9cd4..c8ae9ee3cb12 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2149,10 +2149,18 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (!hci_bdaddr_list_lookup(&hdev->blacklist, &ev->bdaddr,
-				    BDADDR_BREDR)) {
-		hci_reject_conn(hdev, &ev->bdaddr);
-		return;
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags)) {
+		if (hci_bdaddr_list_lookup(&hdev->blacklist, &ev->bdaddr,
+					   BDADDR_BREDR)) {
+			hci_reject_conn(hdev, &ev->bdaddr);
+			return;
+		}
+	} else {
+		if (!hci_bdaddr_list_lookup(&hdev->whitelist, &ev->bdaddr,
+					    BDADDR_BREDR)) {
+			hci_reject_conn(hdev, &ev->bdaddr);
+			return;
+		}
 	}
 
 	/* Connection accepted */
-- 
1.9.3

