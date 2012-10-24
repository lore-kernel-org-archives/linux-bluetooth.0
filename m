Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Disallow LE scanning and connecting in peripheral role
Date: Wed, 24 Oct 2012 21:12:03 +0300
Message-Id: <1351102323-4654-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
References: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When an adapter is in the LE peripheral role scanning for other devices
or initiating connections to them is not allowed. This patch makes sure
that such attempts will result in appropriate error returns.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c |    3 +++
 net/bluetooth/hci_core.c |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6dcf452..dc331ce 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -502,6 +502,9 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *le;
 
+	if (test_bit(HCI_LE_PERIPHERAL, &hdev->flags))
+		return ERR_PTR(-ENOTSUPP);
+
 	le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 	if (!le) {
 		le = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5a3400d..515d0c3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1577,6 +1577,9 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 
 	BT_DBG("%s", hdev->name);
 
+	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
+		return -ENOTSUPP;
+
 	if (work_busy(&hdev->le_scan))
 		return -EINPROGRESS;
 
-- 
1.7.10.4

