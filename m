Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 22/22] Bluetooth: AMP: Process physical link complete event
Date: Fri, 24 Aug 2012 17:00:21 +0300
Message-Id: <1345816821-32331-23-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add new hci_conn for representing AMP physical link.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |   47 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1cb8b55..4c41b8c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -207,6 +207,7 @@ enum {
 #define ESCO_LINK	0x02
 /* Low Energy links do not have defined link type. Use invented one */
 #define LE_LINK		0x80
+#define AMP_LINK	0x81
 
 /* LMP features */
 #define LMP_3SLOT	0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 28b2f98..09ec48d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -339,6 +339,7 @@ struct hci_conn {
 	struct amp_mgr	*amp_mgr;
 
 	struct hci_conn	*link;
+	struct phy_link	*phy_link;
 
 	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 029ec04..5d75d47 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3427,6 +3427,49 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void hci_phy_link_complete_evt(struct hci_dev *hdev,
+				      struct sk_buff *skb)
+{
+	struct hci_ev_phy_link_complete *ev = (void *) skb->data;
+	struct hci_conn *conn;
+	struct phy_link *plink;
+
+	BT_DBG("%s handle 0x%2.2x status 0x%2.2x", hdev->name, ev->phy_handle,
+	       ev->status);
+
+	if (ev->status)
+		return;
+
+	plink = phylink_lookup_by_handle(ev->phy_handle);
+	if (!plink)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_add(hdev, AMP_LINK, BDADDR_ANY);
+	if (conn) {
+		conn->handle = ev->phy_handle;
+		conn->state = BT_CONNECTED;
+
+		hci_conn_hold(conn);
+		conn->disc_timeout = HCI_DISCONN_TIMEOUT/2;
+		hci_conn_put(conn);
+
+		bacpy(&conn->dst, &plink->mgr->l2cap_conn->hcon->dst);
+		conn->out = true;
+		conn->phy_link = plink;
+
+		hci_conn_hold_device(conn);
+		hci_conn_add_sysfs(conn);
+	} else {
+		BT_ERR("Cannot add connection");
+	}
+
+	hci_dev_unlock(hdev);
+
+	phylink_put(plink);
+}
+
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -3749,6 +3792,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remote_oob_data_request_evt(hdev, skb);
 		break;
 
+	case HCI_EV_PHY_LINK_COMPLETE:
+		hci_phy_link_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_NUM_COMP_BLOCKS:
 		hci_num_comp_blocks_evt(hdev, skb);
 		break;
-- 
1.7.9.5

