Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Introduce a flag to track who really initiates authentication
Date: Thu, 17 Jul 2014 15:35:39 +0300
Message-Id: <1405600540-28292-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1405600540-28292-1-git-send-email-johan.hedberg@gmail.com>
References: <1405600540-28292-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Even though our side requests authentication, the original action that
caused it may be remotely triggered, such as an incoming L2CAP or RFCOMM
connect request. To track this information introduce a new hci_conn flag
called HCI_CONN_AUTH_INITIATOR.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_conn.c         | 3 +++
 net/bluetooth/hci_event.c        | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index eb2b9c9e3480..996ed065b6c2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -547,6 +547,7 @@ enum {
 	HCI_CONN_SECURE,
 	HCI_CONN_FIPS,
 	HCI_CONN_STK_ENCRYPT,
+	HCI_CONN_AUTH_INITIATOR,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 76c5a38e5997..0d76054efd26 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1027,6 +1027,9 @@ auth:
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
 		return 0;
 
+	if (initiator)
+		set_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags);
+
 	if (!hci_conn_auth(conn, sec_level, auth_type))
 		return 0;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 495d6d5c1146..af2cdca03d73 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1645,6 +1645,8 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
 		struct hci_cp_auth_requested auth_cp;
 
+		set_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags);
+
 		auth_cp.handle = __cpu_to_le16(conn->handle);
 		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED,
 			     sizeof(auth_cp), &auth_cp);
@@ -2387,6 +2389,9 @@ check_auth:
 
 	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
 		struct hci_cp_auth_requested cp;
+
+		set_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags);
+
 		cp.handle = __cpu_to_le16(conn->handle);
 		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
 	}
-- 
1.9.3

