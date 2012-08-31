Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: Remove unneeded zero init
Date: Fri, 31 Aug 2012 16:39:28 +0300
Message-Id: <1346420369-11909-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346339195.23377.8.camel@aeonflux>
References: <1346339195.23377.8.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

hdev is allocated with kzalloc so zero initialization is not needed.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    9 ---------
 net/bluetooth/hci_core.c         |    2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7542af4..4704ca4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -428,15 +428,6 @@ static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
 	       test_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
 }
 
-static inline void hci_conn_hash_init(struct hci_dev *hdev)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	INIT_LIST_HEAD(&h->list);
-	h->acl_num = 0;
-	h->sco_num = 0;
-	h->le_num = 0;
-}
-
 static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 28bab9d..8dbbc01 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1652,6 +1652,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
+	INIT_LIST_HEAD(&hdev->conn_hash.list);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
@@ -1674,7 +1675,6 @@ struct hci_dev *hci_alloc_dev(void)
 
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
-	hci_conn_hash_init(hdev);
 
 	return hdev;
 }
-- 
1.7.9.5

