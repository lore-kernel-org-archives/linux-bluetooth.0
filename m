Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Mon, 2 Aug 2010 18:20:14 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mat Martineau <mathewm@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/8] Bluetooth:  Make sure the L2CAP FCS is only
 enabled for ERTM or streaming.
Message-ID: <20100802212014.GB20149@vigoh>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
 <1280776810-18213-2-git-send-email-mathewm@codeaurora.org>
 <1280777912.12579.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280777912.12579.37.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Marcel Holtmann <marcel@holtmann.org> [2010-08-02 12:38:32 -0700]:

> Hi Mat,
> 
> > Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> > ---
> >  net/bluetooth/l2cap.c |   12 ++++++++----
> >  1 files changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> > index 9ba1e8e..aed72f2 100644
> > --- a/net/bluetooth/l2cap.c
> > +++ b/net/bluetooth/l2cap.c
> > @@ -3127,8 +3127,10 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
> >  		goto unlock;
> >  
> >  	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
> > -		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
> > -		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
> > +		if ((l2cap_pi(sk)->mode == L2CAP_MODE_ERTM ||
> > +			l2cap_pi(sk)->mode == L2CAP_MODE_STREAMING) &&
> > +			(!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
> > +			l2cap_pi(sk)->fcs != L2CAP_FCS_NONE))
> >  			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
> 
> this becomes unreadable and my brain starts to throw a core dump. So it
> clearly needs to be put into a helper inline function.

Actually we don't need that, since the code that deals with Basic Mode
never check  and use the l2cap_pi(sk)->fcs. So we don't care about FCS
value in the Basic Mode.


-- 
Gustavo F. Padovan
http://padovan.org
