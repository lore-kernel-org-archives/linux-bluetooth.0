Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/12] Bluetooth: Add stubs for synchronous HCI request functionality
Date: Tue, 10 Nov 2015 20:14:23 +0200
Message-Id: <1447179274-12276-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
References: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Prepare hci_request.c to have code for doing synchronous HCI requests,
such as LE scanning or advertising changes. The necessary work
callbacks will be set up in hci_request_setup() and cleaned up in
hci_request_cleanup().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c    | 4 ++++
 net/bluetooth/hci_request.c | 8 ++++++++
 net/bluetooth/hci_request.h | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ea7cad5a161c..955b907f7ed8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1604,6 +1604,8 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	hci_req_sync_unlock(hdev);
 
+	hci_request_cleanup(hdev);
+
 	hci_dev_put(hdev);
 	return 0;
 }
@@ -3156,6 +3158,8 @@ struct hci_dev *hci_alloc_dev(void)
 
 	INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
 
+	hci_request_setup(hdev);
+
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ae19bce89616..cfb63fe8545e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -845,3 +845,11 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 	return 0;
 }
+
+void hci_request_setup(struct hci_dev *hdev)
+{
+}
+
+void hci_request_cleanup(struct hci_dev *hdev)
+{
+}
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 5b3240cf9eb7..df02afb517fa 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -70,3 +70,6 @@ void __hci_update_background_scan(struct hci_request *req);
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 		      u8 reason);
+
+void hci_request_setup(struct hci_dev *hdev);
+void hci_request_cleanup(struct hci_dev *hdev);
-- 
2.5.0

