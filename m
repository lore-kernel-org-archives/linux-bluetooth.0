Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1204250827200.20357@mathewm-linux>
References: <1335342544-17320-1-git-send-email-manojkr.sharma@stericsson.com>
	<1335342544-17320-2-git-send-email-manojkr.sharma@stericsson.com>
	<alpine.DEB.2.02.1204250827200.20357@mathewm-linux>
Date: Wed, 25 Apr 2012 22:59:08 +0530
Message-ID: <CAHH5__642UPTBWB0PsDxb7o-0-yrMkgakWBg6=tuNEAN7Af26g@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Fix retransmission of ERTM packets
From: Manoj Sharma <ursmanoj@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On 4/25/12, Mat Martineau <mathewm@codeaurora.org> wrote:
>
> Hi Manoj -
>
> On Wed, 25 Apr 2012, Manoj wrote:
>
>> State CONN_REJ_ACT of connection is not handled properly.
>> ERTM packets should be transmitted only if bit corresponding to
>> CONN_REJ_ACT in conn_state field is set. Opposite was being
>> done, which has been fixed by this patch.
>
> This is incorrect.  CONN_REJ_ACT maps to "RejActioned" in the ERTM
> spec.  RejActioned means the REJ has already been processed but there
> was an outstanding Poll, and the Final flag should not trigger
> retransmission of iframes.  Please review the spec and let us know if
> you still think there is a problem with CONN_REJ_ACT.
>
Thanks for explaining the exact usage of CONN_REJ_ACT. I had
misunderstood it. After your explanation, I completely agree with the
existing implementation. Therefore my patch can be ignored.

>>
>> Signed-off-by: Manoj <manojkr.sharma@stericsson.com>
>> ---
>> net/bluetooth/l2cap_core.c |    6 +++---
>> 1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index a9319e2..485d374 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -4324,7 +4324,7 @@ expected:
>> 	}
>>
>> 	if (__is_ctrl_final(chan, rx_control)) {
>> -		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
>> +		if (test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
>> 			l2cap_retransmit_frames(chan);
>> 	}
>>
>> @@ -4366,7 +4366,7 @@ static inline void l2cap_data_channel_rrframe(struct
>> l2cap_chan *chan, u32 rx_co
>> 	} else if (__is_ctrl_final(chan, rx_control)) {
>> 		clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
>>
>> -		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
>> +		if (test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
>> 			l2cap_retransmit_frames(chan);
>>
>> 	} else {
>> @@ -4394,7 +4394,7 @@ static inline void
>> l2cap_data_channel_rejframe(struct l2cap_chan *chan, u32 rx_c
>> 	l2cap_drop_acked_frames(chan);
>>
>> 	if (__is_ctrl_final(chan, rx_control)) {
>> -		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
>> +		if (test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
>> 			l2cap_retransmit_frames(chan);
>> 	} else {
>> 		l2cap_retransmit_frames(chan);
>> --
>> 1.6.6.1
>>
>
> Regards,
> --
> Mat Martineau
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Regards,
 --
Manoj Sharma
Employee of ST Ericsson
