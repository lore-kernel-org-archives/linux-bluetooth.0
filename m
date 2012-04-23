Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Apr 2012 10:22:39 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv7 02/23] Bluetooth: A2MP: AMP Manager basic functions
Message-ID: <20120423072237.GA8904@aemeltch-MOBL1>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikZqM3Lm_U-5mwCwiDBw-6z+3k517YtbEvbOBnyNBrmT3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikZqM3Lm_U-5mwCwiDBw-6z+3k517YtbEvbOBnyNBrmT3w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Fri, Apr 20, 2012 at 11:51:53AM -0300, Ulisses Furquim wrote:
> > +/* AMP Manager functions */
> > +void amp_mgr_get(struct amp_mgr *mgr)
> 
> I'm probably late to say this but maybe amp_mgr_hold() instead of
> _get() like we already have in the stack would be better?

I actually like more get since this indicates that kref is used with
kref_get as shown below.

Best regards 
Andrei Emeltchenko 

> 
> Regards,
> 
> -- Ulisses
> 
> > +{
> > +       BT_DBG("mgr %p", mgr);
> > +
> > +       kref_get(&mgr->kref);
> > +}
> > +

