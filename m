Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 18:44:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 05/11] android: Add cap to bind to port < 1024
Message-ID: <20131016154450.GB19385@x220.p-661hnu-f1>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381934198-7955-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381934198-7955-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381934198-7955-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 16, 2013, Andrei Emeltchenko wrote:
> For SDP server we need to bind to lower port, acquire this capability.

You might want to mention here exactly which capability it is instead of
just saying "this" :)

The patch also seems to do more than just related to POSIX capabilities
so you should also mention these things in the commit message.

> diff --git a/android/main.c b/android/main.c
> index 3a20148..091ef20 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -32,6 +32,21 @@
>  #include <stdlib.h>
>  #include <stdbool.h>
>  #include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/prctl.h>
> +
> +/**
> + * Include <sys/capability.h> for host build and
> + * also for Android 4.3 when it is added to bionic
> + */
> +#if !defined(ANDROID) || (PLATFORM_SDK_VERSION > 17)
> +#include <sys/capability.h>
> +#endif
> +
> +#if defined(ANDROID)
> +#include <private/android_filesystem_config.h>
> +#endif
>  
>  #include <glib.h>
>  
> @@ -230,6 +245,58 @@ static void cleanup_mgmt_interface(void)
>  	mgmt_if = NULL;
>  }
>  
> +static bool set_capabilities(void)

This whole function seems to me like something that's not needed on
non-android (since we can just execute the daemon as root if necessary),
so I'd consider putting its entire contents behind #if defined(ANDROID)
