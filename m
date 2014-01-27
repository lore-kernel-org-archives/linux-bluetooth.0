Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC BlueZ] android/AVDTP: Make signalling channel high priority
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390854261-5325-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 27 Jan 2014 21:40:07 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <7AF5DE79-4CEA-453C-895C-EF03DE9205B8@holtmann.org>
References: <1390854261-5325-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This makes signalling high priority (6) so it can push commands before
> the stream channel, without this the stream channel may be schedule
> first and cause the signalling commands to timeout while waiting a slot.
> ---
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
> +		error("setsockopt(SO_PRIORITY): %s (%d)", strerror(errno),
> +									errno);
> +		return NULL;
> +	}
> +

I think we should make it one higher than the media channel. If we are currently using priority 6 on the media channel than this should be 7. If 7 is not possible, then we might degrade the media channel to 5.

Regards

Marcel

