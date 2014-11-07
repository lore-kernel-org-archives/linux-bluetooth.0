Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1415365587-6217-1-git-send-email-gowtham.ab@samsung.com>
 <1415365587-6217-3-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZLmmLKH6VMkdy5E5faV8XbfMKyROoPMde1iBs-1EZyuzQ@mail.gmail.com>
 <000d01cffa9b$1d086cc0$57194640$@samsung.com>
In-reply-to: <000d01cffa9b$1d086cc0$57194640$@samsung.com>
Subject: RE: [PATCH v1 2/4] monitor/rfcomm: Add support for printing RFCOMM hdr
Date: Fri, 07 Nov 2014 21:16:29 +0530
Message-id: <000e01cffaa2$0197b840$04c728c0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Friday, November 07, 2014 8:27 PM
> To: 'Luiz Augusto von Dentz'
> Cc: linux-bluetooth@vger.kernel.org; 'Dmitry Kasatkin'; 'Bharat Panda';
> cpgs@samsung.com
> Subject: RE: [PATCH v1 2/4] monitor/rfcomm: Add support for printing
> RFCOMM hdr
> 
> Hi Luiz,
> 
> > -----Original Message-----
> > From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> > Sent: Friday, November 07, 2014 7:57 PM
> > To: Gowtham Anandha Babu
> > Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> > cpgs@samsung.com
> > Subject: Re: [PATCH v1 2/4] monitor/rfcomm: Add support for printing
> > RFCOMM hdr
> >
> > Hi Gowtham,
> >
> > On Fri, Nov 7, 2014 at 3:06 PM, Gowtham Anandha Babu
> > <gowtham.ab@samsung.com> wrote:
> > > Changes made to decode RFCOMM hdr and print the same.
> > >
> > >       RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
> > >          Address: 0x01 cr 0 dlci 0x00
> > >          Control: 0xef poll/final 0
> > >          Length: 10
> > >          FCS: 0xaa
> > >         81 11 20 e0 27 00 9a 02 00 07 aa                 .. .'......
> > >
> > > ---
> > >  monitor/rfcomm.c | 50
> > > +++++++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 47 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c index
> > > 155bde2..a70c404 100644
> > > --- a/monitor/rfcomm.c
> > > +++ b/monitor/rfcomm.c
> > > @@ -44,6 +44,11 @@
> > >  #include "sdp.h"
> > >  #include "rfcomm.h"
> > >
> > > +#define GET_LEN8(length) ((length & 0xfe) >> 1) #define
> > > +GET_LEN16(length) ((length & 0xfffe) >> 1)
> > > +#define GET_CR(type)   ((type & 0x02) >> 1)
> > > +#define GET_PF(ctr) (((ctr) >> 4) & 0x1)
> > > +
> > >  struct rfcomm_lhdr {
> > >         uint8_t address;
> > >         uint8_t control;
> > > @@ -57,6 +62,24 @@ struct rfcomm_frame {
> > >         struct l2cap_frame l2cap_frame;  };
> > >
> > > +static void print_rfcomm_hdr(struct rfcomm_frame *rfcomm_frame,
> > > +uint8_t indent) {
> > > +       struct rfcomm_lhdr hdr = rfcomm_frame->hdr;
> > > +
> > > +       /* Address field */
> > > +       print_field("%*cAddress: 0x%2.2x cr %d dlci 0x%2.2x", indent, ' ',
> > > +                                       hdr.address, GET_CR(hdr.address),
> > > +
> > > + RFCOMM_GET_DLCI(hdr.address));
> > > +
> > > +       /* Control field */
> > > +       print_field("%*cControl: 0x%2.2x poll/final %d", indent, ' ',
> > > +                                       hdr.control,
> > > + GET_PF(hdr.control));
> > > +
> > > +       /* Length and FCS */
> > > +       print_field("%*cLength: %d", indent, ' ', hdr.length);
> > > +       print_field("%*cFCS: 0x%2.2x", indent, ' ', hdr.fcs); }
> > > +
> > >  struct rfcomm_data {
> > >         uint8_t frame;
> > >         const char *str;
> > > @@ -73,12 +96,13 @@ static const struct rfcomm_data rfcomm_table[] =
> > > {
> > >
> > >  void rfcomm_packet(const struct l2cap_frame *frame)  {
> > > -       uint8_t ctype;
> > > +       uint8_t ctype, length, ex_length, indent = 1;
> > >         const char *frame_str, *frame_color;
> > >         struct l2cap_frame *l2cap_frame;
> > >         struct rfcomm_frame rfcomm_frame;
> > >         struct rfcomm_lhdr hdr;
> > >         const struct rfcomm_data *rfcomm_data = NULL;
> > > +       const void *ptr;
> > >         int i;
> > >
> > >         l2cap_frame_pull(&rfcomm_frame.l2cap_frame, frame, 0); @@
> > > -89,9 +113,24 @@ void rfcomm_packet(const struct l2cap_frame *frame)
> > >                 goto fail;
> > >
> > >         if (!l2cap_frame_get_u8(l2cap_frame, &hdr.address) ||
> > > -                       !l2cap_frame_get_u8(l2cap_frame, &hdr.control))
> > > +                       !l2cap_frame_get_u8(l2cap_frame, &hdr.control) ||
> > > +                       !l2cap_frame_get_u8(l2cap_frame, &length))
> > >                 goto fail;
> > >
> > > +       /* length maybe 1 or 2 octets */
> > > +       if (RFCOMM_TEST_EA(length))
> > > +               hdr.length = (uint16_t) GET_LEN8(length);
> > > +       else {
> > > +               if (!l2cap_frame_get_u8(l2cap_frame, &ex_length))
> > > +                       goto fail;
> > > +               hdr.length = ((uint16_t)length << 8) | ex_length;
> > > +               hdr.length = GET_LEN16(hdr.length);
> > > +       }
> > > +
> > > +       /* fetching FCS by frame offset */
> > > +       ptr = (l2cap_frame->data)+l2cap_frame->size-1;
> > > +       hdr.fcs = *(uint8_t *)(ptr);
> >
> > You should probably use l2cap_frame_pull followed by
> > l2cap_frame_get_u8 so we actually check if the frame is too short.
> > Btw, the format looks much better now.
> >
> > >         /* Decoding frame type */
> > >         ctype = RFCOMM_GET_TYPE(hdr.control);
> > >
> > > @@ -122,7 +161,12 @@ void rfcomm_packet(const struct l2cap_frame
> > *frame)
> > >                                                 "(0x%2.2x)", ctype);
> > >
> > >         rfcomm_frame.hdr = hdr;
> > > -       packet_hexdump(l2cap_frame->data, l2cap_frame->size);
> > > +       print_rfcomm_hdr(&rfcomm_frame, indent);
> > > +
> > > +       /* UIH frame */
> > > +       if(ctype == 0xef)
> > > +               packet_hexdump(l2cap_frame->data,
> > > + l2cap_frame->size);
> > > +
> > >         return;
> > >
> > >  fail:
> > > --
> > > 1.9.1
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-bluetooth" in the body of a message to
> > > majordomo@vger.kernel.org More majordomo info at
> > > http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
> 
> I will incorporate this in v2. Is there any other changes stills needs to be
> done?
> 
> Regards,
> Gowtham
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

I have changed FCS fetching by l2cap_frame_pull and submitted v2 for the same.

Regards,
Gowtham

