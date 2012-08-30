Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unneeded zero init
Date: Thu, 30 Aug 2012 12:04:26 +0300
Message-Id: <1346317467-20903-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

hdev is allocated with kzalloc so zero initialization is not needed.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 36720f0..05bcea6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -443,10 +443,8 @@ static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
 static inline void hci_conn_hash_init(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
+
 	INIT_LIST_HEAD(&h->list);
-	h->acl_num = 0;
-	h->sco_num = 0;
-	h->le_num = 0;
 }
 
 static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
-- 
1.7.9.5

