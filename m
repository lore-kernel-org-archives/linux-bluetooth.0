Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Aug 2010 09:13:51 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
    rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 8/8] Bluetooth: Use 3-DH5 payload size for default ERTM
 max PDU size.
In-Reply-To: <1280778508.12579.48.camel@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1008030908480.19861@linux-sea-02>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>  <1280776810-18213-9-git-send-email-mathewm@codeaurora.org> <1280778508.12579.48.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Marcel,

On Mon, 2 Aug 2010, Marcel Holtmann wrote:

> Hi Mat,
>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/l2cap.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> this should have a commit message with technical details to explain why
> it is a good idea.
>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 16e412f..93aba17 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -35,7 +35,7 @@
>>  #define L2CAP_DEFAULT_MAX_TX		3
>>  #define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
>>  #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
>> -#define L2CAP_DEFAULT_MAX_PDU_SIZE	672
>> +#define L2CAP_DEFAULT_MAX_PDU_SIZE	1011    /* Sized for 3-DH5 packet */
>>  #define L2CAP_DEFAULT_ACK_TO		200
>>  #define L2CAP_LOCAL_BUSY_TRIES		12
>
> Also the default PDU size for basic mode should stay with 672. And only
> for ERTM move it to 1010. Is this ensured?
>
> And then again here. Is that explained in the commit message?

It is ensured that the max PDU size is only used for ERTM and 
streaming mode.  The default MTU for basic mode and ERTM/streaming 
remains unchanged.

I will update the commit message to fully describe this.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
