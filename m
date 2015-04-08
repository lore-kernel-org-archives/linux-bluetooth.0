Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001401d071e6$f9c0e710$ed42b530$@samsung.com>
References: <1427974325-3280-1-git-send-email-gowtham.ab@samsung.com>
	<CAMv5Gbd3P_+iN_DL5ZZXn_EzyodjKhUyoE=cxtfOD6j7mtDYSA@mail.gmail.com>
	<001401d0702c$8add5f60$a0981e20$@samsung.com>
	<001401d071e6$f9c0e710$ed42b530$@samsung.com>
Date: Wed, 8 Apr 2015 14:14:27 +0200
Message-ID: <CAMv5GbcmrM6TFJLxoDvX98wyAzFVWPLHcmWH_sPGhhBjaiVRfg@mail.gmail.com>
Subject: Re: [PATCH] monitor: Add initial support for BNEP
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,



On 8 April 2015 at 12:29, Gowtham Anandha Babu <gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Monday, April 06, 2015 11:13 AM
>> To: 'Grzegorz Kolodziejczyk'
>> Cc: 'linux-bluetooth'; bharat.panda@samsung.com; cpgs@samsung.com
>> Subject: RE: [PATCH] monitor: Add initial support for BNEP
>>
>> Hi Grzegorz,
>>
>> > -----Original Message-----
>> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> > owner@vger.kernel.org] On Behalf Of Grzegorz Kolodziejczyk
>> > Sent: Friday, April 03, 2015 4:23 PM
>> > To: Gowtham Anandha Babu
>> > Cc: linux-bluetooth; bharat.panda@samsung.com; cpgs@samsung.com
>> > Subject: Re: [PATCH] monitor: Add initial support for BNEP
>> >
>> > Hi Gowtham,
>> >
>> > On 2 April 2015 at 13:32, Gowtham Anandha Babu
>> > <gowtham.ab@samsung.com> wrote:
>> > >> ACL Data RX: Handle 71 flags 0x02 dlen 11
>> > [hci0] 17.739883
>> > >       Channel: 64 len 7 [PSM 15 mode 0] {chan 0}
>> > >       BNEP: Control (0x01|0)
>> > >         01 02 11 16 11 15                                ......
>> > >
>> > >> ACL Data RX: Handle 71 flags 0x01 dlen 35
>> > [hci0] 175.293028
>> > >       Channel: 64 len 1532 [PSM 15 mode 0] {chan 0}
>> > >       BNEP: General Ethernet (0x00|1)
>> > >         00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 0f  ................
>> > >         05 00 0c 03 00 00 20 00 00 03 00 00 20 00 00 3c  ...... .....
>> > > ..<
>> > >
>> > >> ACL Data RX: Handle 71 flags 0x01 dlen 12
>> > [hci0] 145.825018
>> > >       Channel: 64 len 1509 [PSM 15 mode 0] {chan 0}
>> > >       BNEP: Compressed Ethernet Dest Only (0x04|0)
>> > >         00 00 00 00 00 00 08 00 3c 3b 3a 39 38 37 36 35  ........<;:98765
>> > >         34 33 32 31 30 2f 2e 2d 2c 2b 2a 29 28 27 26 25
>> > > 43210/.-,+*)('&%
>> > > ---
>> > >  Makefile.tools     |   1 +
>> > >  android/Android.mk |   1 +
>> > >  monitor/bnep.c     | 116
>> > +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> > >  monitor/bnep.h     |  25 ++++++++++++
>> > >  monitor/l2cap.c    |   4 ++
>> > >  5 files changed, 147 insertions(+)
>> > >  create mode 100644 monitor/bnep.c
>> > >  create mode 100644 monitor/bnep.h
>> > >
>> > > diff --git a/Makefile.tools b/Makefile.tools index b8dd90a..b37b774
>> > > 100644
>> > > --- a/Makefile.tools
>> > > +++ b/Makefile.tools
>> > > @@ -28,6 +28,7 @@ monitor_btmon_SOURCES = monitor/main.c
>> > monitor/bt.h \
>> > >                                 monitor/sdp.h monitor/sdp.c \
>> > >                                 monitor/avctp.h monitor/avctp.c \
>> > >                                 monitor/rfcomm.h monitor/rfcomm.c \
>> > > +                               monitor/bnep.h monitor/bnep.c \
>> > >                                 monitor/uuid.h monitor/uuid.c \
>> > >                                 monitor/hwdb.h monitor/hwdb.c \
>> > >                                 monitor/keys.h monitor/keys.c \ diff
>> > > --git a/android/Android.mk b/android/Android.mk index
>> > > f218805..880e3ba
>> > > 100644
>> > > --- a/android/Android.mk
>> > > +++ b/android/Android.mk
>> > > @@ -340,6 +340,7 @@ LOCAL_SRC_FILES := \
>> > >         bluez/monitor/l2cap.c \
>> > >         bluez/monitor/avctp.c \
>> > >         bluez/monitor/rfcomm.c \
>> > > +       bluez/monitor/bnep.c \
>> > >         bluez/monitor/uuid.c \
>> > >         bluez/monitor/sdp.c \
>> > >         bluez/monitor/vendor.c \
>> > > diff --git a/monitor/bnep.c b/monitor/bnep.c new file mode 100644
>> > > index 0000000..1450f85
>> > > --- /dev/null
>> > > +++ b/monitor/bnep.c
>> > > @@ -0,0 +1,116 @@
>> > > +/*
>> > > + *
>> > > + *  BlueZ - Bluetooth protocol stack for Linux
>> > > + *
>> > > + *  Copyright (C) 2011-2014  Intel Corporation
>> > > + *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
>> > > + *
>> > > + *
>> > > + *  This library is free software; you can redistribute it and/or
>> > > + *  modify it under the terms of the GNU Lesser General Public
>> > > + *  License as published by the Free Software Foundation; either
>> > > + *  version 2.1 of the License, or (at your option) any later version.
>> > > + *
>> > > + *  This library is distributed in the hope that it will be useful,
>> > > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > GNU
>> > > + *  Lesser General Public License for more details.
>> > > + *
>> > > + *  You should have received a copy of the GNU Lesser General
>> > > +Public
>> > > + *  License along with this library; if not, write to the Free
>> > > +Software
>> > > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> > > +02110-1301  USA
>> > > + *
>> > > + */
>> > > +
>> > > +#ifdef HAVE_CONFIG_H
>> > > +#include <config.h>
>> > > +#endif
>> > > +
>> > > +#include <stdio.h>
>> > > +#include <stdlib.h>
>> > > +#include <string.h>
>> > > +#include <ctype.h>
>> > > +#include <inttypes.h>
>> > > +
>> > > +#include "lib/bluetooth.h"
>> > > +
>> > > +#include "src/shared/util.h"
>> > > +#include "bt.h"
>> > > +#include "packet.h"
>> > > +#include "display.h"
>> > > +#include "l2cap.h"
>> > > +#include "uuid.h"
>> > > +#include "keys.h"
>> > > +#include "sdp.h"
>> > > +#include "bnep.h"
>> > > +
>> > > +#define GET_PKT_TYPE(type) (type & 0x7f) #define
>> > GET_EXTENSION(type)
>> > > +(type & 0x80)
>> > > +
>> > > +struct bnep_frame {
>> > > +       uint8_t type;
>> > > +       int extension;
>> > > +       struct l2cap_frame l2cap_frame; };
>> > > +
>> > > +struct bnep_data {
>> > > +       uint8_t type;
>> > > +       const char *str;
>> > > +};
>> > > +
>> > > +static const struct bnep_data bnep_table[] = {
>> > > +       { 0x00, "General Ethernet"},
>> > > +       { 0x01, "Control"},
>> > > +       { 0x02, "Compressed Ethernet"},
>> > > +       { 0x03, "Compressed Ethernet Src Only"},
>> > > +       { 0x04, "Compressed Ethernet Dest Only"},
>> > > +       { }
>> > > +};
>> > > +
>> > > +void bnep_packet(const struct l2cap_frame *frame) {
>> > > +       uint8_t type;
>> > > +       struct bnep_frame bnep_frame;
>> > > +       struct l2cap_frame *l2cap_frame;
>> > > +       const struct bnep_data *bnep_data = NULL;
>> > > +       const char *pdu_color, *pdu_str;
>> > > +       int i;
>> > > +
>> > > +       l2cap_frame_pull(&bnep_frame.l2cap_frame, frame, 0);
>> > > +       l2cap_frame = &bnep_frame.l2cap_frame;
>> > > +
>> > > +       if (!l2cap_frame_get_u8(l2cap_frame, &type))
>> > > +               goto fail;
>> > > +
>> > > +       bnep_frame.extension = GET_EXTENSION(type);
>> > > +       bnep_frame.type = GET_PKT_TYPE(type);
>> > > +
>> > > +       for (i = 0; bnep_table[i].str; i++) {
>> > > +               if (bnep_table[i].type == bnep_frame.type) {
>> > > +                       bnep_data = &bnep_table[i];
>> > > +                       break;
>> > > +               }
>> > > +       }
>> > > +
>> > > +       if (bnep_data) {
>> > > +               if (frame->in)
>> > > +                       pdu_color = COLOR_MAGENTA;
>> > > +               else
>> > > +                       pdu_color = COLOR_BLUE;
>> > > +               pdu_str = bnep_data->str;
>> > > +       } else {
>> > > +               pdu_color = COLOR_WHITE_BG;
>> > > +               pdu_str = "Unknown packet type";
>> > > +       }
>> > > +
>> > > +       print_indent(6, pdu_color, "BNEP: ", pdu_str, COLOR_OFF,
>> > > +                               " (0x%02x|%s)", bnep_frame.type,
>> > > +                               bnep_frame.extension ? "1" : "0");
>> > > +
>> > > +       packet_hexdump(l2cap_frame->data, l2cap_frame->size);
>> > > +       return;
>> > > +
>> > > +fail:
>> > > +       print_text(COLOR_ERROR, "frame too short");
>> > > +       packet_hexdump(frame->data, frame->size); }
>> > > diff --git a/monitor/bnep.h b/monitor/bnep.h new file mode 100644
>> > > index 0000000..38340d6
>> > > --- /dev/null
>> > > +++ b/monitor/bnep.h
>> > > @@ -0,0 +1,25 @@
>> > > +/*
>> > > + *
>> > > + *  BlueZ - Bluetooth protocol stack for Linux
>> > > + *
>> > > + *  Copyright (C) 2011-2014  Intel Corporation
>> > > + *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
>> > > + *
>> > > + *
>> > > + *  This library is free software; you can redistribute it and/or
>> > > + *  modify it under the terms of the GNU Lesser General Public
>> > > + *  License as published by the Free Software Foundation; either
>> > > + *  version 2.1 of the License, or (at your option) any later version.
>> > > + *
>> > > + *  This library is distributed in the hope that it will be useful,
>> > > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > GNU
>> > > + *  Lesser General Public License for more details.
>> > > + *
>> > > + *  You should have received a copy of the GNU Lesser General
>> > > +Public
>> > > + *  License along with this library; if not, write to the Free
>> > > +Software
>> > > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> > > +02110-1301  USA
>> > > + *
>> > > + */
>> > > +
>> > > +void bnep_packet(const struct l2cap_frame *frame);
>> > > diff --git a/monitor/l2cap.c b/monitor/l2cap.c index
>> > > 5faa26f..fc565b1
>> > > 100644
>> > > --- a/monitor/l2cap.c
>> > > +++ b/monitor/l2cap.c
>> > > @@ -43,6 +43,7 @@
>> > >  #include "sdp.h"
>> > >  #include "avctp.h"
>> > >  #include "rfcomm.h"
>> > > +#include "bnep.h"
>> > >
>> > >  /* L2CAP Control Field bit masks */
>> > >  #define L2CAP_CTRL_SAR_MASK            0xC000
>> > > @@ -2951,6 +2952,9 @@ static void l2cap_frame(uint16_t index, bool
>> > > in,
>> > uint16_t handle,
>> > >                 case 0x0003:
>> > >                         rfcomm_packet(&frame);
>> > >                         break;
>> > > +               case 0x000f:
>> > > +                       bnep_packet(&frame);
>> > > +                       break;
>> > >                 case 0x001f:
>> > >                         att_packet(index, in, handle, cid, data, size);
>> > >                         break;
>> > > --
>> > > 1.9.1
>> > >
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe
>> > > linux-bluetooth" in the body of a message to
>> > > majordomo@vger.kernel.org More majordomo info at
>> > > http://vger.kernel.org/majordomo-info.html
>> >
>> > I've tested it and for me it looks ok. For further development please
>> > remember about frames with extension headers. It'll be also nice to
>> > have specified frame sections/flags (e.g. control frame type, header len).
>> >
>>
>> Thanks for testing. I am planning to do in that way.
>> In the next set, all the BNEP packet type listed above will be handled.
Good to know.
>> Then only the extended headers will be handled.
>> Btw, complete support to handle the extended headers in kernel is done or
>> yet to be completed?
>>
Yes, now it is supported, latest bluetooth-next supports it.
>> Regards,
>> Gowtham Anandha Babu
>>
>> > BR,
>> > Grzegorz
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Best regards,
Grzegorz
