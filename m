Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Oct 2012 10:56:05 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
    sunnyk@codeaurora.org
Subject: Re: [PATCH 09/19] Bluetooth: Move channel response
In-Reply-To: <1350325792.26318.13.camel@aeonflux>
Message-ID: <alpine.DEB.2.02.1210161034570.13129@mathewm-linux>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>  <1350315248-7690-10-git-send-email-mathewm@codeaurora.org> <1350325792.26318.13.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel -

On Mon, 15 Oct 2012, Marcel Holtmann wrote:

> Hi Mat,
>
>> The move response command includes a result code indicationg
>> "pending", "success", or "failure" status.  A pending result is
>> received when the remote address is still setting up a physical link,
>> and will be followed by success or failure.  On success, logical link
>> setup will proceed.  On failure, the move is stopped.  The receiver of
>> a move channel response must always follow up by sending a move
>> channel confirm command.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/l2cap.h |   2 +
>>  net/bluetooth/l2cap_core.c    | 137 +++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 137 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 6d3615e..b4c3c65 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -52,6 +52,8 @@
>>  #define L2CAP_ENC_TIMEOUT		msecs_to_jiffies(5000)
>>  #define L2CAP_CONN_TIMEOUT		msecs_to_jiffies(40000)
>>  #define L2CAP_INFO_TIMEOUT		msecs_to_jiffies(4000)
>> +#define L2CAP_MOVE_TIMEOUT		msecs_to_jiffies(4000)
>> +#define L2CAP_MOVE_ERTX_TIMEOUT		msecs_to_jiffies(60000)
>>
>>  #define L2CAP_A2MP_DEFAULT_MTU		670
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index ef744a9..c687cc1 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -4221,6 +4221,13 @@ static void l2cap_send_move_chan_cfm_rsp(struct l2cap_conn *conn, u8 ident,
>>  	l2cap_send_cmd(conn, ident, L2CAP_MOVE_CHAN_CFM_RSP, sizeof(rsp), &rsp);
>>  }
>>
>> +static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
>> +			      u8 status)
>> +{
>> +	/* Placeholder */
>> +	return;
>> +}
>> +
>>  static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
>>  					 struct l2cap_cmd_hdr *cmd,
>>  					 u16 cmd_len, void *data)
>> @@ -4317,6 +4324,7 @@ static inline int l2cap_move_channel_rsp(struct l2cap_conn *conn,
>>  					 u16 cmd_len, void *data)
>>  {
>>  	struct l2cap_move_chan_rsp *rsp = data;
>> +	struct l2cap_chan *chan = NULL;
>
> do we need the = NULL assignment here?
>
>>  	u16 icid, result;
>>
>>  	if (cmd_len != sizeof(*rsp))
>> @@ -4327,8 +4335,133 @@ static inline int l2cap_move_channel_rsp(struct l2cap_conn *conn,
>>
>>  	BT_DBG("icid 0x%4.4x, result 0x%4.4x", icid, result);
>>
>> -	/* Placeholder: Always unconfirmed */
>> -	l2cap_send_move_chan_cfm(conn, NULL, icid, L2CAP_MC_UNCONFIRMED);
>> +	switch (result) {
>> +	case L2CAP_MR_SUCCESS:
>> +	case L2CAP_MR_PEND:
>> +		chan = l2cap_get_chan_by_scid(conn, icid);
>> +		if (!chan) {
>> +			l2cap_send_move_chan_cfm(conn, NULL, icid,
>> +						 L2CAP_MC_UNCONFIRMED);
>> +			break;
>> +		}
>> +
>> +		__clear_chan_timer(chan);
>> +		if (result == L2CAP_MR_PEND)
>> +			__set_chan_timer(chan, L2CAP_MOVE_ERTX_TIMEOUT);
>> +
>> +		if (chan->move_state == L2CAP_MOVE_WAIT_LOGICAL_COMP) {
>> +			/* Move confirm will be sent when logical link
>> +			 * is complete.
>> +			 */
>> +			chan->move_state = L2CAP_MOVE_WAIT_LOGICAL_CFM;
>> +		} else if (chan->move_state == L2CAP_MOVE_WAIT_RSP_SUCCESS) {
>> +			if (result == L2CAP_MR_PEND) {
>> +				break;
>> +			} else if (test_bit(CONN_LOCAL_BUSY,
>> +					    &chan->conn_state)) {
>> +				chan->move_state = L2CAP_MOVE_WAIT_LOCAL_BUSY;
>> +			} else {
>> +				/* Logical link is up or moving to BR/EDR,
>> +				 * proceed with move */
>> +				chan->move_state = L2CAP_MOVE_WAIT_CONFIRM_RSP;
>> +				l2cap_send_move_chan_cfm(conn, chan, chan->scid,
>> +							 L2CAP_MC_CONFIRMED);
>> +				__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
>> +			}
>> +		} else if (chan->move_state == L2CAP_MOVE_WAIT_RSP) {
>> +			struct hci_chan *hchan = NULL;
>> +			/* Moving to AMP */
>> +			if (result == L2CAP_MR_SUCCESS) {
>> +				/* Remote is ready, send confirm immediately
>> +				 * after logical link is ready
>> +				 */
>> +				chan->move_state = L2CAP_MOVE_WAIT_LOGICAL_CFM;
>> +			} else {
>> +				/* Both logical link and move success
>> +				 * are required to confirm
>> +				 */
>> +				chan->move_state = L2CAP_MOVE_WAIT_LOGICAL_COMP;
>> +			}
>> +
>> +			/* Placeholder - get hci_chan for logical link */
>> +			if (!hchan) {
>> +				/* Logical link not available */
>> +				l2cap_send_move_chan_cfm(conn, chan, chan->scid,
>> +							 L2CAP_MC_UNCONFIRMED);
>> +				break;
>> +			}
>> +
>> +			/* If the logical link is not yet connected, do not
>> +			 * send confirmation.
>> +			 */
>> +			if (hchan->state != BT_CONNECTED)
>> +				break;
>> +
>> +			/* Logical link is already ready to go */
>> +
>> +			chan->hs_hcon = hchan->conn;
>> +			chan->hs_hcon->l2cap_data = chan->conn;
>> +
>> +			if (result == L2CAP_MR_SUCCESS) {
>> +				/* Can confirm now */
>> +				l2cap_send_move_chan_cfm(conn, chan, chan->scid,
>> +							 L2CAP_MC_CONFIRMED);
>> +			} else {
>> +				/* Now only need move success
>> +				 * to confirm
>> +				 */
>> +				chan->move_state = L2CAP_MOVE_WAIT_RSP_SUCCESS;
>> +			}
>> +
>> +			l2cap_logical_cfm(chan, hchan, L2CAP_MR_SUCCESS);
>> +		} else {
>> +			/* Any other amp move state means the move failed. */
>> +			chan->move_id = chan->local_amp_id;
>> +			chan->move_state = L2CAP_MOVE_STABLE;
>> +			l2cap_move_revert(chan);
>> +			chan->move_role = L2CAP_MOVE_ROLE_NONE;
>> +			l2cap_send_move_chan_cfm(conn, chan, chan->scid,
>> +						L2CAP_MC_UNCONFIRMED);
>> +			__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
>> +		}
>> +		break;
>> +	default:
>> +		/* Failed (including collision case) */
>> +		mutex_lock(&conn->chan_lock);
>> +		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
>> +		if (chan)
>> +			l2cap_chan_lock(chan);
>> +		mutex_unlock(&conn->chan_lock);
>
> Don't we have a function for this?
>

It was unused, so I submitted a patch to remove it earlier this year. 
:)

I'll add it back in.

>> +
>> +		if (!chan) {
>> +			/* Could not locate channel, icid is best guess */
>> +			l2cap_send_move_chan_cfm(conn, NULL, icid,
>> +						 L2CAP_MC_UNCONFIRMED);
>> +			break;
>> +		}
>> +
>> +		__clear_chan_timer(chan);
>> +
>> +		if (chan->move_role == L2CAP_MOVE_ROLE_INITIATOR) {
>> +			if (result == L2CAP_MR_COLLISION) {
>> +				chan->move_role = L2CAP_MOVE_ROLE_RESPONDER;
>> +			} else {
>> +				/* Cleanup - cancel move */
>> +				chan->move_id = chan->local_amp_id;
>> +				chan->move_state = L2CAP_MOVE_STABLE;
>> +				l2cap_move_revert(chan);
>> +				chan->move_role = L2CAP_MOVE_ROLE_NONE;
>> +			}
>> +		}
>> +
>> +		l2cap_send_move_chan_cfm(conn, chan, chan->scid,
>> +					 L2CAP_MC_UNCONFIRMED);
>> +		__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
>> +		break;
>> +	}
>> +
>> +	if (chan)
>> +		l2cap_chan_unlock(chan);
>
> I rather prefer that we unlock in the case statements. And not a global
> one. And we might have to split out the case statements into separate
> functions for readability.

Ok, I'll make separate functions.

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
