Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Aug 2010 15:40:52 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
    rshaffer@codeaurora.org
Subject: Re: [PATCH 1/8] Bluetooth: Make sure the L2CAP FCS is only enabled
 for ERTM or streaming.
In-Reply-To: <20100802212014.GB20149@vigoh>
Message-ID: <alpine.DEB.2.00.1008021519430.18432@linux-sea-02>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org> <1280776810-18213-2-git-send-email-mathewm@codeaurora.org> <1280777912.12579.37.camel@localhost.localdomain> <20100802212014.GB20149@vigoh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Gustavo -

On Mon, 2 Aug 2010, Gustavo F. Padovan wrote:

> Hi Mat,
>
> * Marcel Holtmann <marcel@holtmann.org> [2010-08-02 12:38:32 -0700]:
>
>> Hi Mat,
>>
>>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>>> ---
>>>  net/bluetooth/l2cap.c |   12 ++++++++----
>>>  1 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>>> index 9ba1e8e..aed72f2 100644
>>> --- a/net/bluetooth/l2cap.c
>>> +++ b/net/bluetooth/l2cap.c
>>> @@ -3127,8 +3127,10 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>>>  		goto unlock;
>>>
>>>  	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
>>> -		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
>>> -		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
>>> +		if ((l2cap_pi(sk)->mode == L2CAP_MODE_ERTM ||
>>> +			l2cap_pi(sk)->mode == L2CAP_MODE_STREAMING) &&
>>> +			(!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
>>> +			l2cap_pi(sk)->fcs != L2CAP_FCS_NONE))
>>>  			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
>>
>> this becomes unreadable and my brain starts to throw a core dump. So it
>> clearly needs to be put into a helper inline function.
>
> Actually we don't need that, since the code that deals with Basic Mode
> never check  and use the l2cap_pi(sk)->fcs. So we don't care about FCS
> value in the Basic Mode.

There isn't currently any Basic Mode code that triggers this latent 
bug, but I have a patch coming up that does require this fix.

As it stands, getsockopt() on a connected basic mode socket shows FCS 
enabled, so this bug is visible from userspace.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
