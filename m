Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 May 2012 10:38:57 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCHv1 17/17] Bluetooth: A2MP: Manage incoming connections
In-Reply-To: <20120522073739.GA15818@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1205221036130.2239@mathewm-linux>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1337351150-20526-18-git-send-email-Andrei.Emeltchenko.news@gmail.com> <alpine.DEB.2.02.1205211530290.2239@mathewm-linux> <20120522073739.GA15818@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Tue, 22 May 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Mon, May 21, 2012 at 03:45:38PM -0700, Mat Martineau wrote:
> ...
>>> @@ -4652,10 +4653,15 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>>>
>>> 	chan = l2cap_get_chan_by_scid(conn, cid);
>>> 	if (!chan) {
>>> -		BT_DBG("unknown cid 0x%4.4x", cid);
>>> -		/* Drop packet and return */
>>> -		kfree_skb(skb);
>>> -		return 0;
>>> +		if (cid == L2CAP_CID_A2MP) {
>>> +			chan = a2mp_channel_create(conn, skb);
>>
>> This allocates a new AMP manager for each incoming command, doesn't
>> it?  I'd expect the manager to be created once when it is first
>> needed, then remain active until the ACL is closed.
>
> No. If AMP channel exist it will be returned with l2cap_get_chan_by_scid.
> Channel exist while ACL connection exist.

Oh, ok - I see that it is added to the channel list in l2cap_chan_add.


Thanks,
--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

