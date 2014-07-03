Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] android/hal-health: Clear NONBLOCK flag from fd
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404383493-8174-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 3 Jul 2014 12:38:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <700D9D34-C873-4A39-858C-68265704A8EB@holtmann.org>
References: <1404383493-8174-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Java expects file descriptor passed with channel_state_cb() to be
> blocking.
> ---
> android/hal-health.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/android/hal-health.c b/android/hal-health.c
> index 858d499..2ff19ab 100644
> --- a/android/hal-health.c
> +++ b/android/hal-health.c
> @@ -19,6 +19,8 @@
> #include <stddef.h>
> #include <string.h>
> #include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> 
> #include "hal-log.h"
> #include "hal.h"
> @@ -44,6 +46,13 @@ static void handle_app_registration_state(void *buf, uint16_t len, int fd)
> static void handle_channel_state(void *buf, uint16_t len, int fd)
> {
> 	struct hal_ev_health_channel_state *ev = buf;
> +	int flags;
> +
> +	if ((flags = fcntl(fd, F_GETFL, 0)) < 0)
> +		flags = 0;

I do not like the if ((x = x) < x) syntax. Don't use that.

Also what is the point of setting it to 0 here. Just skip the F_SETFL. I rather print a proper error here then trying to outsmart ourselves.

> +
> +	fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
> +

Same here. Might check the return error and print an error if it fails. At least then someone can debug it.

> 
> 	if (cbacks->channel_state_cb)
> 		cbacks->channel_state_cb(ev->app_id, (bt_bdaddr_t *) ev->bdaddr,

Regards

Marcel

