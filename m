Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 11:40:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/4] emulator: Add data handler for l2cap connections
Message-ID: <20131218094005.GA20229@x220.p-661hnu-f1>
References: <1387291779-14960-1-git-send-email-marcin.kraglak@tieto.com>
 <1387291779-14960-2-git-send-email-marcin.kraglak@tieto.com>
 <20131218084056.GH12649@x220.p-661hnu-f1>
 <CABD6X-+XUgQDoJgetbEAjcCazQ396UGUG9qnKbfVHLQu0u+UfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABD6X-+XUgQDoJgetbEAjcCazQ396UGUG9qnKbfVHLQu0u+UfA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Dec 18, 2013, Marcin Kraglak wrote:
> On 18 December 2013 09:40, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Marcin,
> >
> > On Tue, Dec 17, 2013, Marcin wrote:
> >> +void bthost_l2cap_set_data_handler(struct bthost *bthost,
> >> +                                     bthost_l2cap_data_cb handler,
> >> +                                     uint16_t psm)
> >> +{
> >> +     bthost->read_data_psm = psm;
> >> +     bthost->l2cap_data_cb = handler;
> >> +}
> >
> > The function is called just "data handler" but it applies to a more
> > specific read_data_psm. Should this perhaps be simply called data_psm?
> >
> >
> >> +typedef void (*bthost_l2cap_data_cb) (const void *data, uint16_t len);
> >> +
> >> +void bthost_l2cap_set_data_handler(struct bthost *bthost,
> >> +                                     bthost_l2cap_data_cb handler,
> >> +                                     uint16_t psm);
> >> +
> >
> > The problem with your approach is that it will not be usable for
> > protocols that have multiple channels to the same PSM such as AVDTP.
> > To cover this I'd suggest you to consider having something like the
> > following:
> >
> > typedef void (*bthost_l2cap_connect_cb) (uint16_t handle, uint16_t cid);
> >
> > void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
> >                                         bthost_l2cap_connect_cb func);
> > /* the above could replace the existing bthost_set_server_psm */
> >
> > void bthost_connect_l2cap(struct bthost *bthost, uint16_t handle, uint16_t psm,
> >                                                 bthost_l2cap_connect_cb func);
> >
> > For sending and receiving data you wouldn't then need any new functions
> > but you could use the already existing bthost_add_cid_hook (for
> > receiving data) and bthost_send_cid (for sending data).
> >
> > Thoughts?
> >
> > Johan
> 
> So first is to extend existing method bthost_add_l2cap_server and call
> back after connect, and create method bthost_connect_l2cap (instead of
> calling bthost_l2cap_req())?

Maybe you can skip adding this higher level bthost_connect_l2cap for now
and just use the existing bthost_l2cap_req. What I was thinking is that
this new feature is kind of above the existing lower-level access
functions but it's fine to try to keep using them as long as things
don't get too messy.

Johan
