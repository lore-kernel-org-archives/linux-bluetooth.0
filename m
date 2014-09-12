Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <00ef01cfce81$46b27fc0$d4177f40$@samsung.com>
References: <1410438912-14213-1-git-send-email-vikram.pal@samsung.com>
	<CABBYNZKckUXadzuxjoiSfbGYmt9nPLSLp1fHDafBqOtVSyZaOg@mail.gmail.com>
	<00ee01cfce74$0288c640$079a52c0$@samsung.com>
	<CABBYNZLmf-wQ6w=bBV8a7Xx-8LwDaYDwsR6q_WaQTG0Dknkq8g@mail.gmail.com>
	<00ef01cfce81$46b27fc0$d4177f40$@samsung.com>
Date: Fri, 12 Sep 2014 15:08:47 +0300
Message-ID: <CABBYNZJQSXMA-Jk9wcvi-5xXQCsQE5tOikez2SYgs=UBVct1sA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Monitor: Modify design of AVRCP callback functions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Fri, Sep 12, 2014 at 3:00 PM, Vikrampal <vikram.pal@samsung.com> wrote:
> Hi Luiz,
>
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: Friday, September 12, 2014 4:45 PM
>> To: Vikrampal
>> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; cpgs@samsung.com
>> Subject: Re: [PATCH 1/2] Monitor: Modify design of AVRCP callback functions
>>
>> Hi Vikram,
>>
>> On Fri, Sep 12, 2014 at 1:25 PM, Vikrampal <vikram.pal@samsung.com>
>> wrote:
>> > Hi Luiz,
>> >
>> >> -----Original Message-----
>> >> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> >> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
>> >> Sent: Friday, September 12, 2014 3:37 PM
>> >> To: Vikrampal Yadav
>> >> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin;
>> >> cpgs@samsung.com
>> >> Subject: Re: [PATCH 1/2] Monitor: Modify design of AVRCP callback
>> >> functions
>> >>
>> >> Hi Vikram,
>> >>
>> >> On Thu, Sep 11, 2014 at 3:35 PM, Vikrampal Yadav
>> >> <vikram.pal@samsung.com> wrote:
>> >> > Modified the design of AVRCP callback functions.
>> >> > ---
>> >> >  monitor/avctp.c | 94
>> >> > +++++++++++++++++++++++++++++++++++++++------------------
>> >> >  1 file changed, 65 insertions(+), 29 deletions(-)
>> >> >
>> >> > diff --git a/monitor/avctp.c b/monitor/avctp.c index
>> >> > c7e242b..41b6380
>> >> > 100644
>> >> > --- a/monitor/avctp.c
>> >> > +++ b/monitor/avctp.c
>> >> > @@ -158,6 +158,12 @@
>> >> >  #define AVRCP_ATTRIBUTE_SHUFFLE                0x03
>> >> >  #define AVRCP_ATTRIBUTE_SCAN           0x04
>> >> >
>> >> > +struct avctp_frame {
>> >> > +       uint8_t hdr;
>> >> > +       uint8_t pt;
>> >> > +       struct l2cap_frame *l2cap_frame; };
>> >> > +
>> >> >  static const char *ctype2str(uint8_t ctype)  {
>> >> >         switch (ctype & 0x0f) {
>> >> > @@ -517,15 +523,19 @@ static const char *charset2str(uint16_t
>> charset)
>> >> >         }
>> >> >  }
>> >> >
>> >> > -static bool avrcp_passthrough_packet(struct l2cap_frame *frame)
>> >> > +static bool avrcp_passthrough_packet(struct avctp_frame
>> >> > +*avctp_frame)
>> >> >  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> > +
>> >> >         packet_hexdump(frame->data, frame->size);
>> >> >         return true;
>> >> >  }
>> >> >
>> >> > -static bool avrcp_get_capabilities(struct l2cap_frame *frame,
>> >> > uint8_t
>> >> ctype,
>> >> > -                                               uint8_t len, uint8_t indent)
>> >> > +static bool avrcp_get_capabilities(struct avctp_frame *avctp_frame,
>> >> > +                                       uint8_t ctype, uint8_t len,
>> >> > +                                       uint8_t indent)
>> >> >  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> >         uint8_t cap, count;
>> >> >         int i;
>> >> >
>> >> > @@ -576,10 +586,11 @@ static bool avrcp_get_capabilities(struct
>> >> l2cap_frame *frame, uint8_t ctype,
>> >> >         return true;
>> >> >  }
>> >> >
>> >> > -static bool avrcp_list_player_attributes(struct l2cap_frame
>> >> > *frame,
>> >> > +static bool avrcp_list_player_attributes(struct avctp_frame
>> >> > +*avctp_frame,
>> >> >                                                 uint8_t ctype, uint8_t len,
>> >> >                                                 uint8_t indent)  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> >         uint8_t num;
>> >> >         int i;
>> >> >
>> >> > @@ -604,9 +615,11 @@ static bool
>> >> > avrcp_list_player_attributes(struct
>> >> l2cap_frame *frame,
>> >> >         return true;
>> >> >  }
>> >> >
>> >> > -static bool avrcp_list_player_values(struct l2cap_frame *frame,
>> >> > uint8_t
>> >> ctype,
>> >> > -                                               uint8_t len, uint8_t indent)
>> >> > +static bool avrcp_list_player_values(struct avctp_frame *avctp_frame,
>> >> > +                                       uint8_t ctype, uint8_t len,
>> >> > +                                       uint8_t indent)
>> >> >  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> >         static uint8_t attr = 0;
>> >> >         uint8_t num;
>> >> >
>> >> > @@ -640,10 +653,11 @@ response:
>> >> >         return true;
>> >> >  }
>> >> >
>> >> > -static bool avrcp_get_current_player_value(struct l2cap_frame
>> >> > *frame,
>> >> > +static bool avrcp_get_current_player_value(struct avctp_frame
>> >> > +*avctp_frame,
>> >> >                                                 uint8_t ctype, uint8_t len,
>> >> >                                                 uint8_t indent)  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> >         uint8_t num;
>> >> >
>> >> >         if (!l2cap_frame_get_u8(frame, &num)) @@ -688,9 +702,11 @@
>> >> > response:
>> >> >         return true;
>> >> >  }
>> >> >
>> >> > -static bool avrcp_set_player_value(struct l2cap_frame *frame,
>> >> > uint8_t
>> >> ctype,
>> >> > -                                       uint8_t len, uint8_t indent)
>> >> > +static bool avrcp_set_player_value(struct avctp_frame *avctp_frame,
>> >> > +                                       uint8_t ctype, uint8_t len,
>> >> > +                                       uint8_t indent)
>> >> >  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> >         uint8_t num;
>> >> >
>> >> >         if (ctype > AVC_CTYPE_GENERAL_INQUIRY) @@ -720,10 +736,11
>> >> > @@ static bool avrcp_set_player_value(struct l2cap_frame *frame,
>> >> > uint8_t
>> >> ctype,
>> >> >         return true;
>> >> >  }
>> >> >
>> >> > -static bool avrcp_get_player_attribute_text(struct l2cap_frame
>> >> > *frame,
>> >> > +static bool avrcp_get_player_attribute_text(struct avctp_frame
>> >> > +*avctp_frame,
>> >> >                                                 uint8_t ctype, uint8_t len,
>> >> >                                                 uint8_t indent)  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> >         uint8_t num;
>> >> >
>> >> >         if (!l2cap_frame_get_u8(frame, &num)) @@ -783,10 +800,11 @@
>> >> > response:
>> >> >         return true;
>> >> >  }
>> >> >
>> >> > -static bool avrcp_get_player_value_text(struct l2cap_frame *frame,
>> >> > +static bool avrcp_get_player_value_text(struct avctp_frame
>> >> > +*avctp_frame,
>> >> >                                         uint8_t ctype, uint8_t len,
>> >> >                                         uint8_t indent)  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> >         static uint8_t attr = 0;
>> >> >         uint8_t num;
>> >> >
>> >> > @@ -858,9 +876,11 @@ response:
>> >> >         return true;
>> >> >  }
>> >> >
>> >> > -static bool avrcp_displayable_charset(struct l2cap_frame *frame,
>> >> > uint8_t
>> >> ctype,
>> >> > -                                       uint8_t len, uint8_t indent)
>> >> > +static bool avrcp_displayable_charset(struct avctp_frame
>> *avctp_frame,
>> >> > +                                       uint8_t ctype, uint8_t len,
>> >> > +                                       uint8_t indent)
>> >> >  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> >         uint8_t num;
>> >> >
>> >> >         if (ctype > AVC_CTYPE_GENERAL_INQUIRY) @@ -886,8 +906,8 @@
>> >> > static bool avrcp_displayable_charset(struct l2cap_frame *frame,
>> >> > uint8_t ctype,
>> >> >
>> >> >  struct avrcp_ctrl_pdu_data {
>> >> >         uint8_t pduid;
>> >> > -       bool (*func) (struct l2cap_frame *frame, uint8_t ctype, uint8_t len,
>> >> > -                                                       uint8_t indent);
>> >> > +       bool (*func) (struct avctp_frame *avctp_frame, uint8_t ctype,
>> >> > +                                               uint8_t len,
>> >> > + uint8_t indent);
>> >> >  };
>> >> >
>> >> >  static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
>> >> > @@
>> >> > -915,9 +935,10 @@ static bool avrcp_rejected_packet(struct
>> >> > l2cap_frame
>> >> *frame, uint8_t indent)
>> >> >         return true;
>> >> >  }
>> >> >
>> >> > -static bool avrcp_pdu_packet(struct l2cap_frame *frame, uint8_t
>> >> > ctype,
>> >> > +static bool avrcp_pdu_packet(struct avctp_frame *avctp_frame,
>> >> > +uint8_t ctype,
>> >> >
>> >> > uint8_t indent)  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> >         uint8_t pduid, pt;
>> >> >         uint16_t len;
>> >> >         int i;
>> >> > @@ -929,6 +950,9 @@ static bool avrcp_pdu_packet(struct
>> l2cap_frame
>> >> *frame, uint8_t ctype,
>> >> >         if (!l2cap_frame_get_u8(frame, &pt))
>> >> >                 return false;
>> >> >
>> >> > +       /* For further use */
>> >> > +       avctp_frame->pt = pt;
>> >> > +
>> >> >         if (!l2cap_frame_get_be16(frame, &len))
>> >> >                 return false;
>> >> >
>> >> > @@ -953,11 +977,13 @@ static bool avrcp_pdu_packet(struct
>> >> > l2cap_frame
>> >> *frame, uint8_t ctype,
>> >> >                 return true;
>> >> >         }
>> >> >
>> >> > -       return ctrl_pdu_data->func(frame, ctype, len, indent + 2);
>> >> > +       return ctrl_pdu_data->func(avctp_frame, ctype, len, indent
>> >> > + + 2);
>> >> >  }
>> >> >
>> >> > -static bool avrcp_control_packet(struct l2cap_frame *frame)
>> >> > +static bool avrcp_control_packet(struct avctp_frame *avctp_frame)
>> >> >  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> > +
>> >> >         uint8_t ctype, address, subunit, opcode, company[3], indent
>> >> > = 2;
>> >> >
>> >> >         if (!l2cap_frame_get_u8(frame, &ctype) || @@ -988,7 +1014,7
>> >> > @@ static bool avrcp_control_packet(struct l2cap_frame *frame)
>> >> >
>> >> >         switch (opcode) {
>> >> >         case 0x7c:
>> >> > -               return avrcp_passthrough_packet(frame);
>> >> > +               return avrcp_passthrough_packet(avctp_frame);
>> >> >         case 0x00:
>> >> >                 if (!l2cap_frame_get_u8(frame, &company[0]) ||
>> >> >                                 !l2cap_frame_get_u8(frame,
>> >> > &company[1]) || @@ -998,29 +1024,32 @@ static bool
>> >> avrcp_control_packet(struct l2cap_frame *frame)
>> >> >                 print_field("%*cCompany ID: 0x%02x%02x%02x", indent, ' ',
>> >> >                                         company[0], company[1],
>> >> > company[2]);
>> >> >
>> >> > -               return avrcp_pdu_packet(frame, ctype, 10);
>> >> > +               return avrcp_pdu_packet(avctp_frame, ctype, 10);
>> >> >         default:
>> >> >                 packet_hexdump(frame->data, frame->size);
>> >> >                 return true;
>> >> >         }
>> >> >  }
>> >> >
>> >> > -static bool avrcp_browsing_packet(struct l2cap_frame *frame,
>> >> > uint8_t
>> >> > hdr)
>> >> > +static bool avrcp_browsing_packet(struct avctp_frame *avctp_frame)
>> >> >  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> > +
>> >> >         packet_hexdump(frame->data, frame->size);
>> >> >         return true;
>> >> >  }
>> >> >
>> >> > -static void avrcp_packet(struct l2cap_frame *frame, uint8_t hdr)
>> >> > +static void avrcp_packet(struct avctp_frame *avctp_frame)
>> >> >  {
>> >> > +       struct l2cap_frame *frame = avctp_frame->l2cap_frame;
>> >> >         bool ret;
>> >> >
>> >> >         switch (frame->psm) {
>> >> >         case 0x17:
>> >> > -               ret = avrcp_control_packet(frame);
>> >> > +               ret = avrcp_control_packet(avctp_frame);
>> >> >                 break;
>> >> >         case 0x1B:
>> >> > -               ret = avrcp_browsing_packet(frame, hdr);
>> >> > +               ret = avrcp_browsing_packet(avctp_frame);
>> >> >                 break;
>> >> >         default:
>> >> >                 packet_hexdump(frame->data, frame->size); @@
>> >> > -1037,18
>> >> > +1066,25 @@ void avctp_packet(const struct l2cap_frame *frame)  {
>> >> >         uint8_t hdr;
>> >> >         uint16_t pid;
>> >> > -       struct l2cap_frame avctp_frame;
>> >> > +       struct l2cap_frame l2cap_frame;
>> >> > +       struct avctp_frame avctp_frame;
>> >> >         const char *pdu_color;
>> >> >
>> >> > -       l2cap_frame_pull(&avctp_frame, frame, 0);
>> >> > +       l2cap_frame_pull(&l2cap_frame, frame, 0);
>> >>
>> >> I think it better to use only one variable, avctp_frame, and change
>> >> the struct to actually have the data inline instead of a pointer:
>> >>
>> >
>> > I couldn't understand as to how having data inline instead of a pointer is
>> better here.
>> > Having pointer is sufficient. Isn't it? Moreover, in function avctp_packet(),
>> we are receiving a pointer only.
>>
>> It is one variable less in the stack and since you will be forwarding
>> avctp_frame it will include l2cap_frame as well but it is not a pointer to a
>> second variable in the stack, it is a small optimization but as I said we are
>> always passing the avctp_frame around having a separate variable in the
>> stack does not buy us anything.
>>
>> >> struct avctp_frame {
>> >>    uint8_t hdr;
>> >>    uint8_t pt;
>> >>    struct l2cap_frame l2cap_frame; /* note that is not a pointer */ }
>> >>
>> >> >
>> >> > -       if (!l2cap_frame_get_u8(&avctp_frame, &hdr) ||
>> >> > -                               !l2cap_frame_get_be16(&avctp_frame, &pid)) {
>> >> > +       /* For further use */
>> >> > +       avctp_frame.l2cap_frame = &l2cap_frame;
>> >> > +
>> >> > +       if (!l2cap_frame_get_u8(&l2cap_frame, &hdr) ||
>> >> > +                       !l2cap_frame_get_be16(&l2cap_frame, &pid))
>> >> > + {
>> >> >                 print_text(COLOR_ERROR, "frame too short");
>> >> >                 packet_hexdump(frame->data, frame->size);
>> >> >                 return;
>> >> >         }
>> >>
>> >> You should be able to use the fields from the struct directly and
>> >> eliminate the user of extra variable here.
>> >>
>> >> > +       /* For further use */
>> >> > +       avctp_frame.hdr = hdr;
>> >> > +
>> >> >         if (frame->in)
>> >> >                 pdu_color = COLOR_MAGENTA;
>> >> >         else
>> >> > @@ -1061,7 +1097,7 @@ void avctp_packet(const struct l2cap_frame
>> >> *frame)
>> >> >                                 hdr & 0x0c, hdr >> 4, pid);
>> >> >
>> >> >         if (pid == 0x110e || pid == 0x110c)
>> >> > -               avrcp_packet(&avctp_frame, hdr);
>> >> > +               avrcp_packet(&avctp_frame);
>> >> >         else
>> >> >                 packet_hexdump(frame->data, frame->size);
>> >>
>> >> pid should probably be part of the avctp_frame as well.
>> >>
>> >> >  }
>> >> > --
>> >> > 1.9.1
>> >>
>> >> Btw, this patch does not apply when checking with check patch:
>> >>
>> >> Applying: Monitor: Modify design of AVRCP callback functions
>> >> bluez/.git/rebase-apply/patch:132: trailing whitespace.
>> >> uint8_t ctype, uint8_t len,
>> >> fatal: 1 line adds whitespace errors.
>> >>
>> >> Please add a hook to check patch, for example what I use is:
>> >>
>> >> exec git diff --cached | checkpatch.pl -q --no-signoff --ignore
>> >>
>> CAMELCASE,NEW_TYPEDEFS,INITIALISED_STATIC,GLOBAL_INITIALISERS,PREF
>> >>
>> ER_PACKED,SPACING,FSF_MAILING_ADDRESS,TRAILING_STATEMENTS,RETUR
>> >> N_VOID,FILE_PATH_CHANGES
>> >>  --show-types -
>> >>
>> >> --
>> >> Luiz Augusto von Dentz
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe
>> >> linux-bluetooth" in the body of a message to
>> >> majordomo@vger.kernel.org More majordomo info at
>> >> http://vger.kernel.org/majordomo-info.html
>> >
>> > Regards,
>> > Vikram
>> >
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
> The structure becomes now:
> struct avctp_frame {
>         uint8_t hdr;
>         uint8_t pt;
>         uint16_t pid;
>         struct l2cap_frame l2cap_frame;
> };
>
> And the new function:
>
> void avctp_packet(const struct l2cap_frame *frame)
> {
>         struct l2cap_frame *l2cap_frame;
>         struct avctp_frame avctp_frame;
>         const char *pdu_color;
>
>         l2cap_frame_pull(&avctp_frame.l2cap_frame, frame, 0);
>
>         l2cap_frame = &avctp_frame.l2cap_frame;
>
>         if (!l2cap_frame_get_u8(l2cap_frame, &avctp_frame.hdr) ||
>                         !l2cap_frame_get_be16(l2cap_frame, &avctp_frame.pid)) {
>                 print_text(COLOR_ERROR, "frame too short");
>                 packet_hexdump(frame->data, frame->size);
>                 return;
>         }
>
>         if (frame->in)
>                 pdu_color = COLOR_MAGENTA;
>         else
>                 pdu_color = COLOR_BLUE;
>
>         print_indent(6, pdu_color, "AVCTP", "", COLOR_OFF,
>                                 " %s: %s: type 0x%02x label %d PID 0x%04x",
>                                 frame->psm == 23 ? "Control" : "Browsing",
>                                 avctp_frame.hdr & 0x02 ? "Response" : "Command",
>                                 avctp_frame.hdr & 0x0c, avctp_frame.hdr >> 4,
>                                 avctp_frame.pid);
>
>         if (avctp_frame.pid == 0x110e || avctp_frame.pid == 0x110c)
>                 avrcp_packet(&avctp_frame);
>         else
>                 packet_hexdump(frame->data, frame->size);
> }

This looks better, just make sure you fix the coding style as well.

-- 
Luiz Augusto von Dentz
