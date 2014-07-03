Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3] android/hal-health: Clear NONBLOCK flag from fd
Date: Thu, 03 Jul 2014 13:38:49 +0200
Message-ID: <2947534.RfCRlR0Nul@uw000953>
In-Reply-To: <1404386233-27863-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404386233-27863-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 03 of July 2014 14:17:13 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Java expects file descriptor passed with channel_state_cb() to be
> blocking.
> ---
>  android/hal-health.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/android/hal-health.c b/android/hal-health.c
> index 20ba459..1ed9fb1 100644
> --- a/android/hal-health.c
> +++ b/android/hal-health.c
> @@ -19,6 +19,9 @@
>  #include <stddef.h>
>  #include <string.h>
>  #include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
>  
>  #include "hal-log.h"
>  #include "hal.h"
> @@ -44,6 +47,19 @@ static void handle_app_registration_state(void *buf, uint16_t len, int fd)
>  static void handle_channel_state(void *buf, uint16_t len, int fd)
>  {
>  	struct hal_ev_health_channel_state *ev = buf;
> +	int flags;
> +
> +	flags = fcntl(fd, F_GETFL, 0);
> +	if (flags < 0) {
> +		error("health: fcntl GETFL error: %s", strerror(errno));
> +		return;
> +	}
> +
> +	/* Clean O_NONBLOCK fd flag as Android Java layer expects */
> +	if (fcntl(fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
> +		error("health: fcntl SETFL error: %s", strerror(errno));
> +		return;
> +	}
>  
>  	if (cbacks->channel_state_cb)
>  		cbacks->channel_state_cb(ev->app_id, (bt_bdaddr_t *) ev->bdaddr,
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
