Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>, cpgs@samsung.com
References: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
 <1416577665-21876-2-git-send-email-vikram.pal@samsung.com>
 <CABBYNZLhEKz3GQRg-NgwC=tEorV_ygV+FmR_65_r7Bx6tZzSxw@mail.gmail.com>
In-reply-to: <CABBYNZLhEKz3GQRg-NgwC=tEorV_ygV+FmR_65_r7Bx6tZzSxw@mail.gmail.com>
Subject: RE: [PATCH 1/7] monitor: Adjust for ERTM control bytes
Date: Wed, 03 Dec 2014 12:35:44 +0530
Message-id: <003d01d00ec7$976a6f00$c63f4d00$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Friday, November 28, 2014 2:08 PM
> To: Vikrampal Yadav
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; cpgs@samsung.com
> Subject: Re: [PATCH 1/7] monitor: Adjust for ERTM control bytes
> 
> Hi Vikram,
> 
> On Fri, Nov 21, 2014 at 3:47 PM, Vikrampal Yadav
> <vikram.pal@samsung.com> wrote:
> > Adjustment for ERTM control bytes fixed.
> > ---
> >  monitor/l2cap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/monitor/l2cap.c b/monitor/l2cap.c index ebdd20f..635b967
> > 100644
> > --- a/monitor/l2cap.c
> > +++ b/monitor/l2cap.c
> > @@ -2621,6 +2621,9 @@ static void l2cap_frame(uint16_t index, bool in,
> uint16_t handle,
> >                 connless_packet(index, in, handle, cid, data, size);
> >                 break;
> >         case 0x0003:
> > +               /* Adjust for ERTM control bytes */
> > +               data += 2;
> > +               size -= 2;
> >                 amp_packet(index, in, handle, cid, data, size);
> >                 break;
> >         case 0x0004:
> > --
> > 1.9.1
> 
> What are those bytes, shouldn't they be printed?

These bytes are not being printed even in hcidump.
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Vikram

