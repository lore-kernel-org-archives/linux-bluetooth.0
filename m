Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] Bluetooth: Make mgmt_connect_failed() return void
Date: Sun,  6 Oct 2013 23:55:48 -0700
Message-Id: <1381128953-32080-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_connect_failed() function is not used
so change it to just return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/mgmt.c             | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 429969f..d982458 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1108,8 +1108,8 @@ int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			     u8 link_type, u8 addr_type, u8 reason);
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 link_type, u8 addr_type, u8 status);
-int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-			u8 addr_type, u8 status);
+void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+			 u8 addr_type, u8 status);
 int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
 int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				 u8 status);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a35f28e..bd32c43 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4165,8 +4165,8 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	mgmt_pending_remove(cmd);
 }
 
-int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-			u8 addr_type, u8 status)
+void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+			 u8 addr_type, u8 status)
 {
 	struct mgmt_ev_connect_failed ev;
 
@@ -4174,7 +4174,7 @@ int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.status = mgmt_status(status);
 
-	return mgmt_event(MGMT_EV_CONNECT_FAILED, hdev, &ev, sizeof(ev), NULL);
+	mgmt_event(MGMT_EV_CONNECT_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure)
-- 
1.8.3.1

