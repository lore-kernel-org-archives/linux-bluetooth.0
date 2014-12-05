Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix memory leaks from discovery filter UUID list
Date: Fri,  5 Dec 2014 11:45:22 +0100
Message-Id: <1417776323-131063-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of failure or when unplugging a controller, the allocated
memory for the UUID list of the discovery filter is not freed. Use
the newly introduced helper for reset the discovery filter and with
that also freeing existing memory.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c |  1 +
 net/bluetooth/mgmt.c     | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3c81b5cdda83..8b3f839ba826 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4255,6 +4255,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_remote_oob_data_clear(hdev);
 	hci_bdaddr_list_clear(&hdev->le_white_list);
 	hci_conn_params_clear_all(hdev);
+	hci_discovery_filter_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 104c4cc921da..74571a4b85ec 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3870,9 +3870,12 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	/* Clear the discovery filter first to free any previously
+	 * allocated memory for the UUID list.
+	 */
+	hci_discovery_filter_clear(hdev);
+
 	hdev->discovery.type = cp->type;
-	hdev->discovery.rssi = HCI_RSSI_INVALID;
-	hdev->discovery.uuid_count = 0;
 
 	hci_req_init(&req, hdev);
 
@@ -3957,6 +3960,11 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	/* Clear the discovery filter first to free any previously
+	 * allocated memory for the UUID list.
+	 */
+	hci_discovery_filter_clear(hdev);
+
 	hdev->discovery.type = cp->type;
 	hdev->discovery.rssi = cp->rssi;
 	hdev->discovery.uuid_count = uuid_count;
-- 
1.9.3

