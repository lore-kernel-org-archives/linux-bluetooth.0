Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Nov 2012 11:26:43 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 11/12] Bluetooth: AMP: Use l2cap_physical_cfm in
 phylink complete evt
Message-ID: <20121112092641.GA10008@aemeltch-MOBL1>
References: <1350493622.26318.114.camel@aeonflux>
 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1351691197-8394-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1211011045260.9973@mathewm-linux>
 <20121102074844.GA4171@aemeltch-MOBL1>
 <alpine.DEB.2.02.1211020808010.29427@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1211020808010.29427@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Nov 02, 2012 at 08:39:09AM -0700, Mat Martineau wrote:
...
> >>>+void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon)
> >>>+{
> >>>+	struct hci_dev *bredr_hdev = hci_dev_hold(bredr_hcon->hdev);
> >>>+	struct amp_mgr *mgr = hs_hcon->amp_mgr;
> >>>+	struct l2cap_chan *bredr_chan;
> >>>+
> >>>+	BT_DBG("bredr_hcon %p hs_hcon %p mgr %p", bredr_hcon, hs_hcon, mgr);
> >>>+
> >>>+	if (!bredr_hdev || !mgr || !mgr->bredr_chan)
> >>>+		return;
> >>>+
> >>>+	bredr_chan = mgr->bredr_chan;
> >>>+
> >>>+	set_bit(FLAG_EFS_ENABLE, &bredr_chan->flags);
> >>>+	bredr_chan->ctrl_id = hs_hcon->remote_id;
> >>>+	bredr_chan->hs_hcon = hs_hcon;
> >>>+	bredr_chan->conn->mtu = hs_hcon->hdev->block_mtu;
> >>>+	bredr_chan->fcs = L2CAP_FCS_NONE;
> 
> Changing FCS requires L2CAP reconfiguration for the channel, and
> chan->fcs shouldn't be modified until reconfiguration happens.
> While it doesn't make much sense to do so, the remote device may
> want to keep FCS enabled.  The move may also fail and you don't want
> to forget the original FCS setting in that case.

So we agree that FCS shall not be used for High Speed channels. I was
thinking more about the case where we start sending data right over HS
channel. The configuration should be just started.

What would be the better place to init FCS? l2cap_physical_cfm after
checking channel moving status?

> >>Sorry I missed this earlier: bredr_chan needs to be locked before
> >>changing it.  I suggest passing the information to
> >>l2cap_physical_cfm and letting that function update the structure
> >>members while it holds the lock.
> >
> >what about locking here and changing l2cap_physical_cfm to unlocked
> >__l2cap_physical_cfm ?
> 
> My preference is to not manipulate l2cap_chan too much outside of
> l2cap_core, and to keep the channel move or channel create state
> machines inside l2cap_core.  l2cap_physical_cfm checks the channel
> state before modifying it.  The move or new connection may have been
> canceled or be in the wrong state, in which case the structure
> should not be modified even though the physical link was completed.

so maybe we shall move some code to l2cap_physical_cfm ?

Best regards 
Andrei Emeltchenko 

