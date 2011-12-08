Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 13:32:33 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
    pkrystad@codeaurora.org
Subject: Re: [PATCH 2/2] Bluetooth: Prevent uninitialized data access in
 L2CAP configuration
In-Reply-To: <1323332979.1965.19.camel@aeonflux>
Message-ID: <alpine.DEB.2.02.1112081056260.3944@mathewm-linux>
References: <1323217407-2490-1-git-send-email-mathewm@codeaurora.org>  <1323217407-2490-3-git-send-email-mathewm@codeaurora.org> <1323332979.1965.19.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


On Thu, 8 Dec 2011, Marcel Holtmann wrote:

> Hi Mat,
>
>> When configuring an ERTM or streaming mode connection, remote devices
>> are expected to send an RFC option in a successful config response.  A
>> misbehaving remote device might not send an RFC option, and the L2CAP
>> code should not access uninitialized data in this case.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap_core.c |   16 +++++++++++++++-
>>  1 files changed, 15 insertions(+), 1 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 5ea94a1..49ae7df 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -2152,7 +2152,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
>>  	void *ptr = req->data;
>>  	int type, olen;
>>  	unsigned long val;
>> -	struct l2cap_conf_rfc rfc;
>> +	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
>>
>>  	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
>>
>> @@ -2205,6 +2205,9 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
>>  			break;
>>  		case L2CAP_MODE_STREAMING:
>>  			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
>> +			break;
>> +		default:
>> +			break;
>
> Adding a BT_ERR here would be a good idea.
>

That default case is expected when dealing with L2CAP_CONF_UNACCEPT 
config responses in basic mode, or when an RFC option is returned with 
basic mode.  I'll just remove this part of the patch, since it is 
valid to omit the "default" case.  Initializing rfc.mode above is the 
important part.

If an expected RFC is missing, we'll see the same behavior as if an 
RFC option with basic mode was received.

>>  		}
>>  	}
>>
>> @@ -2271,6 +2274,14 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
>>  		}
>>  	}
>>
>> +	/* Use sane default values in case a misbehaving remote device
>> +	 * did not send an RFC option.
>> +	 */
>> +	rfc.mode = chan->mode;
>> +	rfc.retrans_timeout = cpu_to_le16(chan->retrans_timeout);
>> +	rfc.monitor_timeout = cpu_to_le16(chan->monitor_timeout);
>> +	rfc.max_pdu_size = cpu_to_le16(chan->mps);
>> +
>>  done:
>>  	switch (rfc.mode) {
>>  	case L2CAP_MODE_ERTM:
>> @@ -2280,6 +2291,9 @@ done:
>>  		break;
>>  	case L2CAP_MODE_STREAMING:
>>  		chan->mps    = le16_to_cpu(rfc.max_pdu_size);
>> +		break;
>> +	default:
>> +		break;
>
> Also adding a BT_ERR seems like the right thing to do.

Ok.

>
> Otherwise patch looks good to me.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
