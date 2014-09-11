Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>, cpgs@samsung.com
References: <1410253830-7866-1-git-send-email-vikram.pal@samsung.com>
 <CABBYNZJEx64_jNtFzxZBxF0H467UEZD47yCsWcvQ0DFfSBUXWQ@mail.gmail.com>
 <00d001cfccdf$b86eb4b0$294c1e10$@samsung.com>
 <CABBYNZ+ohFnj_3SuFd-5Sa2CA38iv8XH-ExVcWZu18_4FExmGw@mail.gmail.com>
In-reply-to: <CABBYNZ+ohFnj_3SuFd-5Sa2CA38iv8XH-ExVcWZu18_4FExmGw@mail.gmail.com>
Subject: RE: [PATCH v2] monitor: Add AVRCP GetElementAttributes
Date: Thu, 11 Sep 2014 14:06:31 +0530
Message-id: <00dc01cfcd9b$7fb1afd0$7f150f70$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Wednesday, September 10, 2014 6:19 PM
> To: Vikrampal
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; cpgs@samsung.com
> Subject: Re: [PATCH v2] monitor: Add AVRCP GetElementAttributes
> 
> Hi Vikram,
> 
> On Wed, Sep 10, 2014 at 1:12 PM, Vikrampal <vikram.pal@samsung.com>
> wrote:
> > Hi Luiz,
> >
> >> -----Original Message-----
> >> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> >> Sent: Wednesday, September 10, 2014 2:42 PM
> >> To: Vikrampal Yadav
> >> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin;
> >> cpgs@samsung.com
> >> Subject: Re: [PATCH v2] monitor: Add AVRCP GetElementAttributes
> >>
> >> Hi Vikram,
> >>
> >> On Tue, Sep 9, 2014 at 12:10 PM, Vikrampal Yadav
> >> <vikram.pal@samsung.com> wrote:
> >> > Support for decoding AVRCP GetElementAttributes added in Bluetooth
> >> > monitor.
> >> > ---
> >> >  monitor/avctp.c | 158
> >> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >> >  monitor/l2cap.h |  16 +++---
> >> >  2 files changed, 167 insertions(+), 7 deletions(-)
> >> >
> >> > diff --git a/monitor/avctp.c b/monitor/avctp.c index
> >> > c7e242b..89f0f9c
> >> > 100644
> >> > --- a/monitor/avctp.c
> >> > +++ b/monitor/avctp.c
> >> > @@ -158,6 +158,21 @@
> >> >  #define AVRCP_ATTRIBUTE_SHUFFLE                0x03
> >> >  #define AVRCP_ATTRIBUTE_SCAN           0x04
> >> >
> >> > +/* media attributes */
> >> > +#define AVRCP_MEDIA_ATTRIBUTE_ILLEGAL  0x00
> >> > +#define AVRCP_MEDIA_ATTRIBUTE_TITLE    0x01
> >> > +#define AVRCP_MEDIA_ATTRIBUTE_ARTIST   0x02
> >> > +#define AVRCP_MEDIA_ATTRIBUTE_ALBUM    0x03
> >> > +#define AVRCP_MEDIA_ATTRIBUTE_TRACK    0x04
> >> > +#define AVRCP_MEDIA_ATTRIBUTE_TOTAL    0x05
> >> > +#define AVRCP_MEDIA_ATTRIBUTE_GENRE    0x06
> >> > +#define AVRCP_MEDIA_ATTRIBUTE_DURATION 0x07
> >> > +
> >> > +static struct avrcp_continuing {
> >> > +       uint16_t num;
> >> > +       uint16_t size;
> >> > +} avrcp_continuing;
> >> > +
> >> >  static const char *ctype2str(uint8_t ctype)  {
> >> >         switch (ctype & 0x0f) {
> >> > @@ -517,6 +532,30 @@ static const char *charset2str(uint16_t charset)
> >> >         }
> >> >  }
> >> >
> >> > +static const char *mediattr2str(uint32_t attr) {
> >> > +       switch (attr) {
> >> > +       case AVRCP_MEDIA_ATTRIBUTE_ILLEGAL:
> >> > +               return "Illegal";
> >> > +       case AVRCP_MEDIA_ATTRIBUTE_TITLE:
> >> > +               return "Title";
> >> > +       case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
> >> > +               return "Artist";
> >> > +       case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
> >> > +               return "Album";
> >> > +       case AVRCP_MEDIA_ATTRIBUTE_TRACK:
> >> > +               return "Track";
> >> > +       case AVRCP_MEDIA_ATTRIBUTE_TOTAL:
> >> > +               return "Track Total";
> >> > +       case AVRCP_MEDIA_ATTRIBUTE_GENRE:
> >> > +               return "Genre";
> >> > +       case AVRCP_MEDIA_ATTRIBUTE_DURATION:
> >> > +               return "Track duration";
> >> > +       default:
> >> > +               return "Reserved";
> >> > +       }
> >> > +}
> >> > +
> >> >  static bool avrcp_passthrough_packet(struct l2cap_frame *frame)  {
> >> >         packet_hexdump(frame->data, frame->size); @@ -884,6
> >> > +923,122 @@ static bool avrcp_displayable_charset(struct
> >> > l2cap_frame *frame,
> >> uint8_t ctype,
> >> >         return true;
> >> >  }
> >> >
> >> > +static bool avrcp_get_element_attributes(struct l2cap_frame *frame,
> >> > +                                               uint8_t ctype, uint8_t len,
> >> > +                                               uint8_t indent) {
> >> > +       uint64_t id;
> >> > +       uint8_t num;
> >> > +
> >> > +       if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
> >> > +               goto response;
> >> > +
> >> > +       if (!l2cap_frame_get_be64(frame, &id))
> >> > +               return false;
> >> > +
> >> > +       print_field("%*cIdentifier: 0x%jx (%s)", (indent - 8), ' ',
> >> > +                                       id, id ? "Reserved" :
> >> > + "PLAYING");
> >> > +
> >> > +       if (!l2cap_frame_get_u8(frame, &num))
> >> > +               return false;
> >> > +
> >> > +       print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ',
> >> > + num);
> >> > +
> >> > +       for (; num > 0; num--) {
> >> > +               uint32_t attr;
> >> > +
> >> > +               if (!l2cap_frame_get_be32(frame, &attr))
> >> > +                       return false;
> >> > +
> >> > +               print_field("%*cAttribute: 0x%08x (%s)", (indent - 8),
> >> > +                                       ' ', attr, mediattr2str(attr));
> >> > +       }
> >> > +
> >> > +       return true;
> >> > +
> >> > +response:
> >> > +       if (frame->pkt_type == AVRCP_PACKET_TYPE_SINGLE
> >> > +                               || frame->pkt_type == AVRCP_PACKET_TYPE_START) {
> >> > +               if (!l2cap_frame_get_u8(frame, &num))
> >> > +                       return false;
> >> > +
> >> > +               avrcp_continuing.num = num;
> >> > +               print_field("%*cAttributeCount: 0x%02x", (indent - 8),
> >> > +                                                               ' ', num);
> >> > +               len--;
> >> > +       } else {
> >> > +               num = avrcp_continuing.num;
> >> > +
> >> > +               if (avrcp_continuing.size > 0) {
> >> > +                       uint16_t size;
> >> > +
> >> > +                       if (avrcp_continuing.size > len) {
> >> > +                               size = len;
> >> > +                               avrcp_continuing.size -= len;
> >> > +                       } else {
> >> > +                               size = avrcp_continuing.size;
> >> > +                               avrcp_continuing.size = 0;
> >> > +                       }
> >> > +
> >> > +                       printf("ContinuingAttributeValue: ");
> >> > +                       for (; size > 0; size--) {
> >> > +                               uint8_t c;
> >> > +
> >> > +                               if (!l2cap_frame_get_u8(frame, &c))
> >> > +                                       return false;
> >> > +
> >> > +                               printf("%1c", isprint(c) ? c : '.');
> >> > +                       }
> >> > +                       printf("\n");
> >> > +
> >> > +                       len -= size;
> >> > +               }
> >> > +       }
> >> > +
> >> > +       while (num > 0 && len > 0) {
> >> > +               uint32_t attr;
> >> > +               uint16_t charset, attrlen;
> >> > +
> >> > +               if (!l2cap_frame_get_be32(frame, &attr))
> >> > +                       return false;
> >> > +
> >> > +               print_field("%*cAttribute: 0x%08x (%s)", (indent - 8),
> >> > +                                               ' ', attr,
> >> > + mediattr2str(attr));
> >> > +
> >> > +               if (!l2cap_frame_get_be16(frame, &charset))
> >> > +                       return false;
> >> > +
> >> > +               print_field("%*cCharsetID: 0x%04x (%s)", (indent - 8),
> >> > +                               ' ', charset,
> >> > + charset2str(charset));
> >> > +
> >> > +               if (!l2cap_frame_get_be16(frame, &attrlen))
> >> > +                       return false;
> >> > +
> >> > +               print_field("%*cAttributeValueLength: 0x%04x",
> >> > +                                               (indent - 8), ' ',
> >> > + attrlen);
> >> > +
> >> > +               len -= sizeof(attr) + sizeof(charset) + sizeof(attrlen);
> >> > +               num--;
> >> > +
> >> > +               print_field("%*cAttributeValue: ", (indent - 8), ' ');
> >> > +               for (; attrlen > 0 && len > 0; attrlen--, len--) {
> >> > +                       uint8_t c;
> >> > +
> >> > +                       if (!l2cap_frame_get_u8(frame, &c))
> >> > +                               return false;
> >> > +
> >> > +                       printf("%1c", isprint(c) ? c : '.');
> >> > +               }
> >> > +
> >> > +               if (attrlen > 0)
> >> > +                       avrcp_continuing.size = attrlen;
> >> > +       }
> >> > +
> >> > +       avrcp_continuing.num = num;
> >> > +
> >> > +       return true;
> >> > +}
> >> > +
> >> >  struct avrcp_ctrl_pdu_data {
> >> >         uint8_t pduid;
> >> >         bool (*func) (struct l2cap_frame *frame, uint8_t ctype,
> >> > uint8_t len, @@ -899,6 +1054,7 @@ static const struct
> >> avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
> >> >         { 0x15, avrcp_get_player_attribute_text         },
> >> >         { 0x16, avrcp_get_player_value_text             },
> >> >         { 0x17, avrcp_displayable_charset               },
> >> > +       { 0x20, avrcp_get_element_attributes            },
> >> >         { }
> >> >  };
> >> >
> >> > @@ -932,6 +1088,8 @@ static bool avrcp_pdu_packet(struct
> >> > l2cap_frame
> >> *frame, uint8_t ctype,
> >> >         if (!l2cap_frame_get_be16(frame, &len))
> >> >                 return false;
> >> >
> >> > +       frame->pkt_type = pt;
> >> > +
> >>
> >> This does not belong here, you should probably pass pt in the
> >> callback not via frame, or even better have AVCTP frame
> >> representation which points to the L2CAP frame that one can contain
> things AVCTP specifics like pt.
> >
> > Currently, I see only this information to be saved. So, can we not
> > declare a static variable pkt_type in avctp.c. Later on, if more
> > information need to be saved then we can define a frame structure.
> 
> I would probably pass pt to avrcp_packet to be forward to the callback just as
> you did with hdr, but I still think and AVCTP frame representation would be
> better as it can grow without always having to change the callbacks in the
> pdu table e.g.:
> 
> struct avctp_frame {
>     uint8_t hdr;
>     uint8_t pt;
>     struct l2cap_frame l2cap_frame;
> };
> 
> --
> Luiz Augusto von Dentz

I agree with your suggestion. I'll make the necessary changes in design. Thanks!

Regards,
Vikram

