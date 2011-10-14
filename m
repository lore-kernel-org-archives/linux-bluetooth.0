Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 16:19:53 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <padovan@profusion.mobi>
cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com
Subject: Re: [PATCH 9/9] Bluetooth: Add signal handlers for channel moves
In-Reply-To: <20111014184650.GD30989@joana>
Message-ID: <alpine.DEB.2.02.1110141618420.9993@mathewm-linux>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org> <1318543247-27130-10-git-send-email-mathewm@codeaurora.org> <20111014184650.GD30989@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Fri, 14 Oct 2011, Gustavo Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2011-10-13 15:00:47 -0700]:
>
>> AMP channels can be moved between BR/EDR and AMP controllers using a
>> sequence of signals. Every attempted channel move involves a series of
>> four signals:
>>
>>    Move Initiator                 Move Responder
>>         |                                 |
>>         |       Move Channel Request      |
>>         |  ---------------------------->  |
>>         |                                 |
>>         |       Move Channel Response     |
>>         |  <----------------------------  |
>>         |                                 |
>>         |       Move Channel Confirm      |
>>         |  ---------------------------->  |
>>         |                                 |
>>         |  Move Channel Confirm Response  |
>> 	|  <----------------------------  |
>>
>> All four signals are sent even if the move fails.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap_core.c |  123 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 123 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index e38258b..ba64bab 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -2957,6 +2957,112 @@ static inline int l2cap_create_channel_rsp(struct l2cap_conn *conn,
>>  	return l2cap_connect_rsp(conn, cmd, data);
>>  }
>>
>> +static void l2cap_send_move_chan_rsp(struct l2cap_conn *conn, u8 ident,
>> +				u16 icid, u16 result)
>> +{
>> +	struct l2cap_move_chan_rsp rsp;
>> +
>> +	BT_DBG("icid %d, result %d", (int) icid, (int) result);
>> +
>> +	rsp.icid = cpu_to_le16(icid);
>> +	rsp.result = cpu_to_le16(result);
>> +
>> +	l2cap_send_cmd(conn, ident, L2CAP_MOVE_CHAN_RSP, sizeof(rsp), &rsp);
>> +}
>> +
>> +static void l2cap_send_move_chan_cfm(struct l2cap_conn *conn,
>> +				struct l2cap_chan *chan, u16 icid, u16 result)
>> +{
>> +	struct l2cap_move_chan_cfm cfm;
>> +	u8 ident;
>> +
>> +	BT_DBG("icid %d, result %d", (int) icid, (int) result);
>> +
>> +	ident = l2cap_get_ident(conn);
>> +	if (chan)
>> +		chan->ident = ident;
>> +
>> +	cfm.icid = cpu_to_le16(icid);
>> +	cfm.result = cpu_to_le16(result);
>> +
>> +	l2cap_send_cmd(conn, ident, L2CAP_MOVE_CHAN_CFM, sizeof(cfm), &cfm);
>> +}
>> +
>> +static void l2cap_send_move_chan_cfm_rsp(struct l2cap_conn *conn, u8 ident,
>> +					u16 icid)
>> +{
>> +	struct l2cap_move_chan_cfm_rsp rsp;
>> +
>> +	BT_DBG("icid %d", (int) icid);
>> +
>> +	rsp.icid = cpu_to_le16(icid);
>> +	l2cap_send_cmd(conn, ident, L2CAP_MOVE_CHAN_CFM_RSP, sizeof(rsp), &rsp);
>> +}
>> +
>> +static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
>> +					struct l2cap_cmd_hdr *cmd, u8 *data)
>> +{
>> +	struct l2cap_move_chan_req *req = (struct l2cap_move_chan_req *) data;
>> +	u16 icid = 0;
>> +	u16 result = L2CAP_MOVE_CHAN_REFUSED_NOT_ALLOWED;
>> +
>> +	icid = le16_to_cpu(req->icid);
>> +
>> +	BT_DBG("icid %d, dest_amp_id %d", (int) icid, (int) req->dest_amp_id);
>> +
>> +	/* Placeholder: Always refuse */
>> +	l2cap_send_move_chan_rsp(conn, cmd->ident, icid, result);
>> +
>> +	return 0;
>> +}
>
> It's a good idea protect the move channel request with enable_hs.

Yes, I'll require enable_hs to have the move channel do anything. 
When enable_hs is false, it seems like it should return a 
L2CAP_MOVE_CHAN_REFUSED_NOT_ALLOWED response like it does now.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

