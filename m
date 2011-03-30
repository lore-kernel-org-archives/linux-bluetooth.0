Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add mgmt_remote_name event
Date: Wed, 30 Mar 2011 13:18:12 +0300
Message-Id: <1301480292-25370-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1301480292-25370-1-git-send-email-johan.hedberg@gmail.com>
References: <1301480292-25370-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a new remote_name event to the Management interface
which is sent every time the name of a remote device is resolved (over
BR/EDR).

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |    6 ++++++
 net/bluetooth/hci_event.c        |    3 +++
 net/bluetooth/mgmt.c             |   12 ++++++++++++
 4 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2a88fc8..4093133 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -789,6 +789,7 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 								u8 status);
 int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 								u8 *eir);
+int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 864d0cb..6b6ff92 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -275,3 +275,9 @@ struct mgmt_ev_device_found {
 	__s8 rssi;
 	__u8 eir[HCI_MAX_EIR_LENGTH];
 } __packed;
+
+#define MGMT_EV_REMOTE_NAME		0x0013
+struct mgmt_ev_remote_name {
+	bdaddr_t bdaddr;
+	__u8 name[MGMT_MAX_NAME_LENGTH];
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fb78c27..8187846 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1495,6 +1495,9 @@ static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb
 
 	hci_dev_lock(hdev);
 
+	if (ev->status == 0 && test_bit(HCI_MGMT, &hdev->flags))
+		mgmt_remote_name(hdev->id, &ev->bdaddr, ev->name);
+
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (conn && hci_outgoing_auth_needed(hdev, conn)) {
 		struct hci_cp_auth_requested cp;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 066a7f1..203b2f5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2061,3 +2061,15 @@ int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 
 	return mgmt_event(MGMT_EV_DEVICE_FOUND, index, &ev, sizeof(ev), NULL);
 }
+
+int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name)
+{
+	struct mgmt_ev_remote_name ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	bacpy(&ev.bdaddr, bdaddr);
+	memcpy(ev.name, name, HCI_MAX_NAME_LENGTH);
+
+	return mgmt_event(MGMT_EV_REMOTE_NAME, index, &ev, sizeof(ev), NULL);
+}
-- 
1.7.4.1

