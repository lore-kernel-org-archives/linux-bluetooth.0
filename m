Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Nov 2011 23:16:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix byte order problems getting PSM through btio API
Message-ID: <20111130211600.GA9230@fusion.localdomain>
References: <1322670976-9517-1-git-send-email-sancane@gmail.com>
 <CACLukzJWL5=w59ARvwKvz+_Q81=ZJ+4qj_tU0+AxmT4g6847Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CACLukzJWL5=w59ARvwKvz+_Q81=ZJ+4qj_tU0+AxmT4g6847Sw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Nov 30, 2011, Santiago Carot wrote:
> 2011/11/30 Santiago Carot-Nemesio <sancane@gmail.com>:
> > ---
> >  btio/btio.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/btio/btio.c b/btio/btio.c
> > index a129bf9..f8c5cc7 100644
> > --- a/btio/btio.c
> > +++ b/btio/btio.c
> > @@ -882,7 +882,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
> >                        break;
> >                case BT_IO_OPT_PSM:
> >                        *(va_arg(args, uint16_t *)) = src.l2_psm ?
> > -                                               src.l2_psm : dst.l2_psm;
> > +                                       btohs(src.l2_psm) : btohs(dst.l2_psm);
> >                        break;
> >                case BT_IO_OPT_CID:
> >                        *(va_arg(args, uint16_t *)) = src.l2_cid ?
> > --
> > 1.7.7.4
> >
> 
> At a first sight, It seems there may be the same problems retrieving
> CID, OMTU and IMTU on big endian architectures. I preffer waiting for
> a more experienced comments before sending any patch fixing that.

To my understanding the L2CAP PSM is the only parameter that uses
protocol endianess in the socket interface, so we should be safe with
the other values.

Johan
