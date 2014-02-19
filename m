Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Avoid using GFP_ATOMIC where not necessary
Date: Wed, 19 Feb 2014 14:57:43 +0200
Message-Id: <1392814668-4830-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
References: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The various pieces of data cached in the hci_dev structure do not need
to be allocated using GFP_ATOMIC since they are never added from
interrupt context. This patch updates these allocations to use
GFP_KERNEL instead.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e8f61b3fe87c..7e679e085506 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2721,7 +2721,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		key = old_key;
 	} else {
 		old_key_type = conn ? conn->key_type : 0xff;
-		key = kzalloc(sizeof(*key), GFP_ATOMIC);
+		key = kzalloc(sizeof(*key), GFP_KERNEL);
 		if (!key)
 			return -ENOMEM;
 		list_add(&key->list, &hdev->link_keys);
@@ -2773,7 +2773,7 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 	if (old_key)
 		key = old_key;
 	else {
-		key = kzalloc(sizeof(*key), GFP_ATOMIC);
+		key = kzalloc(sizeof(*key), GFP_KERNEL);
 		if (!key)
 			return -ENOMEM;
 		list_add(&key->list, &hdev->long_term_keys);
@@ -2938,7 +2938,7 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	data = hci_find_remote_oob_data(hdev, bdaddr);
 	if (!data) {
-		data = kmalloc(sizeof(*data), GFP_ATOMIC);
+		data = kmalloc(sizeof(*data), GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
 
@@ -2965,7 +2965,7 @@ int hci_add_remote_oob_ext_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	data = hci_find_remote_oob_data(hdev, bdaddr);
 	if (!data) {
-		data = kmalloc(sizeof(*data), GFP_ATOMIC);
+		data = kmalloc(sizeof(*data), GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
 
-- 
1.8.5.3

