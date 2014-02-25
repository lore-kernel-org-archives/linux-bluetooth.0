Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 1/9] shared: Add skeleton of hfp_at parser
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393320227-10931-2-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 25 Feb 2014 10:46:27 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <616CD64E-79F8-4AC7-9696-A91DD7B43779@holtmann.org>
References: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com> <1393320227-10931-2-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> It will parse AT frames in HFP profile implementation. Use can register
> handlers for specified prefixes. Callbacks will be called with one of
> hfp_cmd_type. Default handler will have prefix NULL, and type passed
> to callback will be always HFP_AT_UNKNOWN.
> ---
> src/shared/hfp_at.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> src/shared/hfp_at.h | 43 +++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 93 insertions(+)
> create mode 100644 src/shared/hfp_at.c
> create mode 100644 src/shared/hfp_at.h
> 
> diff --git a/src/shared/hfp_at.c b/src/shared/hfp_at.c
> new file mode 100644
> index 0000000..bd1899b
> --- /dev/null
> +++ b/src/shared/hfp_at.c
> @@ -0,0 +1,50 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
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
> +#include <stdbool.h>
> +#include <string.h>
> +#include <ctype.h>
> +
> +#include "src/shared/util.h"
> +#include "src/shared/hfp_at.h"
> +
> +struct hfp_at {
> +	const struct hfp_at_handler *cmd_handlers;
> +};
> +
> +struct hfp_at *hfp_at_new(const struct hfp_at_handler *handlers)
> +{
> +	struct hfp_at *hfp_at;
> +
> +	hfp_at = new0(struct hfp_at, 1);
> +	if (!hfp_at)
> +		return NULL;
> +
> +	hfp_at->cmd_handlers = handlers;
> +
> +	return hfp_at;
> +}
> +
> +void hfp_at_free(struct hfp_at *hfp_at)
> +{
> +	free(hfp_at);
> +}
> diff --git a/src/shared/hfp_at.h b/src/shared/hfp_at.h
> new file mode 100644
> index 0000000..fe074f2
> --- /dev/null
> +++ b/src/shared/hfp_at.h
> @@ -0,0 +1,43 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
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
> +struct hfp_at;
> +
> +enum hfp_cmd_type {
> +	HFP_AT_READ,
> +	HFP_AT_SET,
> +	HFP_AT_TEST,
> +	HFP_AT_COMMAND,
> +	HFP_AT_UNKNOWN
> +};
> +
> +typedef void (*hfp_at_cmd_cb)(struct hfp_at *hfp_at, enum hfp_cmd_type type,
> +					const char *at, void *user_data);
> +
> +struct hfp_at_handler {
> +	const char *prefix;
> +	hfp_at_cmd_cb cb;
> +};
> +
> +struct hfp_at *hfp_at_new(const struct hfp_at_handler *handlers);
> +void hfp_at_free(struct hfp_at *hfp_at);

so I rather see this integrated into hfp_gw natively. No need for new files or a new structure with all new resource allocation.

Lets just use hfp_gw_set_command_handler for the default case where we have no specific handler to parse the data since that will be needed for unknown AT command callback anyway.

And then add hfp_gw_register_command(hfp, prefix, callback, user_data, destroy) with a matching unregister function. Use a large table does not really makes sense to me. Individual commands similar to GAtServer works seems more reasonable and lot more flexible.

Regards

Marcel

