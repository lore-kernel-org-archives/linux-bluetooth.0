Return-Path: <cyrus@holtmann.org>
Message-ID: <1352846964.20338.5.camel@aeonflux>
Subject: Re: [PATCHv1 11/12] Bluetooth: AMP: Use l2cap_physical_cfm in
 phylink complete evt
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Wed, 14 Nov 2012 07:49:24 +0900
In-Reply-To: <alpine.DEB.2.02.1211130911200.27104@mathewm-linux>
References: <1350493622.26318.114.camel@aeonflux>
	 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351691197-8394-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <alpine.DEB.2.02.1211011045260.9973@mathewm-linux>
	 <20121102074844.GA4171@aemeltch-MOBL1>
	 <alpine.DEB.2.02.1211020808010.29427@mathewm-linux>
	 <20121112092641.GA10008@aemeltch-MOBL1>
	 <alpine.DEB.2.02.1211130911200.27104@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> > ...
> >>>>> +void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon)
> >>>>> +{
> >>>>> +	struct hci_dev *bredr_hdev = hci_dev_hold(bredr_hcon->hdev);
> >>>>> +	struct amp_mgr *mgr = hs_hcon->amp_mgr;
> >>>>> +	struct l2cap_chan *bredr_chan;
> >>>>> +
> >>>>> +	BT_DBG("bredr_hcon %p hs_hcon %p mgr %p", bredr_hcon, hs_hcon, mgr);
> >>>>> +
> >>>>> +	if (!bredr_hdev || !mgr || !mgr->bredr_chan)
> >>>>> +		return;
> >>>>> +
> >>>>> +	bredr_chan = mgr->bredr_chan;
> >>>>> +
> >>>>> +	set_bit(FLAG_EFS_ENABLE, &bredr_chan->flags);
> >>>>> +	bredr_chan->ctrl_id = hs_hcon->remote_id;
> >>>>> +	bredr_chan->hs_hcon = hs_hcon;
> >>>>> +	bredr_chan->conn->mtu = hs_hcon->hdev->block_mtu;
> >>>>> +	bredr_chan->fcs = L2CAP_FCS_NONE;
> >>
> >> Changing FCS requires L2CAP reconfiguration for the channel, and
> >> chan->fcs shouldn't be modified until reconfiguration happens.
> >> While it doesn't make much sense to do so, the remote device may
> >> want to keep FCS enabled.  The move may also fail and you don't want
> >> to forget the original FCS setting in that case.
> >
> > So we agree that FCS shall not be used for High Speed channels. I was
> > thinking more about the case where we start sending data right over HS
> > channel. The configuration should be just started.
> 
> No matter what the BlueZ implementation prefers, it must be able to 
> handle a remote device that requests FCS during L2CAP config.  If one 
> side requests FCS, then it must be used.
> 
> Do we want BlueZ to always ignore the L2CAP FCS socket option on AMP 
> controllers?  (Marcel?)  This checksum is always redundant with 802.11 
> AMP controllers.

if it is there, we should check it. Even on 802.11. Mainly just in case
someone tries to sneak packets in. But if by any means possible we
should try to disable FCS on AMP controllers.

Regards

Marcel


