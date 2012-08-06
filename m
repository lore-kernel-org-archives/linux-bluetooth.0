Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Aug 2012 09:33:50 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 06/21] Bluetooth: Channel move request handling
In-Reply-To: <20120806084435.GA2819@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1208060904500.25736@mathewm-linux>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org> <1343260274-11953-7-git-send-email-mathewm@codeaurora.org> <20120726135924.GC2686@aemeltch-MOBL1> <alpine.DEB.2.02.1207270758080.6052@mathewm-linux>
 <20120806084435.GA2819@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Mon, 6 Aug 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Fri, Jul 27, 2012 at 09:54:03AM -0700, Mat Martineau wrote:
>
> ...
>
>>>> +	if (chan->chan_policy == BT_CHANNEL_POLICY_BREDR_ONLY) {
>>>> +		result = L2CAP_MR_NOT_ALLOWED;
>>>> +		goto send_move_response;
>>>> +	}
>>>> +
>>>> +	chan->move_cmd_ident = cmd->ident;
>>>
>>> BTW: Why do we handle ident in a special way for channel move?
>>
>> At the time I wrote the code, I thought that chan->ident was only
>> used to store idents of sent requests, not received requests.  But
>> it does look like it is also used for storing received idents for
>> use in sending responses.  chan->ident could be used as long as move
>> collisions are handled correctly (where a move request is received
>> when a move response is expected).
>
> So can we use chan->ident instead of chan->move_cmd_ident? Is the channel
> move somehow different from other L2CAP request / response sequence?

Yes, chan->ident can be used.  It doesn't seem necessary to assign 
chan->ident when sending a move request, just when receiving one.

Connect and create requests also assign chan->ident when they are 
sent, but I'm not sure why.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

