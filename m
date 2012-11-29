Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/4] Bluetooth: AMP: Check that AMP is present and active
Date: Thu, 29 Nov 2012 17:46:05 +0200
Message-Id: <1354203968-1335-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20121129103405.GC26707@joana>
References: <20121129103405.GC26707@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Before starting quering remote AMP controllers make sure
that there is local active AMP controller.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |   16 ++++++++++++++++
 net/bluetooth/l2cap_core.c       |    1 +
 2 files changed, 17 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2f2b743..014a2ea 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -779,6 +779,22 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_host_le_capable(dev)   !!((dev)->host_features[0] & LMP_HOST_LE)
 #define lmp_host_le_br_capable(dev) !!((dev)->host_features[0] & LMP_HOST_LE_BREDR)
 
+/* returns true if at least one AMP active */
+static inline bool hci_amp_capable(void)
+{
+	struct hci_dev *hdev;
+	bool ret = false;
+
+	read_lock(&hci_dev_list_lock);
+	list_for_each_entry(hdev, &hci_dev_list, list)
+		if (hdev->amp_type == HCI_AMP &&
+		    test_bit(HCI_UP, &hdev->flags))
+			ret = true;
+	read_unlock(&hci_dev_list_lock);
+
+	return ret;
+}
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f7ee037..d8cffdb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1013,6 +1013,7 @@ static bool __amp_capable(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 
 	if (enable_hs &&
+	    hci_amp_capable() &&
 	    chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED &&
 	    conn->fixed_chan_mask & L2CAP_FC_A2MP)
 		return true;
-- 
1.7.10.4

