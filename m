Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382516789-374-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1382516789-374-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 23 Oct 2013 12:18:50 +0300
Message-ID: <CA+yX-WOvxAiWfQ2COp6tSeCanJrJxo9w1=SrOwuSY+eb=Qe0tA@mail.gmail.com>
Subject: Re: [PATCH] android: Fix build error for Android
From: "Emeltchenko, Andrei" <andrei.emeltchenko@intel.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	szymon.janc@tieto.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Oct 23, 2013 at 11:26 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Android uses functions and defines from sys/capability.h which
> requires additional include
> ---
>  android/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/android/main.c b/android/main.c
> index 988d08b..606baf2 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -52,6 +52,10 @@
>  #include "hal-msg.h"
>  #include "ipc.h"
>
> +#if defined(ANDROID)

check also for platform version in order to compile for 4.2.2

Regards,
Andrei

> +#include <sys/capability.h>
> +#endif
> +
>  static GMainLoop *event_loop;
>  static struct mgmt *mgmt_if = NULL;
>
> --
> 1.8.4
>
> ---------------------------------------------------------------------
> Intel Finland Oy
> Registered Address: PL 281, 00181 Helsinki
> Business Identity Code: 0357606 - 4
> Domiciled in Helsinki
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>



-- 
Best regards,
Andrei Emeltchenko
Intel / OTC / Helsinki
