Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 19 Mar 2012 15:40:20 +0100
Subject: RE: [PATCH obexd v0 03/11] client: refactor transfer callback use
Message-ID: <66BD268F973E3544A665E5F503FB38B71AE959AEBF@DC01.bmw-carit.intra>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1331559165-28367-4-git-send-email-mikel.astiz.oss@gmail.com>
 <CABBYNZLaMoMuCQ9vY6oiUMa5P0dW-WZLvhWQ19AtmgyZezms1Q@mail.gmail.com>
In-Reply-To: <CABBYNZLaMoMuCQ9vY6oiUMa5P0dW-WZLvhWQ19AtmgyZezms1Q@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >
> > -static void obc_transfer_abort(struct obc_transfer *transfer)
> > +static void transfer_notify_progress(struct obc_transfer *transfer)
> {
> > +       struct transfer_callback *callback = transfer->callback;
> > +
> > +       DBG("%p", transfer);
> > +
> > +       if ((callback != NULL) && (transfer->transferred !=
> > +transfer->size))
> > +               callback->func(transfer, transfer->transferred, NULL,
> > +
> > +callback->data); }
> 
> Usually we use early returns and simple statements to be more readable,
> so if (callback == NULL) return would have been better. Also I guess we
> don't really need this check for transferred != size since gobex has a
> complete callback and latter you set it to NULL.
> 

This patch was refactoring code so the size check has been kept there, exactly as it was.

We can try to drop it if you want, but I guess it would be in another patch. However I think it's actually necessary.

Regarding the early return, I will integrate the change in the next proposal.

Cheers,
Mikel

