Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Add mgmt_auth_failed event
Date: Sat, 19 Feb 2011 12:06:00 -0300
Message-Id: <1298127962-18576-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
References: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

To properly track bonding completion an event to indicate authentication
failure is needed. This event will be sent whenever an authentication
complete HCI event with a non-zero status comes. It will also be sent
when we're acting in acceptor role for SSP authentication in which case
the controller will send a Simple Pairing Complete event.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |    7 +++++++
 net/bluetooth/hci_event.c        |   19 ++++++++++++++++---
 net/bluetooth/mgmt.c             |   11 +++++++++++
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05f4706..441dadb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -766,6 +766,7 @@ int mgmt_user_confirm_request(u16 index, bdaddr_t *bdaddr, __le32 value);
 int mgmt_user_confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr,
 								u8 status);
+int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5aee200..1e63c31 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -264,3 +264,10 @@ struct mgmt_ev_user_confirm_request {
 	bdaddr_t bdaddr;
 	__le32 value;
 } __packed;
+
+#define MGMT_EV_AUTH_FAILED		0x0010
+struct mgmt_ev_auth_failed {
+	__le16 index;
+	bdaddr_t bdaddr;
+	__u8 status;
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 604c7b5..3fbfa50 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1424,8 +1424,10 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 		if (!ev->status) {
 			conn->link_mode |= HCI_LM_AUTH;
 			conn->sec_level = conn->pending_sec_level;
-		} else
+		} else {
+			mgmt_auth_failed(hdev->id, &conn->dst, ev->status);
 			conn->sec_level = BT_SECURITY_LOW;
+		}
 
 		clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
 
@@ -2418,9 +2420,20 @@ static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev, struct sk_
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (conn)
-		hci_conn_put(conn);
+	if (!conn)
+		goto unlock;
+
+	/* To avoid duplicate auth_failed events to user space we check
+	 * the HCI_CONN_AUTH_PEND flag which will be set if we
+	 * initiated the authentication. A traditional auth_complete
+	 * event gets always produced as initiator and is also mapped to
+	 * the mgmt_auth_failed event */
+	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->pend) && ev->status != 0)
+		mgmt_auth_failed(hdev->id, &conn->dst, ev->status);
 
+	hci_conn_put(conn);
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0d3d613..46e2c39 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1647,3 +1647,14 @@ int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr,
 	return confirm_reply_complete(index, bdaddr, status,
 					MGMT_OP_USER_CONFIRM_NEG_REPLY);
 }
+
+int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status)
+{
+	struct mgmt_ev_auth_failed ev;
+
+	put_unaligned_le16(index, &ev.index);
+	bacpy(&ev.bdaddr, bdaddr);
+	ev.status = status;
+
+	return mgmt_event(MGMT_EV_AUTH_FAILED, &ev, sizeof(ev), NULL);
+}
-- 
1.7.4.1

