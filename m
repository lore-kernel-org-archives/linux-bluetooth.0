Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/5] android/hal: Add support for handling bond state change event
Date: Tue, 29 Oct 2013 11:52:38 +0100
Message-ID: <1849255.UDdNPKEJ3D@uw000953>
In-Reply-To: <20131029103800.GD27517@aemeltch-MOBL1>
References: <1383041789-28360-1-git-send-email-szymon.janc@tieto.com> <32939690.A882f3Cjsu@uw000953> <20131029103800.GD27517@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> On Tue, Oct 29, 2013 at 11:32:29AM +0100, Szymon Janc wrote:
> > Hi Andrei,
> > 
> > On Tuesday 29 of October 2013 12:27:24 Andrei Emeltchenko wrote:
> > > Hi Szymon,
> > > 
> > > On Tue, Oct 29, 2013 at 11:16:27AM +0100, Szymon Janc wrote:
> > > > ---
> > > >  android/hal-bluetooth.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> > > > index 5f6dcbe..067f420 100644
> > > > --- a/android/hal-bluetooth.c
> > > > +++ b/android/hal-bluetooth.c
> > > > @@ -68,6 +68,17 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
> > > >  	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
> > > >  }
> > > >  
> > > > +static void handle_bond_state_change(void *buf)
> > > > +{
> > > > +	struct hal_ev_bond_state_changed *ev = buf;
> > > > +	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
> > > > +
> > > > +	if (!bt_hal_cbacks->bond_state_changed_cb)
> > > > +		return;
> > > > +
> > > > +	bt_hal_cbacks->bond_state_changed_cb(ev->status, addr, ev->state);
> > > 
> > > We shall use the same style like for other callbacks.
> > 
> > In that case reverting check allow to not break function call into 2 lines.
> > I find it more readable (and there will be reverted check for less trivial
> > callbacks e.g. with properties)
> 
> Those checks at least need to be consistent. Your next patch use other
> way. We shall agree about best way for this check, maybe some #define like
> I have in my patches sent some time ago? We could also add debug traces
> then.

In next patch reverting check wouldn't give any benefit as function call
doesn't fit 1 line. Not that this matter a lot since this is trivial callback
handler. I'll send v3 with this check changed if this really bothers you :)

As for macro, I would prefer to not have any as this makes code harder to
follow especially for non-trivial handlers  (where you can return early in case
callback is null).

(I was even thinking about open-coding interface_ready() functions... )

-- 
BR
Szymon Janc


