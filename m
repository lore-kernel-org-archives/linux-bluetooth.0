Return-Path: <cyrus@holtmann.org>
Message-ID: <1337311849.5970.285.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Fix early return from l2cap_chan_del
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Date: Thu, 17 May 2012 20:30:49 -0700
In-Reply-To: <alpine.DEB.2.02.1205172027170.24136@mathewm-linux>
References: <1337296814-3763-1-git-send-email-mathewm@codeaurora.org>
	  <1337296814-3763-2-git-send-email-mathewm@codeaurora.org>
	 <1337308224.5970.280.camel@aeonflux>
	 <alpine.DEB.2.02.1205172027170.24136@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> >> This fixes a regression from commit
> >> 2ead70b8390d199ca04cd35311b51f5f3676079e that is present in all
> >> kernels starting at v3.0.
> >>
> >> When L2CAP information was moved to struct l2cap_chan, a check was
> >> added to l2cap_chan_del to avoid certain cleanup operations when ERTM
> >> or streaming mode had not yet been initialized.  The logic in the
> >> check did not take in to account that chan->conf_state is set to 0 in
> >> l2cap_chan_ready, so l2cap_chan_del failed to cancel timers and leaked
> >> memory any time the ERTM queues or lists were not empty.
> >>
> >> This change makes sure that l2cap_chan_del only returns early if
> >> ERTM initialization was not performed.
> >>
> >> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> >> ---
> >>  include/net/bluetooth/l2cap.h |    1 +
> >>  net/bluetooth/l2cap_core.c    |    4 ++--
> >>  2 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> >> index 1c7d1cd..452fcc4 100644
> >> --- a/include/net/bluetooth/l2cap.h
> >> +++ b/include/net/bluetooth/l2cap.h
> >> @@ -597,6 +597,7 @@ enum {
> >>  	CONF_EWS_RECV,
> >>  	CONF_LOC_CONF_PEND,
> >>  	CONF_REM_CONF_PEND,
> >> +	CONF_NOT_COMPLETE,
> >>  };
> >>
> >>  #define L2CAP_CONF_MAX_CONF_REQ 2
> >> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >> index 24f144b..36edd42 100644
> >> --- a/net/bluetooth/l2cap_core.c
> >> +++ b/net/bluetooth/l2cap_core.c
> >> @@ -391,6 +391,7 @@ struct l2cap_chan *l2cap_chan_create(void)
> >>  	chan->state = BT_OPEN;
> >>
> >>  	atomic_set(&chan->refcnt, 1);
> >> +	set_bit(CONF_NOT_COMPLETE, &chan->conf_state);
> >>
> >>  	BT_DBG("chan %p", chan);
> >>
> >> @@ -509,8 +510,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >>
> >>  	release_sock(sk);
> >>
> >> -	if (!(test_bit(CONF_OUTPUT_DONE, &chan->conf_state) &&
> >> -			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
> >> +	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
> >>  		return;
> >
> > explain to me how this works? We never clear that bit.
> 
> Line 926 in l2cap_chan_ready (called after configuration is done) is 
> existing code that I didn't change:
> 
>          chan->conf_state = 0;
> 
> So all bits are cleared at once, including CONF_NOT_COMPLETE.

that stuff needs a comment somewhere in the code. Best is to mention it
when calling set_bit().

Regards

Marcel


