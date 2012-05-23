Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 May 2012 08:44:22 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCHv1 01/17] Bluetooth: A2MP: Create A2MP channel
In-Reply-To: <20120523074950.GA32022@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1205230842040.6526@mathewm-linux>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1337351150-20526-2-git-send-email-Andrei.Emeltchenko.news@gmail.com> <alpine.DEB.2.02.1205221039100.2239@mathewm-linux> <20120523074950.GA32022@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei -

On Wed, 23 May 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Tue, May 22, 2012 at 10:45:07AM -0700, Mat Martineau wrote:
>>> +static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
>>> +{
>>> +	struct l2cap_chan *chan;
>>> +
>>> +	chan = l2cap_chan_create();
>>> +	if (!chan)
>>> +		return NULL;
>>> +
>>> +	BT_DBG("chan %p", chan);
>>> +
>>> +	hci_conn_hold(conn->hcon);
>>
>> Holding the hcon will keep the ACL open after all of the other L2CAP
>> channels have closed (unless I missed some code later in the patch
>> series).  The A2MP fixed channel should not keep the ACL open.  If
>> the connection is not held here, then there shouldn't be a put in
>> l2cap_chan_del for the A2MP channel either.
>
> l2cap_chan_del makes hci_conn_put, also for a2mp channel. The behavior is
> the same for fixed and normal channels.

And when does l2cap_chan_del get called for a fixed channel?  The 
fixed channel must not do an hci_conn_hold so the ACL is allowed to 
close when all dynamic L2CAP channels have closed.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

