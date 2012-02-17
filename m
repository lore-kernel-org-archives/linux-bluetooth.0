Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 11:11:02 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: Szymon Janc <szymon.janc@tieto.com>
cc: Gustavo Padovan <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"kanak.gupta@stericsson.com" <kanak.gupta@stericsson.com>
Subject: Re: [PATCH] Bluetooth: Drop frames without F-bit set when in WAIT_F
 state
In-Reply-To: <alpine.DEB.2.02.1202151037510.432@mathewm-linux>
Message-ID: <alpine.DEB.2.02.1202170917220.7686@mathewm-linux>
References: <1329227796-22609-1-git-send-email-szymon.janc@tieto.com> <20120214154141.GA14503@joana> <201202151034.53555.szymon.janc@tieto.com> <alpine.DEB.2.02.1202151037510.432@mathewm-linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Szymon -

On Wed, 15 Feb 2012, Mat Martineau wrote:

>
> Szymon -
>
> On Wed, 15 Feb 2012, Szymon Janc wrote:
>
>>> Hi Szymon,
>> 
>> Hi Gustavo,
>> 
>> I was pretty sure this patch will trigger some comments :-)
>> 
>>>> +	/* drop frame without F-bit set when in WAIT_F state */
>>>> +	if (test_bit(CONN_WAIT_F, &chan->conn_state) &&
>>>> +			!__is_ctrl_final(chan, control))
>>>> +		goto drop;
>>>> +
>>> 
>>> I think this is wrong, you are completely dropping frames here while you
>>> should at least process the reqseq received. Check the spec, the WAIT_F 
>>> table.
>>> Another point is that the WAIT_F state belongs belongs to the transmit 
>>> side,
>>> and you are checking for it in the receive side. This also seems wrong to 
>>> me.
>> 
>> Spec is a bit unclear here for me, so this is how I understand it:
>> Transmitter state machine is triggered by events from receiver state 
>> machine.
>> For receiver to take action (and sent event to tx machine eventually) 
>> condition
>> must be fulfilled. Every event in receiver state machine which can possibly
>> trigger tx machine has 'With-Valid-F-bit' condition (so my understanding is 
>> that
>> if Fbit has invalid value action should not be triggered, and next matching
>> event should be check, here last one - 'Recv frame' which has action 
>> 'Ignore').
>> So if transmitter is in WAIT_F state any frame received without Fbit=1 
>> doesn't
>> fulfill 'With-Valid-F-bit' condition and should be dropped.
>> 
>> My opinion is that spec is redundant here since if 'With-Valid-F-bit' is 
>> not
>> valid rx machine will never emit 'Recv ReqSeqAndFbit' with F=0 when tx is 
>> in
>> WAIT_F and that condition will never happen (yet, it is described in WAIT_F
>> state table).
>
> I agree with Gustavo, this code is incorrect.
>
> "With-Valid-F-bit" only means that both the P-bit and F-bit are *not* set. 
> The packet should be dropped when P=1 and F=1, but your check only looks at 
> the TX state and F-bit.
>
> Frames without the F-bit need to be processed, because the remote device may 
> have sent a frame with the F-bit that did not reach us.
>

I saw your question on IRC, so I thought I would clarify.

The definition of "With-Valid-F-bit is on page 167 of the 4.0 spec, 
and is very narrow.  The ONLY time an F-bit is invalid is when it is 
set and the P-bit is also set.  Every incoming frame with F=0 meets 
the With-Valid-F-bit condition and should be passed to the TX state 
machine.

The WAIT_F state machine in the spec explicitly mentions receiving 
frames with F=0 because those frames are *expected*.  An F=1 frame 
could have been lost and the remote side might think it's ok to send 
other frames.  There are parts of the RX state machine that look for 
PbitOutstanding - which is exactly this situation.

Your PTS results show PTS saying that control bits were not set 
correctly on the first retransmitted iframe, but the control fields 
look valid to me.  Does your version of PTS allow both of the current 
alternatives from TP/ERM/BI-05-C (reqseq=1 or reqseq=0) in the 
retransmitted frames?

>>> Also I never find problem to pass this test in PTS with the following 
>>> l2test
>>> line:
>>> 
>>> l2test -P 17 -X 3 -b 48 -w -D 1 -N 2
>>> 
>>> Please tell the problem you have in PTS so we can try to find a better
>>> solution for this.
>> 
>> We tried with l2test -x -X ertm -P 33 -N 2 (I guess -x vs -w is not 
>> relevant here).
>> I'm bit surprise how you pass that test if receiving of REJ (P=0, F=0) 
>> triggers
>> retransmission I-Frames before I-Frame with F=1 was sent by PTS (and this 
>> is
>> what PTS didn't like saying it received unexpected I-Frame). So now we have 
>> test
>> failed although we did retransmitted I-Frame only once (but before frame 
>> with
>> Fbit=1 was received).
>> 
>> Some discussion about that can be found here as well:
>> https://www.bluetooth.org/pts/issues/view_issue.cfm?id=8413
>> https://www.bluetooth.org/tse/errata_view.cfm?errata_id=4512
>> 
>> 
>> BTW, we use following PTS version:
>> PTS  v. 4.4.2.8
>> L2CAP  v. 7.4.0.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
