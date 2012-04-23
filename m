Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Apr 2012 10:26:06 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv7 04/23] Bluetooth: A2MP: Add chan callbacks
Message-ID: <20120423072604.GB8904@aemeltch-MOBL1>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikbktPhFA6i_crUo7U-59jEeG4Kj+rAviPwLvSiFwPtARw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikbktPhFA6i_crUo7U-59jEeG4Kj+rAviPwLvSiFwPtARw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Fri, Apr 20, 2012 at 11:09:29AM -0300, Ulisses Furquim wrote:
> > +static void a2mp_chan_state_change_cb(void *data, int state)
> > +{
> > +       struct amp_mgr *mgr = data;
> > +       struct l2cap_chan *chan;
> > +
> > +       if (!mgr)
> > +               return;
> > +
> > +       chan = mgr->a2mp_chan;
> > +
> > +       BT_DBG("chan %p state %s", chan, state_to_string(state));
> > +
> > +       chan->state = state;
> 
> Do we have to l2cap_chan_lock() here? Or is that taken care somewhere else?

Yes by caller of state_change

Best regards 
Andrei Emeltchenko 

