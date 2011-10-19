Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Oct 2011 13:53:49 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Subject: Re: [PATCHv2 5/9] Bluetooth: Add signal handlers for channel
 creation
In-Reply-To: <1319050958.15441.165.camel@aeonflux>
Message-ID: <alpine.DEB.2.02.1110191340400.1976@mathewm-linux>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>  <1319046247-3391-6-git-send-email-mathewm@codeaurora.org> <1319050958.15441.165.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Wed, 19 Oct 2011, Marcel Holtmann wrote:

> Hi Mat,
>
>> Handle both "create channel request" and "create channel response".
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap_core.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 45 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index bda6da7..67f0ab6 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -3044,6 +3044,43 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
>>  	return 0;
>>  }
>>
>> +static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
>> +					struct l2cap_cmd_hdr *cmd, u8 *data)
>
> so I just question myself why we keep doing u8 *data here and not just
> fix everything to be a void *data.
>
>> +{
>> +	struct l2cap_create_chan_req *req =
>> +		(struct l2cap_create_chan_req *) data;
>
> Then these casting stuff would go away. And I bet it is just some
> leftover from the original L2CAP code.
>
> Or does anybody else have an idea why we keep on insisting on u8 *data?

I assume it traces back to "u8 *data = skb->data;" in 
l2cap_sig_channel(), but I see no reason to hang on to that type 
information either if it's just going to be cast away.

I'll change it for these new signal handlers.  The others can be in a 
separate cleanup patch.

>> +	struct l2cap_create_chan_rsp rsp;
>> +	u16 psm, scid;
>
> I think we might need to have a length check here first to ensure that
> the header packet is really full present.

Will add a length check.

>> +
>> +	psm = le16_to_cpu(req->psm);
>> +	scid = le16_to_cpu(req->scid);
>
> Otherwise this just accesses some random memory.
>
>> +
>> +	BT_DBG("psm %d, scid %d, amp_id %d", (int) psm, (int) scid,
>> +		(int) req->amp_id);
>
> Why are we casting to (int) here?

I'll remove them.

>> +
>> +	if (!enable_hs)
>> +		return -EINVAL;
>> +
>> +	/* Placeholder: Always reject */
>> +	rsp.dcid = 0;
>> +	rsp.scid = cpu_to_le16(scid);
>> +	rsp.result = L2CAP_CR_NO_MEM;
>> +	rsp.status = L2CAP_CS_NO_INFO;
>> +
>> +	l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
>> +		       sizeof(rsp), &rsp);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int l2cap_create_channel_rsp(struct l2cap_conn *conn,
>> +					struct l2cap_cmd_hdr *cmd, u8 *data)
>> +{
>> +	BT_DBG("conn %p", conn);
>> +
>> +	return l2cap_connect_rsp(conn, cmd, data);
>> +}
>> +
>>  static inline int l2cap_check_conn_param(u16 min, u16 max, u16 latency,
>>  							u16 to_multiplier)
>>  {
>> @@ -3156,6 +3193,14 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
>>  		err = l2cap_information_rsp(conn, cmd, data);
>>  		break;
>>
>> +	case L2CAP_CREATE_CHAN_REQ:
>> +		err = l2cap_create_channel_req(conn, cmd, data);
>> +		break;
>> +
>> +	case L2CAP_CREATE_CHAN_RSP:
>> +		err = l2cap_create_channel_rsp(conn, cmd, data);
>> +		break;
>> +
>>  	default:
>>  		BT_ERR("Unknown BR/EDR signaling command 0x%2.2x", cmd->code);
>>  		err = -EINVAL;


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

