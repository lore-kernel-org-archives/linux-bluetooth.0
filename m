Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Track number of LE slave connections
Date: Wed, 16 Jul 2014 11:56:08 +0300
Message-Id: <1405500969-17578-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1405500969-17578-1-git-send-email-johan.hedberg@gmail.com>
References: <1405500969-17578-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Most (probably all) controllers can only deal with a single slave LE
connection at a time. This patch adds a counter for such connections so
that the number can be quickly looked up without iterating the
connections list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3de000fbecdc..73e16ecfd6b9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -83,6 +83,7 @@ struct hci_conn_hash {
 	unsigned int     amp_num;
 	unsigned int     sco_num;
 	unsigned int     le_num;
+	unsigned int     le_num_slave;
 };
 
 struct bdaddr_list {
@@ -575,6 +576,8 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 		break;
 	case LE_LINK:
 		h->le_num++;
+		if (c->role == HCI_ROLE_SLAVE)
+			h->le_num_slave++;
 		break;
 	case SCO_LINK:
 	case ESCO_LINK:
@@ -599,6 +602,8 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 		break;
 	case LE_LINK:
 		h->le_num--;
+		if (c->role == HCI_ROLE_SLAVE)
+			h->le_num_slave--;
 		break;
 	case SCO_LINK:
 	case ESCO_LINK:
-- 
1.9.3

