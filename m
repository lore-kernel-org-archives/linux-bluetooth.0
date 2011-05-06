Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 11/12] Bluetooth: Check advertising cache in hci_connect()
Date: Fri,  6 May 2011 14:05:20 -0300
Message-Id: <1304701521-26459-12-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When connecting to a LE device, we need to check the advertising
cache in order to know the address type of that device.

If its advertising entry is not found, the connection is not
established and hci_connect() returns error.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b67c83c..ed9ca28 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -459,10 +459,17 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
 	if (type == LE_LINK) {
+		struct adv_entry *entry;
+
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 		if (le)
 			return ERR_PTR(-EBUSY);
-		le = hci_le_conn_add(hdev, dst, 0);
+
+		entry = hci_find_adv_entry(hdev, dst);
+		if (!entry)
+			return ERR_PTR(-EHOSTUNREACH);
+
+		le = hci_le_conn_add(hdev, dst, entry->bdaddr_type);
 		if (!le)
 			return ERR_PTR(-ENOMEM);
 
-- 
1.7.1

