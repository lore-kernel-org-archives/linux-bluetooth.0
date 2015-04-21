Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1429190200-13911-1-git-send-email-bharat.panda@samsung.com>
 <CABBYNZLsfxUGYowi8bgVTrTcN7=8=Z769RnJeBRnAQ5MTwMSRw@mail.gmail.com>
In-reply-to: <CABBYNZLsfxUGYowi8bgVTrTcN7=8=Z769RnJeBRnAQ5MTwMSRw@mail.gmail.com>
Subject: RE: [PATCH 1/4] monitor: Add AVRCP GetFolderItems Support
Date: Tue, 21 Apr 2015 17:28:09 +0530
Message-id: <025201d07c2a$7728af10$657a0d30$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Friday, April 17, 2015 7:34 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH 1/4] monitor: Add AVRCP GetFolderItems Support
> 
> Hi Bharat,
> 
> On Thu, Apr 16, 2015 at 4:16 PM, Bharat Panda
> <bharat.panda@samsung.com> wrote:
> > Support for decoding AVRCP GetFolderItems added in btmon.
> >
> >       Channel: 65 len 20 ctrl 0x0000 [PSM 27 mode 3] {chan 1}
> >       I-frame: Unsegmented TxSeq 0 ReqSeq 0
> >       AVCTP Browsing: Command: type 0x00 label 0 PID 0x110e
> >         AVRCP: GetFolderItems: len 0x000a
> >           Scope: 0x01 (Media Player Virtual Filesystem)
> >           StartItem: 0x00000000 (0)
> >           EndItem: 0x0000000a (10)
> >           AttributeCount: 0xff (255)
> >           AttributeID: 0x0000326e (Reserved)
> > ---
> >  monitor/avctp.c | 113
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 111 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor/avctp.c b/monitor/avctp.c index c599aa4..a55cb41
> > 100644
> > --- a/monitor/avctp.c
> > +++ b/monitor/avctp.c
> > @@ -182,6 +182,11 @@
> >  #define AVRCP_MEDIA_SEARCH             0x02
> >  #define AVRCP_MEDIA_NOW_PLAYING                0x03
> >
> > +/* Media Item Type */
> > +#define AVRCP_MEDIA_PLAYER_ITEM_TYPE   0x01
> > +#define AVRCP_FOLDER_ITEM_TYPE                 0x02
> > +#define AVRCP_MEDIA_ELEMENT_ITEM_TYPE  0x03
> > +
> >  /* operands in passthrough commands */
> >  #define AVC_PANEL_VOLUME_UP            0x41
> >  #define AVC_PANEL_VOLUME_DOWN          0x42
> > @@ -677,6 +682,20 @@ static char *op2str(uint8_t op)
> >         }
> >  }
> >
> > +static const char *type2str(uint8_t type) {
> > +       switch (type) {
> > +       case AVRCP_MEDIA_PLAYER_ITEM_TYPE:
> > +               return "Media Player";
> > +       case AVRCP_FOLDER_ITEM_TYPE:
> > +               return "Folder";
> > +       case AVRCP_MEDIA_ELEMENT_ITEM_TYPE:
> > +               return "Media Element";
> > +       default:
> > +               return "Unknown";
> > +       }
> > +}
> > +
> >  static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame,
> >
> > uint8_t indent)  { @@ -1096,10 +1115,10 @@ static bool
> > avrcp_get_element_attributes(struct avctp_frame *avctp_frame,
> >         for (; num > 0; num--) {
> >                 uint32_t attr;
> >
> > -               if (!l2cap_frame_get_be32(frame, &attr))
> > +               if (!l2cap_frame_get_le32(frame, &attr))
> >                         return false;
> >
> > -               print_field("%*cAttribute: 0x%08x (%s)", (indent - 8),
> > +               print_field("%*cAttributeID: 0x%08x (%s)", (indent -
> > + 8),
> >                                         ' ', attr, mediattr2str(attr));
> >         }
> >
> > @@ -1637,6 +1656,93 @@ static bool avrcp_control_packet(struct
> avctp_frame *avctp_frame)
> >         }
> >  }
> >
> > +static bool avrcp_get_folder_items(struct avctp_frame *avctp_frame) {
> > +       struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
> > +       uint8_t scope, count, status, indent = 2;
> > +       uint32_t start, end;
> > +       uint16_t uid, num;
> > +
> > +       if (avctp_frame->hdr & 0x02)
> > +               goto response;
> > +
> > +       if (!l2cap_frame_get_u8(frame, &scope))
> > +               return false;
> > +
> > +       print_field("%*cScope: 0x%02x (%s)", indent, ' ',
> > +                                       scope, scope2str(scope));
> > +
> > +       if (!l2cap_frame_get_be32(frame, &start))
> > +               return false;
> > +
> > +       print_field("%*cStartItem: 0x%08x (%u)", indent, ' ', start,
> > + start);
> > +
> > +       if (!l2cap_frame_get_be32(frame, &end))
> > +               return false;
> > +
> > +       print_field("%*cEndItem: 0x%08x (%u)", indent, ' ', end, end);
> > +
> > +       if (!l2cap_frame_get_u8(frame, &count))
> > +               return false;
> > +
> > +       print_field("%*cAttributeCount: 0x%02x (%u)", indent, ' ',
> > +                                               count, count);
> > +
> > +       for (; count > 0; count--) {
> > +               uint16_t attr;
> > +
> > +               if (!l2cap_frame_get_be16(frame, &attr)) {
> > +                       return false;
> > +               }
> > +
> > +               print_field("%*cAttributeID: 0x%08x (%s)", indent, ' ',
> > +                                       attr, mediattr2str(attr));
> > +       }
> > +
> > +       return false;
> > +
> > +response:
> > +       if (!l2cap_frame_get_u8(frame, &status))
> > +               return false;
> > +
> > +       print_field("%*cStatus: 0x%02x (%s)", indent, ' ',
> > +                               status, error2str(status));
> > +
> > +       if (!l2cap_frame_get_be16(frame, &uid))
> > +               return false;
> > +
> > +       print_field("%*cUIDCounter: 0x%04x (%u)", indent, ' ', uid,
> > + uid);
> > +
> > +       if (!l2cap_frame_get_be16(frame, &num))
> > +               return false;
> > +
> > +       print_field("%*cUIDCounter: 0x%04x (%u)", indent, ' ', num,
> > + num);
> > +
> > +       for (; num > 0; num--) {
> > +               uint8_t type;
> > +               uint16_t len;
> > +
> > +               if (!l2cap_frame_get_u8(frame, &type))
> > +                       return false;
> > +
> > +               if (!l2cap_frame_get_be16(frame, &len))
> > +                       return false;
> > +
> > +               print_field("%*cItem: 0x%02x (%s) ", indent, ' ',
> > +                                       type, type2str(type));
> > +               print_field("%*cLength: 0x%04x (%u)", indent, ' ',
> > + len, len);
> > +
> > +               switch (type) {
> > +               case AVRCP_MEDIA_PLAYER_ITEM_TYPE:
> > +               case AVRCP_FOLDER_ITEM_TYPE:
> > +               case AVRCP_MEDIA_ELEMENT_ITEM_TYPE:
> > +                       packet_hexdump(frame->data, frame->size);
> > +                       break;
> > +               }
> > +       }
> > +       return true;
> > +}
> > +
> >  static bool avrcp_set_browsed_player(struct avctp_frame *avctp_frame)
> > {
> >         struct l2cap_frame *frame = &avctp_frame->l2cap_frame; @@
> > -1722,6 +1828,9 @@ static bool avrcp_browsing_packet(struct avctp_frame
> *avctp_frame)
> >         case AVRCP_SET_BROWSED_PLAYER:
> >                 avrcp_set_browsed_player(avctp_frame);
> >                 break;
> > +       case AVRCP_GET_FOLDER_ITEMS:
> > +               avrcp_get_folder_items(avctp_frame);
> > +               break;
> >         default:
> >                 packet_hexdump(frame->data, frame->size);
> >         }
> > --
> > 1.9.1
> 
> Applied, note that one of the patches was not compiling:
> 
> http://fpaste.org/212274/29279121/
> 
> Im not sure how you were even able to test it before because
> if(l2cap_frame_get_be128 should always return but after fixing the check for
> !l2cap_frame_get_be128 it seems to work properly.
> 

Thanks. I will make sure such mistakes won't happen in future patches.

Best Regards,
Bharat


