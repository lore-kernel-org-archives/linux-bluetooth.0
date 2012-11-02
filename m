Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Nov 2012 09:48:51 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 11/12] Bluetooth: AMP: Use l2cap_physical_cfm in
 phylink complete evt
Message-ID: <20121102074844.GA4171@aemeltch-MOBL1>
References: <1350493622.26318.114.camel@aeonflux>
 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1351691197-8394-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1211011045260.9973@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1211011045260.9973@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Nov 01, 2012 at 10:51:19AM -0700, Mat Martineau wrote:
> 
> Andrei -
> 
> On Wed, 31 Oct 2012, Andrei Emeltchenko wrote:
> 
> >From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> >When receiving HCI Phylink Complete event run amp_physical_cfm
> >which initialize BR/EDR L2CAP channel associated with High Speed
> >link and run l2cap_physical_cfm which shall send L2CAP Create
> >Chan Request.
> >
> >Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >Acked-by: Marcel Holtmann <marcel@holtmann.org>
> >---
> >include/net/bluetooth/amp.h   |    1 +
> >include/net/bluetooth/l2cap.h |    1 +
> >net/bluetooth/amp.c           |   24 ++++++++++++++++++++++++
> >net/bluetooth/hci_event.c     |   15 ++-------------
> >4 files changed, 28 insertions(+), 13 deletions(-)
> >
> >diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
> >index f1c0017..7ea3db7 100644
> >--- a/include/net/bluetooth/amp.h
> >+++ b/include/net/bluetooth/amp.h
> >@@ -46,6 +46,7 @@ void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
> >			struct hci_conn *hcon);
> >void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
> >void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
> >+void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon);
> >void amp_create_logical_link(struct l2cap_chan *chan);
> >void amp_disconnect_logical_link(struct hci_chan *hchan);
> >void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason);
> >diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> >index 24c61ef..18149c8 100644
> >--- a/include/net/bluetooth/l2cap.h
> >+++ b/include/net/bluetooth/l2cap.h
> >@@ -812,5 +812,6 @@ void l2cap_send_conn_req(struct l2cap_chan *chan);
> >void l2cap_move_start(struct l2cap_chan *chan);
> >void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
> >		       u8 status);
> >+void l2cap_physical_cfm(struct l2cap_chan *chan, int result);
> >
> >#endif /* __L2CAP_H */
> >diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
> >index 917e034..650bb8d 100644
> >--- a/net/bluetooth/amp.c
> >+++ b/net/bluetooth/amp.c
> >@@ -373,6 +373,30 @@ void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
> >	hci_send_cmd(hdev, HCI_OP_ACCEPT_PHY_LINK, sizeof(cp), &cp);
> >}
> >
> >+void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon)
> >+{
> >+	struct hci_dev *bredr_hdev = hci_dev_hold(bredr_hcon->hdev);
> >+	struct amp_mgr *mgr = hs_hcon->amp_mgr;
> >+	struct l2cap_chan *bredr_chan;
> >+
> >+	BT_DBG("bredr_hcon %p hs_hcon %p mgr %p", bredr_hcon, hs_hcon, mgr);
> >+
> >+	if (!bredr_hdev || !mgr || !mgr->bredr_chan)
> >+		return;
> >+
> >+	bredr_chan = mgr->bredr_chan;
> >+
> >+	set_bit(FLAG_EFS_ENABLE, &bredr_chan->flags);
> >+	bredr_chan->ctrl_id = hs_hcon->remote_id;
> >+	bredr_chan->hs_hcon = hs_hcon;
> >+	bredr_chan->conn->mtu = hs_hcon->hdev->block_mtu;
> >+	bredr_chan->fcs = L2CAP_FCS_NONE;
> 
> Sorry I missed this earlier: bredr_chan needs to be locked before
> changing it.  I suggest passing the information to
> l2cap_physical_cfm and letting that function update the structure
> members while it holds the lock.

what about locking here and changing l2cap_physical_cfm to unlocked
__l2cap_physical_cfm ?

> 
> 
> >+
> >+	l2cap_physical_cfm(bredr_chan, 0);
> >+
> >+	hci_dev_put(bredr_hdev);
> >+}

Best regards 
Andrei Emeltchenko 
