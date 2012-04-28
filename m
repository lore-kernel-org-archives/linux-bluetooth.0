Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Apr 2012 12:56:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: TP/SIG/SMG/BI-02-C failure
Message-ID: <20120428095617.GA7550@x220.P-661HNU-F1>
References: <CAB7rCTiT6m368AReu0mbVVp+Ptc9frQLXp+AvsOY8csyKiVEhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB7rCTiT6m368AReu0mbVVp+Ptc9frQLXp+AvsOY8csyKiVEhg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Fri, Apr 27, 2012, Mike wrote:
> I am experiencing a failure on TP/SIG/SMG/BI-02-C "To verify that the
> IUT (ACP) is able to discard a corrupted stream discover command
> received by the INT."  The test claims that "No message is sent to the
> upper layers and no response is generated." and the problem I have is
> that the disconnect_timeout function is sending its own DISCOVER_CMD
> after the timeout.  This apparently is invalid.

The test spec talks about a response, not about a new command. So from
that perspective I'd say we're still compliant and that the test vector
itself might be wrongly define (not looking at the message type sent by
us).

> For those who are more familiar with the position of
> "remove_disconnect_timer(session);" in session_cb, does it make sense
> to move that outside the AVDTP_MSG_TYPE_COMMAND block so that even the
> invalid discover command (general reject) turns off the timer?

The timer is only removed if there are no streams present, so I don't
see how moving it outside of the if branch would help. However as I said
this is still looking like a test vector issue to me.

Johan
