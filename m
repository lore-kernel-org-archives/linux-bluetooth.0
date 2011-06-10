Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC] Bluetooth: Add link_type information to the mgmt Connected event
Date: Fri, 10 Jun 2011 19:34:43 -0300
Message-Id: <1307745283-12160-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

One piece of information that was lost when using the mgmt interface,
was the type of the connection. Using HCI events we used to know
the type of the connection based on the type of the event, e.g.
HCI_LE_Connection_Complete for LE links.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---

Johan,

>From my SM series, the other patch that adds information to the mgmt
interface is:
"Bluetooth: Add new structures for supporting SM key distribution"
from Jun 7.

Cheers,


 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |    1 +
 net/bluetooth/hci_event.c        |    4 ++--
 net/bluetooth/mgmt.c             |    3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 404872d..5de3866 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -834,7 +834,7 @@ int mgmt_powered(u16 index, u8 powered);
 int mgmt_discoverable(u16 index, u8 discoverable);
 int mgmt_connectable(u16 index, u8 connectable);
 int mgmt_new_key(u16 index, struct link_key *key, u8 persistent);
-int mgmt_connected(u16 index, bdaddr_t *bdaddr);
+int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type);
 int mgmt_disconnected(u16 index, bdaddr_t *bdaddr);
 int mgmt_disconnect_failed(u16 index);
 int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 status);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 129d4b3..9663f5d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -239,6 +239,7 @@ struct mgmt_ev_new_key {
 #define MGMT_EV_CONNECTED		0x000B
 struct mgmt_ev_connected {
 	bdaddr_t bdaddr;
+	__u8 link_type;
 } __packed;

 #define MGMT_EV_DISCONNECTED		0x000C
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 620f307..bc3a0b6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1356,7 +1356,7 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->state = BT_CONFIG;
 			hci_conn_hold(conn);
 			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-			mgmt_connected(hdev->id, &ev->bdaddr);
+			mgmt_connected(hdev->id, &ev->bdaddr, conn->type);
 		} else
 			conn->state = BT_CONNECTED;

@@ -2752,7 +2752,7 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 		goto unlock;
 	}

-	mgmt_connected(hdev->id, &ev->bdaddr);
+	mgmt_connected(hdev->id, &ev->bdaddr, conn->type);

 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bf8f84e..1373a32 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1942,11 +1942,12 @@ int mgmt_new_key(u16 index, struct link_key *key, u8 persistent)
 	return err;
 }

-int mgmt_connected(u16 index, bdaddr_t *bdaddr)
+int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type)
 {
 	struct mgmt_ev_connected ev;

 	bacpy(&ev.bdaddr, bdaddr);
+	ev.link_type = link_type;

 	return mgmt_event(MGMT_EV_CONNECTED, index, &ev, sizeof(ev), NULL);
 }
--
1.7.5.4

