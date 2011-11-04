Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Nov 2011 15:25:09 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Gustavo Padovan <padovan@profusion.mobi>,
    Szymon Janc <szymon.janc@tieto.com>, linux-bluetooth@vger.kernel.org,
    ulrik.lauren@stericsson.com, kanak.gupta@stericsson.com
Subject: Re: [PATCH 2/2] Bluetooth: Add ability to force local busy condition
 on L2CAP ERTM
In-Reply-To: <1320441040.15441.303.camel@aeonflux>
Message-ID: <alpine.DEB.2.02.1111041513330.11981@mathewm-linux>
References: <1320332745-21750-1-git-send-email-szymon.janc@tieto.com>  <1320332745-21750-2-git-send-email-szymon.janc@tieto.com>  <20111104171518.GD6171@joana> <1320441040.15441.303.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


Hi everyone -

On Fri, 4 Nov 2011, Marcel Holtmann wrote:

> Hi Gustavo,
>
>>> This is required to pass PTS TP/ERM/BV-07-C (Send S-Frame [RNR]).
>>>
>>> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
>>> ---
>>>  net/bluetooth/l2cap_core.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
>>>  1 files changed, 42 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>> index 9dcbf3d..6202009 100644
>>> --- a/net/bluetooth/l2cap_core.c
>>> +++ b/net/bluetooth/l2cap_core.c
>>> @@ -59,6 +59,8 @@
>>>  int disable_ertm;
>>>  int enable_hs;
>>>
>>> +static int force_local_busy;
>>> +
>>>  static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
>>>  static u8 l2cap_fixed_chan[8] = { 0x02, };
>>>
>>> @@ -3522,7 +3524,7 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
>>>  	if (chan->mode == L2CAP_MODE_ERTM) {
>>>  		if (busy)
>>>  			l2cap_ertm_enter_local_busy(chan);
>>> -		else
>>> +		else if (!force_local_busy)
>>>  			l2cap_ertm_exit_local_busy(chan);
>>
>> NACK on this. I don't wanna move code with the specific purpose of pass a PTS
>> test into the tree. This kinda of thing can survive outside of the tree.
>
> actually it can not life outside the tree. We need to be able to pass
> the PTS test cases with an upstream source.
>
> However instead of hacking this in, what is the actual test case details
> here that we need to have support for?

ERTM will send an RNR when the socket receive buffer fills up.  For 
this test case, it works to just set the SO_RCVBUF sockopt to 
a small enough value that the recv buffer fills before the transmit 
window does - no kernel changes required.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
