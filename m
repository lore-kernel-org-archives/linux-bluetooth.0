Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [RFCv1 7/9] android/hal-sock: Implement RFCOMM events
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1384173438-21708-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 12 Nov 2013 08:11:19 +0900
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <31537EE3-F035-4B78-9338-F5724686A315@holtmann.org>
References: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1384173438-21708-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Copy data from RFCOMM socket to Android framework.
> ---
> android/socket.c |   29 +++++++++++++++++++++++++++++
> 1 file changed, 29 insertions(+)
> 
> diff --git a/android/socket.c b/android/socket.c
> index dfad9da..a962cdc 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -129,6 +129,35 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
> static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
> 								gpointer data)
> {
> +	struct rfcomm_slot *rfslot = data;
> +	unsigned char buf[1024] = { 0 };
> +	int len;
> +
> +	DBG("rfslot: fd %d hal_fd %d real_sock %d chan %u sock %d",
> +		rfslot->fd, rfslot->hal_fd, rfslot->real_sock, rfslot->channel,
> +		g_io_channel_unix_get_fd(io));
> +
> +	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
> +		error("Socket error: sock %d cond %d",
> +					g_io_channel_unix_get_fd(io), cond);
> +		g_io_channel_shutdown(io, TRUE, NULL);
> +		return FALSE;
> +	}
> +
> +	/* FIXME check real_sock vs sock(io) */
> +	len = recv(rfslot->real_sock, buf, sizeof(buf), 0);
> +	if (len <= 0) {
> +		error("recv(): %s sock %d", strerror(errno), rfslot->real_sock);
> +		return FALSE;
> +	}
> +
> +	DBG("read %d bytes, write to fd %d", len, rfslot->fd);
> +
> +	if (send(rfslot->fd, buf, len, MSG_DONTWAIT) < 0) {
> +		error("send(): %s sock %d", strerror(errno), rfslot->fd);
> +		return FALSE;
> +	}
> +

since both sockets are SOCK_STREAM there is no guarantee that write() will write exactly the same amount of data that you just got via read(). Especially when using MSG_DONTWAIT. The kernel can decide to interrupt you here any time it wants to.

So you need proper error handling for the send() part in case you get truncated transfers.

Regards

Marcel

