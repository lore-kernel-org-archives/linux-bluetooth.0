Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Nov 2013 17:46:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/6] android/socket: Handle Android events for server
 socket
Message-ID: <20131126154602.GB25005@x220.p-661hnu-f1>
References: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1385474750-18331-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385474750-18331-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Nov 26, 2013, Andrei Emeltchenko wrote:
> Add watch for tracking events from Android framework for server socket.
> ---
>  android/socket.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

I've applied the first two patches, but wanted to ask about this one:

> +static gboolean sock_server_stack_event_cb(GIOChannel *io, GIOCondition cond,
> +								gpointer data)
> +{
> +	struct rfcomm_sock *rfsock = data;
> +
> +	DBG("");
> +
> +	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
> +		error("Socket error: sock %d cond %d",
> +					g_io_channel_unix_get_fd(io), cond);
> +		cleanup_rfsock(rfsock);
> +
> +		return FALSE;
> +	}
> +
> +	return TRUE;
> +}

I don't see where (in which patch) you'd add code to handle G_IO_IN on
this socket. Aren't you supposed to read data from this socket and write
it to the RFCOMM one?

Johan
