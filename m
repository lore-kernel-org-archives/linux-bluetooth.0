Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Nov 2011 12:35:08 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com,
	ulrik.lauren@stericsson.com, henrik.possung@stericsson.com
Subject: Re: [PATCH 2/2] Bluetooth: Fix usage of sk_sndtimeo value
Message-ID: <20111110103506.GB8486@aemeltch-MOBL1>
References: <1320917845-20135-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1320917845-20135-3-git-send-email-andrzej.kaczmarek@tieto.com>
 <20111110095705.GA8486@aemeltch-MOBL1>
 <4EBBA3E1.70904@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EBBA3E1.70904@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Nov 10, 2011 at 11:13:53AM +0100, Andrzej Kaczmarek wrote:
> Hi Andrei,
> 
> On 10.11.2011 10:57, Andrei Emeltchenko wrote:
> >Hi Andrzej,
> >
> >On Thu, Nov 10, 2011 at 10:37:25AM +0100, Andrzej Kaczmarek wrote:
> >>sk_sndtimeo timeout value is specified in jiffes and should be
> >>converted to miliseconds when used as input to __set_chan_timer.
> >>
> >>Signed-off-by: Andrzej Kaczmarek<andrzej.kaczmarek@tieto.com>
> >>---
> >>  net/bluetooth/l2cap_core.c |    8 ++++----
> >>  1 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >>diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >>index f850684..3b0f807 100644
> >>--- a/net/bluetooth/l2cap_core.c
> >>+++ b/net/bluetooth/l2cap_core.c
> >>@@ -446,7 +446,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
> >>  		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED&&
> >>  					conn->hcon->type == ACL_LINK) {
> >>  			__clear_chan_timer(chan);
> >>-			__set_chan_timer(chan, sk->sk_sndtimeo);
> >>+			__set_chan_timer(chan, jiffies_to_msecs(sk->sk_sndtimeo));
> >
> >Then __set_chan_timer do reverse conversion:
> >mod_timer(timer, jiffies + msecs_to_jiffies(timeout))
> >
> >Look ugly :-(
> 
> Well, I agree. But problem here is that __set_chan_timer has
> miliseconds as input and sk_sndtimeo has to be specified in jiffies
> thus ugly double conversion.

Maybe we can just use jiffies in  __set_chan_timer ?

Best regards 
Andrei Emeltchenko 

> 
> But what about adding __set_chan_timer_jiffies macro and use it here?
> 
> BR,
> Andrzej
