Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Nov 2012 09:29:38 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCHv1 11/12] Bluetooth: AMP: Use l2cap_physical_cfm in phylink
 complete evt
In-Reply-To: <20121112092641.GA10008@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1211130911200.27104@mathewm-linux>
References: <1350493622.26318.114.camel@aeonflux> <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1351691197-8394-12-git-send-email-Andrei.Emeltchenko.news@gmail.com> <alpine.DEB.2.02.1211011045260.9973@mathewm-linux>
 <20121102074844.GA4171@aemeltch-MOBL1> <alpine.DEB.2.02.1211020808010.29427@mathewm-linux> <20121112092641.GA10008@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei -

On Mon, 12 Nov 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Fri, Nov 02, 2012 at 08:39:09AM -0700, Mat Martineau wrote:
> ...
>>>>> +void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon)
>>>>> +{
>>>>> +	struct hci_dev *bredr_hdev = hci_dev_hold(bredr_hcon->hdev);
>>>>> +	struct amp_mgr *mgr = hs_hcon->amp_mgr;
>>>>> +	struct l2cap_chan *bredr_chan;
>>>>> +
>>>>> +	BT_DBG("bredr_hcon %p hs_hcon %p mgr %p", bredr_hcon, hs_hcon, mgr);
>>>>> +
>>>>> +	if (!bredr_hdev || !mgr || !mgr->bredr_chan)
>>>>> +		return;
>>>>> +
>>>>> +	bredr_chan = mgr->bredr_chan;
>>>>> +
>>>>> +	set_bit(FLAG_EFS_ENABLE, &bredr_chan->flags);
>>>>> +	bredr_chan->ctrl_id = hs_hcon->remote_id;
>>>>> +	bredr_chan->hs_hcon = hs_hcon;
>>>>> +	bredr_chan->conn->mtu = hs_hcon->hdev->block_mtu;
>>>>> +	bredr_chan->fcs = L2CAP_FCS_NONE;
>>
>> Changing FCS requires L2CAP reconfiguration for the channel, and
>> chan->fcs shouldn't be modified until reconfiguration happens.
>> While it doesn't make much sense to do so, the remote device may
>> want to keep FCS enabled.  The move may also fail and you don't want
>> to forget the original FCS setting in that case.
>
> So we agree that FCS shall not be used for High Speed channels. I was
> thinking more about the case where we start sending data right over HS
> channel. The configuration should be just started.

No matter what the BlueZ implementation prefers, it must be able to 
handle a remote device that requests FCS during L2CAP config.  If one 
side requests FCS, then it must be used.

Do we want BlueZ to always ignore the L2CAP FCS socket option on AMP 
controllers?  (Marcel?)  This checksum is always redundant with 802.11 
AMP controllers.

> What would be the better place to init FCS? l2cap_physical_cfm after
> checking channel moving status?

I think it should be as late as possible before L2CAP configuration 
begins in order to be sure the channel is really on AMP.  For the 
"create channel" case, set_default_fcs could see if an AMP link is 
being used and turn the FCS off.

>>>> Sorry I missed this earlier: bredr_chan needs to be locked before
>>>> changing it.  I suggest passing the information to
>>>> l2cap_physical_cfm and letting that function update the structure
>>>> members while it holds the lock.
>>>
>>> what about locking here and changing l2cap_physical_cfm to unlocked
>>> __l2cap_physical_cfm ?
>>
>> My preference is to not manipulate l2cap_chan too much outside of
>> l2cap_core, and to keep the channel move or channel create state
>> machines inside l2cap_core.  l2cap_physical_cfm checks the channel
>> state before modifying it.  The move or new connection may have been
>> canceled or be in the wrong state, in which case the structure
>> should not be modified even though the physical link was completed.
>
> so maybe we shall move some code to l2cap_physical_cfm ?

Yes, I think l2cap_physical_cfm is a better place for changes to 
l2cap_chan.


Regards,
--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
