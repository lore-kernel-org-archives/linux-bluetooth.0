Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>, cpgs@samsung.com
References: <1412855826-3665-1-git-send-email-vikram.pal@samsung.com>
 <CABBYNZJ-SdhX2S6_BPoPYe2qyavnpqhWAYgKmPi4qAABsrMw2g@mail.gmail.com>
In-reply-to: <CABBYNZJ-SdhX2S6_BPoPYe2qyavnpqhWAYgKmPi4qAABsrMw2g@mail.gmail.com>
Subject: RE: [PATCH] Monitor: Fix indentation for AVRCP PASS THROUGH commands
Date: Thu, 09 Oct 2014 18:29:31 +0530
Message-id: <005a01cfe3c0$f5d1d830$e1758890$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Thursday, October 09, 2014 5:29 PM
> To: Vikrampal Yadav
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; cpgs@samsung.com
> Subject: Re: [PATCH] Monitor: Fix indentation for AVRCP PASS THROUGH
> commands
> 
> Hi Vikram,
> 
> On Thu, Oct 9, 2014 at 2:57 PM, Vikrampal Yadav
> <vikram.pal@samsung.com> wrote:
> > Intendation for AVRCP PASS THROUGH commands' decoding fixed.
> 
> Please use lower case at the beginning e.g. monitor:
> 
> > ---
> >  monitor/avctp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor/avctp.c b/monitor/avctp.c index a4e34c5..4abd18f
> > 100644
> > --- a/monitor/avctp.c
> > +++ b/monitor/avctp.c
> > @@ -686,13 +686,13 @@ static bool avrcp_passthrough_packet(struct
> avctp_frame *avctp_frame,
> >         if (!l2cap_frame_get_u8(frame, &op))
> >                 return false;
> >
> > -       print_field("%*cOperation: 0x%02x (%s %s)", (indent - 2), ' ', op,
> > +       print_field("%*cOperation: 0x%02x (%s %s)", (indent - 8), ' ',
> > + op,
> >                                 op2str(op), op & 0x80 ? "Released" :
> > "Pressed");
> >
> >         if (!l2cap_frame_get_u8(frame, &len))
> >                 return false;
> >
> > -       print_field("%*cLength: 0x%02x", (indent - 2), ' ', len);
> > +       print_field("%*cLength: 0x%02x", (indent - 8), ' ', len);
> >
> >         packet_hexdump(frame->data, frame->size);
> >         return true;
> > --
> > 1.9.1
> 
> 
> Could you please start adding the output of the btmon to the description
> once you add new parsers like this that way we can spot more easily
> formatting bugs such as this.
> 
> 
> 
> --
> Luiz Augusto von Dentz

Sure!

Regards,
Vikram

