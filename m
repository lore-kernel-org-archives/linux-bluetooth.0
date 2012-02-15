Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Gustavo Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] Bluetooth: Drop frames without F-bit set when in WAIT_F state
Date: Wed, 15 Feb 2012 10:34:53 +0100
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"kanak.gupta@stericsson.com" <kanak.gupta@stericsson.com>
References: <1329227796-22609-1-git-send-email-szymon.janc@tieto.com> <20120214154141.GA14503@joana>
In-Reply-To: <20120214154141.GA14503@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201202151034.53555.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Szymon,

Hi Gustavo,

I was pretty sure this patch will trigger some comments :-)

> > +	/* drop frame without F-bit set when in WAIT_F state */
> > +	if (test_bit(CONN_WAIT_F, &chan->conn_state) &&
> > +			!__is_ctrl_final(chan, control))
> > +		goto drop;
> > +
> 
> I think this is wrong, you are completely dropping frames here while you
> should at least process the reqseq received. Check the spec, the WAIT_F table.
> Another point is that the WAIT_F state belongs belongs to the transmit side,
> and you are checking for it in the receive side. This also seems wrong to me.

Spec is a bit unclear here for me, so this is how I understand it:
Transmitter state machine is triggered by events from receiver state machine.
For receiver to take action (and sent event to tx machine eventually) condition
must be fulfilled. Every event in receiver state machine which can possibly
trigger tx machine has 'With-Valid-F-bit' condition (so my understanding is that
if Fbit has invalid value action should not be triggered, and next matching 
event should be check, here last one - 'Recv frame' which has action 'Ignore').
So if transmitter is in WAIT_F state any frame received without Fbit=1 doesn't
fulfill 'With-Valid-F-bit' condition and should be dropped.

My opinion is that spec is redundant here since if 'With-Valid-F-bit' is not
valid rx machine will never emit 'Recv ReqSeqAndFbit' with F=0 when tx is in
WAIT_F and that condition will never happen (yet, it is described in WAIT_F
state table).

> Also I never find problem to pass this test in PTS with the following l2test
> line:
> 
> l2test -P 17 -X 3 -b 48 -w -D 1 -N 2
> 
> Please tell the problem you have in PTS so we can try to find a better
> solution for this.

We tried with l2test -x -X ertm -P 33 -N 2 (I guess -x vs -w is not relevant here).
I'm bit surprise how you pass that test if receiving of REJ (P=0, F=0) triggers
retransmission I-Frames before I-Frame with F=1 was sent by PTS (and this is
what PTS didn't like saying it received unexpected I-Frame). So now we have test
failed although we did retransmitted I-Frame only once (but before frame with
Fbit=1 was received).

Some discussion about that can be found here as well:
https://www.bluetooth.org/pts/issues/view_issue.cfm?id=8413
https://www.bluetooth.org/tse/errata_view.cfm?errata_id=4512


BTW, we use following PTS version:
PTS  v. 4.4.2.8
L2CAP  v. 7.4.0.1

-- 
BR
Szymon Janc
