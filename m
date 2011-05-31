Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 3/4] Bluetooth: Check advertising cache in hci_connect()
Date: Tue, 31 May 2011 14:20:56 -0300
Message-Id: <1306862457-20310-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1306862457-20310-1-git-send-email-andre.guedes@openbossa.org>
References: <1306862457-20310-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When connecting to a LE device, we need to check the advertising
cache in order to know the address type of that device.

If its advertising entry is not found, the connection is not
established and hci_connect() returns error.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/hci_conn.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5f352d2..f6729a6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -447,13 +447,22 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
 	if (type == LE_LINK) {
+		struct adv_entry *entry;
+
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 		if (le)
 			return ERR_PTR(-EBUSY);
+
+		entry = hci_find_adv_entry(hdev, dst);
+		if (!entry)
+			return ERR_PTR(-EHOSTUNREACH);
+
 		le = hci_conn_add(hdev, LE_LINK, dst);
 		if (!le)
 			return ERR_PTR(-ENOMEM);
 
+		le->dst_type = entry->bdaddr_type;
+
 		hci_le_connect(le);
 
 		hci_conn_hold(le);
-- 
1.7.4.1

