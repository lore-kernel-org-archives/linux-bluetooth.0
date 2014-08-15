Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Optimize connection parameter lookup for LE connections
Date: Fri, 15 Aug 2014 16:39:11 +0300
Message-Id: <1408109951-12386-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we get an LE connection complete event there's really no reason to
look through the entire connection parameter list as the entry should be
present in the hdev->pend_le_conns list too. This patch changes the
lookup code to do a more restricted lookup only in the pend_le_conns
list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 827117160ac5..88a7e9c91df9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4225,7 +4225,8 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_proto_connect_cfm(conn, ev->status);
 
-	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
+					   conn->dst_type);
 	if (params) {
 		list_del_init(&params->action);
 		if (params && params->conn) {
-- 
1.9.3

