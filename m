Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001f01d0108c$2041e680$60c5b380$@samsung.com>
References: <1417608081-27926-1-git-send-email-gowtham.ab@samsung.com>
	<CAA4A+aDGt89cqFVfdGc4vpRpH1kB9qf+Y5XonTvmXaJ9pBz9vg@mail.gmail.com>
	<000501d01078$707a0830$516e1890$@samsung.com>
	<1762326.kKINeE8oQE@uw000953>
	<000601d0107c$32fcecd0$98f6c670$@samsung.com>
	<CABBYNZ+_TtLrV3gCRFXjemLQNPskTq6=XDN8Jg+LuD4CQEe3ow@mail.gmail.com>
	<001f01d0108c$2041e680$60c5b380$@samsung.com>
Date: Fri, 5 Dec 2014 15:07:34 +0200
Message-ID: <CABBYNZKK=fuaUNDBvCjE6qaL6xHPL7LtS87dAattGYBeA2mPHA@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] monitor/rfcomm: Add support for RPN frame decoding
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Fri, Dec 5, 2014 at 3:04 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi Luiz,
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
>> Sent: Friday, December 05, 2014 5:18 PM
>> To: Gowtham Anandha Babu
>> Cc: Szymon Janc; linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat
>> Panda; cpgs@samsung.com
>> Subject: Re: [PATCH v1 2/5] monitor/rfcomm: Add support for RPN frame
>> decoding
>>
>> Hi Gowtham,
>>
>> On Fri, Dec 5, 2014 at 1:10 PM, Gowtham Anandha Babu
>> <gowtham.ab@samsung.com> wrote:
>> > Hi Szymon,
>> >
>> >> -----Original Message-----
>> >> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> >> owner@vger.kernel.org] On Behalf Of Szymon Janc
>> >> Sent: Friday, December 05, 2014 4:33 PM
>> >> To: Gowtham Anandha Babu
>> >> Cc: 'Szymon Janc'; linux-bluetooth@vger.kernel.org;
>> >> d.kasatkin@samsung.com; bharat.panda@samsung.com;
>> cpgs@samsung.com
>> >> Subject: Re: [PATCH v1 2/5] monitor/rfcomm: Add support for RPN frame
>> >> decoding
>> >>
>> >> Hi Gowtham,
>> >>
>> >> On Friday 05 of December 2014 16:14:20 Gowtham Anandha Babu wrote:
>> >> > Hi Szymon,
>> >> >
>> >> > > -----Original Message-----
>> >> > > From: linux-bluetooth-owner@vger.kernel.org
>> >> > > [mailto:linux-bluetooth- owner@vger.kernel.org] On Behalf Of
>> >> > > Szymon Janc
>> >> > > Sent: Thursday, December 04, 2014 8:48 PM
>> >> > > To: Gowtham Anandha Babu
>> >> > > Cc: linux-bluetooth@vger.kernel.org; d.kasatkin@samsung.com;
>> >> > > bharat.panda@samsung.com; cpgs@samsung.com
>> >> > > Subject: Re: [PATCH v1 2/5] monitor/rfcomm: Add support for RPN
>> >> > > frame decoding
>> >> > >
>> >> > > Hi Gowtham,
>> >> > >
>> >> > > On Wed, Dec 3, 2014 at 1:01 PM, Gowtham Anandha Babu
>> >> > > <gowtham.ab@samsung.com> wrote:
>> >> > > > Changes made to decode RPN frame in RFCOMM for btmon.
>> >> > > >
>> >> > > >       RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
>> >> > > >          Address: 0x03 cr 1 dlci 0x00
>> >> > > >          Control: 0xef poll/final 0
>> >> > > >          Length: 10
>> >> > > >          FCS: 0x70
>> >> > > >          MCC Message type: Remote Port Negotiation Command
>> >> CMD(0x24)
>> >> > > >            Length: 8
>> >> > > >            dlci 32
>> >> > > >            br 3 db 2 sb 0 p 0 pt 0 xi 0 xo 0
>> >> > > >            rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19
>> >> > > >            pm 0x3f7f
>> >> > > > ---
>> >> > > >  monitor/rfcomm.c | 73
>> >> > > >
>> >> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >> > > >  1 file changed, 73 insertions(+)
>> >> > > >
>> >> > > > diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c index
>> >> > > > cd50c8c..62b52cc 100644
>> >> > > > --- a/monitor/rfcomm.c
>> >> > > > +++ b/monitor/rfcomm.c
>> >> > > > @@ -63,6 +63,18 @@ static char *cr_str[] = {
>> >> > > >  #define GET_V24_IC(sigs)       ((sigs & 0x40) >> 6)
>> >> > > >  #define GET_V24_DV(sigs)       ((sigs & 0x80) >> 7)
>> >> > > >
>> >> > > > +/* RPN macros */
>> >> > > > +#define GET_RPN_DB(parity)     (parity & 0x03)
>> >> > > > +#define GET_RPN_SB(parity)     ((parity & 0x04) >> 2)
>> >> > > > +#define GET_RPN_PARITY(parity) ((parity & 0x08) >> 3) #define
>> >> > > > +GET_RPN_PTYPE(parity)  ((parity & 0x03) >> 3)
>> >> > > > +#define GET_RPN_XIN(io)                (io & 0x01)
>> >> > > > +#define GET_RPN_XOUT(io)       ((io & 0x02) >> 1)
>> >> > > > +#define GET_RPN_RTRI(io)       ((io & 0x04) >> 2)
>> >> > > > +#define GET_RPN_RTRO(io)       ((io & 0x08) >> 3)
>> >> > > > +#define GET_RPN_RTCI(io)       ((io & 0x10) >> 4)
>> >> > > > +#define GET_RPN_RTCO(io)       ((io & 0x20) >> 5)
>> >> > > > +
>> >> > > >  struct rfcomm_lhdr {
>> >> > > >         uint8_t address;
>> >> > > >         uint8_t control;
>> >> > > > @@ -77,6 +89,16 @@ struct rfcomm_lmsc {
>> >> > > >         uint8_t break_sig;
>> >> > > >  } __attribute__((packed));
>> >> > > >
>> >> > > > +struct rfcomm_rpn {
>> >> > > > +       uint8_t dlci;
>> >> > > > +       uint8_t bit_rate;
>> >> > > > +       uint8_t parity;
>> >> > > > +       uint8_t io;
>> >> > > > +       uint8_t xon;
>> >> > > > +       uint8_t xoff;
>> >> > > > +       uint16_t pm;
>> >> > > > +} __attribute__ ((packed));
>> >> > > > +
>> >> > > >  struct rfcomm_lmcc {
>> >> > > >         uint8_t type;
>> >> > > >         uint16_t length;
>> >> > > > @@ -138,6 +160,55 @@ done:
>> >> > > >         return true;
>> >> > > >  }
>> >> > > >
>> >> > > > +static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame,
>> >> > > > +uint8_t
>> >> > > > +indent) {
>> >> > > > +       struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
>> >> > > > +       struct rfcomm_rpn rpn;
>> >> > > > +
>> >> > > > +       if (!l2cap_frame_get_u8(frame, &rpn.dlci))
>> >> > > > +               return false;
>> >> > > > +
>> >> > > > +       print_field("%*cdlci %d", indent, ' ',
>> >> > > > + RFCOMM_GET_DLCI(rpn.dlci));
>> >> > > > +
>> >> > > > +       if (frame->size < 7)
>> >> > > > +               goto done;
>> >> > > > +
>> >> > > > +       /* port value octets (optional) */
>> >> > > > +
>> >> > > > +       if (!l2cap_frame_get_u8(frame, &rpn.bit_rate))
>> >> > > > +               return false;
>> >> > > > +
>> >> > > > +       if (!l2cap_frame_get_u8(frame, &rpn.parity))
>> >> > > > +               return false;
>> >> > > > +
>> >> > > > +       if (!l2cap_frame_get_u8(frame, &rpn.io))
>> >> > > > +               return false;
>> >> > > > +
>> >> > > > +       print_field("%*cbr %d db %d sb %d p %d pt %d xi %d xo
>> >> > > > + %d",
>> >> > indent, '
>> >> > > ',
>> >> > > > +               rpn.bit_rate, GET_RPN_DB(rpn.parity),
>> >> > GET_RPN_SB(rpn.parity),
>> >> > > > +               GET_RPN_PARITY(rpn.parity), GET_RPN_PTYPE(rpn.parity),
>> >> > > > +               GET_RPN_XIN(rpn.io), GET_RPN_XOUT(rpn.io));
>> >> > > > +
>> >> > > > +       if (!l2cap_frame_get_u8(frame, &rpn.xon))
>> >> > > > +               return false;
>> >> > > > +
>> >> > > > +       if (!l2cap_frame_get_u8(frame, &rpn.xoff))
>> >> > > > +               return false;
>> >> > > > +
>> >> > > > +       print_field("%*crtri %d rtro %d rtci %d rtco %d xon %d xoff %d",
>> >> > > > +               indent, ' ', GET_RPN_RTRI(rpn.io), GET_RPN_RTRO(rpn.io),
>> >> > > > +               GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon,
>> >> > > > +               rpn.xoff);
>> >> > > > +
>> >> > > > +       if (!l2cap_frame_get_be16(frame, &rpn.pm))
>> >> > > > +               return false;
>> >> > > > +
>> >> > > > +       print_field("%*cpm 0x%04x", indent, ' ',
>> >> > > > + __bswap_16(rpn.pm));
>> >> > >
>> >> > > This __bswap_16 is invalid since rpn.pm was already converted to
>> >> > > host
>> >> > order
>> >> > > by l2cap_frame_get_be16(). (It wouldn't work correctly on BE arch
>> >> anyway).
>> >> > >
>> >> > > Also this was causing build problems under Android. If you are
>> >> > > able to
>> >> > build-
>> >> > > test under Android please do so. If not then at least point this
>> >> > > in cover
>> >> > letter
>> >> > > or patch comment that code was tested only under Linux).
>> >> > >
>> >> > > I've fixed this myself but please pay attention to this with any
>> >> > > future submission.
>> >> > >
>> >> >
>> >> > Sure I will mention the tested platform details for future submission.
>> >> >
>> >> > Btw without __bswap_16(), rpn.pm and pn.mtu will be different from
>> >> > the hcidump logs.
>> >> >
>> >> > This is captured by removing __bswap_16().
>> >> >
>> >> > Btmon log:
>> >> >       RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
>> >> >          Address: 0x03 cr 1 dlci 0x00
>> >> >          Control: 0xef poll/final 0
>> >> >          Length: 10
>> >> >          FCS: 0x70
>> >> >          MCC Message type: DLC Parameter Negotiation CMD(0x20)
>> >> >            Length: 8
>> >> >            dlci 6 frame_type 0 credit_flow 15 pri 3
>> >> >            ack_timer 0 frame_size 32256 max_retrans 0 credits 1
>> >> >
>> >> > Hcidump log:
>> >> >       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>> >> >       dlci 6 frame_type 0 credit_flow 15 pri 3 ack_timer 0
>> >> >       frame_size 126 max_retrans 0 credits 1
>> >> >
>> >> > The rpn.pm is fine. That may be printed without doing __bswap_16()
>> also.
>> >> >
>> >> > But in the above PN frame, frame_size is different from actual
>> >> > hcidump trace.
>> >> > I cross checked with PTS logs, it was same as the hcidump trace.
>> >> > So, if it is causing build problems under Android, use
>> >> > l2cap_frame_get_le16()
>> >> > Instead of l2cap_frame_get_be16() for pn.mtu.
>> >> >
>> >> > If we are consistent with hcidump, then replace the be16() by
>> >> > le16() for both pn.mtu and rpn.pm.
>> >> >
>> >> > After replacing the le16() function:
>> >> > Btmon logs looks like:
>> >> >
>> >> >       RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
>> >> >          Address: 0x03 cr 1 dlci 0x00
>> >> >          Control: 0xef poll/final 0
>> >> >          Length: 10
>> >> >          FCS: 0x70
>> >> >          MCC Message type: DLC Parameter Negotiation CMD(0x20)
>> >> >            Length: 8
>> >> >            dlci 6 frame_type 0 credit_flow 15 pri 3
>> >> >            ack_timer 0 frame_size 126 max_retrans 0 credits 1
>> >> >
>> >> > What do you think ?
>> >>
>> >> If value is LE then l2cap_frame_get_le16() should be used.
>> >> (Same issue affects rpn.pm mcc_rpn(), right?)
>> >>
>> >
>> > Yes you are right. We have to use l2cap_frame_get_le16() for fetching both
>> rpn.pm and pn.mtu.
>> > I hope it will not cause any Android build problem.
>>
>> Actually you need to check what endianess for the protocol, the kernel
>> seems to treat RFCOMM as little endian which I suppose is the correct byte
>> order otherwise we would not be able to qualify or even interoperate with
>> other devices.
>>
>
> I checked it, the correct byte ordering for RFCOMM protocol is LE only.

Then we need to replace every l2cap_frame_get_be* with l2cap_frame_get_le*.

>
>> >> >
>> >> > > > +
>> >> > > > +done:
>> >> > > > +       return true;
>> >> > > > +}
>> >> > > > +
>> >> > > >  struct mcc_data {
>> >> > > >         uint8_t type;
>> >> > > >         const char *str;
>> >> > > > @@ -201,6 +272,8 @@ static inline bool mcc_frame(struct
>> >> > > > rfcomm_frame
>> >> > > *rfcomm_frame, uint8_t indent)
>> >> > > >         switch (type) {
>> >> > > >         case RFCOMM_MSC:
>> >> > > >                 return mcc_msc(rfcomm_frame, indent+2);
>> >> > > > +       case RFCOMM_RPN:
>> >> > > > +               return mcc_rpn(rfcomm_frame, indent+2);
>> >> > > >         default:
>> >> > > >                 packet_hexdump(frame->data, frame->size);
>> >> > > >         }
>> >> > > > --
>> >> > > > 1.9.1
>> >> > > >
>> >> > > > --
>> >> > > > To unsubscribe from this list: send the line "unsubscribe
>> >> > > > linux-bluetooth" in the body of a message to
>> >> > > > majordomo@vger.kernel.org More majordomo info at
>> >> > > > http://vger.kernel.org/majordomo-info.html
>> >> > >
>> >> > >
>> >> > >
>> >> > > --
>> >> > > pozdrawiam
>> >> > > Szymon K. Janc
>> >> > > szymon.janc@gmail.com
>> >> > > --
>> >> > > To unsubscribe from this list: send the line "unsubscribe linux-
>> bluetooth"
>> >> > in
>> >> > > the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> >> > > info at  http://vger.kernel.org/majordomo-info.html
>> >> >
>> >> >
>> >> > Regards,
>> >> > Gowtham Anandha Babu
>> >> >
>> >> > --
>> >> > To unsubscribe from this list: send the line "unsubscribe
>> >> > linux-bluetooth" in the body of a message to
>> >> > majordomo@vger.kernel.org More majordomo info at
>> >> > http://vger.kernel.org/majordomo-info.html
>> >>
>> >> --
>> >> Best regards,
>> >> Szymon Janc
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe
>> >> linux-bluetooth" in the body of a message to
>> >> majordomo@vger.kernel.org More majordomo info at
>> >> http://vger.kernel.org/majordomo-info.html
>> >
>> > Regards,
>> > Gowtham Anandha Babu
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
>
> Regards,
> Gowtham Anandha Babu
>



-- 
Luiz Augusto von Dentz
