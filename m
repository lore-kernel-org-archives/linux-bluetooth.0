Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1415028323-13861-1-git-send-email-gowtham.ab@samsung.com>
 <1415028323-13861-7-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZLLcNQDEjLeKXSSoTqzWOGvvdM+wn0BryXTqPhAPNzc3Q@mail.gmail.com>
 <000b01cff8f3$a21c2a90$e6547fb0$@samsung.com>
In-reply-to: <000b01cff8f3$a21c2a90$e6547fb0$@samsung.com>
Subject: RE: [PATCH v2 6/6] monitor/rfcomm: Add mcc type handlers code
Date: Fri, 07 Nov 2014 16:44:18 +0530
Message-id: <000001cffa7c$040f6440$0c2e2cc0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Wednesday, November 05, 2014 5:55 PM
> To: 'Luiz Augusto von Dentz'
> Cc: linux-bluetooth@vger.kernel.org; 'Dmitry Kasatkin'; 'Bharat Panda';
> cpgs@samsung.com
> Subject: RE: [PATCH v2 6/6] monitor/rfcomm: Add mcc type handlers code
> 
> Hi,
> 
> > -----Original Message-----
> > From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> > Sent: Tuesday, November 04, 2014 5:46 PM
> > To: Gowtham Anandha Babu
> > Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> > cpgs@samsung.com
> > Subject: Re: [PATCH v2 6/6] monitor/rfcomm: Add mcc type handlers code
> >
> > Hi,
> >
> > On Mon, Nov 3, 2014 at 5:25 PM, Gowtham Anandha Babu
> > <gowtham.ab@samsung.com> wrote:
> > > From: Bharat Panda <bharat.panda@samsung.com>
> > >
> > > Adds different mcc type handlers code to print in btmon.
> > > ---
> > > Below provided is the btmon rfcomm logs.
> > >> ACL Data RX: Handle 75 flags 0x02 dlen 8                     [hci0] 22.280283
> > >       Channel: 65 len 4 [PSM 3 mode 0] {chan 1}
> > >        RFCOMM(s): SABM
> > >         Address : (0x83)
> > >         CR Bit: 1
> > >         DLCI : (0x20)
> > >         Poll/FInal Bit : 1
> > >         Length : 0
> > >         FCS : (0xca)
> > > < ACL Data TX: Handle 75 flags 0x00 dlen 8                     [hci0] 22.317803
> > >       Channel: 65 len 4 [PSM 3 mode 0] {chan 1}
> > >        RFCOMM(s): UA
> > >         Address : (0x83)
> > >         CR Bit: 1
> > >         DLCI : (0x20)
> > >         Poll/FInal Bit : 1
> > >         Length : 0
> > >         FCS : (0x01)
> > > < ACL Data TX: Handle 75 flags 0x00 dlen 12                    [hci0] 22.317822
> > >       Channel: 65 len 8 [PSM 3 mode 0] {chan 1}
> > >        RFCOMM(s): MSC CMD
> > >         Address : (0x01)
> > >         CR Bit: 0
> > >         DLCI : (0x00)
> > >         Poll/FInal Bit : 0
> > >         Length : 4
> > >         FCS : (0xaa)
> > >         MCC Length 2
> > >         83 8d aa                                         ...
> > > < ACL Data TX: Handle 75 flags 0x00 dlen 9                     [hci0] 22.346681
> > >       Channel: 65 len 5 [PSM 3 mode 0] {chan 1}
> > >        RFCOMM(d): UIH
> > >         Address : (0x81)
> > >         CR Bit: 0
> > >         DLCI : (0x20)
> > >         Poll/FInal Bit : 1
> > >         Length : 0
> > >         FCS : (0x1e)
> > >         Credits 33
> > > ---
> >
> > This is actually what I wanted to avoid, now you have to include all
> > the frames you changing instead of doing one by one. Btw, did you make
> > sure this is consistent with the spec and what we have done for L2CAP?
> >
> > >  monitor/rfcomm.c | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c index
> > > b85e8fd..10dc4e8 100644
> > > --- a/monitor/rfcomm.c
> > > +++ b/monitor/rfcomm.c
> > > @@ -90,48 +90,69 @@ static void print_rfcomm_hdr(const struct
> > l2cap_frame *frame,
> > >         print_field("FCS : (0x%2.2x)", fcs);  }
> > >
> > > +static void print_mcc(struct rfcomm_lmcc mcc) {
> > > +       print_field("MCC Length %d", mcc.length); }
> > > +
> > >  static inline void mcc_test(const struct l2cap_frame *frame,
> > >                                 struct rfcomm_lhdr hdr, struct
> > > rfcomm_lmcc mcc)  {
> > > +       print_rfcomm_hdr(frame, hdr);
> > > +       print_mcc(mcc);
> > >  }
> > >
> > >  static inline void mcc_fcon(const struct l2cap_frame *frame,
> > >                                 struct rfcomm_lhdr hdr, struct
> > > rfcomm_lmcc mcc)  {
> > > +       print_rfcomm_hdr(frame, hdr);
> > > +       print_mcc(mcc);
> > >  }
> > >
> > >  static inline void mcc_fcoff(const struct l2cap_frame *frame,
> > >                                 struct rfcomm_lhdr hdr, struct
> > > rfcomm_lmcc mcc)  {
> > > +       print_rfcomm_hdr(frame, hdr);
> > > +       print_mcc(mcc);
> > >  }
> > >
> > >  static inline void mcc_msc(const struct l2cap_frame *frame,
> > >                                 struct rfcomm_lhdr hdr, struct
> > > rfcomm_lmcc mcc)  {
> > > +       print_rfcomm_hdr(frame, hdr);
> > > +       print_mcc(mcc);
> > >         packet_hexdump(frame->data, frame->size);  }
> > >
> > >  static inline void mcc_rpn(const struct l2cap_frame *frame,
> > >                                 struct rfcomm_lhdr hdr, struct
> > > rfcomm_lmcc mcc)  {
> > > +       print_rfcomm_hdr(frame, hdr);
> > > +       print_mcc(mcc);
> > >         packet_hexdump(frame->data, frame->size);  }
> > >
> > >  static inline void mcc_rls(const struct l2cap_frame *frame,
> > >                                 struct rfcomm_lhdr hdr, struct
> > > rfcomm_lmcc mcc)  {
> > > +       print_rfcomm_hdr(frame, hdr);
> > > +       print_mcc(mcc);
> > >         packet_hexdump(frame->data, frame->size);  }
> > >
> > >  static inline void mcc_pn(const struct l2cap_frame *frame,
> > >                                 struct rfcomm_lhdr hdr, struct
> > > rfcomm_lmcc mcc)  {
> > > +       print_rfcomm_hdr(frame, hdr);
> > > +       print_mcc(mcc);
> > >         packet_hexdump(frame->data, frame->size);  }
> > >
> > >  static inline void mcc_nsc(const struct l2cap_frame *frame,
> > >                                 struct rfcomm_lhdr hdr, struct
> > > rfcomm_lmcc mcc)  {
> > > +       print_rfcomm_hdr(frame, hdr);
> > > +       print_mcc(mcc);
> > >         packet_hexdump(frame->data, frame->size);  }
> > >
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
> I have revisited the specs and came up with a modified below
> implementation.
> 
> #ifdef HAVE_CONFIG_H
> #include <config.h>
> #endif
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <ctype.h>
> #include <inttypes.h>
> 
> #include <bluetooth/bluetooth.h>
> 
> #include "src/shared/util.h"
> #include "bt.h"
> #include "packet.h"
> #include "display.h"
> #include "l2cap.h"
> #include "uuid.h"
> #include "keys.h"
> #include "sdp.h"
> #include "rfcomm.h"
> 
> #define GET_LEN8(length) ((length & 0xfe) >> 1) #define GET_LEN16(length)
> ((length & 0xfffe) >> 1)
> 
> struct rfcomm_lhdr {
> 	uint8_t address;
> 	uint8_t control;
> 	uint16_t length;
> } __attribute__((packed));
> 
> struct rfcomm_lmcc {
> 	uint8_t type;
> 	uint16_t length;
> } __attribute__((packed));
> 
> struct rfcomm_data {
> 	uint8_t frame;
> 	const char *str;
> };
> 
> static const struct rfcomm_data rfcomm_table[] = {
> 	{ 0x2f, "Set Async Balance Mode (SABM) "},
> 	{ 0x63, "Unnumbered Ack (UA)"},
> 	{ 0x0f, "Disconnect Mode (DM)"},
> 	{ 0x43, "Disconnect (DISC)"},
> 	{ 0xef, "Header Check (UIH)"},
> 	{ }
> };
> void rfcomm_packet(const struct l2cap_frame *frame) {
> 	uint8_t ctype, length, ex_length;
> 	const char *frame_str, *frame_color;
> 	int i;
> 	struct l2cap_frame rfcomm_frame;
> 	struct rfcomm_lhdr hdr;
> 	const struct rfcomm_data *rfcomm_data = NULL;
> 
> 	l2cap_frame_pull(&rfcomm_frame, frame, 0);
> 
> 	if (!l2cap_frame_get_u8(&rfcomm_frame, &hdr.address) ||
> 			!l2cap_frame_get_u8(&rfcomm_frame,
> &hdr.control) ||
> 			!l2cap_frame_get_u8(&rfcomm_frame, &length)){
> 		print_text(COLOR_ERROR, "Frame too short");
> 		packet_hexdump(frame->data, frame->size);
> 		return;
> 	}
> 
> 	/* length maybe 1 or 2 octets */
> 	if (RFCOMM_TEST_EA(length))
> 		hdr.length = (uint16_t) GET_LEN8(length);
> 	else {
> 		if (!l2cap_frame_get_u8(&rfcomm_frame, &ex_length)) {
> 			print_text(COLOR_ERROR, "Frame too short");
> 			packet_hexdump(frame->data, frame->size);
> 			return;
> 		}
> 		hdr.length = ((uint16_t)length << 8) | ex_length;
> 		hdr.length = GET_LEN16(hdr.length);
> 	}
> 
> 	ctype = RFCOMM_GET_TYPE(hdr.control);
> 
> 	for (i = 0; rfcomm_table[i].str; i++) {
> 		if (rfcomm_table[i].frame == ctype) {
> 			rfcomm_data = &rfcomm_table[i];
> 			break;
> 		}
> 	}
> 
> 	if (rfcomm_data) {
> 		if (frame->in)
> 			frame_color = COLOR_MAGENTA;
> 		else
> 			frame_color = COLOR_BLUE;
> 		frame_str = rfcomm_data->str;
> 	} else {
> 		frame_color = COLOR_WHITE_BG;
> 		frame_str = "Unknown";
> 	}
> 
> 	if (!rfcomm_data) {
> 		packet_hexdump(frame->data, frame->size);
> 		return;
> 	}
> 
> 	print_indent(6, frame_color, "RFCOMM: ", frame_str, COLOR_OFF,
> 				"(0x%2.2x)", ctype);
> 
> 	/* Common print header function call */
> 
> 	/* UIH frame handling function call */
> 
> 	packet_hexdump(frame->data, frame->size); }
> 
> Is it fine, for at least initial RFCOMM skeleton ?
> If its ok, then I will keep this as my initial patches and work on the further
> implementation.
> Here I am printing the logs as soon as pulling the data from l2cap_frame.
> 
> Regards,
> Gowtham
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

I have incorporated the review comments and submitted the new patch set.  

Regards,
Gowtham

