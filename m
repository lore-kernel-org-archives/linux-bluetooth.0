Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Dec 2013 14:11:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/6] emulator: Add connect callback when setting l2cap
 server
Message-ID: <20131219121150.GA15358@x220.p-661hnu-f1>
References: <1387445406-20324-1-git-send-email-marcin.kraglak@tieto.com>
 <1387445406-20324-2-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387445406-20324-2-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thu, Dec 19, 2013, Marcin Kraglak wrote:
> Add possibility to set connect callback when client will be
> connected to bthost l2cap server.

I've applied the first patch, but there are some things in the
subsequent ones.

Regarding the commit messages, or code comments (or anything else except
actual code), please capitalize acronyms like L2CAP and PSM (I fixed
this in the first patch that I applied).

> +struct l2cap_conn_cb_data {
> +	uint16_t psm;
> +	bthost_l2cap_connect_cb func;
> +	void *user_data;
> +};
> +
>  struct bthost {
>  	uint8_t bdaddr[6];
>  	bthost_send_func send_handler;
> @@ -101,6 +107,7 @@ struct bthost {
>  	void *cmd_complete_data;
>  	bthost_new_conn_cb new_conn_cb;
>  	void *new_conn_data;
> +	struct l2cap_conn_cb_data *new_l2cap_conn_data;

You should  consider making this a list since otherwise you won't be
able to support profiles that use multiple different PSMs, like HID.

> -void bthost_set_server_psm(struct bthost *bthost, uint16_t psm)
> +void bthost_set_server_psm(struct bthost *bthost, uint16_t psm,
> +				bthost_l2cap_connect_cb func, void *user_data)

Since you're not updating any users of bthost_set_server_psm you'll
break bisectability of the git tree with this patch. In fact, I applied
all patches in your set and the tree still didn't compile.

I don't think set_server_psm is anymore an appropriate name for this
function when you add the two extra parameters. Instead it should be
something like bthost_add_l2cap_server().

Considering the above issues, it's probably better that you keep the
existing set_server_psm and have a add_l2cap_server along side of it
(the former would simply behave like the latter except with NULL
pointers as two last parameters).

Then, once you've updated all users to add_l2cap_server you can remove
the old set_server_psm.

Johan
