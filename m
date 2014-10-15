Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>, cpgs@samsung.com
References: <1413380509-596-1-git-send-email-vikram.pal@samsung.com>
 <CABBYNZKo33dabCdRkp0EkDULu4-K4aGAzkm7cxRC4+-OBkEf7w@mail.gmail.com>
In-reply-to: <CABBYNZKo33dabCdRkp0EkDULu4-K4aGAzkm7cxRC4+-OBkEf7w@mail.gmail.com>
Subject: RE: [PATCH] monitor: Fix indentation for AVRCP PASS THROUGH commands
Date: Wed, 15 Oct 2014 19:39:07 +0530
Message-id: <001001cfe881$ad84cae0$088e60a0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sure Luiz, Thanks!

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Wednesday, October 15, 2014 7:16 PM
> To: Vikrampal Yadav
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; cpgs@samsung.com
> Subject: Re: [PATCH] monitor: Fix indentation for AVRCP PASS THROUGH
> commands
> 
> Hi Vikram,
> 
> On Wed, Oct 15, 2014 at 4:41 PM, Vikrampal Yadav
> <vikram.pal@samsung.com> wrote:
> > Intendation for AVRCP PASS THROUGH commands' decoding fixed.
> >
> > btmon snippets:
> >
> >       Channel: 66 len 14 [PSM 23 mode 0] {chan 3}
> >       AVCTP Control: Command: type 0x00 label 0 PID 0x110e
> >         AV/C: Status: address 0x48 opcode 0x7c
> >           Subunit: Panel
> >           Opcode: Passthrough
> >           Operation: 0x44 (PLAY Pressed)
> >           Lenght: 0x00
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
> >
> 
> Applied, please make sure the patch format is 50/72 according to the
> HACKING document.
> 
> --
> Luiz Augusto von Dentz

Regards,
Vikram

