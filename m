Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix mgmt connected notification
Date: Mon, 10 Nov 2014 17:10:26 +0200
Message-Id: <1415632226-22962-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes a regression that was introduced by commit
cb77c3ec075a50e9f956f62dc2e4c0394df1d578. In addition to BT_CONFIG,
BT_CONNECTED is also a state in which we may get a remote name and need
to indicate over mgmt the connection status. This scenario is
particularly likely to happen for incoming connections that do not need
authentication since there the hci_conn state will reach BT_CONNECTED
before the remote name is received.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 68c882fd20fd..a97af145e7ec 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1581,7 +1581,8 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	struct discovery_state *discov = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	if (conn && conn->state == BT_CONFIG &&
+	if (conn &&
+	    (conn->state == BT_CONFIG || conn->state == BT_CONNECTED) &&
 	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
 		mgmt_device_connected(hdev, conn, 0, name, name_len);
 
-- 
2.1.0

