Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH BlueZ v5 03/14] mesh: Infrastructure for Mesh daemon
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1531062347.7346.18.camel@intel.com>
Date: Sat, 14 Jul 2018 18:23:34 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Message-Id: <96DF0B8D-4B4D-4AA1-A637-E16A1B22009D@holtmann.org>
References: <20180706171306.13501-1-brian.gix@intel.com>
 <20180706171306.13501-4-brian.gix@intel.com>
 <62AEAA3E-B88E-4D53-A113-3680C1F86047@holtmann.org>
 <1531062347.7346.18.camel@intel.com>
To: Brian Gix <brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

>>> ---
>>> mesh/display.c         |  67 +++++
>>> mesh/hci.c             | 699 +++++++++++++++++++++++++++++++++++++++++++++++++
>>> mesh/mesh-io-generic.c | 660 ++++++++++++++++++++++++++++++++++++++++++++++
>>> mesh/mesh-io.c         | 187 +++++++++++++
>>> 4 files changed, 1613 insertions(+)
>>> create mode 100644 mesh/display.c
>>> create mode 100644 mesh/hci.c
>>> create mode 100644 mesh/mesh-io-generic.c
>>> create mode 100644 mesh/mesh-io.c
>>> 
>>> diff --git a/mesh/display.c b/mesh/display.c
>>> new file mode 100644
>>> index 000000000..adf92cae0
>>> --- /dev/null
>>> +++ b/mesh/display.c
>>> @@ -0,0 +1,67 @@
>>> +/*
>>> + *
>>> + *  BlueZ - Bluetooth protocol stack for Linux
>>> + *
>>> + *  Copyright (C) 2018  Intel Corporation. All rights reserved.++++
>>> + *
>>> + *
>>> + *  This library is free software; you can redistribute it and/or
>>> + *  modify it under the terms of the GNU Lesser General Public
>>> + *  License as published by the Free Software Foundation; either
>>> + *  version 2.1 of the License, or (at your option) any later version.
>>> + *
>>> + *  This library is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + *  Lesser General Public License for more details.
>>> + *
>>> + */
>>> +
>>> +#include <stdio.h>
>>> +#include <unistd.h>
>>> +#include <termios.h>
>>> +#include <sys/ioctl.h>
>>> +#include <sys/time.h>
>>> +#include <ell/ell.h>
>>> +
>>> +#include "display.h"
>>> +
>>> +#define likely(x)   __builtin_expect(!!(x), 1)
>>> +#define unlikely(x) __builtin_expect(!!(x), 0)
>> 
>> I highly doubt we will make good use of likely and unlikely. Just remove that. We can measure that at some
>> point, but right now it seems useless. On a side note, I am not convinced that our usage in ELL is actually
>> worth while doing.
> 
> This will be removed for v6 of patch-set
> 
>> 
>>> +
>>> +static unsigned int cached_num_columns;
>>> +
>>> +unsigned int num_columns(void)
>>> +{
>>> +	struct winsize ws;
>>> +
>>> +	if (likely(cached_num_columns > 0))
>>> +		return cached_num_columns;
>>> +
>>> +	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0 || ws.ws_col == 0)
>>> +		cached_num_columns = 80;
>>> +	else
>>> +		cached_num_columns = ws.ws_col;
>>> +
>>> +	return cached_num_columns;
>>> +}
>>> +
>>> +void print_packet(const char *label, const void *data, uint16_t size)
>>> +{
>>> +	struct timeval pkt_time;
>>> +
>>> +	gettimeofday(&pkt_time, NULL);
>>> +
>>> +	if (size > 0) {
>>> +		char *str;
>>> +
>>> +		str = l_util_hexstring(data, size);
>>> +		l_info("%05d.%03d %s: %s",
>>> +				(uint32_t) pkt_time.tv_sec % 100000,
>>> +				(uint32_t) pkt_time.tv_usec/1000, label, str);
>>> +		l_free(str);
>>> +	} else
>>> +		l_info("%05d.%03d %s: empty",
>>> +				(uint32_t) pkt_time.tv_sec % 100000,
>>> +				(uint32_t) pkt_time.tv_usec/1000, label);
>>> +}
>> 
>> I have no idea why we are not using util_hexdump() or l_util_hexdump() since they are hooked up properly with
>> debug defines etc.
> 
> l_util_hexdump does not create strings in the format we most use, which is a form that can be fed back into
> l_util_from_hexstring. l_util_hexdump adds whitespace between each octet, and ascii gorp at the end of the
> line, while l_util_hexstring returns a tightly packed octets-to-asciihex.

