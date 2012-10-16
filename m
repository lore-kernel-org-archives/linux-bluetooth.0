Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Oct 2012 16:00:02 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
    sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCH 07/19] Bluetooth: Add move channel confirm handling
In-Reply-To: <20121016102726.GG14036@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1210161557330.13129@mathewm-linux>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org> <1350315248-7690-8-git-send-email-mathewm@codeaurora.org> <20121016102726.GG14036@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


On Tue, 16 Oct 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Mon, Oct 15, 2012 at 08:33:56AM -0700, Mat Martineau wrote:
>> After sending a move channel response, a move responder waits for a
>> move channel confirm command.  If the received command has a
>> "confirmed" result the move is proceeding, and "unconfirmed" means the
>> move has failed and the channel will not change controllers.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap_core.c | 70 ++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 67 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index aab7f79..ef744a9 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -1030,6 +1030,42 @@ static void l2cap_move_setup(struct l2cap_chan *chan)
>>  	set_bit(CONN_REMOTE_BUSY, &chan->conn_state);
>>  }
>>
>> +static void l2cap_move_success(struct l2cap_chan *chan)
>> +{
>> +	BT_DBG("chan %p", chan);
>> +
>> +	if (chan->mode != L2CAP_MODE_ERTM)
>> +		return;
>> +
>> +	switch (chan->move_role) {
>> +	case L2CAP_MOVE_ROLE_INITIATOR:
>> +		l2cap_tx(chan, NULL, NULL, L2CAP_EV_EXPLICIT_POLL);
>> +		chan->rx_state = L2CAP_RX_STATE_WAIT_F;
>> +		break;
>> +	case L2CAP_MOVE_ROLE_RESPONDER:
>> +		chan->rx_state = L2CAP_RX_STATE_WAIT_P;
>> +		break;
>> +	}
>> +}
>> +
>> +static void l2cap_move_revert(struct l2cap_chan *chan)
>> +{
>> +	BT_DBG("chan %p", chan);
>> +
>> +	if (chan->mode != L2CAP_MODE_ERTM)
>> +		return;
>
> Not sure that all those function need to check for ERTM. Can it be done
> before calling them (for example in l2cap_move_channel_confirm)?

I prefer to leave the checks where they are for ERTM.  Either 
streaming mode or ERTM channels may be moved, and these functions need 
to do something different for ERTM and streaming mode.  These are not 
redundant mode checks.

Regards,

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
