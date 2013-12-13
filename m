Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Dec 2013 16:39:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/8] android/socket: Do not close fd on unref
Message-ID: <20131213143948.GA30037@x220.p-661hnu-f1>
References: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1386861474-29524-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386861474-29524-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Dec 12, 2013, Andrei Emeltchenko wrote:
> We close file descriptors in cleanup_rfsock() and leaving the default
> value gives us glib warnings if we close fd already and got G_IO_NVAL in
> server_cb from bt_io.
> ---
>  android/socket.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/socket.c b/android/socket.c
> index 5e8f8e5..9d759be 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -736,6 +736,7 @@ static void handle_listen(const void *buf, uint16_t len)
>  	rfsock->real_sock = g_io_channel_unix_get_fd(io);
>  
>  	g_io_channel_unref(io);
> +	g_io_channel_set_close_on_unref(io, FALSE);

Strictly speaking this function is not allowed to touch "io" after it
drops its own reference to it, i.e. these calls should be in the
opposite order. I fixed it up myself this time.

Johan
