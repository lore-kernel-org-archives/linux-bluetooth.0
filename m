Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/5] Bluetooth: AMP: Clean up logical link create / accept
Date: Fri,  7 Dec 2012 14:59:06 +0200
Message-Id: <1354885148-4677-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1354885148-4677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1354885148-4677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use chan->hs_hcon instead of lookup by dst address.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/amp.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 88720e8..f55d3f2 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -407,26 +407,20 @@ void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon)
 
 void amp_create_logical_link(struct l2cap_chan *chan)
 {
+	struct hci_conn *hs_hcon = chan->hs_hcon;
 	struct hci_cp_create_accept_logical_link cp;
-	struct hci_conn *hcon;
 	struct hci_dev *hdev;
 
-	BT_DBG("chan %p", chan);
+	BT_DBG("chan %p hs_hcon %p dst %pMR", chan, hs_hcon, chan->conn->dst);
 
-	if (!chan->hs_hcon)
+	if (!hs_hcon)
 		return;
 
 	hdev = hci_dev_hold(chan->hs_hcon->hdev);
 	if (!hdev)
 		return;
 
-	BT_DBG("chan %p dst %pMR", chan, chan->conn->dst);
-
-	hcon = hci_conn_hash_lookup_ba(hdev, AMP_LINK, chan->conn->dst);
-	if (!hcon)
-		goto done;
-
-	cp.phy_handle = hcon->handle;
+	cp.phy_handle = hs_hcon->handle;
 
 	cp.tx_flow_spec.id = chan->local_id;
 	cp.tx_flow_spec.stype = chan->local_stype;
@@ -442,14 +436,13 @@ void amp_create_logical_link(struct l2cap_chan *chan)
 	cp.rx_flow_spec.acc_lat = cpu_to_le32(chan->remote_acc_lat);
 	cp.rx_flow_spec.flush_to = cpu_to_le32(chan->remote_flush_to);
 
-	if (hcon->out)
+	if (hs_hcon->out)
 		hci_send_cmd(hdev, HCI_OP_CREATE_LOGICAL_LINK, sizeof(cp),
 			     &cp);
 	else
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_LOGICAL_LINK, sizeof(cp),
 			     &cp);
 
-done:
 	hci_dev_put(hdev);
 }
 
-- 
1.7.10.4

