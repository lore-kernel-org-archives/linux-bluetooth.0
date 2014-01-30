Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v6 01/14] Bluetooth: Save connection interval parameters in hci_conn
Date: Thu, 30 Jan 2014 18:22:04 -0300
Message-Id: <1391116937-28217-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
References: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch creates two new fields in struct hci_conn to save the
minimum and maximum connection interval values used to establish
the connection this object represents.

This change is required in order to know what parameters the
connection is currently using.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/hci_conn.c         | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8d225e4..77a4cb5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -334,6 +334,8 @@ struct hci_conn {
 	__u8		passkey_entered;
 	__u16		disc_timeout;
 	__u16		setting;
+	__u16		le_conn_min_interval;
+	__u16		le_conn_max_interval;
 	unsigned long	flags;
 
 	__u8		remote_cap;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0266bd8..7f148c9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -558,8 +558,8 @@ static int hci_create_le_conn(struct hci_conn *conn)
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
 	cp.own_address_type = conn->src_type;
-	cp.conn_interval_min = cpu_to_le16(hdev->le_conn_min_interval);
-	cp.conn_interval_max = cpu_to_le16(hdev->le_conn_max_interval);
+	cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
+	cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
 	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
 	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
 	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
@@ -624,6 +624,8 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
 	conn->auth_type = auth_type;
+	conn->le_conn_min_interval = hdev->le_conn_min_interval;
+	conn->le_conn_max_interval = hdev->le_conn_max_interval;
 
 	err = hci_create_le_conn(conn);
 	if (err)
-- 
1.8.5.3

