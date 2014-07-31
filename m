Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1406557469-29288-1-git-send-email-vikram.pal@samsung.com>
References: <1406557469-29288-1-git-send-email-vikram.pal@samsung.com>
Date: Thu, 31 Jul 2014 16:07:57 +0300
Message-ID: <CABBYNZLM9EtVBNMf4ZJqDHYvrqCTisBvNTzg52EUPB0JvtqmMw@mail.gmail.com>
Subject: Re: [PATCH ] monitor: Add AVCTP support to btmon
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Vikram <vikrampal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Mon, Jul 28, 2014 at 5:24 PM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Support for decoding AVCTP packets added in Bluetooth monitor.
> ---
>  Makefile.tools  |  1 +
>  monitor/avctp.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  monitor/avctp.h | 25 +++++++++++++++++++
>  monitor/l2cap.c |  6 +++++
>  monitor/l2cap.h |  1 +
>  5 files changed, 108 insertions(+)
>  create mode 100644 monitor/avctp.c
>  create mode 100644 monitor/avctp.h
>
> diff --git a/Makefile.tools b/Makefile.tools
> index dc9dde9..9226386 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -26,6 +26,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
>                                 monitor/ll.h monitor/ll.c \
>                                 monitor/l2cap.h monitor/l2cap.c \
>                                 monitor/sdp.h monitor/sdp.c \
> +                               monitor/avctp.h monitor/avctp.c \
>                                 monitor/uuid.h monitor/uuid.c \
>                                 monitor/hwdb.h monitor/hwdb.c \
>                                 monitor/keys.h monitor/keys.c \
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> new file mode 100644
> index 0000000..37084c2
> --- /dev/null
> +++ b/monitor/avctp.c
> @@ -0,0 +1,75 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2011-2014  Intel Corporation
> + *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <inttypes.h>
> +
> +#include <bluetooth/bluetooth.h>
> +
> +#include "src/shared/util.h"
> +#include "bt.h"
> +#include "packet.h"
> +#include "display.h"
> +#include "l2cap.h"
> +#include "uuid.h"
> +#include "keys.h"
> +#include "sdp.h"
> +#include "avctp.h"
> +
> +void avctp_packet(const struct l2cap_frame *frame)
> +{
> +        uint8_t hdr;
> +        uint16_t pid;
> +        const char *pdu_color;
> +
> +        if (frame->size < 3) {
> +                print_text(COLOR_ERROR, "frame too short");
> +                packet_hexdump(frame->data, frame->size);
> +                return;
> +        }
> +
> +        hdr = *((uint8_t *) frame->data);
> +
> +        pid = get_be16(frame->data + 1);
> +
> +        if (frame->in)
> +                pdu_color = COLOR_MAGENTA;
> +        else
> +                pdu_color = COLOR_BLUE;
> +
> +        print_indent(6, pdu_color, "AVCTP", "", COLOR_OFF,
> +                        " %s: %s: Packet_type 0x%02x Transaction label %d "
> +                        "PID 0x%04x",
> +                        frame->psm == 23 ? "Control" : "Browsing",
> +                        hdr & 0x02 ? "Response" : "Command",
> +                        hdr & 0x0c, hdr >> 4, pid);
> +
> +       packet_hexdump(frame->data + 3, frame->size - 3);
> +}
> diff --git a/monitor/avctp.h b/monitor/avctp.h
> new file mode 100644
> index 0000000..2613f14
> --- /dev/null
> +++ b/monitor/avctp.h
> @@ -0,0 +1,25 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2011-2014  Intel Corporation
> + *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +void avctp_packet(const struct l2cap_frame *frame);
> diff --git a/monitor/l2cap.c b/monitor/l2cap.c
> index 993aa8b..b286787 100644
> --- a/monitor/l2cap.c
> +++ b/monitor/l2cap.c
> @@ -41,6 +41,7 @@
>  #include "uuid.h"
>  #include "keys.h"
>  #include "sdp.h"
> +#include "avctp.h"
>
>  #define MAX_CHAN 64
>
> @@ -2620,6 +2621,7 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
>         default:
>                 l2cap_frame_init(&frame, index, in, handle, cid, data, size);
>                 psm = get_psm(&frame);
> +               frame.psm = psm;
>                 mode = get_mode(&frame);
>                 chan = get_chan(&frame);
>
> @@ -2634,6 +2636,10 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
>                 case 0x001f:
>                         att_packet(index, in, handle, cid, data, size);
>                         break;
> +               case 0x0017:
> +               case 0x001B:
> +                       avctp_packet(&frame);
> +                       break;
>                 default:
>                         packet_hexdump(data, size);
>                         break;
> diff --git a/monitor/l2cap.h b/monitor/l2cap.h
> index 0d18478..851b5c4 100644
> --- a/monitor/l2cap.h
> +++ b/monitor/l2cap.h
> @@ -32,6 +32,7 @@ struct l2cap_frame {
>         uint16_t cid;
>         const void *data;
>         uint16_t size;
> +       uint16_t psm;
>  };
>
>  static inline void l2cap_frame_init(struct l2cap_frame *frame,
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
