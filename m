Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 09/12] Bluetooth: Disconnect logical link when deleteing chan
Date: Wed, 31 Oct 2012 15:46:34 +0200
Message-Id: <1351691197-8394-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Disconnect logical link for high speed channel hs_hchan
associated with L2CAP channel chan.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/amp.h |    1 +
 net/bluetooth/amp.c         |   14 ++++++++++++++
 net/bluetooth/l2cap_core.c  |    7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index 405fb9c..f1c0017 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -47,6 +47,7 @@ void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
 void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
 void amp_create_logical_link(struct l2cap_chan *chan);
+void amp_disconnect_logical_link(struct hci_chan *hchan);
 void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason);
 
 #endif /* __AMP_H */
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 0f3fef3..917e034 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -422,6 +422,20 @@ done:
 	hci_dev_put(hdev);
 }
 
+void amp_disconnect_logical_link(struct hci_chan *hchan)
+{
+	struct hci_conn *hcon = hchan->conn;
+	struct hci_cp_disconn_logical_link cp;
+
+	if (hcon->state != BT_CONNECTED) {
+		BT_DBG("hchan %p not connected", hchan);
+		return;
+	}
+
+	cp.log_handle = cpu_to_le16(hchan->handle);
+	hci_send_cmd(hcon->hdev, HCI_OP_DISCONN_LOGICAL_LINK, sizeof(cp), &cp);
+}
+
 void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason)
 {
 	BT_DBG("hchan %p", hchan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ecc5020..bb2cd9e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -578,6 +578,13 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 			mgr->bredr_chan = NULL;
 	}
 
+	if (chan->hs_hchan) {
+		struct hci_chan *hs_hchan = chan->hs_hchan;
+
+		BT_DBG("chan %p disconnect hs_hchan %p", chan, hs_hchan);
+		amp_disconnect_logical_link(hs_hchan);
+	}
+
 	chan->ops->teardown(chan, err);
 
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
-- 
1.7.9.5

