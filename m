Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
 <1420619000-24211-7-git-send-email-vikram.pal@samsung.com>
 <CABBYNZ+pMGqYxbF9WxsE_VS9LD=M0ta4Ejxgw4svyprbURG4XQ@mail.gmail.com>
In-reply-to: <CABBYNZ+pMGqYxbF9WxsE_VS9LD=M0ta4Ejxgw4svyprbURG4XQ@mail.gmail.com>
Subject: RE: [PATCH 6/6] monitor: Add AVRCP SetBrowsedPlayer support
Date: Thu, 08 Jan 2015 14:17:11 +0530
Message-id: <009b01d02b1f$b2494070$16dbc150$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Wednesday, January 07, 2015 6:55 PM
> To: Vikrampal Yadav
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH 6/6] monitor: Add AVRCP SetBrowsedPlayer support
> 
> Hi Vikram,
> 
> On Wed, Jan 7, 2015 at 6:23 AM, Vikrampal Yadav
> <vikram.pal@samsung.com> wrote:
> > Support for decoding AVRCP SetBrowsedPlayer added in Bluetooth
> monitor.
> >
> > Channel: 65 len 12 ctrl 0x0102 [PSM 27 mode 3] {chan 1}
> >       I-frame: Unsegmented TxSeq 1 ReqSeq 1
> >       AVCTP Browsing: Command: type 0x00 label 0 PID 0x110e
> >         AVRCP: SetBrowsedPlayer: len 0x0002
> >           PlayerID: 0x0001 (1)
> 
> Can you please add the response frame as well.

I couldn't find any response, not even in hcidump.

> 
> > ---
> >  monitor/avctp.c | 86
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 85 insertions(+), 1 deletion(-)
> >
> > diff --git a/monitor/avctp.c b/monitor/avctp.c index af91ecc..0a1e92d
> > 100644
> > --- a/monitor/avctp.c
> > +++ b/monitor/avctp.c
> > @@ -1637,11 +1637,95 @@ static bool avrcp_control_packet(struct
> avctp_frame *avctp_frame)
> >         }
> >  }
> >
> > +static bool avrcp_set_browsed_player(struct avctp_frame *avctp_frame)
> > +{
> > +       struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
> > +       uint32_t items;
> > +       uint16_t id, uids, charset;
> > +       uint8_t status, folders, indent = 2;
> > +
> > +       if (avctp_frame->hdr & 0x02)
> > +               goto response;
> > +
> > +       if (!l2cap_frame_get_be16(frame, &id))
> > +               return false;
> > +
> > +       print_field("%*cPlayerID: 0x%04x (%u)", indent, ' ', id, id);
> > +       return true;
> > +
> > +response:
> > +       if (!l2cap_frame_get_u8(frame, &status))
> > +               return false;
> > +
> > +       print_field("%*cStatus: 0x%02x (%s)", indent, ' ', status,
> > +
> > + error2str(status));
> > +
> > +       if (!l2cap_frame_get_be16(frame, &uids))
> > +               return false;
> > +
> > +       print_field("%*cUIDCounter: 0x%04x (%u)", indent, ' ', uids,
> > + uids);
> > +
> > +       if (!l2cap_frame_get_be32(frame, &items))
> > +               return false;
> > +
> > +       print_field("%*cNumber of Items: 0x%08x (%u)", indent, ' ',
> > +                                                               items,
> > + items);
> > +
> > +       if (!l2cap_frame_get_be16(frame, &charset))
> > +               return false;
> > +
> > +       print_field("%*cCharsetID: 0x%04x (%s)", indent, ' ', charset,
> > +
> > + charset2str(charset));
> > +
> > +       if (!l2cap_frame_get_u8(frame, &folders))
> > +               return false;
> > +
> > +       print_field("%*cFolder Depth: 0x%02x (%u)", indent, ' ', folders,
> > +
> > + folders);
> > +
> > +       for (; folders > 0; folders--) {
> > +               uint8_t len;
> > +
> > +               if (!l2cap_frame_get_u8(frame, &len))
> > +                       return false;
> > +
> > +               printf("Folder: ");
> > +               for (; len > 0; len--) {
> > +                       uint8_t c;
> > +
> > +                       if (!l2cap_frame_get_u8(frame, &c))
> > +                               return false;
> > +
> > +                       printf("%1c", isprint(c) ? c : '.');
> > +               }
> > +               printf("\n");
> > +       }
> > +
> > +       return true;
> > +}
> > +
> >  static bool avrcp_browsing_packet(struct avctp_frame *avctp_frame)  {
> >         struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
> > +       uint16_t len;
> > +       uint8_t pduid;
> > +
> > +       if (!l2cap_frame_get_u8(frame, &pduid))
> > +               return false;
> > +
> > +       if (!l2cap_frame_get_be16(frame, &len))
> > +               return false;
> > +
> > +       print_field("AVRCP: %s: len 0x%04x", pdu2str(pduid), len);
> > +
> > +       switch (pduid) {
> > +       case AVRCP_SET_BROWSED_PLAYER:
> > +               avrcp_set_browsed_player(avctp_frame);
> > +               break;
> > +       default:
> > +               packet_hexdump(frame->data, frame->size);
> > +       }
> >
> > -       packet_hexdump(frame->data, frame->size);
> >         return true;
> >  }
> >
> > --
> > 1.9.1
> >
> 
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Vikram

