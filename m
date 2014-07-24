Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	p.sinha@samsung.com, sanjay.nm@samsung.com,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1406026672-3127-1-git-send-email-vikram.pal@samsung.com>
 <CABBYNZ+dyL0qUiGKDFfLHH1nDGMuopYyJ8XD0MRfEqc2yJdq7w@mail.gmail.com>
In-reply-to: <CABBYNZ+dyL0qUiGKDFfLHH1nDGMuopYyJ8XD0MRfEqc2yJdq7w@mail.gmail.com>
Subject: RE: [PATCH ] monitor: Add AVCTP support to btmon
Date: Thu, 24 Jul 2014 15:32:24 +0530
Message-id: <006b01cfa726$5f53ff90$1dfbfeb0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Thursday, July 24, 2014 1:41 PM
> To: Vikrampal Yadav
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin;
> p.sinha@samsung.com; sanjay.nm@samsung.com; Bharat Panda;
> cpgs@samsung.com
> Subject: Re: [PATCH ] monitor: Add AVCTP support to btmon
> 
> Hi,
> 
> On Tue, Jul 22, 2014 at 1:57 PM, Vikrampal Yadav
> <vikram.pal@samsung.com> wrote:
> > Support for decoding AVCTP packets added in Bluetooth monitor.
> > ---
> >  monitor/l2cap.c | 64
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/monitor/l2cap.c b/monitor/l2cap.c index 993aa8b..3475263
> > 100644
> > --- a/monitor/l2cap.c
> > +++ b/monitor/l2cap.c
> > @@ -2220,6 +2220,66 @@ static void att_packet(uint16_t index, bool in,
> uint16_t handle,
> >         opcode_data->func(&frame);
> >  }
> >
> > +static void avrcp_control_packet(const struct l2cap_frame *frame) { }
> > +
> > +static void avrcp_browsing_packet(const struct l2cap_frame *frame,
> > +uint8_t hdr) { }
> 
> Please use avctp prefix while processing AVCTP part of the packets.

The above function skeleton is meant for AVRCP decoding. Otherwise, I've used
avctp prefix while processing AVCTP part of the packets.

> 
> > +static void avrcp_packet(const struct l2cap_frame *frame, uint8_t hdr,
> > +                               uint16_t psm) {
> > +        switch (psm) {
> > +                case 0x17:
> > +                        avrcp_control_packet(frame);
> > +                        break;
> > +                case 0x1B:
> > +                        avrcp_browsing_packet(frame, hdr);
> > +                        break;
> > +                default:
> > +                        packet_hexdump(frame->data, frame->size);
> > +        }
> > +}
> 
> Here as well.

The above function skeleton is meant for AVRCP decoding. Otherwise, I've used
avctp prefix while processing AVCTP part of the packets.

> 
> > +static void avctp_packet(const struct l2cap_frame *frame, uint16_t
> > +psm) {
> > +        uint8_t hdr;
> > +        uint16_t pid;
> > +        struct l2cap_frame avctp_frame;
> > +        const char *pdu_color;
> > +
> > +        if (frame->size < 3) {
> > +                print_text(COLOR_ERROR, "frame too short");
> > +                packet_hexdump(frame->data, frame->size);
> > +                return;
> > +        }
> > +
> > +        hdr = *((uint8_t *) frame->data);
> > +
> > +        pid = get_be16(frame->data + 1);
> > +
> > +        if (frame->in)
> > +                pdu_color = COLOR_MAGENTA;
> > +        else
> > +                pdu_color = COLOR_BLUE;
> > +
> > +        print_indent(6, pdu_color, "AVCTP", "", COLOR_OFF,
> > +                        " %s: %s: Packet_type 0x%02x Transaction label %d "
> > +                        "PID 0x%04x",
> > +                        psm == 23 ? "Control" : "Browsing",
> > +                        hdr & 0x02 ? "Response" : "Command",
> > +                        hdr & 0x0c, hdr >> 4, pid);
> > +
> > +        l2cap_frame_pull(&avctp_frame, frame, 3);
> > +
> > +        if (pid == 0x110e || pid == 0x110c)
> > +                avrcp_packet(&avctp_frame, hdr, psm);
> > +        else
> > +                packet_hexdump(frame->data + 3, frame->size - 3); }
> > +
> >  static void print_addr(const uint8_t *addr, uint8_t addr_type)  {
> >         const char *str;
> > @@ -2634,6 +2694,10 @@ static void l2cap_frame(uint16_t index, bool in,
> uint16_t handle,
> >                 case 0x001f:
> >                         att_packet(index, in, handle, cid, data, size);
> >                         break;
> > +               case 0x0017:
> > +               case 0x001B:
> > +                       avctp_packet(&frame, psm);
> > +                       break;
> >                 default:
> >                         packet_hexdump(data, size);
> >                         break;
> 
> Perhaps we should split this into avctp.c to keep l2cap.c just for L2CAP layer,
> otherwise this file will grow quite big.

Ok, I'll do that and submit again. Thanks!

> 
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Vikram

