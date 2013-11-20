Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Nov 2013 15:21:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv6 10/19] android/socket: Parse SDP response and connect
Message-ID: <20131120132130.GB28347@x220.p-661hnu-f1>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1384943077-5366-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384943077-5366-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Nov 20, 2013, Andrei Emeltchenko wrote:
> Parse SDP response, find RFCOMM channel and connect.
> ---
>  android/socket.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)

Patches 1-9 have been applied (I merged 2 and 3 to avoid the compilation
error reported earlier), but one issue here:

> +	io = bt_io_connect(connect_cb, rfsock, NULL, &gerr,
> +				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
> +				BT_IO_OPT_DEST_BDADDR, &rfsock->dst,
> +				BT_IO_OPT_CHANNEL, chan,
> +				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
> +				BT_IO_OPT_INVALID);
> +	if (!io) {
> +		error("Failed connect: %s", gerr->message);
> +		g_error_free(gerr);
> +		goto fail;
> +	}
> +
> +	rfsock->real_sock = g_io_channel_unix_get_fd(io);
> +	rfsock->channel = chan;
> +	connections = g_list_append(connections, rfsock);
> +	return;

Looks like you're leaking a reference for the GIOChannel since you don't
store it anywhere and return from the function without doing a
g_io_channel_unref().

Johan
