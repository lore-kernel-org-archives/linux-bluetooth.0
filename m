Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/10] Bluetooth: Rename hci_conn_params_clear to hci_conn_params_clear_all
Date: Wed,  2 Jul 2014 17:37:25 +0300
Message-Id: <1404311854-12233-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll soon have specific clear functions for clearing enabled or
disabled entries, so rename the function that removes everything to
clear_all().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_core.c         | 4 ++--
 net/bluetooth/mgmt.c             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ee480a86e558..091934bcfd84 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -861,7 +861,7 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 			u8 auto_connect);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
-void hci_conn_params_clear(struct hci_dev *hdev);
+void hci_conn_params_clear_all(struct hci_dev *hdev);
 
 struct bdaddr_list *hci_pend_le_conn_lookup(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 21a4c8dfb874..e6e169007fd2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3580,7 +3580,7 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 }
 
 /* This function requires the caller holds hdev->lock */
-void hci_conn_params_clear(struct hci_dev *hdev)
+void hci_conn_params_clear_all(struct hci_dev *hdev)
 {
 	struct hci_conn_params *params, *tmp;
 
@@ -4038,7 +4038,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_smp_irks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
 	hci_white_list_clear(hdev);
-	hci_conn_params_clear(hdev);
+	hci_conn_params_clear_all(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 93cfefa260d5..29850e76ea3c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5104,7 +5104,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		hci_conn_params_clear(hdev);
+		hci_conn_params_clear_all(hdev);
 	}
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
-- 
1.9.3

