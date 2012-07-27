Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Lookup hci_conn in hci_le_conn_complete_evt
Date: Fri, 27 Jul 2012 15:10:15 -0300
Message-Id: <1343412616-25641-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
References: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does a trivial code refactoring in hci_conn lookup in
hci_le_conn_complete_evt. It performs the hci_conn lookup at the
begining of the function since it is used by both flows (error
and success).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8dc1f0f..92522b4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3333,8 +3333,9 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
+	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+
 	if (ev->status) {
-		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
 		if (!conn)
 			goto unlock;
 
@@ -3346,7 +3347,6 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		goto unlock;
 	}
 
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &ev->bdaddr);
 	if (!conn) {
 		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
 		if (!conn) {
-- 
1.7.11.2

