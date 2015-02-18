Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: Add new hci_cb entries to the tail rather than the head
Date: Wed, 18 Feb 2015 14:53:54 +0200
Message-Id: <1424264038-32153-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1424264038-32153-1-git-send-email-johan.hedberg@gmail.com>
References: <1424264038-32153-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When processing hci_cb entries we want first registered callbacks to be
called first and later ones later. This is because eventually the L2CAP
callbacks that are part of the core will use this list and get
registered first. To keep the same order of calling L2CAP callbacks
before e.g. RFCOMM the order of elements needs to be this way.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 980260846d25..91f557b0318a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3465,7 +3465,7 @@ int hci_register_cb(struct hci_cb *cb)
 	BT_DBG("%p name %s", cb, cb->name);
 
 	write_lock(&hci_cb_list_lock);
-	list_add(&cb->list, &hci_cb_list);
+	list_add_tail(&cb->list, &hci_cb_list);
 	write_unlock(&hci_cb_list_lock);
 
 	return 0;
-- 
2.1.0

