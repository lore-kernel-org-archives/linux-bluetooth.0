Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH BlueZ v2 1/4] android/AVDTP: Make signalling channel priority 6
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390889820-24709-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 28 Jan 2014 04:05:04 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <12AE93C8-7EBA-458E-AD05-B1D7888F3ECC@holtmann.org>
References: <1390889820-24709-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This makes signalling priority 6 so it can push commands before the
> stream channel, without this the stream channel may be schedule
> first and cause the signalling commands to timeout while waiting a slot.
> ---
> v2: Return error if writes fails since that probably means the socket has been
> disconnected, also makes code setting socket to blocking a bit cleaner.
> 
> android/avdtp.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/android/avdtp.c b/android/avdtp.c
> index 4abcd75..4cfffc8 100644
> --- a/android/avdtp.c
> +++ b/android/avdtp.c
> @@ -2057,6 +2057,7 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
> 	struct avdtp *session;
> 	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
> 	int new_fd;
> +	int priority;

make it “int new_fd, priority;”.

> 
> 	new_fd = dup(fd);
> 	if (new_fd < 0) {
> @@ -2064,6 +2065,14 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
> 		return NULL;
> 	}
> 
> +	priority = 6;
> +	if (setsockopt(new_fd, SOL_SOCKET, SO_PRIORITY,
> +			(const void *) &priority, sizeof(priority)) < 0) {

What is this (const void *) cast for. That should not be needed.

> +		error("setsockopt(SO_PRIORITY): %s (%d)", strerror(errno),
> +									errno);
> +		return NULL;
> +	}
> +
> 	session = g_new0(struct avdtp, 1);
> 	session->io = g_io_channel_unix_new(new_fd);
> 	session->version = version;

Regards

Marcel

