Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Mar 2012 15:44:10 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Fix memory leaks due to chan refcnt
Message-ID: <20120322134403.GE6607@aemeltch-MOBL1>
References: <1332344707-5193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120322133335.GB6260@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120322133335.GB6260@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 22, 2012 at 10:33:35AM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> * Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-21 17:45:06 +0200]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > When we queue delayed work we hold(chan) and delayed work
> > shall put(chan) after execution.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> Looks you are right.
> 
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index ec9f883..c90d025 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1341,6 +1341,7 @@ static void l2cap_monitor_timeout(struct work_struct *work)
> >  	if (chan->retry_count >= chan->remote_max_tx) {
> >  		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
> >  		l2cap_chan_unlock(chan);
> > +		l2cap_chan_put(chan);
> >  		return;
> >  	}
> >  
> > @@ -1349,6 +1350,7 @@ static void l2cap_monitor_timeout(struct work_struct *work)
> >  
> >  	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
> >  	l2cap_chan_unlock(chan);
> > +	l2cap_chan_put(chan);
> >  }
> >  
> >  static void l2cap_retrans_timeout(struct work_struct *work)
> > @@ -1366,8 +1368,8 @@ static void l2cap_retrans_timeout(struct work_struct *work)
> >  	set_bit(CONN_WAIT_F, &chan->conn_state);
> >  
> >  	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
> > -
> 
> But please remove this change and re-send you patch.

Without this change the code looks inconsistent. Look to the code above;
it does not have empty line here.

Best regards 
Andrei Emeltchenko 
