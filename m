Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Jul 2011 10:45:53 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] Bluetooth: Check earlier for L2CAP ERTM frames to
 drop
In-Reply-To: <20110701191348.GF23683@joana>
Message-ID: <alpine.DEB.2.02.1107051042440.19392@mathewm-linux>
References: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org> <1309383324-12002-2-git-send-email-mathewm@codeaurora.org> <20110630212419.GF25602@joana> <alpine.DEB.2.02.1106301449130.18354@mathewm-linux> <20110701191348.GF23683@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Fri, 1 Jul 2011, Gustavo F. Padovan wrote:

> * Mat Martineau <mathewm@codeaurora.org> [2011-06-30 16:36:01 -0700]:
>
>>
>> Hi Gustavo -
>>
>> On Thu, 30 Jun 2011, Gustavo F. Padovan wrote:
>>
>>> * Mat Martineau <mathewm@codeaurora.org> [2011-06-29 14:35:19 -0700]:
>>>
>>>> Even when the received tx_seq is expected, the frame still needs to be
>>>> dropped if the TX window is exceeded or the receiver is in the local
>>>> busy state.
>>>
>>> The check doesn't mean that TX window is exceeded, it means that we have an
>>> invalid tx_seq and connection should be closed. I don't see the point in
>>> moving the expected check to after this one.
>>> About the local busy check. Is it worth to drop expected frames when on local
>>> busy? What are the advantages/disadvantages? Drop will trigger SREJ while
>>> Store will press the buffer. Do you have measures to prove this?
>>
>>
>> It's possible for expected_tx_seq to be invalid if the tx window is
>> full.  Therefore it is important to check for an invalid tx_seq
>> before checking if it is expected.
>>
>>
>> Dropping frames during local busy is a good idea because:
>>
>>  * Queuing frames during local busy ignores the receive buffer
>> limits requested by the application with SO_RCVBUF.  This problem
>> gets worse with extended window sizes, where the busy_q could be
>> quite large
>>  * ERTM senders are not supposed to send frames during local busy
>> anyway
>>  * The spec allows for packets to be dropped in local busy (look for
>> "StoreOrIgnore")
>>
>> It's the memory that's most important, though. Dropping all incoming
>> iframes during local busy is a simple way to keep data buffer size
>> bounded while still allowing for larger tx windows.
>>
>> If the application can't keep up with the data rate and is
>> triggering local busy, throughput isn't going to be improved
>> significatnly by queuing those frames during local busy.
>
> You convinced me, applied! Thanks.


Thanks for applying this!  Have you had a chance to consider the other 
local busy changes for recv_cb?


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

