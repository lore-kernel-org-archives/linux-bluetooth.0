Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Tue, 30 Aug 2011 09:22:25 -0400
Subject: [PATCH 2/2] Bluetooth: Fix unsafe connection list access
Message-ID: <1314710545.2232.11.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hci_num_comp_pkts_evt accesses the hci connection list unsafely (does
not acquire the dev lock). Considering the relatively infrequent
updates to the hci connection list, disable the rx tasklet during
hci connection list updates (rather than claiming dev lock in
hci_num_comp_pkts_evt).

NB - this will be even more appropriate when tx buffer counts are
updated atomically.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/hci_conn.c |    8 +++++++-
 net/bluetooth/hci_core.c |    4 ----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 38993f6..4c62a46 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -334,7 +334,13 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	tasklet_disable(&hdev->tx_task);
 
-	hci_conn_hash_add(hdev, conn);
+	if (!in_serving_softirq()) {
+		tasklet_disable(&hdev->rx_task);
+		hci_conn_hash_add(hdev, conn);
+		tasklet_enable(&hdev->rx_task);
+	} else {
+		hci_conn_hash_add(hdev, conn);
+	}
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c9b44c5..6e1817a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1994,9 +1994,7 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hdev->stat.acl_rx++;
 
-	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
 
 	if (conn) {
 		register struct hci_proto *hp;
@@ -2032,9 +2030,7 @@ static inline void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hdev->stat.sco_rx++;
 
-	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
 
 	if (conn) {
 		register struct hci_proto *hp;
-- 
1.7.4.1

