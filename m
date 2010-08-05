Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Aug 2010 08:53:57 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/9] Bluetooth: Change default ERTM retransmit timeout.
In-Reply-To: <20100805032903.GD7870@vigoh>
Message-ID: <alpine.DEB.2.00.1008050839590.27235@linux-sea-02>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org> <1280962146-22604-3-git-send-email-mathewm@codeaurora.org> <20100805032903.GD7870@vigoh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Gustavo -

On Thu, 5 Aug 2010, Gustavo F. Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2010-08-04 15:48:59 -0700]:
>
>> The L2CAP spec requires that the ERTM retransmit timeout be at least 2
>> seconds for BR/EDR connections.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/l2cap.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 636724b..16e412f 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -33,7 +33,7 @@
>>  #define L2CAP_DEFAULT_FLUSH_TO		0xffff
>>  #define L2CAP_DEFAULT_TX_WINDOW		63
>>  #define L2CAP_DEFAULT_MAX_TX		3
>> -#define L2CAP_DEFAULT_RETRANS_TO	1000    /* 1 second */
>> +#define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
>>  #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
>>  #define L2CAP_DEFAULT_MAX_PDU_SIZE	672
>>  #define L2CAP_DEFAULT_ACK_TO		200
>
> The spec says that a 2 seconds retransmission timeout shall be used
> after a move channel operation in a BR/EDR radio. (section 8.6.2.3)
> For a normal ACL connection the default value is 1 second(section
> 8.6.2.1), so I prefer to keep L2CAP_DEFAULT_RETRANS_TO set to 1000.

Section 8.6.2.1 reads:

"If a flush timeout does not exist on the BR/EDR link for the channel 
using Enhanced Retransmission mode, then the value for the 
Retransmission timeout shall be at least two seconds..."

That is followed by the rule for channels with a flush timeout, which 
requires the retrans timeout to be the larger of flushTO * 3 or 1 
second.  Since BlueZ does not configure the flush timeout for BR/EDR 
links, the 2 second rule applies.

I experienced interoperability problems with ERTM on the BM3 Bluetooth 
stack and the 1-second timeout - the one second timeout was not long 
enough to allow for all the transmit buffering in BlueZ (all frames to 
fill the TX window are immediately pushed to the HCI TX queue).  I'd 
like to discuss changing the way ERTM queues data to HCI, but that's a 
separate topic - maybe something to chat about in Boston.


Regards,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
