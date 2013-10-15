Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] Bluetooth: Make mgmt_auth_failed() return void
Date: Tue, 15 Oct 2013 14:26:23 -0700
Message-Id: <1381872389-34389-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_auth_failed() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/mgmt.c             | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aaa897f..c742716 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1108,8 +1108,8 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			     u8 link_type, u8 addr_type, u32 passkey,
 			     u8 entered);
-int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		     u8 addr_type, u8 status);
+void mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+		      u8 addr_type, u8 status);
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c959915..3c44990 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4681,8 +4681,8 @@ int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return mgmt_event(MGMT_EV_PASSKEY_NOTIFY, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		     u8 addr_type, u8 status)
+void mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+		      u8 addr_type, u8 status)
 {
 	struct mgmt_ev_auth_failed ev;
 
@@ -4690,7 +4690,7 @@ int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.status = mgmt_status(status);
 
-	return mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
+	mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
-- 
1.8.3.1

