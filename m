Return-Path: <cyrus@holtmann.org>
Message-ID: <4D66D651.7070403@codeaurora.org>
Date: Thu, 24 Feb 2011 14:06:09 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Bruna Moreira <bruna.moreira@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix MTU value used on MTU exchange response
References: <1298583454-18227-1-git-send-email-bruna.moreira@openbossa.org>	<4D66D107.9000305@codeaurora.org> <AANLkTi=T1NqchZ=yyGDPwdC2GjgN=DR3Fn_ObhwjPe6c@mail.gmail.com>
In-Reply-To: <AANLkTi=T1NqchZ=yyGDPwdC2GjgN=DR3Fn_ObhwjPe6c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On 2/24/2011 1:58 PM, Bruna Moreira wrote:
> Hi Brian,
>
> On 2/24/11, Brian Gix<bgix@codeaurora.org>  wrote:
>> On 2/24/2011 1:37 PM, Bruna Moreira wrote:
>>> The new MTU value only should be applied in server side after sending
>>> the ATT_MTU_RESP so encode the response using the old MTU value.
>>> ---
>>>    src/attrib-server.c |    4 +++-
>>>    1 files changed, 3 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/src/attrib-server.c b/src/attrib-server.c
>>> index 62c10f4..9de4c81 100644
>>> --- a/src/attrib-server.c
>>> +++ b/src/attrib-server.c
>>> @@ -773,9 +773,11 @@ static uint16_t write_value(struct gatt_channel
>>> *channel, uint16_t handle,
>>>    static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
>>>    		uint8_t *pdu, int len)
>>>    {
>>> +	guint old_mtu = channel->mtu;
>>> +
>>>    	channel->mtu = MIN(mtu, channel->mtu);
>>>
>>> -	return enc_mtu_resp(channel->mtu, pdu, len);
>>> +	return enc_mtu_resp(old_mtu, pdu, len);
>>>    }
>>>
>>>    static void channel_disconnect(void *user_data)
>>
>>
>> I don't think this is correct.  The change has us replying with our old
>> MTU.  What part of the specification justifies this change?
>
>  From "3.4.2.2 Exchange MTU Response" section:
>
> "This ATT_MTU value shall be applied in the server after this response has
> been sent and before any other attribute protocol PDU is sent."
>
> BR,


OK,  I re-read the MTU section, and agree that your reading appears to 
be correct.  I wonder if we should also be testing for the default 
(minimum) MTUs of 23 and 48 for LE and BR/EDR respectively here as well, 
per:

"If either Client Rx MTU or Service Rx MTU are incorrectly less than the 
default ATT_MTU, then the ATT_MTU shall not be changed and the ATT_MTU 
shall be the default ATT_MTU."

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
