Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCHv2 07/16] android/hal-sock: Implement RFCOMM events
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1384526278-26260-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 15 Nov 2013 23:49:16 +0900
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <446C88D1-95D3-4F52-AA92-6AD1D09FD93C@holtmann.org>
References: <1384526278-26260-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1384526278-26260-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Copy data from RFCOMM socket to Android framework. Consider splice
> in the future.
> ---
> android/socket.c |   37 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 37 insertions(+)
> 
> diff --git a/android/socket.c b/android/socket.c
> index af14ef6..fdd2e09 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -181,6 +181,43 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
> static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
> 								gpointer data)
> {
> +	struct rfcomm_slot *rfslot = data;
> +	unsigned char buf[1024];
> +	int len, sent;
> +
> +	DBG("rfslot: fd %d real_sock %d chan %u sock %d",
> +		rfslot->fd, rfslot->real_sock, rfslot->channel,
> +		g_io_channel_unix_get_fd(io));
> +
> +	if (!g_list_find(rfcomm_connected_list, rfslot)) {
> +		error("rfslot %p not found in the list", rfslot);
> +		return FALSE;
> +	}
> +
> +	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
> +		error("Socket error: sock %d cond %d",
> +					g_io_channel_unix_get_fd(io), cond);
> +		rfcomm_connected_list = g_list_remove(rfcomm_connected_list,
> +								rfslot);
> +		cleanup_rfslot(rfslot);
> +		return FALSE;
> +	}
> +
> +	len = recv(rfslot->real_sock, buf, sizeof(buf), 0);
> +	if (len <= 0) {
> +		error("recv(): %s sock %d", strerror(errno), rfslot->real_sock);
> +		return FALSE;
> +	}
> +
> +	DBG("read %d bytes, write to fd %d", len, rfslot->fd);
> +
> +	if ((sent = write_n(rfslot->fd, buf, len)) < 0) {

we do not use this coding style.

> +		error("send(): %s", strerror(errno));
> +		return FALSE;
> +	}
> +
> +	DBG("Written %d bytes", sent);
> +
> 	return TRUE;
> }

Regards

Marcel

