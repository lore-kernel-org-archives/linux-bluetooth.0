Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10] Bluetooth: Make mgmt_pin_code_request() return void
Date: Tue, 15 Oct 2013 14:26:20 -0700
Message-Id: <1381872389-34389-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_pin_code_request() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/mgmt.c             | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fc04bc8..a167a9d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1087,7 +1087,7 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 link_type, u8 addr_type, u8 status);
 void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			 u8 addr_type, u8 status);
-int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
+void mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
 int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				 u8 status);
 int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ca3cdb5..efa2c52 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4533,7 +4533,7 @@ void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	mgmt_event(MGMT_EV_CONNECT_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure)
+void mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure)
 {
 	struct mgmt_ev_pin_code_request ev;
 
@@ -4541,8 +4541,7 @@ int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure)
 	ev.addr.type = BDADDR_BREDR;
 	ev.secure = secure;
 
-	return mgmt_event(MGMT_EV_PIN_CODE_REQUEST, hdev, &ev, sizeof(ev),
-			  NULL);
+	mgmt_event(MGMT_EV_PIN_CODE_REQUEST, hdev, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
1.8.3.1

