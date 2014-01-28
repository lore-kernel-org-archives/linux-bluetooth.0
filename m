Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 1/4] android/AVDTP: Make signalling channel priority 6
Date: Wed, 29 Jan 2014 00:33:06 +0100
Message-ID: <5250546.TxQk6hBFbY@leonov>
In-Reply-To: <1390929286-30206-1-git-send-email-luiz.dentz@gmail.com>
References: <1390929286-30206-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tuesday 28 of January 2014 09:14:43 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes signalling priority 6 so it can push commands before the
> stream channel, without this the stream channel may be schedule
> first and cause the signalling commands to timeout while waiting a slot.
> ---
> v2: Return error if writes fails since that probably means the socket has
> been disconnected, also makes code setting socket to blocking a bit
> cleaner. v3: Remove cast as suggested by Marcel, make code setting stream
> fd to block a separate function.
> 
>  android/avdtp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/android/avdtp.c b/android/avdtp.c
> index 4abcd75..e93ff70 100644
> --- a/android/avdtp.c
> +++ b/android/avdtp.c
> @@ -2056,7 +2056,7 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t
> omtu, uint16_t version) {
>  	struct avdtp *session;
>  	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
> -	int new_fd;
> +	int new_fd, priority;
> 
>  	new_fd = dup(fd);
>  	if (new_fd < 0) {
> @@ -2064,6 +2064,14 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t
> omtu, uint16_t version) return NULL;
>  	}
> 
> +	priority = 6;
> +	if (setsockopt(new_fd, SOL_SOCKET, SO_PRIORITY, &priority,
> +						sizeof(priority)) < 0) {
> +		error("setsockopt(SO_PRIORITY): %s (%d)", strerror(errno),
> +									errno);
> +		return NULL;
> +	}
> +
>  	session = g_new0(struct avdtp, 1);
>  	session->io = g_io_channel_unix_new(new_fd);
>  	session->version = version;

All four patches applied, thanks.

-- 
BR
Szymon Janc
