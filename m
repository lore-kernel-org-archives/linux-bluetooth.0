Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Aug 2010 09:27:50 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
    rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/9] Bluetooth: Only enable for L2CAP FCS for ERTM or
 streaming.
In-Reply-To: <20100805033218.GE7870@vigoh>
Message-ID: <alpine.DEB.2.00.1008050903320.27235@linux-sea-02>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org> <1280962146-22604-2-git-send-email-mathewm@codeaurora.org> <20100805033218.GE7870@vigoh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Thu, 5 Aug 2010, Gustavo F. Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2010-08-04 15:48:58 -0700]:
>
>> This fixes a bug which caused the FCS setting to show L2CAP_FCS_CRC16
>> with L2CAP modes other than ERTM or streaming.  At present, this only
>> affects the FCS value shown with getsockopt() for basic mode.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap.c |   17 +++++++++++++----
>>  1 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index 9ba1e8e..a2706d9 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -3063,6 +3063,17 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
>>  	return 0;
>>  }
>>
>> +static inline int l2cap_fcs_needed(struct l2cap_pinfo *pi)
>> +{
>> +	if (pi->mode != L2CAP_MODE_ERTM && pi->mode != L2CAP_MODE_STREAMING)
>> +		return 0;
>> +	else {
>> +		/* FCS is enabled if one or both sides request it. */
>> +		return !(pi->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
>> +			pi->fcs == L2CAP_FCS_CRC16;
>> +	}
>
> Get ride of the else, just put the return !(pi->....

Ok.

> Also I would like to see the use case for the check for the ERTM and
> Streaming before merge this patch. ;)

I have a patch modifying l2cap_skbuff_fromiovec() that allows ERTM 
PDUs to be longer than the HCI MTU (some USB BT dongles only have a 
310 byte HCI MTU).  That function has to allocate space for the FCS in 
the final HCI continuation fragment, and therefore checks to see if 
FCS is enabled.  When I first did this, it was not obvious that 
pi->fcs could be L2CAP_FCS_CRC16 even when the FCS is not in use.

I hope you can agree that this patch makes the meaning of pi->fcs more 
intuitive, and eliminates the need to check both pi->fcs and pi->mode 
to really determine if the FCS is in use.  Depending on using pi->fcs 
only in ERTM code paths makes the code more fragile.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
