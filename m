Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3 7/7] Bluetooth: Add secure flag for mgmt_pin_code_req
Date: Thu, 28 Apr 2011 12:07:59 +0200
Message-ID: <1303985279-3944-8-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Extend the mgmt_pin_code_request interface to require secure
pin code (16 digit) for authentication.

This is a kernel part of the secure pin code requirement notification
to user space agent.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |    1 +
 net/bluetooth/hci_event.c        |    9 +++++++--
 net/bluetooth/mgmt.c             |    3 ++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2da2eb9..2995e2e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -777,7 +777,7 @@ int mgmt_connected(u16 index, bdaddr_t *bdaddr);
 int mgmt_disconnected(u16 index, bdaddr_t *bdaddr);
 int mgmt_disconnect_failed(u16 index);
 int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 status);
-int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr);
+int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr, u8 secure);
 int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_user_confirm_request(u16 index, bdaddr_t *bdaddr, __le32 value);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 7434406..0e7de63 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -253,6 +253,7 @@ struct mgmt_ev_connect_failed {
 #define MGMT_EV_PIN_CODE_REQUEST	0x000E
 struct mgmt_ev_pin_code_request {
 	bdaddr_t bdaddr;
+	__u8 secure;
 } __packed;
 
 #define MGMT_EV_USER_CONFIRM_REQUEST	0x000F
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9d50e90..5350ad0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2006,6 +2006,7 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 {
 	struct hci_ev_pin_code_req *ev = (void *) skb->data;
 	struct hci_conn *conn;
+	u8 secure = 0;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2022,8 +2023,12 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 					sizeof(ev->bdaddr), &ev->bdaddr);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_pin_code_request(hdev->id, &ev->bdaddr);
+	if (test_bit(HCI_MGMT, &hdev->flags)) {
+		if (conn->pending_sec_level == BT_SECURITY_HIGH)
+			secure = 1;
+
+		mgmt_pin_code_request(hdev->id, &ev->bdaddr, secure);
+	}
 
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4542396..a7b4937 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1942,11 +1942,12 @@ int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 status)
 	return mgmt_event(MGMT_EV_CONNECT_FAILED, index, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr)
+int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr, u8 secure)
 {
 	struct mgmt_ev_pin_code_request ev;
 
 	bacpy(&ev.bdaddr, bdaddr);
+	ev.secure = secure;
 
 	return mgmt_event(MGMT_EV_PIN_CODE_REQUEST, index, &ev, sizeof(ev),
 									NULL);
-- 
1.7.1

