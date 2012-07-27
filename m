Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Jul 2012 09:54:03 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 06/21] Bluetooth: Channel move request handling
In-Reply-To: <20120726135924.GC2686@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1207270758080.6052@mathewm-linux>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org> <1343260274-11953-7-git-send-email-mathewm@codeaurora.org> <20120726135924.GC2686@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei -

On Thu, 26 Jul 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Wed, Jul 25, 2012 at 04:50:58PM -0700, Mat Martineau wrote:
>
> ...
>
>>  static void l2cap_chan_ready(struct l2cap_chan *chan)
>>  {
>> @@ -4117,7 +4148,67 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
>>
>>  	chan = l2cap_get_chan_by_dcid(conn, icid);
>>
>> -	/* Placeholder: Always refuse */
>> +	if (!chan)
>> +		goto send_move_response;
>> +
>> +	if (chan->scid < L2CAP_CID_DYN_START || (chan->mode != L2CAP_MODE_ERTM
>> +	    && chan->mode != L2CAP_MODE_STREAMING))
>
> I think if we add here line below the code would be more understandable
> and following the same style.
> 		"result = L2CAP_MR_NOT_ALLOWED;"
>

Ok.

>> +		goto send_move_response;
>> +
>> +	if (chan->chan_id == req->dest_amp_id) {
>> +		result = L2CAP_MR_SAME_ID;
>> +		goto send_move_response;
>> +	}
>> +
>> +	if (req->dest_amp_id) {
>> +		struct hci_dev *hdev;
>> +		hdev = hci_dev_get(req->dest_amp_id);
>> +		if (!hdev || !test_bit(HCI_UP, &hdev->flags)) {
>
> Again here we shall check dev_type.
>

Right.

>> +			if (hdev)
>> +				hci_dev_put(hdev);
>> +
>> +			result = L2CAP_MR_BAD_ID;
>> +			goto send_move_response;
>> +		}
>> +		hci_dev_put(hdev);
>> +	}
>> +
>> +	if (((chan->move_state != L2CAP_MOVE_STABLE &&
>> +	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE) ||
>> +	    chan->move_role != L2CAP_MOVE_ROLE_NONE) &&
>> +	    bacmp(conn->src, conn->dst) > 0) {
>> +		result = L2CAP_MR_COLLISION;
>> +		goto send_move_response;
>> +	}
>> +
>> +	if (chan->chan_policy == BT_CHANNEL_POLICY_BREDR_ONLY) {
>> +		result = L2CAP_MR_NOT_ALLOWED;
>> +		goto send_move_response;
>> +	}
>> +
>> +	chan->move_cmd_ident = cmd->ident;
>
> BTW: Why do we handle ident in a special way for channel move?

At the time I wrote the code, I thought that chan->ident was only used 
to store idents of sent requests, not received requests.  But it does 
look like it is also used for storing received idents for use in 
sending responses.  chan->ident could be used as long as move 
collisions are handled correctly (where a move request is received 
when a move response is expected).

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
