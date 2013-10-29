Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/5] android/hal: Add support for handling bond state change event
Date: Tue, 29 Oct 2013 11:32:29 +0100
Message-ID: <32939690.A882f3Cjsu@uw000953>
In-Reply-To: <20131029102722.GB27517@aemeltch-MOBL1>
References: <1383041789-28360-1-git-send-email-szymon.janc@tieto.com> <1383041789-28360-3-git-send-email-szymon.janc@tieto.com> <20131029102722.GB27517@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 29 of October 2013 12:27:24 Andrei Emeltchenko wrote:
> Hi Szymon,
> 
> On Tue, Oct 29, 2013 at 11:16:27AM +0100, Szymon Janc wrote:
> > ---
> >  android/hal-bluetooth.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> > index 5f6dcbe..067f420 100644
> > --- a/android/hal-bluetooth.c
> > +++ b/android/hal-bluetooth.c
> > @@ -68,6 +68,17 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
> >  	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
> >  }
> >  
> > +static void handle_bond_state_change(void *buf)
> > +{
> > +	struct hal_ev_bond_state_changed *ev = buf;
> > +	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
> > +
> > +	if (!bt_hal_cbacks->bond_state_changed_cb)
> > +		return;
> > +
> > +	bt_hal_cbacks->bond_state_changed_cb(ev->status, addr, ev->state);
> 
> We shall use the same style like for other callbacks.

In that case reverting check allow to not break function call into 2 lines.
I find it more readable (and there will be reverted check for less trivial
callbacks e.g. with properties)

-- 
BR
Szymon Janc