the l_util_hexdump is intentionally this way sine it is readable without making the brain hurt ;)

> We can then use the output from this function to copy/paste strings between instances for example to:
> 1. simulate "Out Of Band" public and static key exchange
> 2. trade via email long ascii-hex strings to IOP and UPF partners
> 3. paste repeated over-the-air packets to repeat exact test runs without preconditioning sequence numbers and
> IV Indexs etc.
> 
> If you like, I can rework this to use l_debug, but the current output format of the data is more useful in this
> form, than it is in hexdump format.

Use l_debug or something where the output format can be changed quickly. Since I disagree with you that large streams of hex octets are useful. During development maybe, but unless you build a log decoder for it, it is useless.

So if you want this kind, then abstract it properly and cleanly. Also be able to switch if off by default so that it doesn't clog your logs.

>>> diff --git a/mesh/hci.c b/mesh/hci.c
>>> new file mode 100644
>>> index 000000000..da6838a55
>>> --- /dev/null
>>> +++ b/mesh/hci.c
>>> @@ -0,0 +1,699 @@
>>> +/*
>>> + *
>>> + *  BlueZ - Bluetooth protocol stack for Linux
>>> + *
>>> + *  Copyright (C) 2018  Intel Corporation. All rights reserved.
>>> + *
>>> + *
>>> + *  This library is free software; you can redistribute it and/or
>>> + *  modify it under the terms of the GNU Lesser General Public
>>> + *  License as published by the Free Software Foundation; either
>>> + *  version 2.1 of the License, or (at your option) any later version.
>>> + *
>>> + *  This library is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + *  Lesser General Public License for more details.
>>> + *
>>> + */
>>> +
>>> +#ifdef HAVE_CONFIG_H
>>> +#include <config.h>
>>> +#endif
>>> +
>>> +#include <unistd.h>
>>> +#include <stdlib.h>
>>> +#include <sys/uio.h>
>>> +#include <sys/socket.h>
>>> +#include <ell/ell.h>
>>> +
>>> +#include "monitor/bt.h"
>>> +
>>> +#include "mesh/hci.h"
>>> +
>>> +#define BTPROTO_HCI	1
>>> +struct sockaddr_hci {
>>> +	sa_family_t	hci_family;
>>> +	unsigned short	hci_dev;
>>> +	unsigned short  hci_channel;
>>> +};
>>> +#define HCI_CHANNEL_USER	1
>>> +
>>> +struct bt_hci {
>>> +	int ref_count;
>>> +	struct l_io *io;
>>> +	bool is_stream;
>>> +	bool writer_active;
>>> +	uint8_t num_cmds;
>>> +	uint8_t num_pkts;
>>> +	unsigned int next_cmd_id;
>>> +	unsigned int next_evt_id;
>>> +	struct l_queue *cmd_queue;
>>> +	struct l_queue *rsp_queue;
>>> +	struct l_queue *evt_list;
>>> +	struct l_queue *pkt_queue;
>>> +	bt_hci_receive_func_t receive_callback;
>>> +	bt_hci_destroy_func_t receive_destroy;
>>> +	void *receive_data;
>>> +};
>> 
>> What is wrong with src/shared/hci.[ch] instead having a copy here?
> 
> The main barrier to this is that the src/shared/hci.[ch] uses glib conventions, and the mesh versions use ELL.
> I agree that these should be a single hci.[ch], but it may need to wait until the rest of bluez is transitioned
> to ELL.
> 
> I can add a /* TODO */ to the mesh version to ensure that this is eventually addressed (?).

No. I am not buying your argument. src/shared/hci.c has no GLib in it. It is fully IO agnostic. Actually everything in src/shared is IO agnostic. It is that way for a reason. If you can not make this work with ELL, then lets address that problem and not paper over it.

Regards

Marcel

