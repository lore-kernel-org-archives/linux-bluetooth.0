Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Aug 2010 09:50:35 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
    rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/9] Bluetooth: Fix endianness issue with L2CAP MPS
 configuration.
In-Reply-To: <20100805040018.GG7870@vigoh>
Message-ID: <alpine.DEB.2.00.1008050940430.27235@linux-sea-02>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org> <1280962146-22604-5-git-send-email-mathewm@codeaurora.org> <20100805040018.GG7870@vigoh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Thu, 5 Aug 2010, Gustavo F. Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2010-08-04 15:49:01 -0700]:
>
>> Incoming configuration values must be converted to native CPU order
>> before use.  This fixes a bug where a little-endian MPS value is
>> compared to a native CPU value.  On big-endian processors, this
>> can cause ERTM and streaming mode segmentation to produce PDUs
>> that are larger than the remote stack is expecting, or that would
>> produce fragmented skbs that the current FCS code cannot handle.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap.c |    9 ++++-----
>>  1 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index 920a53f..8cf9569 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -2708,10 +2708,10 @@ done:
>>  		case L2CAP_MODE_ERTM:
>>  			pi->remote_tx_win = rfc.txwin_size;
>>  			pi->remote_max_tx = rfc.max_transmit;
>> -			if (rfc.max_pdu_size > pi->conn->mtu - 10)
>> -				rfc.max_pdu_size = le16_to_cpu(pi->conn->mtu - 10);
>>
>>  			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
>> +			if (pi->remote_mps > pi->conn->mtu - 10)
>> +				pi->remote_mps = pi->conn->mtu - 10;
>
>
> What happened with thte "rfc.max_pdu_size =" attribution. We have the
> send the value to through the RFC option.

You're right - I didn't see that the rfc struct was used for both the 
response and reply.

> So what I do propose here is:
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 0f34e12..11d4405 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2705,7 +2705,7 @@ done:
>                case L2CAP_MODE_ERTM:
>                        pi->remote_tx_win = rfc.txwin_size;
>                        pi->remote_max_tx = rfc.max_transmit;
> -                       if (rfc.max_pdu_size > pi->conn->mtu - 10)
> +                       if (le16_to_cpu(rfc.max_pdu_size) > pi->conn->mtu - 10)
>                                rfc.max_pdu_size = le16_to_cpu(pi->conn->mtu - 10);
>
>                        pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);

Sure.  I'll change it to "cpu_to_le16(pi->conn->mtu - 10)" (even 
though they're functionally equivalent, it is definitely a conversion 
to le16).

> @@ -2723,7 +2723,7 @@ done:
>                        break;
>
>                case L2CAP_MODE_STREAMING:
> -                       if (rfc.max_pdu_size > pi->conn->mtu - 10)
> +                       if (le16_to_cpu(rfc.max_pdu_size) > pi->conn->mtu - 10)
>                                rfc.max_pdu_size = le16_to_cpu(pi->conn->mtu - 10);

Same thing - cpu_to_le16() instead.

>                        pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
>
>
>
>>
>>  			rfc.retrans_timeout =
>>  				le16_to_cpu(L2CAP_DEFAULT_RETRANS_TO);
>> @@ -2726,10 +2726,9 @@ done:
>>  			break;
>>
>>  		case L2CAP_MODE_STREAMING:
>> -			if (rfc.max_pdu_size > pi->conn->mtu - 10)
>> -				rfc.max_pdu_size = le16_to_cpu(pi->conn->mtu - 10);
>> -
>>  			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
>> +			if (pi->remote_mps > pi->conn->mtu - 10)
>> +				pi->remote_mps = pi->conn->mtu - 10;
>>
>>  			pi->conf_state |= L2CAP_CONF_MODE_DONE;



--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
