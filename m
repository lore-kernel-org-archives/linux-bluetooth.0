Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Szymon Janc' <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1427453488-25550-1-git-send-email-bharat.panda@samsung.com>
 <1534417.DtWm0C0aRA@leonov>
In-reply-to: <1534417.DtWm0C0aRA@leonov>
Subject: RE: [PATCH v3] monitor: Add AVDTP support to btmon
Date: Fri, 27 Mar 2015 19:14:23 +0530
Message-id: <000301d06894$636c39f0$2a44add0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Szymon Janc
> Sent: Friday, March 27, 2015 4:23 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH v3] monitor: Add AVDTP support to btmon
> 
> Hi Bharat,
> 
> On Friday 27 of March 2015 16:21:28 Bharat Panda wrote:
> > Initial support for decoding AVDTP packets added to btmon.
> >
> > e.g.
> >
> > > ACL Data RX: Handle 70 flags 0x02 dlen 18
> >
> >       Channel: 64 len 14 [PSM 25 mode 0] {chan 0}
> > 		AVDTP: Command Get Config(0x04): transaction 11 nsp 0x00
> >
> >         50 03 04 04 01 00 07 06 00 00 11 15 02 fa < ACL Data TX:
> > Handle 70 flags 0x00 dlen 6
> >       Channel: 64 len 2 [PSM 25 mode 0] {chan 0}
> > 		AVDTP: Response Set Config(0x03): transaction 5 nsp 0x00
> >
> >         52 03
> > ---
> >  Makefile.tools  |   1 +
> >  monitor/avdtp.c | 185
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> monitor/avdtp
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> .h |
> > 25 ++++++++
> >  monitor/l2cap.c |  23 +++++++
> >  monitor/l2cap.h |   2 +
> >  5 files changed, 236 insertions(+)
> >  create mode 100644 monitor/avdtp.c
> >  create mode 100644 monitor/avdtp.h
> >
> > diff --git a/Makefile.tools b/Makefile.tools index 1d2dc94..e663b46
> > 100644
> > --- a/Makefile.tools
> > +++ b/Makefile.tools
> > @@ -27,6 +27,7 @@ monitor_btmon_SOURCES = monitor/main.c
> monitor/bt.h \
> >  				monitor/l2cap.h monitor/l2cap.c \
> >  				monitor/sdp.h monitor/sdp.c \
> >  				monitor/avctp.h monitor/avctp.c \
> > +				monitor/avdtp.h monitor/avdtp.c \
> >  				monitor/rfcomm.h monitor/rfcomm.c \
> >  				monitor/uuid.h monitor/uuid.c \
> >  				monitor/hwdb.h monitor/hwdb.c \
> > diff --git a/monitor/avdtp.c b/monitor/avdtp.c new file mode 100644
> > index 0000000..389dde0
> > --- /dev/null
> > +++ b/monitor/avdtp.c
> > @@ -0,0 +1,185 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2004-2011  Marcel Holtmann <marcel@holtmann.org>
> > + *
> > + *
> > + *  This program is free software; you can redistribute it and/or
> > +modify
> > + *  it under the terms of the GNU General Public License as published
> > +by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> > +02110-1301
> > USA + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <ctype.h>
> > +#include <inttypes.h>
> > +
> > +#include "lib/bluetooth.h"
> > +
> > +#include "src/shared/util.h"
> > +#include "bt.h"
> > +#include "packet.h"
> > +#include "display.h"
> > +#include "l2cap.h"
> > +#include "uuid.h"
> > +#include "keys.h"
> > +#include "sdp.h"
> > +#include "avdtp.h"
> > +
> > +/* AVDTP opcodes */
> > +#define AVDTP_DISCOVER_SEP				0x01
> > +#define AVDTP_GET_CAPABILITIES			0x02
> > +#define AVDTP_SET_CONFIG					0x03
> > +#define AVDTP_GET_CONFIG					0x04
> > +#define AVDTP_RECONFIG				0x05
> > +#define AVDTP_OPEN					0x06
> > +#define AVDTP_START					0x07
> > +#define AVDTP_CLOSE					0x08
> > +#define AVDTP_SUSPEND				0x09
> > +#define AVDTP_ABORT					0x0A
> > +#define AVDTP_SEC_CONTROL			0x0B
> > +#define AVDTP_GET_ALL_CAPABILITIES	0x0C
> > +#define AVDTP_DELAY_REPORT			0x0D
> > +
> > +struct avdtp_frame {
> > +	uint8_t hdr;
> > +	uint8_t nsp;
> > +	uint8_t tsid;
> > +	struct l2cap_frame l2cap_frame;
> > +};
> > +
> > +static const char *pt2str(uint8_t hdr) {
> > +	switch (hdr & 0x0c) {
> > +	case 0x00:
> > +		return "Single";
> > +	case 0x04:
> > +		return "Start";
> > +	case 0x08:
> > +		return "Cont";
> > +	case 0x0c:
> > +		return "End";
> > +	default:
> > +		return "Unknown";
> > +	}
> > +}
> > +
> > +static const char *mt2str(uint8_t hdr) {
> > +	switch (hdr & 0x03) {
> > +	case 0x00:
> > +		return "Command";
> > +	case 0x02:
> > +		return "Response";
> > +	case 0x03:
> > +		return "Reject";
> > +	default:
> > +		return "Unknown";
> > +	}
> > +}
> > +
> > +static const char *sig2str(uint8_t tsid) {
> > +	switch (tsid) {
> > +	case AVDTP_DISCOVER_SEP:
> > +		return "Discover";
> > +	case AVDTP_GET_CAPABILITIES:
> > +		return "Get Capabilities";
> > +	case AVDTP_SET_CONFIG:
> > +		return "Set Config";
> > +	case AVDTP_GET_CONFIG:
> > +		return "Get Config";
> > +	case AVDTP_RECONFIG:
> > +		return "Reconfig";
> > +	case AVDTP_OPEN:
> > +		return "Open";
> > +	case AVDTP_START:
> > +		return "Start";
> > +	case AVDTP_CLOSE:
> > +		return "Close";
> > +	case AVDTP_SUSPEND:
> > +		return "Suspend";
> > +	case AVDTP_ABORT:
> > +		return "Anort";
> > +	case AVDTP_SEC_CONTROL:
> > +		return "Security Control";
> > +	case AVDTP_GET_ALL_CAPABILITIES:
> > +		return "Get All Capabilities";
> > +	case AVDTP_DELAY_REPORT:
> > +		return "Delay report";
> > +	default:
> > +		return "Unknown Opcode";
> > +	}
> > +}
> > +
> > +void avdtp_packet(const struct l2cap_frame *frame) {
> > +	struct l2cap_frame *l2cap_frame;
> > +	struct avdtp_frame avdtp_frame;
> > +	const char *pdu_color;
> > +
> > +	l2cap_frame_pull(&avdtp_frame.l2cap_frame, frame, 0);
> > +
> > +	l2cap_frame = &avdtp_frame.l2cap_frame;
> > +	l2cap_frame->num = get_num(l2cap_frame);
> > +
> > +	avdtp_frame.tsid = 0x00;
> > +	avdtp_frame.nsp = 0x00;
> > +
> > +	switch (l2cap_frame->num) {
> > +	case 1:
> > +		if (!l2cap_frame_get_u8(l2cap_frame, &avdtp_frame.hdr) ||
> > +			!l2cap_frame_get_u8(l2cap_frame,
> &avdtp_frame.tsid)) {
> > +			print_text(COLOR_ERROR, "frame too short");
> > +			packet_hexdump(frame->data, frame->size);
> > +			return;
> > +		}
> > +
> > +		if ((avdtp_frame.hdr & 0x0c) == 0x04)
> > +			if (!l2cap_frame_get_u8(l2cap_frame,
> > +					&avdtp_frame.nsp)) {
> > +				packet_hexdump(frame->data, frame-
> >size);
> > +				return;
> > +		}
> > +
> > +		l2cap_frame_get_u8(l2cap_frame, &avdtp_frame.tsid);
> > +
> > +		if (frame->in)
> > +			pdu_color = COLOR_MAGENTA;
> > +		else
> > +			pdu_color = COLOR_BLUE;
> > +
> > +		print_indent(8, pdu_color, "AVDTP: ",
> > +					mt2str(avdtp_frame.hdr),
> COLOR_OFF,
> > +					" %s(0x%02x): transaction %d nsp
> 0x%02x\n",
> > +					avdtp_frame.hdr & 0x08 ?
> > +					pt2str(avdtp_frame.hdr) :
> > +					sig2str(avdtp_frame.tsid),
> avdtp_frame.tsid,
> > +					avdtp_frame.hdr >> 4,
> avdtp_frame.nsp);
> > +
> > +		packet_hexdump(frame->data, frame->size);
> > +		break;
> > +
> > +	case 2:
> > +		/* Media Packets */
> > +		packet_hexdump(frame->data, frame->size);
> > +		break;
> > +	}
> > +}
> > diff --git a/monitor/avdtp.h b/monitor/avdtp.h new file mode 100644
> > index 0000000..0173c21
> > --- /dev/null
> > +++ b/monitor/avdtp.h
> > @@ -0,0 +1,25 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2011-2014  Intel Corporation
> > + *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
> > + *
> > + *
> > + *  This library is free software; you can redistribute it and/or
> > + *  modify it under the terms of the GNU Lesser General Public
> > + *  License as published by the Free Software Foundation; either
> > + *  version 2.1 of the License, or (at your option) any later version.
> > + *
> > + *  This library is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> GNU
> > + *  Lesser General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU Lesser General Public
> > + *  License along with this library; if not, write to the Free
> > +Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> > +02110-1301
> > USA + *
> > + */
> > +
> > +void avdtp_packet(const struct l2cap_frame *frame);
> > diff --git a/monitor/l2cap.c b/monitor/l2cap.c index 5faa26f..6480d92
> > 100644
> > --- a/monitor/l2cap.c
> > +++ b/monitor/l2cap.c
> > @@ -42,6 +42,7 @@
> >  #include "keys.h"
> >  #include "sdp.h"
> >  #include "avctp.h"
> > +#include "avdtp.h"
> >  #include "rfcomm.h"
> >
> >  /* L2CAP Control Field bit masks */
> > @@ -95,6 +96,7 @@ struct chan_data {
> >  	uint16_t scid;
> >  	uint16_t dcid;
> >  	uint16_t psm;
> > +	uint16_t num;
> >  	uint8_t  ctrlid;
> >  	uint8_t  mode;
> >  	uint8_t  ext_ctrl;
> > @@ -102,10 +104,23 @@ struct chan_data {
> >
> >  static struct chan_data chan_list[MAX_CHAN];
> >
> > +uint16_t get_num(struct l2cap_frame *frame) {
> > +	register int i;
> > +
> > +	for (i = 0; i < MAX_CHAN; i++)
> > +		if (chan_list[i].handle == frame->handle &&
> > +				chan_list[i].scid == frame->cid)
> > +			return chan_list[i].num;
> > +
> > +	return 0;
> > +}
> > +
> >  static void assign_scid(const struct l2cap_frame *frame,
> >  				uint16_t scid, uint16_t psm, uint8_t ctrlid)
{
> >  	int i, n = -1;
> > +	int num = 1;
> >
> >  	for (i = 0; i < MAX_CHAN; i++) {
> >  		if (n < 0 && chan_list[i].handle == 0x0000) @@ -128,6 +143,8
> @@
> > static void assign_scid(const struct l2cap_frame *frame, break;
> >  			}
> >  		}
> > +		if (chan_list[i].psm == psm)
> > +			num++;
> >  	}
> >
> >  	if (n < 0)
> > @@ -137,6 +154,7 @@ static void assign_scid(const struct l2cap_frame
> > *frame, chan_list[n].index = frame->index;
> >  	chan_list[n].handle = frame->handle;
> >  	chan_list[n].ident = frame->ident;
> > +	chan_list[n].num = num;
> >
> >  	if (frame->in)
> >  		chan_list[n].dcid = scid;
> > @@ -1314,6 +1332,7 @@ static void l2cap_frame_init(struct l2cap_frame
> > *frame, uint16_t index, bool in, frame->psm    = get_psm(frame);
> >  	frame->mode   = get_mode(frame);
> >  	frame->chan   = get_chan(frame);
> > +	frame->num    = 0;
> >  }
> >
> >  static void bredr_sig_packet(uint16_t index, bool in, uint16_t
> > handle, @@ -2876,6 +2895,7 @@ static void smp_packet(uint16_t index,
> > bool in, uint16_t handle, opcode_data->func(&frame);  }
> >
> > +
> 
> nitpick: double line
I will fix the same and submit a v4 for this patch.
> 
> >  static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
> >  			uint16_t cid, const void *data, uint16_t size)  { @@
-
> 2958,6
> > +2978,9 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t
> > handle, case 0x001B:
> >  			avctp_packet(&frame);
> >  			break;
> > +		case 0x019:
> > +			avdtp_packet(&frame);
> > +			break;
> >  		default:
> >  			packet_hexdump(data, size);
> >  			break;
> > diff --git a/monitor/l2cap.h b/monitor/l2cap.h index 711bcb1..fac8625
> > 100644
> > --- a/monitor/l2cap.h
> > +++ b/monitor/l2cap.h
> > @@ -33,11 +33,13 @@ struct l2cap_frame {
> >  	uint16_t cid;
> >  	uint16_t psm;
> >  	uint16_t chan;
> > +	uint16_t num;
> >  	uint8_t mode;
> >  	const void *data;
> >  	uint16_t size;
> >  };
> >
> > +uint16_t get_num(struct l2cap_frame *frame);
> >  static inline void l2cap_frame_pull(struct l2cap_frame *frame,
> >  				const struct l2cap_frame *source, uint16_t
> len)  {
> 
> How is that suppose to work with more than 1 device connected?
> 
> I recall discussing this with Marcel and Johan some time ago and
conclusion
> was to have marking solution in kernel that would allow userspace to mark
> sockets with type of traffic. The that info would be available on monitor
> socket.
Btmon does not have tag info for multiple connected devices. If more than
one devices are connected, then it shows the logs from both the device
transactions, but unable to tag device info. As you mentioned, if there is
any marking info support already added in kernel, then a device info header
can be added to distinguish among diff device logs in all protocol frames of
btmon.

As this patch is only related to AVDTP parsing, once we start supporting dev
info tags, it can be enhanced accordingly.
I will be sending v4 for the same with above nitpick comment incorporated.

Thanks
BR,
Bharat

