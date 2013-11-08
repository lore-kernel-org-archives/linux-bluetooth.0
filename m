Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 10:10:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 02/11] android/hid: Add a ascii2hex utility
Message-ID: <20131108081018.GA14368@x220.p-661hnu-f1>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383862220-29968-3-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383862220-29968-3-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Fri, Nov 08, 2013, Ravi kumar Veeramally wrote:
> +++ b/android/utils.c
> @@ -0,0 +1,41 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include "utils.h"
> +
> +void ascii2hex(const uint8_t *ascii, int ascii_len, uint8_t *hex)
> +{
> +	int i;
> +
> +	if (!ascii || !hex)
> +		return;
> +
> +	for (i = 0; i < ascii_len / 2; i++)
> +		sscanf((char *) &ascii[i * 2], "%02x",
> +						(unsigned int *) &hex[i]);
> +
> +}

I'd just keep this static inside the HID HAL since that seems to be the
only user for it. Actually I'm not even convinced that it's worth to
have this as a separate function since you only have two users and
essentially the function is just two lines (the if-statement is
redundant). Also, the function name isn't quite right. You're converting
from hex to binary. Not from ascii to hex (hex notation is already using
the ascii character set). Also, do consider the point from Jerzy about
the format specifier.

Johan
